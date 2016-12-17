function gulp_lint_changed_in_branch() {
  node_modules/.bin/gulp \
    --require coffee-script/register lint:ci \
    --modified_files=`git_files_changed_vs_origin_master | grep "\.coffee$" | tr "\n" ','`
}
