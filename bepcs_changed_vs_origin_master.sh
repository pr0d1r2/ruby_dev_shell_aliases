function bepcs_changed_vs_origin_master() {
  local bepcs_changed_vs_origin_master_FILE
  local bepcs_changed_vs_origin_master_FILES_EXISTING=()
  for bepcs_changed_vs_origin_master_FILE in `git_files_changed_vs_origin_master | grep features | grep ".feature$"`
  do
    if [ -f $bepcs_changed_vs_origin_master_FILE ]; then
      bepcs_changed_vs_origin_master_FILES_EXISTING+=$bepcs_changed_vs_origin_master_FILE
    fi
  done
  if [ `echo $bepcs_changed_vs_origin_master_FILES_EXISTING | wc -l` -gt 0 ]; then
    echorun bepcs `echo $bepcs_changed_vs_origin_master_FILES_EXISTING | tr "\n" " "`
  else
    echo
    echo "$0: nothing to run"
  fi
}
