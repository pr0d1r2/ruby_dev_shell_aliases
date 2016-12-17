function capistrano_make_current_branch_deploy_to_staging() {
  local capistrano_make_current_branch_deploy_to_staging_BRANCH
  capistrano_make_current_branch_deploy_to_staging_BRANCH=`git_current_branch`
  echo "3c3
< set :branch, 'master'
---
> set :branch, '$capistrano_make_current_branch_deploy_to_staging_BRANCH'" | patch -p0 config/deploy/staging.rb
  return $?
}
