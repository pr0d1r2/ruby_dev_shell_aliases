function postgres_vacuum_all_databases() {
  for postgres_vacuum_all_databases_DB in `postgres_databases`
  do
    echorun vacuumdb $postgres_vacuum_all_databases_DB
  done
  unset postgres_vacuum_all_databases_DB
}
