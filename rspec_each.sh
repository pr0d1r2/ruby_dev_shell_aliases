# Run each spec silently
#
# Useful when you want to test all files separately
# or in case of performance testing on another core[s].
# Assume 19s timeout (assuming 16s wait time and 3s loading time).
#
# Example usage (all files changed):
#   rspec_each
function rspec_each() {
  echorun spring_ensure_started rspec || return $?
  local rspec_each_COMMAND
  rspec_each_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_each_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_each_COMMAND+="silently gtimeout --foreground 19 spring rspec -f p $* {}"
  case $1 in
    "")
      changed_specs | parallel -v -j 1 "$rspec_each_COMMAND"
      ;;
    *)
      parallel -v -j 1 "$rspec_each_COMMAND" ::: $*
      ;;
  esac
  return $?
}
