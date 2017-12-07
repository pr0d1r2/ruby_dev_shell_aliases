function rails_production_db() {
  rails_database_config production database "$@"
  return $?
}
