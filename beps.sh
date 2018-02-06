function beps() {
  case $1 in
    '')
      DISABLE_SPRING=1 bundle exec parallel_rspec -- --fail-fast -- spec
      ;;
    *)
      case $2 in
        '')
          spring rspec --fail-fast "$@"
          ;;
        *)
          DISABLE_SPRING=1 bundle exec parallel_rspec -- --fail-fast -- "$@"
          ;;
      esac
      ;;
  esac
  return $?
}
