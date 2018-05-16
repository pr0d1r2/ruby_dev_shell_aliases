function rails_new_app() {
  parallel \
    'rails new {} -d postgresql -T &&
     cd {} &&
     git commit -a -m "Add tree generated with: rails new {} -d postgresql -T"
    ' \
    ::: \
    "$@"
  return $?
}
