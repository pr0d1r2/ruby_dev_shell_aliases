# Example usage #1:
#   prepend_spec_with_closest_require_relative_rails_helper spec/my_spec.sh
# Will add following line to spec/my_spec.sh
#   require_relative 'rails_helper'
#
# Example usage #2:
#   prepend_spec_with_closest_require_relative_rails_helper spec/whatever/my_spec.sh
# Will add following line to spec/whatever/my_spec.sh
#   require_relative '../rails_helper'
#
# Example usage #3 (if the engine is containing it at engines/fancy/spec/rails_helper):
#   prepend_spec_with_closest_require_relative_rails_helper engines/fancy/spec/whatever/my_spec.sh
# Will add following line to engines/fancy/spec/whatever/my_spec.sh
#   require_relative '../rails_helper'
function prepend_spec_with_closest_require_relative_rails_helper() {
  prepend_file "$1" "require_relative '$(closest_relative_rails_helper "$1")'\n"
}
