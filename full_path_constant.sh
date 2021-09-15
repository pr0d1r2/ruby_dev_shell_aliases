# Example usage:
#
# full_path_constant "module X
#   module Y
#     class Z < Base
#       include HasA
#
#       CONSTANT"
#
# Will return:
#  X::Y::Z:::CONSTANT
function full_path_constant() {
  echo
  echo $@ | \
    sed -e 's/^[ \t]*//' | \
    grep -E "^(module|class|[A-Z])" | \
    sed -e 's/^module //' -e 's/class //' | \
    cut -f 2 -d '<' | \
    tr "\n" ":" | \
    tr -d " " | \
    sed -e 's/:/::/g' -e 's/::$//' -e 's/^/::/'
  echo
}
