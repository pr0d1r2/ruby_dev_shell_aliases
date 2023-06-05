function ruby_boilerplate() {
  test -f .ruby-version || echo 3.2.2 > .ruby-version
  test -f Gemfile || echo "# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

group :development do
  gem 'rspec', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rubocop-rspec', require: false
end" > Gemfile

  bundle install || return $?

  if [ ! -f Guardfile ]; then
    bundle exec guard init rspec || return $?
    bundle exec guard init rubocop || return $?
  fi

  if [ ! -f .rubocop_todo.yml ]; then
    bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000 || return $?
  fi

  if ! (grep rubocop-rspec .rubocop.yml); then
    echo "require: rubocop-rspec" >> .rubocop.yml
    bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000 || return $?
  fi

  if ! (grep 'NewCops: enable' .rubocop.yml); then
    echo "AllCops:
  NewCops: enable
  TargetRubyVersion: 3.2.2" >> .rubocop.yml
    bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000 || return $?
  fi

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
    grep "^\.bundle/$" .gitignore || echo ".bundle/" >> .gitignore || return $?
    git add .rubocop.yml .rubocop_todo.yml .ruby-version Gemfile Gemfile.lock Guardfile lib/boilerplate.rb spec/lib/boilerplate_spec.rb .gitignore || return $?
    git commit -a -m "Add Ruby TDD boilerplate"
  fi
}
