function feature_with_most_lines() {
  find features -iname "*.feature" -exec wc -l {} \; | grep -v ' total$' |  sort -n -k1
}
