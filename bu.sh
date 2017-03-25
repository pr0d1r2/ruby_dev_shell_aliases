unalias bu 2>/dev/null
function bu() {
  is_new_bundler
  if [ $? -eq 0 ]; then
    echorun bundle update -j`bundler_threads` $@ || return $?
  else
    echorun bundle update $@ || return $?
  fi
}
