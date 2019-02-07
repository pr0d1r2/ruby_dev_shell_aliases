# Revert files one by one and run specs
#
# Useful to find corelations between files and failing spec.
# Before you need to do (to be able to actively checkout files, 16 is depth of soft reset):
#   rspec_revert_files_one_by_one_and_check_spec_prepare 16
#
# Example usage:
#   rspec_revert_files_one_by_one_and_check_spec spec/my_spec.rb
#
# To exclude files from being checked out add them as 2-9 params:
#   rspec_revert_files_one_by_one_and_check_spec spec/my_spec.rb app/my_model.rb config/any_other_file.yml
function rspec_revert_files_one_by_one_and_check_spec() {
  if [ -z "$1" ]; then
    echo "No spec file given as first parameter!"
    return 1
  fi
  case "$1" in
    ?*_spec.rb)
      ;;
    *)
      echo "First parameter is not a spec file!"
      return 2
      ;;
  esac
  local rspec_revert_files_one_by_one_and_check_spec_FILE_TO_REVERT
  for rspec_revert_files_one_by_one_and_check_spec_FILE_TO_REVERT in \
    $(git status -sb | \
      grep "M" | \
      cut -b4- | \
      grep -v "^$1$" | \
      grep -v "^$2$" | \
      grep -v "^$3$" | \
      grep -v "^$4$" | \
      grep -v "^$5$" | \
      grep -v "^$6$" | \
      grep -v "^$7$" | \
      grep -v "^$8$" | \
      grep -v "^$9$" | \
      grep -E -v "^(tests|testing|spec|features|db|.github|gems)/" | \
      grep -E -v "\.(js|sass|coffee|css|scss|example|png|jpg|jpeg|gif|ico|log|svg|md|gemspec)$" | \
      grep "/" | \
      grep -E -v "(.rspec|.gitkeep)$")
  do
    echorun silently git checkout "$rspec_revert_files_one_by_one_and_check_spec_FILE_TO_REVERT"
    case "$rspec_revert_files_one_by_one_and_check_spec_FILE_TO_REVERT" in
      Gemfile | Gemfile.lock)
        echorun silently bundle install || return $?
        ;;
    esac
    echorun silently_when_failing bundle exec rspec "$1" && return 0
  done
}
