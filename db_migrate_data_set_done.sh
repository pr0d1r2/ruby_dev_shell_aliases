# Set all data migrations as done without running them.
# Useful when having broken data migrations and just want to run unrelated project scripts.
#
# Script assumes using postgres
#
# Example usage:
#   db_migrate_data_set_done
function db_migrate_data_set_done() {
  db_set_done_versions db/migrate_data 14 data_migrations identifier
  return $?
}

