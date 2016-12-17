function beps() {
  case $1 in
    '')
      DISABLE_SPRING=1 bundle exec parallel_rspec -- --fail-fast -- spec
      ;;
    *)
      DISABLE_SPRING=1 bundle exec parallel_rspec -- --fail-fast -- $@
      ;;
  esac
  return $?
}
