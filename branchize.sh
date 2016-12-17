function branchize() {
  echo "$@" | tr '[A-Z]' '[a-z]' | sed -e 's/[^a-z0-9]/-/g' | sed -e 's/--/-/g' | sed -e 's/--/-/g'
}
