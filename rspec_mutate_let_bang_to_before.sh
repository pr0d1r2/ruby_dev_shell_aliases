function rspec_mutate_let_bang_to_before() {
  local rspec_mutate_let_bang_to_before_LET
  local rspec_mutate_let_bang_to_before_MARKER_NEEDS
  local rspec_mutate_let_bang_to_before_MARKER_NOT_NEEDS
  for rspec_mutate_let_bang_to_before_LET in $(rspec_lets "$1" | grep -v "_to_remove$")
  do
    echo
    rspec_mutate_let_bang_to_before_MARKER_NEEDS="tmp/needs_let_bang_instead_before/$1.needs.let.bang.instead.before.$rspec_mutate_let_bang_to_before_LET"
    rspec_mutate_let_bang_to_before_MARKER_NOT_NEEDS="tmp/possible_let_bang_instead_before/$1.possible.let.bang.instead.before.$rspec_mutate_let_bang_to_before_LET"

    if [ -d "$rspec_mutate_let_bang_to_before_MARKER_NEEDS" ]; then
      echo "The need for 'let\!(:$rspec_mutate_let_bang_to_before_LET)' in '$1' is confirmed by '$rspec_mutate_let_bang_to_before_MARKER_NEEDS'"
    else
      if [ -d "$rspec_mutate_let_bang_to_before_MARKER_NOT_NEEDS" ]; then
        echo "Possibility of 'before' instead of 'let\!(:$rspec_mutate_let_bang_to_before_LET)' in '$1' is confirmed by '$rspec_mutate_let_bang_to_before_MARKER_NOT_NEEDS'"
        rpl -e "let\!(:${rspec_mutate_let_bang_to_before_LET})" "before" "$1"
        git diff HEAD | cat
      else
        echo "Checking possibility of 'before' instead of 'let\!(:$rspec_mutate_let_bang_to_before_LET)' in '$1' ..."
        rpl -e "let\!(:${rspec_mutate_let_bang_to_before_LET})" "before" "$1"
        git diff HEAD | cat
        if (bundle exec rspec --fail-fast "$1"); then
          mkdir -p "$rspec_mutate_let_bang_to_before_MARKER_NOT_NEEDS"
        else
          git checkout "$1"
          mkdir -p "$rspec_mutate_let_bang_to_before_MARKER_NEEDS"
        fi
      fi
    fi
  done
}
