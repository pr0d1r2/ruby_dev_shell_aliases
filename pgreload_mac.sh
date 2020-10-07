function pgreload_mac() {
  case $1 in
    "")
      echorun brew services restart postgresql || return $?
      ;;
    *)
      local pgreload_mac_VERSION
      pgreload_mac_VERSION="$(echo $1 | cut -f 2 -d @ | cut -f 1 -d /)"
      case "$pgreload_mac_VERSION" in
        [1-9] | [1-9][0-9])
          echorun brew services restart "postgresql@$pgreload_mac_VERSION" || return $?
          ;;
        *)
          echorun brew services restart postgresql || return $?
          ;;
      esac
      ;;
  esac
}
