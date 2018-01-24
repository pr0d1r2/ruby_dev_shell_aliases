function migration_aware_run_reset_dirs() {
  parallel \
    "find {} -type f -depth 1 -name 'migration_aware_run*'" \
    ::: "$@" | \
  parallel \
    "rm -f {}"
}
