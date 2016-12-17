function pow_rc_file_create() {
  echo 'if [ -f "$rvm_path/scripts/rvm" ]; then' > .powrc
  echo '  source "$rvm_path/scripts/rvm"' >> .powrc
  echo '' >> .powrc
  echo '  if [ -f ".rvmrc" ]; then' >> .powrc
  echo '    source ".rvmrc"' >> .powrc
  echo '  fi' >> .powrc
  echo '' >> .powrc
  echo '  if [ -f ".ruby-version" ]; then' >> .powrc
  echo '    rvm use `cat .ruby-version`' >> .powrc
  echo '  fi' >> .powrc
  echo '' >> .powrc
  echo '  if [ -f ".ruby-gemset" ]; then' >> .powrc
  echo '    rvm gemset use --create `cat .ruby-gemset`' >> .powrc
  echo '  fi' >> .powrc
  echo 'fi' >> .powrc
}
