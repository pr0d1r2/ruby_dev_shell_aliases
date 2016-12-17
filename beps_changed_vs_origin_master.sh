function beps_changed_vs_origin_master() {
  rspec_ensure_no_focus || return $?
  local beps_changed_vs_origin_master_FILE
  local beps_changed_vs_origin_master_FILES_EXISTING=()
  for beps_changed_vs_origin_master_FILE in `git_files_changed_vs_origin_master | grep spec | grep "_spec.rb$"`
  do
    if [ -f $beps_changed_vs_origin_master_FILE ]; then
      beps_changed_vs_origin_master_FILES_EXISTING+=$beps_changed_vs_origin_master_FILE
    fi
  done
  if [ `echo $beps_changed_vs_origin_master_FILES_EXISTING | wc -l` -gt 0 ]; then
    echorun beps `echo $beps_changed_vs_origin_master_FILES_EXISTING | tr "\n" " "`
  else
    echo
    echo "$0: nothing to run"
  fi
}
