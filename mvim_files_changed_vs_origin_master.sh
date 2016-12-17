function mvim_files_changed_vs_origin_master() {
  local mvim_files_changed_vs_origin_master_FILE
  for mvim_files_changed_vs_origin_master_FILE in `git_files_changed_vs_origin_master`
  do
    echo mvim $mvim_files_changed_vs_origin_master_FILE
    mvim $mvim_files_changed_vs_origin_master_FILE &
  done
  wait
}
