function cleanup_project() {
  clean_logs
  zero_dir tmp/rubycritic
  zero_dir tmp/capybara
  zero_dir tmp/cache
}
