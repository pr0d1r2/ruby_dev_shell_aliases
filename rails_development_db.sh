function rails_development_db() {
  rails_database_config development database "$@"
  return $?
}
