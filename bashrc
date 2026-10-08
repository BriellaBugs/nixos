#
# ~/.bashrc
#

set completion-ignore-case on

ACCENT_COLOR=219 # Pretty pink

export EDITOR='nano'
export VISUAL='nano'

_update_prompt() {
  PS1="\[\e[38;5;${ACCENT_COLOR}m\]╭──[\[\e[0m\]\u\[\e[38;5;${ACCENT_COLOR}m\]@\[\e[0m\]\h\[\e[38;5;${ACCENT_COLOR}m\]] \[\e[0;2m\]\w\n\[\e[0;38;5;${ACCENT_COLOR}m\]╰╴\[\e[0;2m\]$?\[\e[0;38;5;${ACCENT_COLOR}m\]╶╴\[\e[0m\]\$ "
}

PROMPT_COMMAND="_update_prompt"

PATH="$PATH:$HOME/.local/bin"

# defaults

alias ls='ls -a --color=auto'
alias grep='grep --color=auto'

# shorthands

alias r='reset'
alias q='exit'
alias rq='reset && exit'

alias off='/usr/bin/env systemctl poweroff --no-wall'
alias reboot='/usr/bin/env systemctl reboot --no-wall'
testpkg() { nix-shell -p "$1" --command bash; }
copy() { cat "$1" | wl-copy; }
cpdir() { pwd | wl-copy; }
cleannix() { nix-collect-garbage -d; }
