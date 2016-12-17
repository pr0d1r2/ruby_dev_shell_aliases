function db_bootstrap() {
  `rake_executable` db:drop db:create db:migrate db:setup
}
