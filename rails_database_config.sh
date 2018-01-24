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
  local rails_database_config_COMMAND
  local rails_database_config_CACHE_KEY
  local rails_database_config_CACHE_FILE
  rails_database_config_COMMAND="$(rails_database_config_snippet)['$rails_database_config_ENV']['$rails_database_config_NAME']"
  rails_database_config_CACHE_KEY="$(cd "$rails_database_config_WORKING_DIR" && pwd -P)___$rails_database_config_COMMAND"
  rails_database_config_CACHE_FILE="/tmp/.cache-rails_database_config-$(echo "$rails_database_config_CACHE_KEY" | shasum | cut -f 1 -d ' ')"
  if [ ! -f "$rails_database_config_CACHE_FILE" ]; then
    ruby \
      -X "$rails_database_config_WORKING_DIR" \
      -e "$rails_database_config_COMMAND" > "$rails_database_config_CACHE_FILE" || return $?
  fi
  cat "$rails_database_config_CACHE_FILE" || return $?
  return $?
}
