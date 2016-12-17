function migrate_test() {
  bundle exec `rake_executable` db:migrate RAILS_ENV=test
}
