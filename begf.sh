function begf() {
  ensure_command terminal-notifier || return $?
  beg $@ -w `git_directories_changed_vs_origin_master` || return $?
}
