function bundle_config_credential_exports_in_files() {
  parallel 'test -f {} && egrep "^[A-Z_]{1,}: " {}' ::: $@ | cut -f 1 -d : | sort -u | parallel 'echo export {}'
}
