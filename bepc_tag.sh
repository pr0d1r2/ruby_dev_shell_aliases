function bepc_tag() {
  ensure_command rg || return $?
  local bepc_tag_FILES=`rg -l $1 features | grep "feature$"`
  if [ `echo $bepc_tag_FILES | wc -l` -gt 0 ]; then
    if [ $? -gt 0 ]; then
      echo "bepc_tag: NO FILES !!!"
      return 8472
    else
      echorun bepc -- --tags $1 -- `one_liner $bepc_tag_FILES`
    fi
  fi
}
