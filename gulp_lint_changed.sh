function gulp_lint_changed() {
  node_modules/.bin/gulp \
    --require coffee-script/register lint:ci \
    --modified_files=`git status --porcelain | grep -v "^D" | cut -c4-  | grep "\.coffee$" | tr "\n" ',' | sed 's/.coffee,$/.coffee/g'`
}
