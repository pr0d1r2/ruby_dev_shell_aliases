# Run parallel specs for changed shared examples
#
# Example usage:
#   bepsc_shared_examples
function bepsc_shared_examples() {
  git_not_clean || return $?
  # shellcheck disable=SC2046
  echorun beps $(specs_using_changed_shared_examples | tr "\n" ' ') || return $?
}
