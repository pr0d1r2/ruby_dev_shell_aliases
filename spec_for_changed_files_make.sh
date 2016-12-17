function spec_for_changed_files_make() {
  local spec_for_changed_files_make_FILE
  for spec_for_changed_files_make_FILE in `spec_for_changed_files`
  do
    local spec_for_changed_files_make_DIR=`dirname $spec_for_changed_files_make_FILE`
    if [ ! -d $spec_for_changed_files_make_DIR ]; then
      mkdir -p $spec_for_changed_files_make_DIR
    fi
    touch $spec_for_changed_files_make_FILE
    cat $spec_for_changed_files_make_FILE | grep -q "^RSpec.describe"
    if [ $? -gt 0 ]; then
      if [ ! -s $spec_for_changed_files_make_FILE ]; then
        local spec_for_changed_files_make_CLASS=`ruby_class_for_tested_file $spec_for_changed_files_make_FILE`
        case $spec_for_changed_files_make_CLASS in
          '')
            ;;
          *)
            echo "RSpec.describe $spec_for_changed_files_make_CLASS do" > $spec_for_changed_files_make_FILE
            echo "end" >> $spec_for_changed_files_make_FILE
            ;;
        esac
      fi
    fi
  done
}
