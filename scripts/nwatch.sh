#!/usr/bin/env bash

#
# nwatch [-n interval] [-c clear_every] [-t] <command>
#
# puppygirl<at>briellabugs<dot>com
#

catch_exit() {
  printf "\e[2J\e[?47l\e[?25h\e8"
  stty sane
  exit 0
}
trap catch_exit INT

if ! [ -t 1 ] ; then
  echo "Stdout is not a tty, exiting..."
  exit 0
fi

error_exit() {
  printf "\e[2J\e[?47l\e[?25h\e8"
  stty sane
  exit 1
}

usage() {
  printf '\nUsage:\n'
  printf '  %s [options] <command>\n\n' "$(basename "$0")"
  printf 'Options:\n'
  printf '  -n <seconds> seconds to wait between each command\n'
  printf '  -c <frames>  frames to wait before clearing the screen\n'
  printf '               lower numbers reduce flicker\n'
  printf '               higher numbers reduce overlap between frames\n'
  printf '  -t           don''t show a header\n\n'
  exit 0
}

if [ $# -eq 0 ]; then
  usage
  exit 0
fi

interval=0
clear_every=20
header=1

while getopts ":n:c:t" opt; do
  case "$opt" in
    n) interval="$OPTARG" ;;
    c) clear_every="$OPTARG" ;;
    t) header=0 ;;
    \?) printf "Invalid option: -%s\n" "$OPTARG"; usage ;;
    :) printf "Option -%s requires an argument\n" "$OPTARG"; usage ;;
  esac
done
shift $((OPTIND - 1))

command="$*"
if [ -z "$command" ]; then
  usage
  exit 0
fi

interval=$(awk -v a="$interval" 'BEGIN { print (a > 0.002) ? a : 0.002 }')

frame=1
printf "\e7\e[?47h\e[1J\e[?25l\e[2J" # Init
while true; do
  if [ "$clear_every" -gt 0 ] && [ "$((frame % clear_every))" -eq 0 ]; then
    printf "\e[2J"
  fi
  printf "\e[H"
  if [ "$header" -eq 1 ]; then
    printf '\e[1mEvery %s sec:\e[0m %s\e[0K\n\e[0K\n' "$interval" "$command"
  fi
  eval "$command"
  [ "$?" -eq 130 ] && catch_exit
  printf "\e[0J"
  sleep "$interval" || error_exit
  [ "$?" -eq 130 ] && catch_exit
  frame=$((frame + 1))
done

# EOF meow
