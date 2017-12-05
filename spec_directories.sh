function spec_directories() {
  ls -d spec engines/*/spec gems/*/spec 2>/dev/null || return $?
}
