function watchflak() {
  case $1 in
    *_spec.rb)
      ;;
    *)
      echo "The first argument have to be path to RSpec specification file !!!"
      return 101
      ;;
  esac

  local watchflak_COMMAND

  while [ $(ps -ax | grep bin/rspec | grep -v grep | wc -l) -gt 0 ]
  do
    echo "watchflak: killing remaining RSpec workers..."
    ps -ax | grep bin/rspec | grep -v grep | cut -b1-5 | parallel "kill {}"
    sleep 0.5
  done

  while [ $(ps -ax | grep bin/rspec | grep -v grep | wc -l) -gt 0 ]
  do
    echo "watchflak: killing remaining RSpec workers..."
    ps -ax | grep bin/rspec | grep -v grep | cut -b1-5 | parallel "kill -9 {}"
    sleep 0.5
  done

  clear || return $?

  watchexec \
    --restart --shell zsh -w $1 \
    -- \
    "clear && source ~/.compiled_shell_aliases.sh && rspec_check_for_flakiness $1"
  return $?
}
