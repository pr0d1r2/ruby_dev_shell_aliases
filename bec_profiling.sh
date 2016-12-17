function bec_profiling() {
  if [ `cat Gemfile | grep cucumber_characteristics | wc -l` -eq 0 ]; then
    echo
    echo "Please add gem 'cucumber_characteristics' to your Gemfile"
    echo
    return 1
  fi
  if [ ! -f features/support/cucumber_characteristics.rb ]; then
    echo "require 'cucumber_characteristics/autoload'" > features/support/cucumber_characteristics.rb
  fi
  bec --format CucumberCharacteristics::Formatter || return $?
}
