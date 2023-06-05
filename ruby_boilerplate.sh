function ruby_boilerplate() {
  test -f .ruby-version || echo 3.2.2 > .ruby-version
  test -f Gemfile || echo "# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'" > Gemfile

  ruby_boilerplate_tdd_on_guard || return $?

  test -d lib || mkdir lib || return $?
  test -d spec/lib || mkdir -p spec/lib || return $?

  echo "# frozen_string_literal: true

# Main TDD boilerplate
class Boilerplate
  def run
    'OK'
  end
end" > lib/boilerplate.rb || return $?

  echo "# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/boilerplate'

RSpec.describe Boilerplate do
  subject(:instance) { described_class.new }

  it do
    expect(instance.run).to eq('OK')
  end
end" > spec/lib/boilerplate_spec.rb || return $?

  bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000 || return $?

  if [ -d .git ]; then
    git add .rubocop_todo.yml lib/boilerplate.rb spec/lib/boilerplate_spec.rb || return $?
    git commit -a -m "Add Ruby TDD boilerplate containers"
  fi
}
