function migration_aware_run_reset() {
  case $1 in
    "")
      local migration_aware_run_reset_PROJECTS_PATH
      migration_aware_run_reset_PROJECTS_PATH="$PROJECTS_PATH"
      case $migration_aware_run_reset_PROJECTS_PATH in
        "")
          migration_aware_run_reset_PROJECTS_PATH="$HOME/projects"
          ;;
      esac
      # shellcheck disable=SC2086
      migration_aware_run_reset_dirs \
        /tmp \
        "$(ls -d $migration_aware_run_reset_PROJECTS_PATH/*/tmp)" &>/dev/null || return $?
      ;;
    *)
      migration_aware_run_reset_dirs "$@" &>/dev/null || return $?
      ;;
  esac
}
