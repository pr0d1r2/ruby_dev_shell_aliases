# Makes following warning to dissapear when using rbenv:
#   warning: ignoring extraneous `ruby-' prefix in version `ruby-x.y.z'
# Example usage:
#   cd project_directory && rbenv_ignore_extraneous_ruby_prefix_warning
function rbenv_ignore_extraneous_ruby_prefix_warning() {
  test -f .ruby-version || return 0
  grep -q "^ruby-" < .ruby-version || return 0
  local rbenv_ignore_extraneous_ruby_prefix_warning_VERSION
  local rbenv_ignore_extraneous_ruby_prefix_warning_VERSION_LINK
  rbenv_ignore_extraneous_ruby_prefix_warning_VERSION="$(cut -f2- -d - < .ruby-version)"
  rbenv_ignore_extraneous_ruby_prefix_warning_VERSION_LINK="$(rbenv root)/versions/ruby-$rbenv_ignore_extraneous_ruby_prefix_warning_VERSION"
  test -L "$rbenv_ignore_extraneous_ruby_prefix_warning_VERSION_LINK" && return 0
  ln -sv \
    "$rbenv_ignore_extraneous_ruby_prefix_warning_VERSION" \
    "$rbenv_ignore_extraneous_ruby_prefix_warning_VERSION_LINK"
  return $?
}
