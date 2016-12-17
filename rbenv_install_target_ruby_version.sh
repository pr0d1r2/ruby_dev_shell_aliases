function rbenv_install_target_ruby_version() {
  if [ -f .rubocop.yml ]; then
    cat .rubocop.yml | grep -q TargetRubyVersion:
    if [ $? -eq 0 ]; then
      local rbenv_install_target_ruby_version_VERSION=`echo $(cat .rubocop.yml | grep TargetRubyVersion: | cut -f 2 -d :)`
      cd ~/.rbenv/plugins/ruby-build || return 1003
      git pull || git pull || return 1004
      cd - || return 1005
      local rbenv_install_target_ruby_version_PATCHED_VERSION=`echo $(rbenv install --list | grep "  $rbenv_install_target_ruby_version_VERSION" | sort | tail -n 1)`
      rbenv version | cut -f 1 -d ' ' | grep -q $rbenv_install_target_ruby_version_PATCHED_VERSION
      if [ $? -gt 0 ]; then
        rbenv local $rbenv_install_target_ruby_version_PATCHED_VERSION
        if [ $? -gt 0 ]; then
          rbenv install $rbenv_install_target_ruby_version_PATCHED_VERSION
          rbenv local $rbenv_install_target_ruby_version_PATCHED_VERSION || return 1006
        fi
      fi
      bi || return 1007
    else
      echo "No TargetRubyVersion in .rubocop.yml file. Exiting ..."
      return 1002
    fi
  else
    echo "No .rubocop.yml file. Exiting ..."
    return 1001
  fi
}
