# Mark cucumbers that must pass for this branch.
# When run without parameters lists them.
#
# Example usage:
#   cucumbers_must_pass features/my.feature features/other.feature:8472
#
# And then list:
#   cucumbers_must_pass
# Returns:
#   features/my.feature
#   features/other.feature:8472
function cucumbers_must_pass() {
  local cucumbers_must_pass_FILE
  cucumbers_must_pass_FILE="tmp/.cucumbers_must_pass-$(git_current_branch)"
  git_current_branch
  case $1 in
    "")
      sort < "$cucumbers_must_pass_FILE" | uniq
      ;;
    *)
      parallel \
        -j 1 \
        "test -f {= '\$_' =~ /([^:]+)/; =} && echo {}" \
        ::: \
        "$@" 1>> "$cucumbers_must_pass_FILE" 2>/dev/null
      ;;
  esac
}
