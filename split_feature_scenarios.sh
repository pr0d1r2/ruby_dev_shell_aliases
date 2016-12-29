function split_feature_scenarios() {
  local split_feature_scenarios_FEATURE
  local split_feature_scenarios_FEATURE_FILES=()
  local split_feature_scenarios_FEATURE_FILE
  local split_feature_scenarios_SPLITTED_FILE
  local split_feature_scenarios_SPLITTED_DIR

  for split_feature_scenarios_FEATURE in $@
  do
    if [ -d $split_feature_scenarios_FEATURE ]; then
      for split_feature_scenarios_FEATURE_FILE in `find $split_feature_scenarios_FEATURE -type f -name "*.feature"`
      do
        split_feature_scenarios $split_feature_scenarios_FEATURE_FILE || return $?
      done
    fi
  done

  local split_feature_scenarios_LINES
  local split_feature_scenarios_FIRST_SCENARIO_LINE
  local split_feature_scenarios_CONTENT_BEFORE_FIRST_SCENARIO
  local split_feature_scenarios_LINE
  local split_feature_scenarios_ENDING_LINE
  local split_feature_scenarios_DIRECTORY
  local split_feature_scenarios_SPLITTED_FILE_LINES
  local split_feature_scenarios_EXAMPLES_LINE
  local split_feature_scenarios_SPLITTED_EXAMPLES_DIRECTORY
  local split_feature_scenarios_SPLITTED_EXAMPLES_FILE
  local split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER
  local split_feature_scenarios_TOTAL_LINES
  for split_feature_scenarios_FEATURE in $@
  do
    if [ -f $split_feature_scenarios_FEATURE ]; then
      split_feature_scenarios_TOTAL_LINES=`echo $(cat $split_feature_scenarios_FEATURE | wc -l)`
      split_feature_scenarios_LINES_REMAINING=`cucumber_scenarios_or_tags_at_lines $split_feature_scenarios_FEATURE`
      split_feature_scenarios_FIRST_SCENARIO_LINE=`echo $split_feature_scenarios_LINES_REMAINING | head -n 1`
      split_feature_scenarios_CONTENT_BEFORE_FIRST_SCENARIO=`cat $split_feature_scenarios_FEATURE | head -n \`expr $split_feature_scenarios_FIRST_SCENARIO_LINE - 1\``
      split_feature_scenarios_DIRECTORY="${split_feature_scenarios_FEATURE}_splitted"
      if [ ! -d $split_feature_scenarios_DIRECTORY ]; then
        mkdir $split_feature_scenarios_DIRECTORY
      fi
      for split_feature_scenarios_LINE in `cucumber_scenarios_or_tags_at_lines $split_feature_scenarios_FEATURE`
      do
        split_feature_scenarios_LINES_REMAINING=`echo $split_feature_scenarios_LINES_REMAINING | grep -v "^$split_feature_scenarios_LINE$"`
        split_feature_scenarios_ENDING_LINE=`expr \`echo $split_feature_scenarios_LINES_REMAINING | head -n 1\` - 1 2>/dev/null`
        if [ $? -gt 0 ]; then
          split_feature_scenarios_ENDING_LINE=$split_feature_scenarios_TOTAL_LINES
        fi

        split_feature_scenarios_SPLITTED_FILE="$split_feature_scenarios_DIRECTORY/$split_feature_scenarios_LINE.feature"
        echo $split_feature_scenarios_CONTENT_BEFORE_FIRST_SCENARIO > $split_feature_scenarios_SPLITTED_FILE
        sed -n $split_feature_scenarios_LINE,${split_feature_scenarios_ENDING_LINE}p $split_feature_scenarios_FEATURE >> $split_feature_scenarios_SPLITTED_FILE
        cat $split_feature_scenarios_SPLITTED_FILE | grep -q "Scenario Outline: "
        if [ $? -eq 0 ]; then
          split_feature_scenarios_SPLITTED_FILE_LINES=`echo $(cat $split_feature_scenarios_SPLITTED_FILE | wc -l)`
          split_feature_scenarios_SPLITTED_EXAMPLES_DIRECTORY="${split_feature_scenarios_SPLITTED_FILE}_examples"
          if [ ! -d $split_feature_scenarios_SPLITTED_EXAMPLES_DIRECTORY ]; then
            mkdir -p $split_feature_scenarios_SPLITTED_EXAMPLES_DIRECTORY
          fi
          for split_feature_scenarios_EXAMPLES_LINE in `grep -n "Examples:" $split_feature_scenarios_SPLITTED_FILE | cut -f 1 -d :`
          do
            split_feature_scenarios_EXAMPLES_LINE=`expr $split_feature_scenarios_EXAMPLES_LINE + 1`
            split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER=`expr $split_feature_scenarios_EXAMPLES_LINE + 1`
            while [ $split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER -lt $split_feature_scenarios_SPLITTED_FILE_LINES ]; do
              split_feature_scenarios_SPLITTED_EXAMPLES_FILE="$split_feature_scenarios_SPLITTED_EXAMPLES_DIRECTORY/$split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER.feature"
              sed -n 1,${split_feature_scenarios_EXAMPLES_LINE}p $split_feature_scenarios_SPLITTED_FILE > $split_feature_scenarios_SPLITTED_EXAMPLES_FILE
              sed -n ${split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER}p $split_feature_scenarios_SPLITTED_FILE >> $split_feature_scenarios_SPLITTED_EXAMPLES_FILE
              split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER=`expr $split_feature_scenarios_SPLITTED_EXAMPLES_FILE_COUNTER + 1`
            done
            rm -f $split_feature_scenarios_SPLITTED_FILE
          done
        fi
      done
      echo $split_feature_scenarios_DIRECTORY
    fi
  done
}
