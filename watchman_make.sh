function watchman_make() {
  watchman-make -p '**/*.*' --make=$HOME/projects/shell_aliases_compiler/bin/shell_wrapper.sh -t $@
}
