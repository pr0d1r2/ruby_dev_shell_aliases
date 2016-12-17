function migrate_all() {
  migrate_development &
  migrate_test &
  migrate_cucumber &
  wait
}
