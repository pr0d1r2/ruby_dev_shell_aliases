function watchflak() {
  case $1 in
    *_spec.rb)
      ;;
    *)
      echo "The first argument have to be path to RSpec specification file !!!"
      return 101
      ;;
  esac

  watchexec \
    --restart --shell zsh -w $1 \
    -- \
    "clear && source ~/.compiled_shell_aliases.sh && rspec_check_for_flakiness $1"
  return $?
}
