# Run cucumber features lines (and/or all lines from files) in parallel.
#
# Example usage:
#   cucumber_lines_run_in_parallel features/user.feature:5 features/user.feature:25 features/user/profile.feature:100 features/user/whole_multiline.feature
function cucumber_lines_run_in_parallel() {
  cucumber_scenarios_lines "$@" | \
    parallel \
      'TEST_ENV_NUMBER={%} bundle exec cucumber {}' 2>/dev/null
  return $?
}
