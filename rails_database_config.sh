function rails_database_config() {
  local rails_database_config_ENV
  local rails_database_config_NAME
  local rails_database_config_WORKING_DIR
  case $1 in
    "") rails_database_config_ENV="development";;
    *) rails_database_config_ENV="$1";;
  esac
  case $2 in
    "") rails_database_config_NAME="database";;
    *) rails_database_config_NAME="$2";;
  esac
  case $3 in
    "") rails_database_config_WORKING_DIR=".";;
    *) rails_database_config_WORKING_DIR="$3";;
  esac
  ruby \
    -X "$rails_database_config_WORKING_DIR" \
    -e "$(rails_database_config_snippet)['$rails_database_config_ENV']['$rails_database_config_NAME']"
  return $?
}
