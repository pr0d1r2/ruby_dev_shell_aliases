function ruby_boilerplate_tdd_on_guard() {
  echo "group :development do
  gem 'rspec', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rubocop-rspec', require: false
end" >> Gemfile

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

echo "--- a/Guardfile
+++ b/Guardfile
@@ -69,7 +69,13 @@ guard :rspec, cmd: "bundle exec rspec" do
   end
 end

-guard :rubocop do
+RUBOCOP_CONFIG = {
+  cli: '--display-cop-names --parallel',
+  all_on_start: true,
+  halt_on_fail: true
+}.freeze
+
+guard :rubocop, RUBOCOP_CONFIG do
   watch(%r{.+\.rb$})
   watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
 end" | patch -p1 || return $?

  if [ -d .git ]; then
    git add .rubocop.yml .rubocop_todo.yml Gemfile Gemfile.lock Guardfile || return $?
    git commit -a -m "Add Ruby TDD boilerplate"
  fi
}
