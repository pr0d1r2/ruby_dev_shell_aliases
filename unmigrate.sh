function unmigrate() {
  git status -sb | \
    grep db/migrate/ | \
    sort | \
    tac | \
    parallel basename | \
    cut -f 1 -d _ | \
    parallel -j 1 --halt-on-error now,fail=1 "bundle exec rails db:migrate:down VERSION={}"
}
