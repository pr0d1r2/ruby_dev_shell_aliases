# Useful for testing separate run of files to decrease rails_helper dependency
#
# Example usage:
#   beps_each_file_separately spec/dir1 spec/dir2
function beps_each_file_separately() {
  local beps_each_file_separately_COMMAND
  beps_each_file_separately_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  beps_each_file_separately_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  beps_each_file_separately_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec -f p --fail-fast {}"
  rg -l --type-add 'spec:*_spec.rb' -tspec "^RSpec.describe" $* | parallel -v "$beps_each_file_separately_COMMAND"
}
