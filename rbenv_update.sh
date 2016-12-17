function rbenv_update() {
  local rbenv_update_CWD=`pwd -P`
  cd ~/.rbenv || return $?
  git pull origin master || return $?
  cd ~/.rbenv/plugins/ruby-build || return $?
  git pull || return $?
  cd $rbenv_update_CWD || return $?
}
