function rspec_mutate_let_bang_removal() {
  local rspec_mutate_let_bang_removal_LET
  local rspec_mutate_let_bang_removal_MARKER_NEEDS
  local rspec_mutate_let_bang_removal_MARKER_NOT_NEEDS
  for rspec_mutate_let_bang_removal_LET in $(rspec_lets "$1" | grep -v "_to_remove$")
  do
    echo
    rspec_mutate_let_bang_removal_MARKER_NEEDS="tmp/needs_let/$1.needs.let.$rspec_mutate_let_bang_removal_LET"
    rspec_mutate_let_bang_removal_MARKER_NOT_NEEDS="tmp/does_not_need_let/$1.does.not.need.let.$rspec_mutate_let_bang_removal_LET"

    if [ -d "$rspec_mutate_let_bang_removal_MARKER_NEEDS" ]; then
      echo "The need for 'let!(:$rspec_mutate_let_bang_removal_LET)' in '$1' is confirmed by '$rspec_mutate_let_bang_removal_MARKER_NEEDS'"
    else
      if [ -d "$rspec_mutate_let_bang_removal_MARKER_NOT_NEEDS" ]; then
        echo "No need for 'let!(:$rspec_mutate_let_bang_removal_LET)' in '$1' is confirmed by '$rspec_mutate_let_bang_removal_MARKER_NOT_NEEDS'"
        rpl -e "let\!(:${rspec_mutate_let_bang_removal_LET})" "let\!(:${rspec_mutate_let_bang_removal_LET}_to_remove)" "$1"
        git diff HEAD | cat
      else
        echo "Checking the need for 'let!(:$rspec_mutate_let_bang_removal_LET)' in '$1' ..."
        rpl -e "let\!(:${rspec_mutate_let_bang_removal_LET})" "let\!(:${rspec_mutate_let_bang_removal_LET}_to_remove)" "$1"
        git diff HEAD | cat
        if (bundle exec rspec --fail-fast "$1"); then
          mkdir -p "$rspec_mutate_let_bang_removal_MARKER_NOT_NEEDS"
        else
          git checkout "$1"
          mkdir -p "$rspec_mutate_let_bang_removal_MARKER_NEEDS"
        fi
      fi
    fi
  done
}
