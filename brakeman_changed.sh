function brakeman_changed() {
  brakeman --only-files `git status --porcelain | grep -v "^D" | cut -c4- | tr "\n" " "` .
}
