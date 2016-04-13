# shellrc.sc
# Source this to add additional shell features for mpv.

alias mpvnova='mpv --no-video'
alias mpvshuf='mpvnova --shuffle --loop=inf'
mpvp() {
  mpvshuf --playlist <(cat $*)
}

playcurrentdir() {
  TMP=$(mktemp .mpv.XXX) # Must be in current dir for relative paths.
  find "$PWD" -type f -follow -not -path '*/\.*' > $TMP
  mpvp $TMP
  rm $TMP
}
alias pcd='playcurrentdir'

playdir() {
  if [[ $# == 0 ]]; then
    echo "playdir requires one or more directories on input."
  else
    TMP=$(mktemp .mpv.XXX) # Must be in current dir for relative paths.
    find "$@" -type f -follow -not -path '*/\.*' > $TMP
    mpvp $TMP
    rm $TMP
  fi
}
alias pd='playdir'

alias random-mpv="find . -type f  | shuf | head -n 1 | xargs mpv"
