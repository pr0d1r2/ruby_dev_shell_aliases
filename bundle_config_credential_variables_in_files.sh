function bundle_config_credential_variables_in_files() {
  parallel 'test -f {} && (grep ": " {} | sed -e "s/: /=/")' ::: $@ | sort -u | egrep "^[A-Z_-]{1,}=\"[A-Za-z0-9:]{1,}\""
}
