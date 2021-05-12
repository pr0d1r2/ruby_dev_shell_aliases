function spec_files_changed_in_branch() {
  git_files_changed_in_branch | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} "_spec.rb$"
}
