function spec_files_changed_now() {
  git_files_changed | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} "_spec.rb$"
}
