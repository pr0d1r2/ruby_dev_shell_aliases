function bec_changed_vs_origin_master() {
  local bec_changed_vs_origin_master_FILE
  local bec_changed_vs_origin_master_FILES_EXISTING=()
  for bec_changed_vs_origin_master_FILE in `git_files_changed_vs_origin_master | grep features | grep ".feature$"`
  do
    if [ -f $bec_changed_vs_origin_master_FILE ]; then
      bec_changed_vs_origin_master_FILES_EXISTING+=$bec_changed_vs_origin_master_FILE
    fi
  done
  if [ `echo $bec_changed_vs_origin_master_FILES_EXISTING | wc -l` -gt 0 ]; then
    echorun bec `echo $bec_changed_vs_origin_master_FILES_EXISTING | tr "\n" " "`
  else
    echo
    echo "$0: nothing to run"
  fi
}
