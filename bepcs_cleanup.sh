function bepcs_cleanup() {
  local bepcs_cleanup_FILE
  for bepcs_cleanup_FILE in `git status -sb | grep "^?? " | grep "feature_splitted/$" | cut -b4-`
  do
    echorun rm -rf $bepcs_cleanup_FILE &
  done
  wait
}
