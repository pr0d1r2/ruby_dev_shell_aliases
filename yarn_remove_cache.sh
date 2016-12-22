function yarn_remove_cache() {
  if [ -d $HOME/Library/Caches/Yarn ]; then
    echorun rm -rf $HOME/Library/Caches/Yarn || return $?
  fi
}
