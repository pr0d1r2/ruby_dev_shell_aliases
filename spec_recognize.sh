# Recognize specs from parameters
#
# If shared_example/shared_context given it returns files containing it.
# Spec files must exist.
#
# Example usage:
#   spec_recognize xxx_spec.rb yyy_spec.rb:8472 my_shared_examples.rb
function spec_recognize() {
  if [ -z "$1" ]; then
    echo "Please give spec[s] or shared_(context|examples) as parameter[s] !!!" 1>&2
    return 1
  fi
  local spec_recognize_SHARED_EXAMPLES_COMMAND
  spec_recognize_SHARED_EXAMPLES_COMMAND="source $HOME/projects/ruby_dev_shell_aliases/spec_directories.sh"
  spec_recognize_SHARED_EXAMPLES_COMMAND+=" && source $HOME/projects/ruby_dev_shell_aliases/rspec_files_containing_shared_examples_from_file.sh"
  spec_recognize_SHARED_EXAMPLES_COMMAND+=" && rspec_files_containing_shared_examples_from_file {}"
  parallel \
    "echo {} | grep -E \".*(_spec.rb|_spec.rb:\\d+)$\" || ($spec_recognize_SHARED_EXAMPLES_COMMAND)" \
    ::: \
    "$@" | \
  sort -u | \
  parallel "test -f \$(echo {} | cut -f 1 -d :) && echo {}"
}
