function postgres_ensure() {
  if (command -v postgres &>/dev/null); then
    echorun brew install postgresql$1 || return $?
    echorun brew services start postgresql$1 || return $?
  fi
  return 0
}
