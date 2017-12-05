# Run RuboCop in parallel for RSpec/AggregateFailures
#
# Example usage:
#   rubocop_parallel_specs_aggregate_failures -a
function rubocop_parallel_specs_aggregate_failures() {
  local rubocop_parallel_specs_aggregate_failures_COMMAND
  rubocop_parallel_specs_aggregate_failures_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rubocop_parallel_specs_aggregate_failures_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rubocop_parallel_specs_aggregate_failures_COMMAND+="silently rubocop --only RSpec/AggregateFailures $* {}"
  # shellcheck disable=SC2046
  spec_directories | parallel \
    'find {} -type f -iname "*.rb"' | \
      parallel "$rubocop_parallel_specs_aggregate_failures_COMMAND"

  return $?
}
