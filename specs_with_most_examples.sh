function specs_with_most_examples() {
  find spec -type f -name "*_spec.rb" | parallel "echo -n {}/ && grep -c -E ' (it|specify) ' {}" | parallel "echo {/}:{//}" | sort -V
}
