# List existing spec directories in the project
#
# Example usage:
#   spec_directories
function spec_directories() {
  ls -d spec engines/*/spec gems/*/spec 2>/dev/null || return $?
}
