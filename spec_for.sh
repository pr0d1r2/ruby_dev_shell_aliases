function spec_for() {
  local spec_for_FILE
  local spec_for_SPEC_FILE
  for spec_for_FILE in $@
  do
    spec_for_SPEC_FILE=`echo $spec_for_FILE | sed -e "s/app\//spec\//" | sed -e 's/.rb$/_spec.rb/' | sed -e 's/.slim$/.slim_spec.rb/'`
    case $spec_for_SPEC_FILE in
      spec/*)
        ;;
      *)
        spec_for_SPEC_FILE="spec/$spec_for_SPEC_FILE"
        ;;
    esac
    echo $spec_for_SPEC_FILE | grep --color=never "_spec.rb$" | sed -e 's/_spec_spec.rb$/_spec.rb/'
  done
}
