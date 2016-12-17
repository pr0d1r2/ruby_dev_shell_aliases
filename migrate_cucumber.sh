function migrate_cucumber() {
  bundle exec `rake_executable` db:migrate RAILS_ENV=cucumber
}
