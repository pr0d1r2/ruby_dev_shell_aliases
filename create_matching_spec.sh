function create_matching_spec() {
  local create_matching_spec_FILE
  local create_matching_spec_SPEC
  for create_matching_spec_FILE in $@
  do
    create_matching_spec_SPEC=`echo $create_matching_spec_FILE | sed -e 's/^app/spec/' | sed -e 's/\.slim$/.slim_spec.rb/'`
    local create_matching_spec_SPEC_DIR=`dirname $create_matching_spec_SPEC`
    if [ ! -d $create_matching_spec_SPEC_DIR ]; then
      echorun mkdir -p $create_matching_spec_SPEC_DIR || return $?
    fi
    case $create_matching_spec_FILE in
      app/views/*)
        local create_matching_spec_SPEC_NAME=`echo $create_matching_spec_FILE | sed -e 's|^app/views/||' | sed -e 's/\.slim$//'`
        echo "RSpec.describe '$create_matching_spec_SPEC_NAME' do" > $create_matching_spec_SPEC
        echo "end" >> $create_matching_spec_SPEC
        ;;
      *)
        echorun touch $create_matching_spec_SPEC || return $?
        ;;
    esac
    git add $create_matching_spec_SPEC &
    mvim $create_matching_spec_SPEC &
  done
  wait
}
