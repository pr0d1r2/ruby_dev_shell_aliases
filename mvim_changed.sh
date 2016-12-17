function mvim_changed() {
  local mvim_changed_FILE
  for mvim_changed_FILE in `git status --porcelain | grep -v "^D" | cut -c4-`
  do
    echo mvim $mvim_changed_FILE
    mvim $mvim_changed_FILE &
  done
  wait
}
