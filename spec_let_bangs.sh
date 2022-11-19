function spec_let_bangs() {
  rg -F "let!(:" spec | grep let | cut -f 3 -d : | cut -f 1 -d ")" | sort -u
}
