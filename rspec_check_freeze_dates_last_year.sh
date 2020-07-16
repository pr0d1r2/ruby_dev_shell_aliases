# Check freezing time in examples for last year dates descending
# It outputs only successful cases
#
# Example usage:
#   rspec_check_freeze_dates_last_year spec/my_spec.rb
# Results in following commands run in parallel:
#   FREEZE=2020-07-15 TEST_ENV_NUMBER=1 bundle exec rspec spec/my_spec.rb
#   FREEZE=2020-07-14 TEST_ENV_NUMBER=2 bundle exec rspec spec/my_spec.rb
#   ...
#   FREEZE=YYYY-MM-DD TEST_ENV_NUMBER=N bundle exec rspec spec/my_spec.rb
function rspec_check_freeze_dates_last_year() {
  local rspec_check_freeze_dates_last_year_COMMAND
  rspec_check_freeze_dates_last_year_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh"
  rspec_check_freeze_dates_last_year_COMMAND+="; source $HOME/projects/common_shell_aliases/silently_when_failing.sh"
  rspec_check_freeze_dates_last_year_COMMAND+="; source $HOME/projects/osx_shell_aliases/md5sum.sh" ## Darwin
  # shellcheck disable=SC2124
  rspec_check_freeze_dates_last_year_COMMAND+="; FREEZE={} TEST_ENV_NUMBER={%} silently_when_failing bundle exec rspec $1 && echo 'OK: {}'"
  last_year_dates | parallel "$rspec_check_freeze_dates_last_year_COMMAND"
}
