# Search and replace in specs
#
# Example usage:
#  rpl_in_specs 'search string' 'replace string'
function rpl_in_specs() {
  if [ -z "$1" ]; then
    echo "Provide search string as the first parameter !!!"
    return 101
  fi
  if [ -z "$2" ]; then
    echo "Provide replacement string as the second parameter !!!"
    return 102
  fi
  spec_directories | \
    parallel "rg -l '$1' {}" | \
      parallel "rpl '$1' '$2' {}"
  return $?
}
