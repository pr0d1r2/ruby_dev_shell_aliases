# Run parallel specs for files changed in branch
#
# Example usage:
#   bepsc_branch
# Or if you want to add extra files and directories:
#   bepsc_branch spec/my_spec.rb spec/my1 spec/my2
function bepsc_branch() {
  # shellcheck disable=SC2046,SC2068
  bepsc $(git_files_changed_in_branch) $@
  return $?
}
