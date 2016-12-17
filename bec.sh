function bec() {
  bundle exec `cucumber_executable` $@ || return $?
}
