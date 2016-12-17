function p2ls_first_free_thread() {
  local p2ls_first_free_thread_PROJECT_ROOT=`pwd -P`
  local p2ls_first_free_thread_ROOT="$p2ls_first_free_thread_PROJECT_ROOT/tmp/p2ls"

  local p2ls_first_free_thread_THREAD_FREE=0
  while [ $p2ls_first_free_thread_THREAD_FREE -eq 0 ]
  do
    local p2ls_first_free_thread_THREAD=1
    while [ $p2ls_first_free_thread_THREAD -le `cpu_num` ]
    do
      if [ ! -e $p2ls_first_free_thread_ROOT/$p2ls_first_free_thread_THREAD/THREAD_BUSY ]; then
        echo $p2ls_first_free_thread_THREAD
        return $p2ls_first_free_thread_THREAD
      else
        sleep 0.05
      fi
      p2ls_first_free_thread_THREAD=`expr $p2ls_first_free_thread_THREAD + 1`
    done
  done
}
