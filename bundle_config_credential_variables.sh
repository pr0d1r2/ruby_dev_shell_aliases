function bundle_config_credential_variables() {
  case $1 in
    "")
      bundle_config_credential_variables_in_files "$HOME/.bundle/config" ".bundle/config" || return $?
      ;;
    *)
      bundle_config_credential_variables_in_files $@ || return $?
      ;;
  esac
}
