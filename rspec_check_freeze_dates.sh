# Check freezing time in examples for file changes timestamps
#
# Example usage:
#   rspec_check_freeze_dates spec/my_spec.rb
# Results in following commands run in parallel:
#   FREEZE=2019-06-15 TEST_ENV_NUMBER=1 bundle exec rspec spec/my_spec.rb
#   FREEZE=2020-06-13 TEST_ENV_NUMBER=2 bundle exec rspec spec/my_spec.rb
#   FREEZE=2020-06-15 TEST_ENV_NUMBER=3 bundle exec rspec spec/my_spec.rb
#   ...
#   FREEZE=YYYY-MM-DD TEST_ENV_NUMBER=N bundle exec rspec spec/my_spec.rb

function rspec_check_freeze_dates() {
  git_file_changed_dates $1 | \
    parallel "FREEZE={} TEST_ENV_NUMBER={%} bundle exec rspec $1"
  return $?
}
