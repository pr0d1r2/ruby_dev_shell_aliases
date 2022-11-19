function spec_let_bangs_replace_with_ordered_before() {
  rg -l -F "let!(:" spec | parallel "rpl 'let!(:' 'let(:' {}"

  local spec_let_bangs_replace_with_ordered_before_FILE
  local spec_let_bangs_replace_with_ordered_before_LET

  for spec_let_bangs_replace_with_ordered_before_FILE in $(git_files_changed_in_branch)
  do
    cat "$spec_let_bangs_replace_with_ordered_before_FILE" | grep -v "^end" > "$spec_let_bangs_replace_with_ordered_before_FILE.tmp"
    mv "$spec_let_bangs_replace_with_ordered_before_FILE.tmp" "$spec_let_bangs_replace_with_ordered_before_FILE"

    echo "  before do" >> "$spec_let_bangs_replace_with_ordered_before_FILE"
    for spec_let_bangs_replace_with_ordered_before_LET in $(git diff HEAD "$spec_let_bangs_replace_with_ordered_before_FILE" | grep '^+ ' | cut -f 2 -d : | cut -f 1 -d ')' | grep -e "[a-z]+")
    do
      echo "    $spec_let_bangs_replace_with_ordered_before_LET" >> "$spec_let_bangs_replace_with_ordered_before_FILE"
    done
    echo "  end" >> "$spec_let_bangs_replace_with_ordered_before_FILE"
    echo "end" >> "$spec_let_bangs_replace_with_ordered_before_FILE"

    echorun silently bundle exec rubocop -A "$spec_let_bangs_replace_with_ordered_before_FILE"

    # TODO: when ready - remove
    return 1
  done
}
