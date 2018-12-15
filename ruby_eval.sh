function ruby_eval() {
  ruby -e "puts $@" || return $?
}
