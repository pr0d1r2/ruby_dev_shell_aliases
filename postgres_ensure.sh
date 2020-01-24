function postgres_ensure() {
  if (command -v postgres &>/dev/null); then
    echorun brew install postgresql || return $?
    echorun brew services start postgresql || return $?
  fi
  return 0
}
