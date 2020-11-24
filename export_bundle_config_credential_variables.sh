function export_bundle_config_credential_variables() {
  eval $(bundle_config_credential_variables $@)
  eval $(bundle_config_credential_exports $@)
}
