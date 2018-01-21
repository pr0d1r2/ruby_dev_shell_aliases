function changed_specs() {
  git status -sb | grep _spec.rb | grep -v "^D  " | cut -b4- | sed -e 's/ -> /|/g' | cut -f 2 -d '|'
}
