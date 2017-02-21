function branchize() {
  echo "$@" | tr '[A-Z]' '[a-z]' | sed -e 's/[^a-z0-9]/-/g' -e 's/--/-/g' -e 's/--/-/g'
}
