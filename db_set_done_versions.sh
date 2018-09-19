# Fill in versions of migrations
#
# Example usages:
#   db_set_done_versions db/migrate 14 schema_migrations version
#   db_set_done_versions db/migrate_data 14 data_migrations identifier
# Or:
#   db_set_done_versions db/migrate 14 schema_migrations version 201809191021 201809191200
#   db_set_done_versions db/migrate_data 14 data_migrations identifier 201809191021 201809191200
#
# Which translates to:
#   db_set_done_versions migrations_directory version_string_length database_table database_column
# Or:
#   db_set_done_versions migrations_directory version_string_length database_table database_column MIGRATION_TIMESTAMP1 MIGRATION_TIMESTAMP2
function db_set_done_versions() {
  case $5 in
    "")
      find "$1" -exec basename {} \; | cut -b "1-$2" | \
        parallel \
          -P "+$(nproc)" \
          "echo \"
             INSERT INTO $3 ($4)
             SELECT '{}' FROM $3
             WHERE NOT EXISTS (SELECT $4 FROM $3 WHERE $4 = '{}')
             LIMIT 1;\" |
           psql -U '$(rails_database_config development username)' -d '$(rails_development_db)' |
           grep -Ev \"^INSERT 0 [01]\""
      ;;
    *)
      parallel \
        -P "+$(nproc)" \
        "echo \"
           INSERT INTO $3 ($4)
           SELECT '{}' FROM $3
           WHERE NOT EXISTS (SELECT $4 FROM $3 WHERE $4 = '{}')
           LIMIT 1;\" |
         psql -U '$(rails_database_config development username)' -d '$(rails_development_db)'" \
         ::: \
         "${@:5}"
       ;;
  esac
  return $?
}
