function parallelized_cucumber_thread() {
  local parallelized_cucumber_thread_COMMAND="TEST_ENV_NUMBER=$1 bundle exec cucumber $2"
  local parallelized_cucumber_thread_OUTPUT="/tmp/.$USER.cucumber_lines_run_in_parallel.`echo $parallelized_cucumber_thread_COMMAND | md5`"
  echo "$parallelized_cucumber_thread_COMMAND # (output in $parallelized_cucumber_thread_OUTPUT)"
  TEST_ENV_NUMBER=$1 bundle exec cucumber $2 &> $parallelized_cucumber_thread_OUTPUT
  local parallelized_cucumber_thread_ERROR="$?"
  if [ $parallelized_cucumber_thread_ERROR -eq 0 ]; then
    echo "$parallelized_cucumber_thread_COMMAND # OK"
  else
    echo "$parallelized_cucumber_thread_COMMAND # FAILED"
  fi
  return $parallelized_cucumber_thread_ERROR
}
