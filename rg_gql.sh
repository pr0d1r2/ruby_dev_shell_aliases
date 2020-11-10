function rg_gql() {
  rg $@ $(parallel "find . -name {}" ::: graphql graphql_api | grep -v "^./node_modules")
}
