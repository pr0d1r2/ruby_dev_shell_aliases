function rails_production_db() {
  ruby -e "$(rails_database_config_snippet)['production']['database']"
  return $?
}
