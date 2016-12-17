function spec_with_most_lines() {
  find spec -iname "*_spec.rb" -exec wc -l {} \; | grep -v ' total$' | sort -n -k1
}
