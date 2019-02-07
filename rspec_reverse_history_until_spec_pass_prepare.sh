# Prepare tree to be used with rspec_revert_files_one_by_one_and_check_spec
#
# Example usage (make soft reset with depth as first parameter:
#   rspec_revert_files_one_by_one_and_check_spec_prepare 16
function rspec_revert_files_one_by_one_and_check_spec_prepare() {
  echorun git reset --soft "HEAD~$1" || return $?
  echorun git stash || return $?
  echorun git stash pop || return $?
}
