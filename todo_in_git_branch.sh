function todo_in_git_branch() {
  if (git_diff_in_branch | grep TODO); then
    echo "TODO found in git branch diff !!!"
    return 1
  fi
}
