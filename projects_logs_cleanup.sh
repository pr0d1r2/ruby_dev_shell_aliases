function projects_logs_cleanup() {
  for X in `ls -d ~/projects/*/log/*.log ~/projects/*/spec/internal/log/*.log ~/projects/*/spec/dummy/log/*.log`
  do
    echo -n > $X
  done
}
