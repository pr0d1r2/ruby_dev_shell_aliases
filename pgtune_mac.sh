function pgtune_mac() {
  local pgtune_mac_CONFIG=$1
  local pgtune_mac_RELOAD=0
  local pgtune_mac_PG_VERSION
  local pgtune_mac_PG_VERSION_MAJOR
  local pgtune_mac_PG_VERSION_MINOR
  case $pgtune_mac_CONFIG in
    '')
      pgtune_mac_CONFIG="/usr/local/var/postgres/postgresql.conf"
      ;;
  esac
  if [ -f $pgtune_mac_CONFIG ]; then
    cat $pgtune_mac_CONFIG | grep -q "pgtune wizard"
    if [ $? -gt 0 ]; then
      echorun pgtune -T Web -i $pgtune_mac_CONFIG -o $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    cat $pgtune_mac_CONFIG | grep -q "full_page_writes = off"
    if [ $? -gt 0 ]; then
      echo "Disabling full_page_writes for better performance ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "full_page_writes = off" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    cat $pgtune_mac_CONFIG | grep -q "fsync = off"
    if [ $? -gt 0 ]; then
      echo "Disabling fsync for better performance ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "fsync = off" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    cat $pgtune_mac_CONFIG | grep -q "wal_level = minimal"
    if [ $? -gt 0 ]; then
      echo "Setting archive wal_level for better performance ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "wal_level = minimal" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    cat $pgtune_mac_CONFIG | grep -q "max_locks_per_transaction = 1024"
    if [ $? -gt 0 ]; then
      echo "Setting max_locks_per_transaction to work with huge databases ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "max_locks_per_transaction = 1024" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi

    # this will go when pgtune supports postgres 9.5+
    pgtune_mac_PG_VERSION=`psql --version | cut -f 2 -d \)`
    pgtune_mac_PG_VERSION_MAJOR=`echo $pgtune_mac_PG_VERSION | cut -f 1 -d .`
    pgtune_mac_PG_VERSION_MINOR=`echo $pgtune_mac_PG_VERSION | cut -f 2 -d .`
    if [ $pgtune_mac_PG_VERSION_MAJOR -eq 9 ]; then
      if [ $pgtune_mac_PG_VERSION_MINOR -gt 4 ]; then
        cat $pgtune_mac_CONFIG | grep -q "^checkpoint_segments"
        if [ $? -eq 0 ]; then
          echo "Removing checkpoint_segments as postgres versions >9.4 ..."
          cat $pgtune_mac_CONFIG | grep -v "^checkpoint_segments" > ~/.postgresql.conf.tmp || return $?
          mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
          pgtune_mac_RELOAD=1
        fi
      fi
    fi

    if [ $pgtune_mac_RELOAD -eq 1 ]; then
      pgreload_mac || return $?
    fi
  else
    echo
    echo "Config file does not exist: $pgtune_mac_CONFIG"
    echo
    return 8472
  fi
}
