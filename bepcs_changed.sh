function bepcs_changed() {
  git_files_changed | grep -q ".feature$"
  if [ $? -eq 0 ]; then
    split_feature_scenarios_and_run_in_parallel_all `git_files_changed | grep ".feature$"`
    return $?
  else
    echo "$0: No feature files changed!"
    return 8472
  fi
}
