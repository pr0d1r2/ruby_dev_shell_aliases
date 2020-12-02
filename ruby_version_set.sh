function ruby_version_set() {
  local ruby_version_set_VERSION
  case $1 in
    [0-9].[0-9] | [0-9].[0-9].[0-9])
      ruby_version_set_VERSION="$1"
      ;;
    *)
      ruby_version_set_VERSION="2.7.2"
      ;;
  esac
  echo "$ruby_version_set_VERSION" > .ruby-version || return $?
  sed -i '' -e "s/^ruby '[0-9.]\{1,\}'/ruby '$ruby_version_set_VERSION'/" Gemfile || return $?
  bi || return $?
}
