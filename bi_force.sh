function bi_force() {
  while true; do
    bi && return 0
    sleep 5
  done
}
