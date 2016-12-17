function unsplit_scenario_names() {
  echo
  local unsplit_scenario_names_LINE
  for unsplit_scenario_names_LINE in `echo $@ | tr ' ' "\n"`
  do
    case $unsplit_scenario_names_LINE in
      features/*feature_splitted*)
        echo $unsplit_scenario_names_LINE | \
          sed -e "s/\.feature_splitted\//.feature:/g" | \
          sed -e "s/\.feature:\(*.\)\.feature:\(*.\)/.feature:\1/g"
        ;;
    esac
  done
}
