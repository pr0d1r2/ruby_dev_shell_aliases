# Example usage:
#   CI_NODE_INDEX=0 CI_NODE_TOTAL=4 rubocop_sharded_thread
# Will run every 4th ruby file with RuboCop
function rubocop_sharded_thread() {
  bundle exec rubocop --parallel $(ruby_files_sharded $CI_NODE_INDEX $CI_NODE_TOTAL)
}
