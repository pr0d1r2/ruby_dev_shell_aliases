function rspec_mutate_let_bang_to_let() {
  local rspec_mutate_let_bang_to_let_LET
  local rspec_mutate_let_bang_to_let_MARKER_NEEDS
  local rspec_mutate_let_bang_to_let_MARKER_NOT_NEEDS
  for rspec_mutate_let_bang_to_let_LET in $(rspec_lets "$1" | grep -v "_to_remove$")
  do
    echo
    rspec_mutate_let_bang_to_let_MARKER_NEEDS="tmp/needs_let_bang_instead_let/$1.needs.let.bang.instead.let.$rspec_mutate_let_bang_to_let_LET"
    rspec_mutate_let_bang_to_let_MARKER_NOT_NEEDS="tmp/possible_let_bang_instead_let/$1.possible.let.bang.instead.let.$rspec_mutate_let_bang_to_let_LET"

    if [ -d "$rspec_mutate_let_bang_to_let_MARKER_NEEDS" ]; then
      echo "The need for 'let\!(:$rspec_mutate_let_bang_to_let_LET)' in '$1' is confirmed by '$rspec_mutate_let_bang_to_let_MARKER_NEEDS'"
    else
      if [ -d "$rspec_mutate_let_bang_to_let_MARKER_NOT_NEEDS" ]; then
        echo "Possibility of 'let(:$rspec_mutate_let_bang_to_let_LET)' instead of 'let\!(:$rspec_mutate_let_bang_to_let_LET)' in '$1' is confirmed by '$rspec_mutate_let_bang_to_let_MARKER_NOT_NEEDS'"
        rpl -e "let\!(:${rspec_mutate_let_bang_to_let_LET})" "let(:${rspec_mutate_let_bang_to_let_LET})" "$1"
        git diff HEAD | cat
      else
        echo "Checking possibility of 'let(:$rspec_mutate_let_bang_to_let_LET)' instead of 'let\!(:$rspec_mutate_let_bang_to_let_LET)' in '$1' ..."
        rpl -e "let\!(:${rspec_mutate_let_bang_to_let_LET})" "let(:${rspec_mutate_let_bang_to_let_LET})" "$1"
        git diff HEAD | cat
        if (bundle exec rspec --fail-fast "$1"); then
          if (grep -q "$rspec_mutate_let_bang_to_let_LET" "$1" | grep -Ev "(let|let\!)\(:$rspec_mutate_let_bang_to_let_LET\)"); then
            echo "Not needed. The spec '$1' is passing and '$rspec_mutate_let_bang_to_let_LET' it is mentioned elsewhere in '$1' not in let context."
            mkdir -p "$rspec_mutate_let_bang_to_let_MARKER_NOT_NEEDS"
          else
            echo "Needed. The spec '$1' is passing but '$rspec_mutate_let_bang_to_let_LET' is NOT mentioned elsewhere in '$1' not in let context."
            git checkout "$1"
            mkdir -p "$rspec_mutate_let_bang_to_let_MARKER_NEEDS"
          fi
        else
          git checkout "$1"
          mkdir -p "$rspec_mutate_let_bang_to_let_MARKER_NEEDS"
        fi
      fi
    fi
  done
}
