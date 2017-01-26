function existing_spec_for() {
  local existing_spec_for_FILE
  for existing_spec_for_FILE in `spec_for $@`
  do
    if [ -f $existing_spec_for_FILE ]; then
      echo $existing_spec_for_FILE
    fi
  done
}
