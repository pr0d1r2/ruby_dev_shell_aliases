function rails_migration_bool_int_fix() {
  rg 't.bool ' db/migrate -l | parallel "rpl 't.bool ' 't.boolean ' {}"
  rg 't.int ' db/migrate -l | parallel "rpl 't.int ' 't.integer ' {}"
}
