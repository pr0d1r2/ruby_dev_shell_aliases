function jenkins_failed_lines() {
  local jenkins_failed_lines_STATUS
  local jenkins_failed_lines_CWD=`pwd -P`
  if [ ! -d ~/projects/jenkins_failed_lines ]; then
    git clone git@github.com:pr0d1r2/jenkins_failed_lines.git ~/projects/jenkins_failed_lines || return $?
    cd ~/projects/jenkins_failed_lines || return $?
    bi || return $?
  fi
  cd ~/projects/jenkins_failed_lines || return $?
  be ruby jenkins_failed_lines.rb $@
  jenkins_failed_lines_STATUS=$?
  cd $jenkins_failed_lines_CWD
  return $jenkins_failed_lines_STATUS
}
