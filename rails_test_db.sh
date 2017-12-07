function rails_test_db() {
  rails_database_config test database "$@"
  return $?
}
