function beps_files() {
  case $1 in
    "") return 0;;
    *)
      beps "$@" || return $?
      ;;
  esac
}
