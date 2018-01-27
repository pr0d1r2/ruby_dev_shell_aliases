function mvim_changed() {
  git status --porcelain | grep -v "^D" | cut -c4- | \
    parallel "mvim {}"
}
