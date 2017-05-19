# Run failed Jenkins lines on parallel cucumber threads
#
# Example usage:
#   jenkins_failed_lines https://jenkins.my.net/job/core-pr-features/8472/
function parallelized_cucumber_from_jenkins_failed_lines() {
  jenkins_failed_lines $@ | \
    parallel --bar "source $RUBY_DEV_SHELL_ALIASES_PATH/parallelized_cucumber_thread.sh && parallelized_cucumber_thread {%} {}"
}
