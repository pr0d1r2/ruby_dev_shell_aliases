function most_used_shared_examples_show() {
  test -d tmp/most_used_shared_examples || echorun most_used_shared_examples_determine || return $?
  find tmp/most_used_shared_examples -size +0 -type f -exec ls -lSr {} + | \
      awk '{ print $9 }' | parallel "wc -l {}" | \
        parallel "echo {} | sed -e 's|tmp/most_used_shared_examples/||'" -e 's/.list$//' | sort
}
