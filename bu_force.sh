function bu_force() {
  while true; do
    bu $@ && return 0
    sleep 5
  done
}
