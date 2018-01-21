function changed_specs_from_shared_contexts() {
  changed_shared_contexts | \
    parallel -j1 \
      "source $HOME/projects/ruby_dev_shell_aliases/spec_directories.sh && \
       source $HOME/projects/ruby_dev_shell_aliases/rspec_files_containing_shared_contexts_from_file.sh && \
       rspec_files_containing_shared_contexts_from_file {}" | \
    sort -u
  return $?
}
