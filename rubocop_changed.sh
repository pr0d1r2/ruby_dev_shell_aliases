function rubocop_changed() {
  git status --porcelain | grep -v "^D" | cut -c4- | grep "\.rb$" | grep -v "^db/schema.rb$" | xargs `rubocop_executable`
}
