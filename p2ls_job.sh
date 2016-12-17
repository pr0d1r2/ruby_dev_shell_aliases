function p2ls_job() {
  local p2ls_job_PROJECT_ROOT=`pwd -P`
  local p2ls_job_ROOT="$p2ls_job_PROJECT_ROOT/tmp/p2ls"
  local p2ls_job_THREAD=`p2ls_first_free_thread`

  cd $p2ls_job_ROOT/$p2ls_job_THREAD
  touch THREAD_BUSY
  SPRING_TMP_PATH="$p2ls_job_ROOT/$p2ls_job_THREAD/tmp" SPRING_APPLICATION_ID=`pwd -P | md5` $@
  rm -f THREAD_BUSY
  cd $p2ls_job_PROJECT_ROOT
}
