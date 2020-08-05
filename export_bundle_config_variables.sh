function export_bundle_config_variables() {
  local export_bundle_config_variables_TMP
  export_bundle_config_variables_TMP="$(mktemp)"
  cat .bundle/config | grep ": " | sed -e "s/: /=/" > "$export_bundle_config_variables_TMP" || return $?
  cat .bundle/config | grep ": " | cut -f 1 -d : | parallel -j 1 "echo export {} >> '$export_bundle_config_variables_TMP'" || return $?
  source "$export_bundle_config_variables_TMP"
}
