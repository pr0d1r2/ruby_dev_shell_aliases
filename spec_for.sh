function spec_for() {
  local spec_for_FILE
  local spec_for_SPEC_FILE
  for spec_for_FILE in "$@"
  do
    if [ -d "$spec_for_FILE" ]; then
      find "$spec_for_FILE" -type f -name "*.rb" | \
        parallel "source $RUBY_DEV_SHELL_ALIASES_PATH/spec_for.sh && spec_for {}" 2>/dev/null
    else
      spec_for_SPEC_FILE="$(echo "$spec_for_FILE" | sed -e 's|^./||' -e "s/app\//spec\//" -e 's/.rb$/_spec.rb/' -e 's/.slim$/.slim_spec.rb/')"
      case $spec_for_SPEC_FILE in
        spec/* | engines/*) ;;
        *)
          spec_for_SPEC_FILE="spec/$spec_for_SPEC_FILE"
          ;;
      esac
      echo "$spec_for_SPEC_FILE" | grep --color=never "_spec.rb$" | sed -e 's/_spec_spec.rb$/_spec.rb/' | parallel "test -f {} && echo {}"
    fi
  done
}
