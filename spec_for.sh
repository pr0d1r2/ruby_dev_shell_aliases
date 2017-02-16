function spec_for() {
  local spec_for_FILE
  local spec_for_SPEC_FILE
  local spec_for_FILE_IN_DIRECTORY
  for spec_for_FILE in $@
  do
    if [ -d $spec_for_FILE ]; then
      for spec_for_FILE_IN_DIRECTORY in `find $spec_for_FILE -type f`
      do
        spec_for $spec_for_FILE_IN_DIRECTORY
      done
    else
      spec_for_SPEC_FILE=`echo $spec_for_FILE | sed -e "s/app\//spec\//" | sed -e 's/.rb$/_spec.rb/' | sed -e 's/.slim$/.slim_spec.rb/'`
      case $spec_for_SPEC_FILE in
        spec/*)
          ;;
        *)
          spec_for_SPEC_FILE="spec/$spec_for_SPEC_FILE"
          ;;
      esac
      echo $spec_for_SPEC_FILE | grep --color=never "_spec.rb$" | sed -e 's/_spec_spec.rb$/_spec.rb/'
    fi
  done
}
