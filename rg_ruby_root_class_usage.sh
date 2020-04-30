# Search for Ruby root classes (prefixed with "::") usage
#
# Rationale:
#   When implementing SOA, often you start with code separation within an engine.
#   Engines should not use root classes coming from Rails like models.
#
# Example usage:
#   rg_ruby_root_classes_usage engines/a engines/b engines/c
function rg_ruby_root_classes_usage() {
  parallel 'rg -e "[ \(]::[A-Z][a-z]+[\.\)]"' ::: "$@"
  return $?
}
