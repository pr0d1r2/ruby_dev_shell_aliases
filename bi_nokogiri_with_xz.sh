function bi_nokogiri_with_xz() {
  which xz &>/dev/null
  local bi_nokogiri_with_xz_NOT_PRESENT=$?
  if [ $bi_nokogiri_with_xz_NOT_PRESENT -eq 0 ]; then
    brew uninstall --ignore-dependencies --force xz || return $?
  fi
  bi_quiet || return $?
  if [ $bi_nokogiri_with_xz_NOT_PRESENT -eq 0 ]; then
    brew install xz || return $?
  fi
}
