function changed_shared_contexts() {
  git status -sb | grep '/shared_contexts/' | grep -v "^D  " | cut -b4- | sed -e 's/ -> /|/g' | cut -f 2 -d '|'
}
