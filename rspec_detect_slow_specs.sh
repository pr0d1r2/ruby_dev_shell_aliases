# Detect slow specs.
#
# By default any spec over 18s threshold is considered slow.
# It uses half of processing threads for stability purposes.
#
# Example usages:
#   rspec_detect_slow_specs spec/dir
#   rspec_detect_slow_specs spec/dir/prefix_*_spec.rb
#   rspec_detect_slow_specs spec/dir/exact_spec.rb
#   SLOW_SPEC_THRESHOLD=5 rspec_detect_slow_specs spec/dir
function rspec_detect_slow_specs() {
  local rspec_detect_slow_specs_COMMAND
  local rspec_detect_slow_specs_TMP
  local rspec_detect_slow_specs_SLOW_SPEC_THRESHOLD
  if [ -z "$SLOW_SPEC_THRESHOLD" ]; then
    rspec_detect_slow_specs_SLOW_SPEC_THRESHOLD="18"
  else
    rspec_detect_slow_specs_SLOW_SPEC_THRESHOLD="$SLOW_SPEC_THRESHOLD"
  fi
  rspec_detect_slow_specs_TMP="$(mktemp -d)"
  rspec_detect_slow_specs_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_detect_slow_specs_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_detect_slow_specs_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec -f json -o '$rspec_detect_slow_specs_TMP/{%}.json' {} ;"
  rspec_detect_slow_specs_COMMAND+="cat '$rspec_detect_slow_specs_TMP/{%}.json' | jq '.summary.duration' | cut -f 1 -d . > '$rspec_detect_slow_specs_TMP/{%}.time' ;"
  rspec_detect_slow_specs_COMMAND+="test \$(cat '$rspec_detect_slow_specs_TMP/{%}.time') -gt $rspec_detect_slow_specs_SLOW_SPEC_THRESHOLD && echo {}"
  parallel "find {} -type f -name '*_spec.rb'" ::: $@ | \
    parallel -j "$(( $(nproc) / 2 ))" "$rspec_detect_slow_specs_COMMAND"
  rm -rf "$rspec_detect_slow_specs_TMP" || return $?
}
