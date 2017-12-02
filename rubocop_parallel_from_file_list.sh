# Run RuboCop in parallel
#
# Example usage:
#   rubocop_parallel_from_file_list my_listing_of_files_to_check.txt --only RSpec/AggregateFailures
function rubocop_parallel_from_file_list() {
  local rubocop_parallel_from_file_list_COMMAND
  rubocop_parallel_from_file_list_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rubocop_parallel_from_file_list_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rubocop_parallel_from_file_list_COMMAND+="silently rubocop ${*:2} {}"
  parallel cat "$@" | \
    parallel "$rubocop_parallel_from_file_list_COMMAND"

  return $?
}
