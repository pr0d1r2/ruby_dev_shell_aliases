# Run spec examples (single lines) in parallel.
# Useful when you have heavy spec examples to run them in parallel (10 seconds+ per example).
#
# Remember that you need to have PARALLEL_TEST_FIRST_IS_1 set and setup parallel databases:
#   https://github.com/pr0d1r2/ruby_dev_shell_aliases/blob/master/PARALLEL_TEST_FIRST_IS_1.sh
#
# Example usage:
#   rspec_parallel_examples spec/first_spec.rb spec/second_spec.rb
function rspec_parallel_examples() {
  rspec_list_all_examples "$@" | \
    parallel \
      -v \
      'TEST_ENV_NUMBER={%} bundle exec rspec {}'
  return $?
}
