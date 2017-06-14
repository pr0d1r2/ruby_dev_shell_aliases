vcr_find_unused_cassettes() {
  vcr_cassettes_list | \
    parallel "source $PROJECTS_PATH/ruby_dev_shell_aliases/exist_in_test_suite.sh && exist_in_test_suite {}" | \
    parallel 'echo spec/fixtures/cassettes/{}.yml'
}
