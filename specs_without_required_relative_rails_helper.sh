function specs_without_required_relative_rails_helper() {
  rg -l --type-add 'spec:*_spec.rb' -tspec "^RSpec.describe" $* | parallel "head -n 1 | grep -q \"require_relative.*rails_helper.\" {} || echo {}"
}
