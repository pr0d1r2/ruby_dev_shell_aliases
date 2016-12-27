function bec_parallelized() {
  local bec_parallelized_FILE
  local bec_parallelized_TEST_ENV_NUMBER=0
  for bec_parallelized_FILE in $@
  do
    bec_parallelized_TEST_ENV_NUMBER+=1
  done
  if [ $bec_parallelized_TEST_ENV_NUMBER -gt `nproc` ]; then
    echo "Number of specs greater than CPUs. Exiting ..."
    return 8472
  fi
  local bec_parallelized_TEST_ENV_NUMBER=1
  for bec_parallelized_FILE in $@
  do
    if [ $bec_parallelized_TEST_ENV_NUMBER -eq 1 ]; then
      TEST_ENV_NUMBER="$bec_parallelized_TEST_ENV_NUMBER" bec -p parallel $bec_parallelized_FILE &
    else
      TEST_ENV_NUMBER="$bec_parallelized_TEST_ENV_NUMBER" bundle exec cucumber -p parallel $bec_parallelized_FILE &
    fi
    bec_parallelized_TEST_ENV_NUMBER+=1
  done
  wait || return $?
}
