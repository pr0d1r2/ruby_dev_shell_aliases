# Run changed specs in parallel
# Supports changes in shared_examples and shared_contexts translated to specs files
#
# Example usage:
#   bepsc
# If you want to include extra file[s]:
#   beps spec/my_spec.rb
# If you want to include extra directories:
#   beps spec/my_dir spec/my_dir2
function bepsc() {
  if [ ! -d .git ]; then
    echo "$0: not a git repo!"
    return 1
  fi

  rspec_ensure_no_focus || return $?

  # shellcheck disable=SC2046
  echorun beps_files $(
    parallel \
      ::: \
      "git status -sb | grep -v '^##' | cut -b4- | grep -v '^D  ' | sed -e 's/ -> /|/g' | cut -f 2 -d '|'" \
      "parallel -I '<>' 'test -f <> && echo <>' ::: $*" \
      "parallel -I '<>' 'test -d <> && find <> -type f | grep _spec\.rb' ::: $*" \
      "source $HOME/projects/ruby_dev_shell_aliases/changed_shared_examples.sh && \
       source $HOME/projects/ruby_dev_shell_aliases/changed_specs_from_shared_examples.sh && \
       changed_specs_from_shared_examples" \
      "source $HOME/projects/ruby_dev_shell_aliases/changed_shared_contexts.sh && \
       source $HOME/projects/ruby_dev_shell_aliases/changed_specs_from_shared_contexts.sh && \
       changed_specs_from_shared_contexts" | \
    sort -u | \
    sed \
      -e 's/^app/spec/' \
      -e 's/^lib/spec\/lib/' \
      -e 's/.rb$/_spec.rb/' \
      -e 's/_spec_spec.rb$/_spec.rb/' | \
    sort -u | \
    grep '_spec.rb' | \
    parallel 'test -f {} && echo {}'
  )

  return $?
}
