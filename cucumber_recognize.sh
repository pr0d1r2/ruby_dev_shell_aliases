# Recognize cucumbers from parameters
#
# Example usage:
#   cucumber_recognize xxx.feature yyy.feature:8472
function cucumber_recognize() {
  if [ -z "$1" ]; then
    echo "Please give cucumber[s] as parameter[s] !!!" 1>&2
    return 1
  fi
  parallel \
    "echo {} | grep -E \".*(.feature|.feature:\\d+)$\"" \
    ::: \
    "$@" | \
  sort -u | \
  parallel "test -f \$(echo {} | cut -f 1 -d :) && echo {}"
}
