function guard_stop_all() {
  kill_forcefully \
    "$(parallel "pgrep -f {}" ::: "gems/guard-rspec" "ruby .*bin/_guard-core" "bin/guard" 2>/dev/null)"
  return $?
}
