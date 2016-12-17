function sample_file_use() {
  for sample_file_use_FILE in `find . -name "*.sample" | grep -v "^./.git"`
  do
    echo cp $sample_file_use_FILE `echo $sample_file_use_FILE | sed -e "s/\.sample//g"`
  done
}
