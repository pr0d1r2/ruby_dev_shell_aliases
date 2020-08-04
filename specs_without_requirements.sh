function specs_without_requirements() {
  rg -l --type-add 'spec:*_spec.rb' -tspec "^RSpec.describe" $* | parallel "head -n 1 | grep -q 'require' {} || echo {}"
}
