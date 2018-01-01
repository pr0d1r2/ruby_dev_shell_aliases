# Search via ripgrep in factories directories.
#
# Example usage:
#   rg_factories "factory :user"
function rg_factories() {
  find . -type d -name factories | \
    parallel "parallel -I '<>' 'rg <> {}' ::: $*"
  return $?
}
