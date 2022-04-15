function specs_with_most_top_level_lets_creating_records() {
  find spec -type f -name "*_spec.rb" | parallel "echo -n {}/ && grep -c -E '^  (let\(|let\():.*create\(' {}" | parallel "echo {/}:{//}" | sort -V | tail -n 20
}
