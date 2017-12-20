# Run each spec silently in parallel
#
# Useful when you want to test all files separately on all cores.
# Another use case is then you detect freezing specs.
#
# Example usage (all files changed):
#   rspec_each_parallel
function rspec_each_parallel() {
  local rspec_each_parallel_COMMAND
  rspec_each_parallel_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_each_parallel_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_each_parallel_COMMAND+="TEST_ENV_NUMBER={%} silently rspec -f p $* {}"
  case $1 in
    "")
      ;;
  esac
  changed_specs | parallel -v "$rspec_each_parallel_COMMAND"

  return $?
}
