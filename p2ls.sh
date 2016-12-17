function p2ls() {
  local p2ls_PROJECT_ROOT=`pwd -P`
  local p2ls_ROOT="$p2ls_setup_PROJECT_ROOT/tmp/p2ls"
  local p2ls_RSPEC_EXAMPLE

  for p2ls_RSPEC_EXAMPLE in `rspec_list_all_examples $@`
  do
    echo "$p2ls_RSPEC_EXAMPLE"
    p2ls_first_free_thread
    p2ls_job spring rspec $p2ls_RSPEC_EXAMPLE &
    sleep 0.01
  done
  wait
}
