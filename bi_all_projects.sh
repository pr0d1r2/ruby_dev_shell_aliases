function bi_all_projects() {
  local bi_all_projects_GEMFILE
  for bi_all_projects_GEMFILE in `find ~/projects -name Gemfile`
  do
    echo "Running bi for $bi_all_projects_GEMFILE ..."
    cd `dirname $bi_all_projects_GEMFILE` && bi
  done
}
