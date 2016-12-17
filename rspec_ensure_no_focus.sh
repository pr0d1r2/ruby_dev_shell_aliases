function rspec_ensure_no_focus() {
  ag ", :focus " spec | grep -q "focus"
  if [ $? -eq 0 ]; then
    echo "ERROR: specs contain :focus !!!"
    return 8472
  fi
}
