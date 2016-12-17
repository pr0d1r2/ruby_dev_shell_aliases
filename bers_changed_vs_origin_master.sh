function bers_changed_vs_origin_master() {
  rspec_ensure_no_focus || return $?
  local bers_changed_vs_origin_master_FILE
  local bers_changed_vs_origin_master_FILES_EXISTING=()
  for bers_changed_vs_origin_master_FILE in `git_files_changed_vs_origin_master | grep spec | grep "_spec.rb$"`
  do
    if [ -f $bers_changed_vs_origin_master_FILE ]; then
      bers_changed_vs_origin_master_FILES_EXISTING+=$bers_changed_vs_origin_master_FILE
    fi
  done
  if [ `echo $bers_changed_vs_origin_master_FILES_EXISTING | wc -l` -gt 0 ]; then
    echorun bers `echo $bers_changed_vs_origin_master_FILES_EXISTING | tr "\n" " "`
  else
    echo
    echo "$0: nothing to run"
  fi
}
