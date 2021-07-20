function is_new_bundler() {
  local is_new_bundler_VERSION=`bundle --version | cut -f 3 -d ' '`
  local is_new_bundler_VERSION_MAJOR=`echo $is_new_bundler_VERSION | cut -f 1 -d .`
  local is_new_bundler_VERSION_MINOR=`echo $is_new_bundler_VERSION | cut -f 2 -d .`
  if [ $is_new_bundler_VERSION_MAJOR -gt 1 ]; then
    return 0
  else
    if [ $is_new_bundler_VERSION_MINOR -ge 4 ]; then
      return 0
    fi
  fi
  return 1
}
