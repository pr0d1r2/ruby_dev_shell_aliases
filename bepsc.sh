function bepsc() {
  local bepsc_FILE_CHANGED
  local bepsc_SPECS
  local bepsc_SPEC_FROM_FILE_CHANGED
  if [ ! -d .git ]; then
    echo "$0: not a git repo!"
    return 1
  fi
  rspec_ensure_no_focus || return $?
  bepsc_SPECS=()
  for bepsc_FILE_CHANGED in `changed_specs`
  do
    bepsc_SPECS+=$bepsc_FILE_CHANGED
  done
  for bepsc_FILE_CHANGED in `git st | grep -v "^##" | cut -b4- | grep -v "^D  " | sed -e 's/ -> /|/g' | cut -f 2 -d '|'`
  do
    bepsc_SPEC_FROM_FILE_CHANGED=`echo $bepsc_FILE_CHANGED | sed -e 's/^app/spec/' | sed -e 's/^lib/spec\/lib/' | sed -e 's/.rb$/_spec.rb/' | grep '_spec.rb' | grep -v '_spec_spec.rb'`
    if [ -f $bepsc_SPEC_FROM_FILE_CHANGED ]; then
      bepsc_SPECS+=$bepsc_SPEC_FROM_FILE_CHANGED
    else
      echo "WARNING: missing spec: $bepsc_SPEC_FROM_FILE_CHANGED"
    fi
  done
  case $bepsc_SPECS in
    "")
      return 0
      ;;
    *)
      echo
      echorun beps $bepsc_SPECS || return $?
      ;;
  esac
}
