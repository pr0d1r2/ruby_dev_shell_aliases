function cucumbers_must_pass_run() {
  cucumber_lines_run_in_parallel "$(cucumbers_must_pass)"
  return $?
}
