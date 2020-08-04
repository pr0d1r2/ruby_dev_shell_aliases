# Show path to closest relative rails_helper
#
# Example usage #1:
#   closest_relative_rails_helper spec/my_spec.sh
# Will return:
#   rails_helper
#
# Example usage #2:
#   closest_relative_rails_helper spec/whatever/my_spec.sh
# Will return:
#   ../rails_helper
#
# Example usage #3 (if the engine is containing it at engines/fancy/spec/rails_helper):
#   closest_relative_rails_helper engines/fancy/spec/whatever/my_spec.sh
# Will return:
#   ../rails_helper
function closest_relative_rails_helper() {
  local closest_relative_rails_helper_START_DIR
  local closest_relative_rails_helper_DIR
  local closest_relative_rails_helper_PATH
  local closest_relative_rails_helper_ABSOLUTE_PATH
  closest_relative_rails_helper_START_DIR="$(pwd -P)"
  closest_relative_rails_helper_PATH="rails_helper"
  closest_relative_rails_helper_DIR="$(dirname "$1")"
  cd "$closest_relative_rails_helper_DIR" || return $?
  while true; do
    closest_relative_rails_helper_ABSOLUTE_PATH="$(pwd -P)"
    if [ -f "rails_helper.rb" ]; then
      break
    fi
    case "$closest_relative_rails_helper_START_DIR" in
      "$closest_relative_rails_helper_ABSOLUTE_PATH")
        break
        ;;
    esac
    closest_relative_rails_helper_PATH="../$closest_relative_rails_helper_PATH"
    cd ..
  done
  cd "$closest_relative_rails_helper_START_DIR" || return $?
  echo "$closest_relative_rails_helper_PATH"
}
