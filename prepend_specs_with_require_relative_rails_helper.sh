# Prepend all specs that do not have requirements with rails helper
#
# Example usage:
#   prepend_specs_with_require_relative_rails_helper spec/dir1 spec/dir2
function prepend_specs_with_require_relative_rails_helper() {
  local prepend_specs_with_require_relative_rails_helper_COMMAND
  prepend_specs_with_require_relative_rails_helper_COMMAND="source $HOME/projects/common_shell_aliases/prepend_file.sh && "
  prepend_specs_with_require_relative_rails_helper_COMMAND+="source $HOME/projects/ruby_dev_shell_aliases/closest_relative_rails_helper.sh && "
  prepend_specs_with_require_relative_rails_helper_COMMAND+="source $HOME/projects/ruby_dev_shell_aliases/prepend_spec_with_closest_require_relative_rails_helper.sh && "
  prepend_specs_with_require_relative_rails_helper_COMMAND+="prepend_spec_with_closest_require_relative_rails_helper {}"
  specs_without_required_relative_rails_helper $* | parallel "$prepend_specs_with_require_relative_rails_helper_COMMAND"
}
