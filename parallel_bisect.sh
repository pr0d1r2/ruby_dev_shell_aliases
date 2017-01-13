function parallel_bisect() {
  local parallel_bisect_NPROC=`nproc`
  if [ -n "$PARALLEL_TEST_FIRST_IS_1" ]; then
    local parallel_bisect_START=1
  else
    local parallel_bisect_START=0
  fi
  local parallel_bisect_END=`expr $parallel_bisect_START + $parallel_bisect_NPROC`
  local parallel_bisect_THREAD=$parallel_bisect_START
  while [ $parallel_bisect_THREAD -le $parallel_bisect_END ]
  do
    TEST_ENV_NUMBER=$parallel_bisect_THREAD bundle exec rspec $@ --bisect &
  done
  wait
}
