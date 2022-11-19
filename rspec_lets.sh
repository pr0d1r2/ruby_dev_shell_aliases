function rspec_lets() {
  cat "$1" | grep -E "(let|let\!)\(:" | cut -f 2 -d : | cut -f 1 -d ')' | sort -u
}
