# Ensure spring is started.
# Useful when runing commands on GNU parallel or xargs
#
# Example usage:
#   spring_ensure_started && parallel "spring rake {}" ::: foo bar baz
function spring_ensure_started() {
  spring status | grep -q " spring server | " || spring &>/dev/null || return $?
}
