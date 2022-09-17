# Example usage:
#   ruby_files_sharded 0 4
# Will run every 4th ruby file with RuboCop.
#
# Example usage (Typical usage in GitHub actions):
#   ruby_files_sharded $CI_NODE_INDEX $CI_NODE_TOTAL
function ruby_files_sharded() {
  # TODO: https://www.google.com/search?client=safari&rls=en&q=unix+awk+every+nth+line&ie=UTF-8&oe=UTF-8
  ruby_files_sharded_INDEX=$(expr $1 + 1)
  ruby_files_sharded_TOTAL=$2
  find . -type f -name "*_spec.rb" | gawk "NR%$ruby_files_sharded_TOTAL==$ruby_files_sharded_INDEX"
}
