function rails_development_db() {
  ruby -e "$(rails_database_config_snippet)['development']['database']"
  return $?
}
