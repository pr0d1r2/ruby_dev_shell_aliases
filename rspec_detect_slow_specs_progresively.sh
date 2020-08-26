# Detect slow specs progressively.
#
# By default it starts from 18s threshold and decreases it by 1 until 1.
# You can manipulate start-stop by using variables:
# SLOW_SPEC_THRESHOLD_START=12
# SLOW_SPEC_THRESHOLD_END=3
#
# Example usages:
#   rspec_detect_slow_specs_progresively spec/dir
#   rspec_detect_slow_specs_progresively spec/dir/prefix_*_spec.rb
#   rspec_detect_slow_specs_progresively spec/dir/exact_spec.rb
#   SLOW_SPEC_THRESHOLD_START=10 rspec_detect_slow_specs_progresively spec/dir
#   SLOW_SPEC_THRESHOLD_START=20 SLOW_SPEC_THRESHOLD_END=8 rspec_detect_slow_specs_progresively spec/dir
function rspec_detect_slow_specs_progresively() {
  local rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_START
  local rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_END
  local rspec_detect_slow_specs_progresively_COMMAND

  if [ -z "$SLOW_SPEC_THRESHOLD_START" ]; then
    rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_START="18"
  else
    rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_START="$SLOW_SPEC_THRESHOLD_START"
  fi
  if [ -z "$SLOW_SPEC_THRESHOLD_END" ]; then
    rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_END="1"
  else
    rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_END="$SLOW_SPEC_THRESHOLD_END"
  fi

  rspec_detect_slow_specs_progresively_COMMAND="source $PROJECTS_PATH/ruby_dev_shell_aliases/rspec_detect_slow_specs.sh && "
  rspec_detect_slow_specs_progresively_COMMAND+="SLOW_SPEC_THRESHOLD={} rspec_detect_slow_specs $@"

  seq "$rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_START" "$rspec_detect_slow_specs_progresively_SLOW_SPEC_THRESHOLD_END" | \
    parallel -v -j 1 "$rspec_detect_slow_specs_progresively_COMMAND"

  return $?
}
