function most_used_shared_examples_open_in_mvim() {
  most_used_shared_examples_show | \
    sed -e 's| spec/|~spec/|' -e 's| engines/|~engines/|' | \
    cut -f 2 -d '~' | \
      parallel -j1 'mvim {}'
  return $?
}
