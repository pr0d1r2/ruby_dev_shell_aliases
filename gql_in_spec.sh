function gql_in_spec() {
  between_in_file '~GRAPHQL' ' GRAPHQ' $1
  return $?
}
