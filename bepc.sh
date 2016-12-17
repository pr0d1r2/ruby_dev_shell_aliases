function bepc() {
  case $1 in
    '')
      DISABLE_SPRING=1 bundle exec parallel_cucumber features
      ;;
    *)
      DISABLE_SPRING=1 bundle exec parallel_cucumber $@
      ;;
  esac
  return $?
}
