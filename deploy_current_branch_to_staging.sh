function deploy_current_branch_to_staging() {
  capistrano_make_current_branch_deploy_to_staging || return $?
  bundle exec cap staging deploy || return $?
  git checkout config/deploy/staging.rb || return $?
}
