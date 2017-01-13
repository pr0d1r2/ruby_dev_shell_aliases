function jenkins_failed_lines() {
  local jenkins_failed_lines_STATUS
  local jenkins_failed_lines_CWD=`pwd -P`
  ensure_jenkins_failed_lines_present || return $?
  cd ~/projects/jenkins_failed_lines || return $?
  be ruby jenkins_failed_lines.rb $@
  jenkins_failed_lines_STATUS=$?
  cd $jenkins_failed_lines_CWD
  return $jenkins_failed_lines_STATUS
}
