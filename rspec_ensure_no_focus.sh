function rspec_ensure_no_focus() {
  ensure_command rg || return $?
  rg ", :focus " spec | grep -q "focus"
  if [ $? -eq 0 ]; then
    echo "ERROR: specs contain :focus !!!"
    return 8472
  fi
}
