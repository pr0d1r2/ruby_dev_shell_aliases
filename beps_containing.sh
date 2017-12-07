# Run parallel specs containing certain string
#
# Example usage:
#   beps_containing 'name of some shared context'
function beps_containing() {
  spec_directories | \
    parallel "rg -l '$1' {}" | grep "_spec.rb$" | \
      parallel -v 'TEST_ENV_NUMBER={%} bundle exec rspec -f p {}'
}
