#!/bin/bash

###############################################################################
echo "Default apps"
###############################################################################

# Without this, .ts opens in VLC (MPEG transport stream) and .js in Chrome.
vscode=com.microsoft.VSCode
if command -v duti >/dev/null && open -Ra "Visual Studio Code" 2>/dev/null; then
  echo "∙ Open code and config files in VS Code"
  for ext in md mdx ts tsx mts cts js jsx mjs cjs json jsonc json5 yml yaml toml ini conf env sh bash zsh css scss sql graphql; do
    duti -s "$vscode" ".$ext" all
  done
else
  echo "  ! Skipped: needs duti and VS Code (run: ./bootstrap packages)"
fi
