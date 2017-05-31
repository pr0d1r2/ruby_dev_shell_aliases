function rspec_warn_about_focus() {
  ensure_command rg || return $?
  rg ", :focus " spec | grep -q "focus"
  if [ $? -eq 0 ]; then
    echo "WARNING: specs contain :focus !!!"
  fi
}
