function ruby_class() {
  local ruby_class_FILE
  for ruby_class_FILE in $@
  do
    cat $ruby_class_FILE | grep "^class " | cut -f 2 -d ' '
  done
}
