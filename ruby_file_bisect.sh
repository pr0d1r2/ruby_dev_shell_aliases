# Go to git commit and checkout files one-by-one to check command -v one fails command
#
# Example usage:
#   ruby_file_bisect d8472 bin/test
function ruby_file_bisect() {
  echorun silently overcommit_disable git checkout "$1" || return $?
  echorun silently overcommit_disable git reset --soft HEAD~1 || return $?
  echorun silently overcommit_disable git stash || return $?
  echorun silently overcommit_disable git stash pop || return $?

  local ruby_file_bisect_COMMAND
  ruby_file_bisect_COMMAND+="; source $HOME/projects/common_shell_aliases/silently.sh"
  ruby_file_bisect_COMMAND+="; source $HOME/projects/common_shell_aliases/silently_when_failing.sh"
  ruby_file_bisect_COMMAND+="; source $HOME/projects/osx_shell_aliases/md5sum.sh" ## Darwin
  ruby_file_bisect_COMMAND+="; silently git checkout {} || return 0 "
  # shellcheck disable=SC2124
  ruby_file_bisect_COMMAND+="; silently_when_failing ${@:2} && echo {}"

  git_files_changed | tac | \
    parallel -v -j1 --halt now,success=1 "$ruby_file_bisect_COMMAND"
}
