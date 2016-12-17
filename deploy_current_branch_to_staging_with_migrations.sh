function deploy_current_branch_to_staging_with_migrations() {
  capistrano_make_current_branch_deploy_to_staging || return $?
  bundle exec cap staging deploy:migrations || return $?
  git checkout config/deploy/staging.rb || return $?
}
