function bundle_config_credential_exports() {
  case $1 in
    "")
      bundle_config_credential_exports_in_files "$HOME/.bundle/config" ".bundle/config" || return $?
      ;;
    *)
      bundle_config_credential_exports_in_files $@ || return $?
      ;;
  esac
}
