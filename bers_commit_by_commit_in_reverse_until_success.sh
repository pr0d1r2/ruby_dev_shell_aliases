function bers_commit_by_commit_in_reverse_until_success() {
  local bers_commit_by_commit_in_reverse_until_success_STATUS=1
  while [ $bers_commit_by_commit_in_reverse_until_success_STATUS -gt 0 ]; do
    OVERCOMMIT_DISABLE=1 git checkout `git_previous_hash` || return $?
    bers --tag "~focus" $@
    bers_commit_by_commit_in_reverse_until_success_STATUS=$?
  done
  echo
  echo "$0: First successful commit: `git_current_hash`"
}
