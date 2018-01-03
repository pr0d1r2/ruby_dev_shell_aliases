# Show spec files which include examples from file
#
# example usage:
#   rspec_files_containing_shared_examples_from_file spec/support/shared_examples/my_shared_examples.rb
function rspec_files_containing_shared_examples_from_file() {
  parallel -j 1 \
    "grep shared_examples {} | \
     cut -f 2 -d \"'\" | \
     parallel -I '<>' \"
        rg <> $(spec_directories | tr "\n" ' ') | \
        grep -E 'include_examples|it_behaves_like|it_should_behave_like' | \
        cut -f 1 -d : | \
        sort -u
     \" | \
     grep \"\\\.rb$\" | \
     sort -u
    " \
    ::: \
    "$@" | sort -u | IFS="|" grep -vE "^($*)$" | \
      parallel -j 1 \
        "if (echo {} | grep -q \"_spec\\\.rb$\") then
           echo {}
         else
           echo FORK {}
           source $HOME/projects/ruby_dev_shell_aliases/spec_directories.sh && \
           source $HOME/projects/ruby_dev_shell_aliases/rspec_files_containing_shared_examples_from_file.sh && \
           rspec_files_containing_shared_examples_from_file {}
           echo POST FORK
         fi
        "
}
