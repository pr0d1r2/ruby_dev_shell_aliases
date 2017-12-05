function rails_test_db() {
  ruby -e "$(rails_database_config_snippet)['test']['database']"
  return $?
}
