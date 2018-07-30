# Set all migrations as done without running them.
# Useful when having broken migrations and just want to run unrelated project scripts.
#
# Script assumes using postgres
#
# Example usage:
#   db_migrate_set_done
function db_migrate_set_done() {
  db_set_done_versions db/migrate 14 schema_migrations version
  return $?
}
