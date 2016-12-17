function smartspec() {
  bundle exec rspec `echo "$@" | \
    grep "^rspec" | \
    sed -e "s/spec\//#/" | \
    cut -f 2 -d "#" | \
    sed "s/^/spec\//g" | \
    tr "\n" " "`
}
