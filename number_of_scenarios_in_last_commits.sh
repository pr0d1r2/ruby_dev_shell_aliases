function number_of_scenarios_in_last_commits() {
  local number_of_scenarios_in_last_commits_COMMITS
  local number_of_scenarios_in_last_commits_COMMIT
  local number_of_scenarios_in_last_commits_BRANCH=`git status | grep "On branch" | cut -b11-`
  local number_of_scenarios_in_last_commits_NUMBER=$1
  for number_of_scenarios_in_last_commits_COMMIT in `git log --pretty=format:"%h" | head -n $number_of_scenarios_in_last_commits_NUMBER`
  do
    git checkout $number_of_scenarios_in_last_commits_COMMIT
    number_of_scenarios
  done
  git checkout $number_of_scenarios_in_last_commits_BRANCH
}
