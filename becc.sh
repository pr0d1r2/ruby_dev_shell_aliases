function becc() {
  if [ ! -d .git ]; then
    echo "$0: not a git repo!"
    return 1
  fi
  becc_CUCUMBERS=()
  for becc_FILE_CHANGED in `git st | grep "\.feature$" | grep -v "_steps.rb" | grep -v features/support | grep -v "^D  " | cut -b4- | sed -e 's/ -> /|/g' | cut -f 2 -d '|'`
  do
    becc_CUCUMBERS+=$becc_FILE_CHANGED
  done
  case $becc_CUCUMBERS in
    "")
      return 0
      ;;
    *)
      echo
      echorun bec $becc_CUCUMBERS || return $?
      ;;
  esac
  unset becc_CUCUMBERS
  unset becc_FILE_CHANGED
  unset becc_CUCUMBER_FROM_FILE_CHANGED
}

