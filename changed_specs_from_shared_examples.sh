function changed_specs_from_shared_examples() {
  changed_shared_examples | \
    parallel -j1 \
      "source $HOME/projects/ruby_dev_shell_aliases/spec_directories.sh && \
       source $HOME/projects/ruby_dev_shell_aliases/rspec_files_containing_shared_examples_from_file.sh && \
       rspec_files_containing_shared_examples_from_file {}" | \
    sort -u
  return $?
}
