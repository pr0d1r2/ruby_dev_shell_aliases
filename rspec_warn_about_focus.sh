function rspec_warn_about_focus() {
  ag ", :focus " spec | grep -q "focus"
  if [ $? -eq 0 ]; then
    echo "WARNING: specs contain :focus !!!"
  fi
}
