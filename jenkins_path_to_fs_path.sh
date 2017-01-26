function jenkins_path_to_fs_path() {
  local jenkins_path_to_fs_path_PATH
  for jenkins_path_to_fs_path_PATH in $@
  do
    echo $jenkins_path_to_fs_path_PATH | tr '.' '/'
  done
}
