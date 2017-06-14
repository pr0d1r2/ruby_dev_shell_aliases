not_existing_in_test_suite() {
  local not_existing_in_test_suite_COMMAND
  not_existing_in_test_suite_COMMAND="rg --quiet $1 {};"
  not_existing_in_test_suite_COMMAND+='if [ $? -eq 0 ]; then exit 1; else exit 0; fi'

  parallel \
    --halt-on-error now,fail=1 \
    "$not_existing_in_test_suite_COMMAND" \
    ::: \
    features \
    spec

  if [ $? -eq 0 ]; then
    echo $1
    return 1
  fi
  return 0
}
