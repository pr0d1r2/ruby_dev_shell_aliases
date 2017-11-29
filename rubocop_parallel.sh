# Run RuboCop in parallel
#
# Example usage:
#   rubocop_parallel --only RSpec/AggregateFailures
function rubocop_parallel() {
  local rubocop_parallel_COMMAND
  rubocop_parallel_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rubocop_parallel_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rubocop_parallel_COMMAND+="silently rubocop $* {}"
  find . -type f -iname "*.rb" | \
    parallel "$rubocop_parallel_COMMAND"

  return $?
}
