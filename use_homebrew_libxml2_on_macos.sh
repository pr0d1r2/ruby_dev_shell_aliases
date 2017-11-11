function use_homebrew_libxml2_on_macos() {
  case $(uname) in
    Darwin);;
    *)
      echo 'This is only for macOS'
      return 1
      ;;
  esac
  local use_homebrew_libxml2_on_macos_CONFIG
  use_homebrew_libxml2_on_macos_CONFIG="$(ls /usr/local/Cellar/libxml2/*/bin/xml2-config)"
  if [ -e "$use_homebrew_libxml2_on_macos_CONFIG" ]; then
    echorun brew install libxml2 || return $?
  fi
  echorun bundle config build.libxml-ruby --with-xml2-config="$use_homebrew_libxml2_on_macos_CONFIG"
}
