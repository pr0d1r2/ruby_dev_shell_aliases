# Checks for flakiness related to id added to factory creation
#
# Example usage:
#   rspec_detect_id_related_flakiness
function rspec_detect_id_related_flakiness() {
  echorun rspec_check_for_flakiness $(rg -l "create.+, id: [0-9'\"]" | grep "_spec.rb$") || return $?
}
