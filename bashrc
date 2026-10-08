#
# /etc/nixos/bashrc
#

set completion-ignore-case on

export EDITOR='nano'
export VISUAL='nano'

_update_prompt() {
  local ec=$?
  local ACCENT_COLOR=219
  [[ -n $IN_NIX_SHELL ]] && ACCENT_COLOR=160

  PS1="\[\e[38;5;${ACCENT_COLOR}m\]╭──[\[\e[0m\]\u\[\e[38;5;${ACCENT_COLOR}m\]@\[\e[0m\]\h\[\e[38;5;${ACCENT_COLOR}m\]] \[\e[0;2m\]\w\n\[\e[0;38;5;${ACCENT_COLOR}m\]╰╴\[\e[0;2m\]${ec}\[\e[0;38;5;${ACCENT_COLOR}m\]╶╴\[\e[0m\]\$ "
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
cleannix() { sudo nix-collect-garbage -d; }
