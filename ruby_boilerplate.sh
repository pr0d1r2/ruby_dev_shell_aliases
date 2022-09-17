function ruby_boilerplate() {
  test -f .ruby-version || echo 3.0.0 > .ruby-version
  test -f Gemfile || echo "# frozen_string_literal: true

ruby '3.0.0'

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
    bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000
  fi

  if ! (grep rubocop-rspec .rubocop.yml); then
    echo "require: rubocop-rspec" >> .rubocop.yml
    bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000
  fi

  if ! (grep 'NewCops: enable' .rubocop.yml); then
    echo "AllCops:
  NewCops: enable
  TargetRubyVersion: 3.0.0" >> .rubocop.yml
    bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000
  fi
}
