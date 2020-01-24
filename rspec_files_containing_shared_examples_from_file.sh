# Show spec files command -v include examples from file
#
# example usage:
#   rspec_files_containing_shared_examples_from_file spec/support/shared_examples/my_shared_examples.rb
function rspec_files_containing_shared_examples_from_file() {
  local rspec_files_containing_shared_examples_from_file_RECURSION_IGNORE
  # shellcheck disable=SC2116
  rspec_files_containing_shared_examples_from_file_RECURSION_IGNORE=$(IFS="|" echo "$*")
  case $IGNORE in
    "");;
    *)
      rspec_files_containing_shared_examples_from_file_RECURSION_IGNORE+="|$IGNORE"
      ;;
  esac
  # TODO: refactor
  # shellcheck disable=SC1117
  parallel \
    "test -f {} && grep -E \"shared_examples \\\"(.*)\\\"|shared_examples '(.*)'|shared_examples_for \\\"(.*)\\\"|shared_examples_for '(.*)'\" {} | \
     sed -e \"s/shared_examples \\\"/~/\" -e \"s/shared_examples '/~/\" -e \"s/shared_examples_for \\\"/~/\" -e \"s/shared_examples_for '/~/\" -e \"s/\\\" do/~/\" -e \"s/' do/~/\" | \
     cut -f 2 -d '~' | \
     parallel -I '<>' \"
        rg <> $(spec_directories | tr "\n" ' ') | \
        grep -E 'include_examples|it_behaves_like|it_should_behave_like' | \
        cut -f 1 -d : | \
        sort -u
     \" | \
     grep \"\\\.rb$\" | \
     sort -u" ::: \
    "$@" | sort -u | grep -vE "^$rspec_files_containing_shared_examples_from_file_RECURSION_IGNORE$" | \
      parallel "if (echo {} | grep -q \"_spec\\\.rb$\") then
         echo {}
       else
         source $HOME/projects/ruby_dev_shell_aliases/spec_directories.sh && \
         source $HOME/projects/ruby_dev_shell_aliases/rspec_files_containing_shared_examples_from_file.sh && \
         IGNORE='$rspec_files_containing_shared_examples_from_file_RECURSION_IGNORE' rspec_files_containing_shared_examples_from_file {}
       fi" | \
      sort -u
}
