# Run spec for given file/line
#
# Example usage:
#
# run_spec_for app/model/user.rb # will run `rspec spec/model/user_spec.rb`
# run_spec_for spec/model/user_spec.rb:8472 # will run `rspec spec/model/user_spec.rb:8472`
function run_spec_for() {
  local run_spec_for_STATUS
  local run_spec_for_CHECKSUM=`git diff HEAD | shasum -a 1 | cut -f 1 -d ' '`
  if [ -f tmp/run_spec_for-$run_spec_for_CHECKSUM.log ]; then
    echo
    echo "Specs was run previously. Please check tmp/run_spec_for-$run_spec_for_CHECKSUM.log for more details ..."
    echo
    tail tmp/run_spec_for-$run_spec_for_CHECKSUM.log
    return `cat tmp/run_spec_for-$run_spec_for_CHECKSUM.status`
  else
    local run_spec_for_FILE
    local run_spec_for_FILES=()
    for run_spec_for_FILE in `existing_spec_for $@ | sort | uniq`
    do
      run_spec_for_FILES+=$run_spec_for_FILE
    done
    local run_spec_for_SINGLE_LINES=()
    for run_spec_for_FILE in $@
    do
      case $run_spec_for_FILE in
        *_spec.rb:[1-9] | *_spec.rb:[1-9][0-9] | *_spec.rb:[1-9][0-9][0-9] | *_spec.rb:[1-9][0-9][0-9][0-9] | *_spec.rb:[1-9][0-9][0-9][0-9][0-9])
          run_spec_for_SINGLE_LINES+=$run_spec_for_FILE
          ;;
      esac
    done
    if [ ${#run_spec_for_SINGLE_LINES[@]} -gt 0 ]; then
      echo bers $run_spec_for_SINGLE_LINES
      echorun bers $run_spec_for_SINGLE_LINES 2>&1 | tee -a tmp/run_spec_for-$run_spec_for_CHECKSUM.log
      run_spec_for_STATUS=$?
      if [ $run_spec_for_STATUS -gt 0 ]; then
        echo $run_spec_for_STATUS > tmp/run_spec_for-$run_spec_for_CHECKSUM.status
        return $run_spec_for_STATUS
      fi
    fi
    if [ ${#run_spec_for_FILES[@]} -eq 1 ]; then
      echo bers $run_spec_for_FILES
      echorun bers $run_spec_for_FILES 2>&1 | tee -a tmp/run_spec_for-$run_spec_for_CHECKSUM.log
    elif [ ${#run_spec_for_FILES[@]} -gt 1 ]; then
      echo beps $run_spec_for_FILES
      echorun beps $run_spec_for_FILES 2>&1 | tee -a tmp/run_spec_for-$run_spec_for_CHECKSUM.log
    else
      echo "No specs for $@ !!!"
      return 8472
    fi
    run_spec_for_STATUS=$?
    echo $run_spec_for_STATUS > tmp/run_spec_for-$run_spec_for_CHECKSUM.status
    if [ $run_spec_for_STATUS -gt 0 ]; then
      return $run_spec_for_STATUS
    fi
  fi
}
