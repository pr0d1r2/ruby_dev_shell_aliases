function pgrecreate() {
  local pgrecreate_ANSWER
  echo "pgrecreate: I will remove /usr/local/var/postgres and recreate it from scratch!!! Are you sure? [type upcase 'YES']"
  read pgrecreate_ANSWER
  case $pgrecreate_ANSWER in
    YES)
       echorun brew services stop postgresql
       echorun rm -rf /usr/local/var/postgres
       echorun initdb /usr/local/var/postgres -E utf8
       echorun brew services start postgresql
       case `uname` in
         Darwin)
           echorun pgtune_mac
           ;;
       esac
      ;;
    *)
      return 8472
      ;;
  esac
}
