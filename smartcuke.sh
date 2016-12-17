function smartcuke() {
  bundle exec cucumber `echo "$@" | \
    grep "^cucumber" | \
    sed -e "s/features\//#/" | \
    cut -f 2 -d "#" | \
    sed "s/^/features\//g" | \
    tr "\n" " "`
}
