function group_feature_scenarios() {
  local group_feature_scenarios_FILE
  local group_feature_scenarios_DIR
  local group_feature_scenarios_TARGET_DIR
  local group_feature_scenarios_BASE_DIR="features/splitted_and_groupped"
  for group_feature_scenarios_FILE in `find features -type d -name "*.feature_splitted" | grep -v $group_feature_scenarios_BASE_DIR | tail -r`
  do
    group_feature_scenarios_DIR=`dirname $group_feature_scenarios_FILE`
    group_feature_scenarios_TARGET_DIR="$group_feature_scenarios_BASE_DIR/$group_feature_scenarios_DIR"
    if [ ! -d $group_feature_scenarios_TARGET_DIR ]; then
      mkdir -p $group_feature_scenarios_TARGET_DIR
    fi
    mv $group_feature_scenarios_FILE $group_feature_scenarios_TARGET_DIR/
  done
}
