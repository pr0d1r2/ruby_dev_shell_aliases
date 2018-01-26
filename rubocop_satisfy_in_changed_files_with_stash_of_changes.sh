# This is useful when you want to prepare separate branch in which you fix RuboCop offences first.
# Changes are stashed.
#
# Example usage:
#   rubocop_satisfy_in_changed_files_with_stash_of_changes
# Or if you want to run extra command in the chain:
#   rubocop_satisfy_in_changed_files_with_stash_of_changes my_command with parameters
function rubocop_satisfy_in_changed_files_with_stash_of_changes() {
  local rubocop_satisfy_in_changed_files_with_stash_of_changes_LIST
  local rubocop_satisfy_in_changed_files_with_stash_of_changes_COMMAND
  rubocop_satisfy_in_changed_files_with_stash_of_changes_LIST=($(git status -sb | cut -b4-))
  rubocop_satisfy_in_changed_files_with_stash_of_changes_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rubocop_satisfy_in_changed_files_with_stash_of_changes_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rubocop_satisfy_in_changed_files_with_stash_of_changes_COMMAND+="silently rubocop -a {}"
  case $1 in
    "");;
    *)
      rubocop_satisfy_in_changed_files_with_stash_of_changes_COMMAND+="; silently $*"
      ;;
  esac

  OVERCOMMIT_DISABLE=1 git stash || return $?
  parallel \
    "$rubocop_satisfy_in_changed_files_with_stash_of_changes_COMMAND" \
    ::: \
    "${rubocop_satisfy_in_changed_files_with_stash_of_changes_LIST[@]}"
  return $?
}
