function rspec_run_changed_and_checkout_if_failed() {
  local rspec_run_changed_and_checkout_if_failed_COMMAND
  rspec_run_changed_and_checkout_if_failed_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_run_changed_and_checkout_if_failed_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_run_changed_and_checkout_if_failed_COMMAND+="echo {} && "
  rspec_run_changed_and_checkout_if_failed_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec {} || "
  rspec_run_changed_and_checkout_if_failed_COMMAND+="silently git checkout {}"
  changed_specs | \
    parallel \
      "$rspec_run_changed_and_checkout_if_failed_COMMAND"
  return $?
}
