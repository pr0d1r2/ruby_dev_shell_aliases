function let_in_spec() {
  between_in_file "let(:$1) do" ' end' $2
  return $?
}
