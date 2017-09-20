function add_missing_slim_specs_for_changed_files() {
  git st  | grep slim | cut -b4- | \
    parallel "source ~/projects/ruby_dev_shell_aliases/spec_for.sh && spec_for {}" | \
      parallel "test -f {} || (test -d {//} || mkdir -p {//} ; touch {} && git add {} && echo {})" | \
        parallel 'echo "RSpec.describe \"$(echo {} | sed -e "s|^spec/views/||g" -e "s/\.html\.slim_spec\.rb$//g")\" do\n  specify do\n    is_expected.to have_text(\"TODO\")\n  end\nend" > {}'
}
