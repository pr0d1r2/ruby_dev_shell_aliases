function jenkins_failed_command() {
  local jenkins_failed_command_STATUS
  local jenkins_failed_command_CWD=`pwd -P`
  ensure_jenkins_failed_lines_present || return $?
  cd ~/projects/jenkins_failed_lines || return $?
  be ruby jenkins_failed_command.rb $@
  jenkins_failed_command_STATUS=$?
  cd $jenkins_failed_command_CWD
  return $jenkins_failed_command_STATUS
}
