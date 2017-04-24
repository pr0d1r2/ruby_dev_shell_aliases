function postgres_ensure() {
  which postgres &>/dev/null
  if [ $? -gt 0 ]; then
    echorun brew install postgresql || return $?
    echorun brew services start postgresql || return $?
  fi
}
