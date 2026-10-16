#!/bin/bash

###############################################################################
echo "Sound"
###############################################################################

echo "∙ Disable the sound on startup"
# The NVRAM variable behind System Settings → Sound → Play sound on startup.
sudo nvram StartupMute=%01
