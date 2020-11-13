# Update gems requested by bundle outdated
#
# Example usage:
#   bundle_outdated_update
function bundle_outdated_update() {
  bundle update $(bundle outdated | grep "^  * " |  awk '{ print $2 }' | sort -u)
  return $?
}
