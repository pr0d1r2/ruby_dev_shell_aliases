function mvim_each() {
  local mvim_each_SCOPE
  local mvim_each_FILE
  local mvim_each_DIR_FILE
  for mvim_each_SCOPE in $@
  do
    for mvim_each_FILE in `ls $mvim_each_SCOPE`
    do
      if [ -d $mvim_each_FILE ]; then
        for mvim_each_DIR_FILE in `find $mvim_each_FILE -type f`
        do
          mvim $mvim_each_DIR_FILE &
        done
      else
        mvim $mvim_each_FILE &
      fi
    done
  done
}
