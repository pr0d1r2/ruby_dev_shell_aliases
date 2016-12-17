function tested_file() {
  local tested_file_FILE
  for tested_file_FILE in $@
  do
    echo $tested_file_FILE | grep -q "_spec.rb$"
    if [ $? -eq 0 ]; then
      local tested_file_FILE_IN_APP=`echo $tested_file_FILE | sed -e 's/spec\//app\//' | sed -e 's/_spec.rb/.rb/'`
      if [ -f $tested_file_FILE_IN_APP ]; then
        echo $tested_file_FILE_IN_APP
      fi
      local tested_file_FILE_IN_ANYWHERE=`echo $tested_file_FILE | sed -e 's/spec\///' | sed -e 's/_spec.rb/.rb/'`
      if [ -f $tested_file_FILE_IN_ANYWHERE ]; then
        echo $tested_file_FILE_IN_ANYWHERE
      fi
    fi
  done
}
