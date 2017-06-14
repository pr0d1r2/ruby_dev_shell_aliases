exist_in_test_suite() {
  rg --quiet $1 features spec

  if [ $? -gt 0 ]; then
    echo $1
    return 1
  fi
  return 0
}
