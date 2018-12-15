# Return seed permutations to run with GNU parallel
#
# Example usage:
#   seed_permutations spec/my_spec.rb other_spec.rb:8472
# Will return:
#   spec/my_spec.rb+1 other_spec.rb:8472+1 spec/my_spec.rb+2 other_spec.rb:8472+2 ... spec/my_spec.rb+64 other_spec.rb:8472+64
#
# Example usage:
#   START=1 END=256 seed_permutations spec/my_spec.rb other_spec.rb:8472
#   spec/my_spec.rb+1 other_spec.rb:8472+1 spec/my_spec.rb+2 other_spec.rb:8472+2 ... spec/my_spec.rb+256 other_spec.rb:8472+256
# Will return:
function seed_permutations() {
  local seed_permutations_START
  local seed_permutations_END
  seed_permutations_START="$START"
  seed_permutations_END="$END"
  if [ -z "$seed_permutations_START" ]; then
    seed_permutations_START="1"
  fi
  if [ -z "$seed_permutations_END" ]; then
    seed_permutations_END="64"
  fi
  seq "$seed_permutations_START" "$seed_permutations_END" | \
    parallel "parallel -I '[]' 'echo [] | sed -e \"s/$/+{}/g\"' ::: $@"
}
