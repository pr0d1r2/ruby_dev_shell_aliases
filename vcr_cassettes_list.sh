vcr_cassettes_list() {
  if [ -f .vcr_cassettes_in ]; then
    cat .vcr_cassettes_in | \
      parallel "find {} -name '*.yml'" | \
      parallel 'basename {}' | \
      cut -f 1 -d .
  else
    find spec/fixtures/cassettes -name '*.yml' | \
      parallel 'basename {}' | \
      cut -f 1 -d .
  fi
}
