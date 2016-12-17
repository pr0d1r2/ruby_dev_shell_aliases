function ack_dotenv_contents() {
  for ack_dotenv_contents_VAR in `cat $1 | cut -f 1 -d = | tr "\n" " "`
  do
    ack_dotenv_contents_VALUE="`cat $1 | grep ^$ack_dotenv_contents_VAR | cut -f 2 -d = | cut -f 2 -d '"'`"
    case $ack_dotenv_contents_VALUE in
      "")
        ;;
      *)
        ack -Q "$ack_dotenv_contents_VALUE" spec/
        ;;
    esac
  done
  unset ack_dotenv_contents_VAR
  unset ack_dotenv_contents_VALUE
}
