# Run cucumber features lines in parallel.
#
# Example usage:
#   cucumber_lines_run_in_parallel features/user.feature:5 features/user.feature:25 features/user/profile.feature:100
function cucumber_lines_run_in_parallel() {
  local cucumber_lines_run_in_parallel_THREAD=1
  local cucumber_lines_run_in_parallel_LINE
  for cucumber_lines_run_in_parallel_LINE in $@
  do
    local cucumber_lines_run_in_parallel_COMMAND="TEST_ENV_NUMBER=$cucumber_lines_run_in_parallel_THREAD bundle exec cucumber $cucumber_lines_run_in_parallel_LINE"
    local cucumber_lines_run_in_parallel_OUTPUT="/tmp/.$USER.cucumber_lines_run_in_parallel.`echo $cucumber_lines_run_in_parallel_COMMAND | md5sum`"
    echo "$cucumber_lines_run_in_parallel_COMMAND & (output in $cucumber_lines_run_in_parallel_OUTPUT)"
    touch $cucumber_lines_run_in_parallel_OUTPUT
    TEST_ENV_NUMBER=$cucumber_lines_run_in_parallel_THREAD bundle exec cucumber $cucumber_lines_run_in_parallel_LINE &> $cucumber_lines_run_in_parallel_OUTPUT &
    cucumber_lines_run_in_parallel_THREAD=`expr $cucumber_lines_run_in_parallel_THREAD + 1`
  done
  if [ -z "$NO_WAIT" ]; then
    wait
  fi
}
