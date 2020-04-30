# Show Rails model classes
#
# Example usage:
#   show_model_classes
function show_model_classes() {
  rg -g '!app/models/concerns' -e "(^| )class [A-Z]" app/models/ | cut -f 2 -d : | grep -v "^#" | cut -f 1 -d '<' | sed -e 's/^[ \t]*//' | sort -u
}
