function parallelized_cucumber() {
  echo $@ | parallel --bar "source $RUBY_DEV_SHELL_ALIASES_PATH/parallelized_cucumber_thread.sh && parallelized_cucumber_thread {%} {}"
  return $?
}
