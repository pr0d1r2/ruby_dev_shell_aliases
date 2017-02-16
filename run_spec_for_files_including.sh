function run_spec_for_files_including() {
  run_spec_for `rg -l "$@"` || return $?
}
