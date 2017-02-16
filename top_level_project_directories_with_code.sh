function top_level_project_directories_with_code() {
  find $@ -depth 1 -type d | \
    grep -v "/vendor$" | \
    grep -v "/tmp$" | \
    grep -v "/test_results$" | \
    grep -v "/public$" | \
    grep -v "/docs$" | \
    grep -v "/node_modules$" | \
    grep -v "/log$" | \
    grep -v "/doc$" | \
    grep -v "/db$" | \
    grep -v "/bin$" | \
    grep -v "/coverage$" | \
    grep -v "/config$" | \
    grep -v "/\."
}
