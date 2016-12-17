function gem_versions() {
  curl_cached https://rubygems.org/gems/$1/versions | grep t-list__item | cut -f 2 -d \> | cut -f 1 -d \<
}
