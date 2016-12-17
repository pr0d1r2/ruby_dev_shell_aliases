function rspec_list_all_examples() {
  rspec --dry-run -f d $@ | grep "example at" | sed -e 's/example at .\//|/' | cut -f 2 -d '|' | sort | uniq
}
