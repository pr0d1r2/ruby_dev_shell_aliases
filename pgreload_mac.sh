function pgreload_mac() {
  echorun brew services restart postgresql || return $?
}
