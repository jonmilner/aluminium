# flatten-movies [-n] <dir>
# For each "Title (YYYY) [..]..." folder in <dir>, move its main video file to
# <dir>/Title (YYYY).ext, then move the folder to the Trash. -n = dry run.
# Folders holding a second video over 100 MB (multi-part, extras) are skipped.
flatten-movies() {
  emulate -L zsh
  setopt extended_glob null_glob

  local dry=0
  [[ $1 == -n ]] && { dry=1; shift }
  local root=${1:?usage: flatten-movies [-n] <dir>}
  [[ -d $root ]] || { print -u2 "not a directory: $root"; return 1 }
  root=${root:A}

  local re='^(.+\([0-9]{4}\))[[:space:]]*\['
  local -a done_dirs videos
  local dir name title video dest

  for dir in $root/*(/); do
    name=${dir:t}
    [[ $name =~ $re ]] || continue
    title=${match[1]}

    # Largest video file anywhere in the folder (skips samples/extras)
    videos=( $dir/**/*.(#i)(mkv|mp4|m4v|avi|mov|wmv|webm|ts|m2ts|mpg|mpeg|flv)(.OL) )
    if (( ! $#videos )); then
      print -u2 "skip (no video): $name"
      continue
    fi
    if (( $#videos > 1 )) && [[ -n ${videos[2]}(#qLm+100) ]]; then
      print -u2 "skip (multiple videos): $name"
      continue
    fi
    video=${videos[1]}
    dest=$root/$title.${video:e}

    if [[ -e $dest ]]; then
      print -u2 "skip (exists): ${dest:t}"
      continue
    fi

    print "${video#$root/} -> ${dest:t}"
    # mv -n exits 0 even when it refuses to overwrite, so check the result
    if (( dry )) || { mv -n -- $video $dest && [[ ! -e $video && -e $dest ]] }; then
      done_dirs+=( $dir )
    else
      print -u2 "move failed: $name"
    fi
  done

  for dir in $done_dirs; do
    if (( dry )); then
      print "would trash: ${dir:t}"
    else
      trash $dir && print "trashed: ${dir:t}"
    fi
  done
}
