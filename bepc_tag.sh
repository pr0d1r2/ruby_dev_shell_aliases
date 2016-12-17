function bepc_tag() {
  local bepc_tag_FILES=`ag -l $1 features | grep "feature$"`
  if [ `echo $bepc_tag_FILES | wc -l` -gt 0 ]; then
    if [ $? -gt 0 ]; then
      echo "bepc_tag: NO FILES !!!"
      return 8472
    else
      echorun bepc -- --tags $1 -- `one_liner $bepc_tag_FILES`
    fi
  fi
}
