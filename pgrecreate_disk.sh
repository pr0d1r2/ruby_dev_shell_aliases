function pgrecreate_disk() {
  echorun brew services stop postgresql
  echorun rm -rf /usr/local/var/postgres || return $?
  echorun initdb /usr/local/var/postgres -E utf8 || return $?
  echorun brew services start postgresql
  echorun pgtune_mac
  echorun sleep 1
}
