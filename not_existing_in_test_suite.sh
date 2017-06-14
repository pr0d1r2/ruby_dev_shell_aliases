not_existing_in_test_suite() {
  rg --quiet $1 features spec

  local not_existing_in_test_suite_STATUS=$?

  if [ $not_existing_in_test_suite_STATUS -gt 0 ]; then
    echo $1
  fi
  return $not_existing_in_test_suite_STATUS
}
