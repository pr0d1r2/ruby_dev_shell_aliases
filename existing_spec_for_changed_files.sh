function existing_spec_for_changed_files() {
  local existing_spec_for_changed_files_FILE
  for existing_spec_for_changed_files_FILE in `spec_for_changed_files`
  do
    if [ -f $existing_spec_for_changed_files_FILE ]; then
      echo $existing_spec_for_changed_files_FILE
    fi
  done
}
