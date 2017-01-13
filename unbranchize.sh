# Make sentence out of branch name for use as commit message
#
# Usage:
# unbranchize my-example-branch-name
# => My example branch name
function unbranchize() {
  echo $@ | tr '-' ' ' | perl -pe 's/(.)/\u$1/'
}
