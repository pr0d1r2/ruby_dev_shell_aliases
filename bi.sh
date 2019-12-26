# Installs full ruby project bundle with required ruby and bundler versions
#
# Example usage:
#   bi
unalias bi 2>/dev/null # unaliasing
function bi() {
  if [ -e .ruby-version ]; then
    if [ -x "$HOME/.rbenv/bin/rbenv" ]; then
      local bi_RUBY_VERSION
      bi_RUBY_VERSION="$(cat .ruby-version | sed -e 's/ruby-//g')"
      if ($HOME/.rbenv/bin/rbenv local "$bi_RUBY_VERSION" 2>&1 | grep -q "not installed"); then
        echo "Ruby version $bi_RUBY_VERSION not present, installing..."
        cd "$HOME/.rbenv/plugins/ruby-build" || return $?
        git pull || return $?
        cd - || return $?
        $HOME/.rbenv/bin/rbenv install "$bi_RUBY_VERSION" || return $?
        $HOME/.rbenv/bin/rbenv local "$bi_RUBY_VERSION" || return $?
      fi
    fi
  fi
  if [ -e Gemfile.lock ]; then
    if grep -q 'BUNDLED WITH' Gemfile.lock; then
      local bi_BUNDLED_WITH_VERSION
      local bi_BUNDLER_VERSION_PARAM
      bi_BUNDLED_WITH_VERSION=$(tail -n1 Gemfile.lock | awk '{gsub(/^ +| +$/,"")}1')
      bi_BUNDLER_VERSION_PARAM="_${bi_BUNDLED_WITH_VERSION}_"
      case "$(bundle "$bi_BUNDLER_VERSION_PARAM" version | cut -f 3 -d ' ')" in
        "$bi_BUNDLED_WITH_VERSION")
          ;;
        *)
          echorun gem install bundler -v "$bi_BUNDLED_WITH_VERSION"
          ;;
      esac
    fi
  fi
  if is_new_bundler; then
    echorun bundle "$bi_BUNDLER_VERSION_PARAM" install -j "$(bundler_threads)" || return $?
  else
    echorun bundle "$bi_BUNDLER_VERSION_PARAM" install || return $?
  fi
}
