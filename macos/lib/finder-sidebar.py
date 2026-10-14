"""Make the Finder sidebar match TARGET below.

Uses the LSSharedFileList API (deprecated since 10.11 but still present on
macOS 26), which talks to sharedfilelistd. The .sfl4 files it stores are
protected by TCC and in a private format, so they can't be edited directly.

usage: python3 -I finder-sidebar.py [--dry-run]
Rewrites Favorites only when they differ from the target, so re-runs are no-ops.
"""
import ctypes as C
import os
import sys

HOME = os.path.expanduser("~")
DRY_RUN = "--dry-run" in sys.argv


def favorites():
    """Favorites, in order. Folders that don't exist on this Mac are skipped."""
    return [
        folder("/"),  # Macintosh HD
        special("IsHome", file_url(HOME)),
        folder("/Applications"),
        folder(HOME + "/Desktop"),
        folder(HOME + "/Documents"),
        folder(HOME + "/Pictures"),
        folder(HOME + "/Movies"),
        folder(HOME + "/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"),
        folder(HOME + "/Downloads"),
        folder(HOME + "/Library/CloudStorage/SynologyDrive-NASbox"),
        special("IsICloudDrive", lambda: str_url("x-apple-finder:icloud")),
        special("IsMeetingRoom", lambda: str_url("nwnode://domain-AirDrop")),  # AirDrop
    ]


# Finder Settings → Sidebar → Locations. Values read from a Mac set up by hand.
LOCATIONS = {
    "ComputerIsVisible": True,
    "ShowHardDrives": True,
    "ShowEjectableVolumes": True,  # External disks
    "ShowNetworkVolumes": True,
}

# --- CoreFoundation / LSSharedFileList plumbing ------------------------------

cs = C.CDLL("/System/Library/Frameworks/CoreServices.framework/CoreServices")
cf = C.CDLL("/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")
P = C.c_void_p
UTF8 = 0x08000100
for fn, res, args in [
    (cf.CFArrayGetCount, C.c_long, [P]),
    (cf.CFArrayGetValueAtIndex, P, [P, C.c_long]),
    (cf.CFStringCreateWithCString, P, [P, C.c_char_p, C.c_uint32]),
    (cf.CFStringGetCString, C.c_bool, [P, C.c_char_p, C.c_long, C.c_uint32]),
    (cf.CFGetTypeID, C.c_ulong, [P]),
    (cf.CFStringGetTypeID, C.c_ulong, []),
    (cf.CFURLGetString, P, [P]),
    (cf.CFURLCreateWithString, P, [P, P, P]),
    (cf.CFURLCreateWithFileSystemPath, P, [P, P, C.c_long, C.c_bool]),
    (cf.CFURLCopyFileSystemPath, P, [P, C.c_long]),
    (cf.CFDictionaryCreate, P, [P, P, P, C.c_long, P, P]),
    (cs.LSSharedFileListCreate, P, [P, P, P]),
    (cs.LSSharedFileListCopySnapshot, P, [P, P]),
    (cs.LSSharedFileListItemCopyResolvedURL, P, [P, C.c_uint32, P]),
    (cs.LSSharedFileListItemCopyProperty, P, [P, P]),
    (cs.LSSharedFileListItemRemove, C.c_int32, [P, P]),
    (cs.LSSharedFileListInsertItemURL, P, [P, P, P, P, P, P, P]),
    (cs.LSSharedFileListSetProperty, C.c_int32, [P, P, P]),
]:
    fn.restype, fn.argtypes = res, args

SPECIAL_ID = "com.apple.LSSharedFileList.SpecialItemIdentifier"
LAST = P(C.c_size_t.in_dll(cs, "kLSSharedFileListItemLast").value)
NO_UI = 3  # kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes


def cfstr(s):
    return cf.CFStringCreateWithCString(None, s.encode(), UTF8)


def pystr(ref):
    if not ref or cf.CFGetTypeID(ref) != cf.CFStringGetTypeID():
        return None
    buf = C.create_string_buffer(4096)
    return buf.value.decode() if cf.CFStringGetCString(ref, buf, 4096, UTF8) else None


def file_url(path):
    return lambda: cf.CFURLCreateWithFileSystemPath(None, cfstr(path), 0, True)


def str_url(s):
    return cf.CFURLCreateWithString(None, cfstr(s), None)


def folder(path):
    if not os.path.isdir(path):
        return None
    return ("path:" + os.path.realpath(path), file_url(path), None)


def special(name, url):
    return ("special:" + name, url, "com.apple.LSSharedFileList." + name)


def item_key(item):
    sid = pystr(cs.LSSharedFileListItemCopyProperty(item, cfstr(SPECIAL_ID)))
    if sid:
        return "special:" + sid.rsplit(".", 1)[-1]
    url = cs.LSSharedFileListItemCopyResolvedURL(item, NO_UI, None)
    path = pystr(cf.CFURLCopyFileSystemPath(url, 0)) if url else None
    return "path:" + os.path.realpath(path) if path else "url:" + str(pystr(cf.CFURLGetString(url)) if url else None)


def snapshot(lst):
    arr = cs.LSSharedFileListCopySnapshot(lst, None)
    items = [cf.CFArrayGetValueAtIndex(arr, i) for i in range(cf.CFArrayGetCount(arr) if arr else 0)]
    return [(item_key(i), i) for i in items]


def props_for(sid):
    if not sid:
        return None
    keys, values = (P * 1)(cfstr(SPECIAL_ID)), (P * 1)(cfstr(sid))
    callbacks = lambda name: C.addressof(C.c_char.in_dll(cf, name))
    return cf.CFDictionaryCreate(None, keys, values, 1,
                                 callbacks("kCFTypeDictionaryKeyCallBacks"),
                                 callbacks("kCFTypeDictionaryValueCallBacks"))


def main():
    fav = cs.LSSharedFileListCreate(None, P.in_dll(cs, "kLSSharedFileListFavoriteItems"), None)
    vol = cs.LSSharedFileListCreate(None, P.in_dll(cs, "kLSSharedFileListFavoriteVolumes"), None)
    target = [t for t in favorites() if t]
    have = snapshot(fav)
    want_keys = [key for key, _, _ in target]
    have_keys = [key for key, _ in have]

    if have_keys == want_keys:
        print("  Sidebar favorites already match")
    elif DRY_RUN:
        print("  Sidebar favorites differ:\n    have: %s\n    want: %s" % (have_keys, want_keys))
    else:
        for _, item in have:
            cs.LSSharedFileListItemRemove(fav, item)
        for key, url, sid in target:
            if not cs.LSSharedFileListInsertItemURL(fav, LAST, None, None, url(), props_for(sid), None):
                print("  ! Couldn't add %s to the sidebar" % key, file=sys.stderr)
        result = [key for key, _ in snapshot(fav)]
        print("  Sidebar favorites rewritten" if result == want_keys else
              "  ! Sidebar favorites still differ: %s" % result)

    if not DRY_RUN:
        boolean = lambda on: P.in_dll(cf, "kCFBooleanTrue" if on else "kCFBooleanFalse")
        for name, on in LOCATIONS.items():
            cs.LSSharedFileListSetProperty(vol, cfstr("com.apple.LSSharedFileList.FavoriteVolumes." + name), boolean(on))


main()
