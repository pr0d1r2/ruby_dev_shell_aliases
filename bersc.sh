function bersc() {
  local bersc_FILE_CHANGED
  local bersc_SPECS
  local bersc_SPEC_FROM_FILE_CHANGED
  if [ ! -d .git ]; then
    echo "$0: not a git repo!"
    return 1
  fi
  rspec_ensure_no_focus || return $?
  bersc_SPECS=()
  for bersc_FILE_CHANGED in `git st | grep _spec.rb | grep -v "^D  " | cut -b4- | sed -e 's/ -> /|/g' | cut -f 2 -d '|'`
  do
    bersc_SPECS+=$bersc_FILE_CHANGED
  done
  for bersc_FILE_CHANGED in `git st | grep -v "^##" | cut -b4- | grep -v "^D  " | sed -e 's/ -> /|/g' | cut -f 2 -d '|'`
  do
    bersc_SPEC_FROM_FILE_CHANGED=`echo $bersc_FILE_CHANGED | sed -e 's/^app/spec/' | sed -e 's/^lib/spec\/lib/' | sed -e 's/.rb$/_spec.rb/' | grep '_spec.rb' | grep -v '_spec_spec.rb'`
    if [ -f $bersc_SPEC_FROM_FILE_CHANGED ]; then
      bersc_SPECS+=$bersc_SPEC_FROM_FILE_CHANGED
    else
      echo "WARNING: missing spec: $bersc_SPEC_FROM_FILE_CHANGED"
    fi
  done
  case $bersc_SPECS in
    "")
      return 0
      ;;
    *)
      echo
      echorun bers $bersc_SPECS || return $?
      ;;
  esac
}
