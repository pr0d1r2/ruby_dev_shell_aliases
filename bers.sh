function bers() {
  rspec_warn_about_focus
  if [ -x bin/rspec ]; then
    be bin/rspec $@ || return $?
  else
    be rspec $@ || return $?
  fi
}
