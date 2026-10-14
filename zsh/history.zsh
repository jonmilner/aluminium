HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt extended_history       # save timestamps
setopt hist_expire_dups_first # trim duplicates first when the file is full
setopt hist_ignore_dups       # don't record a command twice in a row
setopt hist_ignore_space      # don't record commands that start with a space
setopt hist_verify            # show !! expansions before running them
setopt share_history          # share history across open terminals
