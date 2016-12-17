function ruby_class_for_tested_file() {
  local ruby_class_for_tested_file_FILE
  for ruby_class_for_tested_file_FILE in $@
  do
    ruby_class `tested_file $ruby_class_for_tested_file_FILE`
  done
}
