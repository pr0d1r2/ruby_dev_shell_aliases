# Run each spec silently
#
# Useful when you want to test all files separately
# or in case of performance testing on another core[s].
#
# Example usage (all files changed):
#   rspec_each
function rspec_each() {
  local rspec_each_COMMAND
  rspec_each_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_each_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_each_COMMAND+="silently rspec -f p $* {}"
  case $1 in
    "")
      ;;
  esac
  changed_specs | parallel -v -j 1 "$rspec_each_COMMAND"

  return $?
}
