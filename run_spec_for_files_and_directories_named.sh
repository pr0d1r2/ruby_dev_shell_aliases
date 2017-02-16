function run_spec_for_files_and_directories_named() {
  run_spec_for `top_level_project_directories_with_code . | parallel "find -f '{}' -- -name '$@'" 2>/dev/null`
}
