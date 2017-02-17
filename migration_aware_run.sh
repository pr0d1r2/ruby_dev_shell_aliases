# Run commands in migration aware way
# This means command will not run more than once for given migration set
#
# Example usage:
#   migration_aware_run bundle exec rake parallel:create parallel:prepare
function migration_aware_run() {
  if [ ! -d db/migrate ]; then
    echo "Migration directory 'db/migrate' does not exist, exiting ..."
    return 1001
  fi
  local migration_aware_run_LAST_100_COMMITS_SUM=`git log --pretty=format:"%h - %an : %s" | head -n 100 | shasum -a 1 | cut -f 1 -d ' '`
  local migration_aware_run_MIGRATION_CHANGES_SUM=`git diff HEAD db/migrate | shasum -a 1 | cut -f 1 -d ' '`
  local migration_aware_run_LIST_SUFFIX="$$-$migration_aware_run_LAST_100_COMMITS_SUM-$migration_aware_run_MIGRATION_CHANGES_SUM"
  local migration_aware_run_LIST_MARKER="tmp/migration_aware_run_list_unsorted-$migration_aware_run_LIST_SUFFIX"
  local migration_aware_run_SORTED_LIST_MARKER="tmp/migration_aware_run_list_sorted-$migration_aware_run_LIST_SUFFIX"

  if [ ! -f $migration_aware_run_LIST_MARKER ]; then
    find db/migrate -type f | parallel -j `expr \`nproc\` \* 4` 'shasum -a 1 "{}"' 2>/dev/null > $migration_aware_run_LIST_MARKER
  fi
  if [ ! -f $migration_aware_run_SORTED_LIST_MARKER ]; then
    cat $migration_aware_run_LIST_MARKER | sort > $migration_aware_run_SORTED_LIST_MARKER
  fi
  local migration_aware_run_MIGRATION_SUM=`shasum -a 1 $migration_aware_run_SORTED_LIST_MARKER | cut -f 1 -d ' '`
  local migration_aware_run_COMMAND_SUM=`echo $@ | shasum -a 1 | cut -f 1 -d ' '`
  local migration_aware_run_MARKER="tmp/migration_aware_run-$migration_aware_run_MIGRATION_SUM-$migration_aware_run_COMMAND_SUM"
  if [ -f $migration_aware_run_MARKER ]; then
    local migration_aware_run_STATUS=`cat $migration_aware_run_MARKER.status`
    echo
    echo "Command already run with current migrations: $@"
    echo
    if [ $migration_aware_run_STATUS -eq 0 ]; then
      echo "It was SUCCESSFUL."
    else
      echo "It was FAILED."
    fi
    echo
    echo "To run it again please remove marker file:"
    echo "  rm -f $migration_aware_run_MARKER"
    echo
    echo "To see more details about run please do:"
    echo "  less $migration_aware_run_MARKER"
    echo
    tail $migration_aware_run_MARKER
    return $?
  else
    echorun $@ 2>&1 | tee -a $migration_aware_run_MARKER
    local migration_aware_run_STATUS=$?
    echo $migration_aware_run_STATUS > $migration_aware_run_MARKER.status
    return $migration_aware_run_STATUS
  fi
}
