# Run RuboCop in parallel with bundled environment
#
# Example usage:
#   rubocop_parallel_bundled --only RSpec/AggregateFailures
function rubocop_parallel_bundled() {
  local rubocop_parallel_COMMAND
  rubocop_parallel_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rubocop_parallel_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rubocop_parallel_COMMAND+="silently bundle exec rubocop $* {}"
  find . -type f -iname "*.rb" | \
    parallel "$rubocop_parallel_COMMAND"

  return $?
}
