function most_used_shared_examples_determine() {
  find . -name shared_examples -type d | \
    parallel "find {} -type f -name '*.rb'" | \
      parallel -j1 \
        "test -f tmp/most_used_shared_examples/{}.list && exit 0
         test -d tmp/most_used_shared_examples/{//} || mkdir -p tmp/most_used_shared_examples/{//} && \
         source $HOME/.compiled_shell_aliases.sh && \
         rspec_files_containing_shared_examples_from_file {} > tmp/most_used_shared_examples/{}.list" || return $?
}
