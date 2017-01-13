function ensure_jenkins_failed_lines_present() {
  if [ ! -d ~/projects/jenkins_failed_lines ]; then
    git clone git@github.com:pr0d1r2/jenkins_failed_lines.git ~/projects/jenkins_failed_lines || return $?
    cd ~/projects/jenkins_failed_lines || return $?
    bi || return $?
  else
    cd ~/projects/jenkins_failed_lines || return $?
    git pull &>/dev/null
    bi &>/dev/null
  fi
}
