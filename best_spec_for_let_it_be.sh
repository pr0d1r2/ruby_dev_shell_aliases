function best_spec_for_let_it_be() {
  local best_spec_for_let_it_be_MOST_EXAMPLES
  local best_spec_for_let_it_be_FILE
  local best_spec_for_let_it_be_NUMBER_OF_EXAMPLES
  local best_spec_for_let_it_be_NUMBER_OF_RECORDS
  local best_spec_for_let_it_be_THIS
  local best_spec_for_let_it_be_MAX
  local best_spec_for_let_it_be_BEST_FILE

  test -f tmp/specs_with_most_examples || specs_with_most_examples > tmp/specs_with_most_examples || return $?
  test -f tmp/specs_with_most_top_level_lets_creating_records || specs_with_most_top_level_lets_creating_records > tmp/specs_with_most_top_level_lets_creating_records || return $?

  best_spec_for_let_it_be_MAX=0
  for best_spec_for_let_it_be_MOST_EXAMPLES in $(tac tmp/specs_with_most_examples)
  do
    best_spec_for_let_it_be_FILE="$(echo "$best_spec_for_let_it_be_MOST_EXAMPLES" | cut -f 2 -d :)"
    best_spec_for_let_it_be_NUMBER_OF_EXAMPLES="$(echo "$best_spec_for_let_it_be_MOST_EXAMPLES" | cut -f 1 -d :)"
    best_spec_for_let_it_be_NUMBER_OF_RECORDS="$(cat tmp/specs_with_most_top_level_lets_creating_records | grep ":$best_spec_for_let_it_be_FILE$" | cut -f 1 -d :)"
    if [ -z "$best_spec_for_let_it_be_NUMBER_OF_RECORDS" ]; then
      best_spec_for_let_it_be_NUMBER_OF_RECORDS=0
    fi
    best_spec_for_let_it_be_THIS="$(( $best_spec_for_let_it_be_NUMBER_OF_EXAMPLES * $best_spec_for_let_it_be_NUMBER_OF_RECORDS ))"
    if [ "$best_spec_for_let_it_be_THIS" -gt "$best_spec_for_let_it_be_MAX" ]; then
      best_spec_for_let_it_be_MAX="$best_spec_for_let_it_be_THIS"
      best_spec_for_let_it_be_BEST_FILE="$best_spec_for_let_it_be_FILE"
    fi
  done

  echo "$best_spec_for_let_it_be_BEST_FILE"
}
