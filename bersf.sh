function bersf() {
  git stash && git_pull_rebase_origin_master && git stash pop && bers_changed_vs_origin_master
  return $?
}
