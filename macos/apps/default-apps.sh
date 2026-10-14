#!/bin/bash

###############################################################################
echo "Default apps"
###############################################################################

# Without this, .ts opens in VLC (MPEG transport stream) and .js in Chrome.
vscode=com.microsoft.VSCode
if command -v duti >/dev/null && open -Ra "Visual Studio Code" 2>/dev/null; then
  echo "∙ Open code and config files in VS Code"
  # macOS asks to confirm each change, so only touch the ones that differ.
  # Not listed: mdx, cts, jsonc, json5, conf, env and graphql have no type
  # registered by any installed app, so macOS can't hold a default for them.
  for ext in md ts tsx mts js jsx mjs cjs json yml yaml toml ini sh bash zsh css scss sql; do
    [[ $(duti -x "$ext" 2>/dev/null | sed -n 3p) == "$vscode" ]] || duti -s "$vscode" ".$ext" all
  done
else
  echo "  ! Skipped: needs duti and VS Code (run: ./bootstrap packages)"
fi
