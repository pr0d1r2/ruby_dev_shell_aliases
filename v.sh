function v() {
  local v_FILE
  local v_QUERY
  for v_QUERY in $@
  do
    for v_FILE in `fzf -0 -1 -q $v_QUERY`
    do
      mvim $v_FILE
    done
  done
}
