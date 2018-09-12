unalias bi 2>/dev/null
function bi() {
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
