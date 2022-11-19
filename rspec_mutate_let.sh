function rspec_mutate_let() {
  local rspec_mutate_let_FUNCTION
  for rspec_mutate_let_FUNCTION in \
    rspec_mutate_let_bang_to_let \
    rspec_mutate_let_bang_to_before \
    rspec_mutate_let_bang_removal \
    rspec_mutate_let_removal
  do
    $rspec_mutate_let_FUNCTION "$1"
  done
  bundle exec rubocop "$1" || bundle exec rubocop "$1" -A || bundle exec rubocop "$1"
}
