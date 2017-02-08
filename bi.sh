unalias bi
function bi() {
  local bi_BUNDLER_VERSION_PARAM=""
  if [ -e Gemfile.lock ]; then
    cat Gemfile.lock | grep -q 'BUNDLED WITH'
    if [ $? -eq 0 ]; then
      local bi_BUNDLED_WITH_VERSION=`echo $(tail -n1 Gemfile.lock)`
      bi_BUNDLER_VERSION_PARAM="_${bi_BUNDLED_WITH_VERSION}_"
      case `bundler --version | cut -f 3 -d ' '` in
        $bi_BUNDLED_WITH_VERSION)
          ;;
        *)
          echorun gem install bundler -v $bi_BUNDLED_WITH_VERSION
          ;;
      esac
    fi
  fi
  is_new_bundler
  if [ $? -eq 0 ]; then
    echorun bundle $bi_BUNDLER_VERSION_PARAM install -j`bundler_threads` || return $?
  else
    echorun bundle $bi_BUNDLER_VERSION_PARAM install || return $?
  fi
}
