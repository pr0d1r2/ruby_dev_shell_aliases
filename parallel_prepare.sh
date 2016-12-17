function parallel_prepare() {
  be rake parallel:create parallel:prepare || return $?
  RAILS_ENV=cucumber be rake parallel:create parallel:prepare || return $?
}
