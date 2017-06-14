vcr_cassettes_list() {
  find spec/fixtures/cassettes -name "*.yml" | parallel basename {} | cut -f 1 -d .
}
