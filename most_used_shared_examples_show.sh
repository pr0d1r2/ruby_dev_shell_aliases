function most_used_shared_examples_show() {
  test -d most_used_shared_examples || echorun most_used_shared_examples_determine || return $?
  find most_used_shared_examples -size +0 -type f -exec ls -lSr {} + | \
      awk '{ print $9 }' | parallel "wc -l {}" | \
        parallel "echo {} | sed -e 's|most_used_shared_examples/||'" -e 's/.list$//' | sort
}
