function pgtune_mac() {
  local pgtune_mac_CONFIG=$1
  local pgtune_mac_RELOAD=0
  local pgtune_mac_PG_VERSION
  local pgtune_mac_PG_VERSION_MAJOR
  case $pgtune_mac_CONFIG in
    '')
      pgtune_mac_CONFIG="/usr/local/var/postgres/postgresql.conf"
      ;;
  esac
  if [ -f $pgtune_mac_CONFIG ]; then
    if ! (grep -q "pgtune wizard" $pgtune_mac_CONFIG); then
      echorun pgtune -T Web -i $pgtune_mac_CONFIG -o $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    if ! (grep -q "full_page_writes = off" $pgtune_mac_CONFIG); then
      echo "Disabling full_page_writes for better performance ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "full_page_writes = off" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    if ! (grep -q "fsync = off" $pgtune_mac_CONFIG); then
      echo "Disabling fsync for better performance ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "fsync = off" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi
    if ! (grep -q "max_locks_per_transaction = 1024" $pgtune_mac_CONFIG); then
      echo "Setting max_locks_per_transaction to work with huge databases ..."
      cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
      echo "max_locks_per_transaction = 1024" >> ~/.postgresql.conf.tmp || return $?
      mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
      pgtune_mac_RELOAD=1
    fi

    # this will go when pgtune supports postgres 9.5+
    pgtune_mac_PG_VERSION=$(psql --version | cut -f 2 -d ')' | cut -f 2 -d ' ')
    pgtune_mac_PG_VERSION_MAJOR=$(echo "$pgtune_mac_PG_VERSION" | cut -f 1 -d .)
    if [ "$pgtune_mac_PG_VERSION_MAJOR" -ge 9 ]; then
      if (grep -q "^checkpoint_segments" $pgtune_mac_CONFIG); then
        echo "Removing checkpoint_segments as postgres versions >=9 ..."
        grep -v "^checkpoint_segments" $pgtune_mac_CONFIG > ~/.postgresql.conf.tmp || return $?
        mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
        pgtune_mac_RELOAD=1
      fi
    fi
    if [ "$pgtune_mac_PG_VERSION_MAJOR" -ge 10 ]; then
      if ! (grep -q "wal_level = logical" $pgtune_mac_CONFIG); then
        echo "Setting logical wal_level for better performance ..."
        cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
        echo "wal_level = logical" >> ~/.postgresql.conf.tmp || return $?
        mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
        pgtune_mac_RELOAD=1
      fi
    else
      if ! (grep -q "wal_level = minimal" $pgtune_mac_CONFIG); then
        echo "Setting archive wal_level for better performance ..."
        cp $pgtune_mac_CONFIG ~/.postgresql.conf.tmp || return $?
        echo "wal_level = minimal" >> ~/.postgresql.conf.tmp || return $?
        mv ~/.postgresql.conf.tmp $pgtune_mac_CONFIG || return $?
        pgtune_mac_RELOAD=1
      fi
    fi

    if [ $pgtune_mac_RELOAD -eq 1 ]; then
      pgreload_mac $pgtune_mac_CONFIG || return $?
    fi
  else
    echo
    echo "Config file does not exist: $pgtune_mac_CONFIG"
    echo
    return 250
  fi
}
