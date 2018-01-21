function changed_shared_examples() {
  git status -sb | grep '/shared_examples/' | grep -v "^D  " | cut -b4- | sed -e 's/ -> /|/g' | cut -f 2 -d '|'
}
