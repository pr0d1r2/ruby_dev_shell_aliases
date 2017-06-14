not_existing_in_test_suite() {
  if [ -f .vcr_used_in ]; then
    rg --quiet $1 `cat .vcr_used_in | tr -d "\n"`
  else
    rg --quiet $1 features spec
  fi

  local not_existing_in_test_suite_STATUS=$?

  if [ $not_existing_in_test_suite_STATUS -eq 1 ]; then
    echo $1
  fi
  return $not_existing_in_test_suite_STATUS
}
