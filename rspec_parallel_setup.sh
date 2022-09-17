function rspec_parallel_setup() {
  seq 1 $(nproc) | parallel "TEST_ENV_NUMBER={%} RAILS_ENV=test bin/rake db:drop db:create db:environment:set db:schema:load db:migrate"
}
