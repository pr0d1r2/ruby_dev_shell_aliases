function number_of_scenarios() {
  local number_of_scenarios_FILE
  local number_of_scenarios_IN_FILE
  local number_of_scenarios_ALL=0
  for number_of_scenarios_IN_FILE in `ack -c Scenario features`
  do
    number_of_scenarios_FILE=`echo $number_of_scenarios_IN_FILE | cut -f 1 -d :`
    case $number_of_scenarios_FILE in
      *.feature)
        number_of_scenarios_IN_FILE=`echo $number_of_scenarios_IN_FILE | cut -f 2 -d :`
        ((number_of_scenarios_ALL=$number_of_scenarios_ALL+$number_of_scenarios_IN_FILE))
        ;;
    esac
  done
  echo $number_of_scenarios_ALL
}
