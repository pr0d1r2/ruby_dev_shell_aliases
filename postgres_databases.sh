function postgres_databases() {
  psql -l | \
    cut -f 1 -d \| | \
    grep -v "List of databases" | \
    grep -v Name | \
    grep -v "\-\-\-" | \
    grep -v " rows)" |
    grep -v postgres | \
    grep -v template0 | \
    grep -v template1
}
