function specs_using_changed_shared_examples() {
  test -d tmp/most_used_shared_examples || echorun most_used_shared_examples_determine || return $?
  git status -sb | \
    grep -E "^( M |M  |MM )" | \
    grep "\.rb$" | \
    grep '/shared_examples/' | \
    cut -b4- | \
    parallel 'cat tmp/most_used_shared_examples/{}.list' | \
    sort -u
}
