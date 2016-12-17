function bec_tag() {
  local bec_tag_FILES=`ag -l $1 features | grep "feature$"`
  if [ `echo $bec_tag_FILES | wc -l` -gt 0 ]; then
    if [ $? -gt 0 ]; then
      echo "bec_tag: NO FILES !!!"
      return 8472
    else
      echorun bec --tags $1 `one_liner $bec_tag_FILES`
    fi
  fi
}
