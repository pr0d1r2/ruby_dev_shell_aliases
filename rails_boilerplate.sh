function rails_boilerplate() {
  if ! (rails --version | rails --version | grep -q " 7.0.5$"); then
    echo "Install supported rails version !!!"
    return 101
  fi

  rails new "$1" \
    --skip-test \
    --database=postgresql \
    --css=tailwind \
    --javascript=importmap \
    --asset-pipeline=sprockets \
    --ruby="$HOME/.rbenv/versions/3.2.2/bin/ruby" || return $?

  cd "$1" || return $?

  git add . || return $?
  git commit -a -m "Initialize Rails boilerplate with postgresql, tailwing, sprockets and importmap" || return $?


  echo "group :development, :test do
  gem 'rspec-rails', require: false
end" >> Gemfile

  bundle install || return $?
  bundle exec rails generate rspec:install || return $?
  bundle exec rspec || return $?

  git add . || return $?
  git commit -a -m "Add RSpec Rails support" || return $?


  ruby_boilerplate_tdd_on_guard || return $?


  echo "group :test do
  gem 'factory_bot_rails', require: false
end" >> Gemfile
  bundle install || return $?
  git add Gemfile Gemfile.lock || return $?
  git commit Gemfile Gemfile.lock -m "Add factory support" || return $?


  echo "diff --git a/config/application.rb b/config/application.rb
index 5581b51..d2be6cb 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -33,5 +33,9 @@ module CgtraderRails

     # Don't generate system test files.
     config.generators.system_tests = nil
+
+    config.generators do |g|
+      g.test_framework :rspec, spec: true, fixture: false, fixture_replacement: :factory_bot
+      g.factory_bot dir: 'spec/factories'
+    end
   end
 end" | patch -p1
  git add config/application.rb || return $?
  git commit config/application.rb -m "Generating model will also generate spec and factory"


  echo "diff --git a/.rubocop.yml b/.rubocop.yml
index f2cb7ec..17276f7 100644
--- a/.rubocop.yml
+++ b/.rubocop.yml
@@ -3,3 +3,5 @@ require: rubocop-rspec
 AllCops:
   NewCops: enable
   TargetRubyVersion: 3.2.2
+  Exclude:
+    - 'db/schema.rb'" | patch -p1 || return $?
  git add .rubocop.yml || return $?
  git commit .rubocop.yml -m "Ignore DB schema changes in RuboCop" || return $?
}
