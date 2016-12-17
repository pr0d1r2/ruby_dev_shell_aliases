function p2ls_setup() {
  local p2ls_setup_FILE
  local p2ls_setup_THREAD_DB
  local p2ls_setup_THREAD=1
  local p2ls_setup_PROJECT_ROOT=`pwd -P`
  local p2ls_setup_ROOT="$p2ls_setup_PROJECT_ROOT/tmp/p2ls"
  while [ $p2ls_setup_THREAD -le `cpu_num` ]
  do
    echo
    echo "Setup thread #${p2ls_setup_THREAD}"
    echo

    if [ ! -d $p2ls_setup_ROOT/$p2ls_setup_THREAD ]; then
      echorun mkdir -p $p2ls_setup_ROOT/$p2ls_setup_THREAD || return $?
    fi
    for p2ls_setup_FILE in `ls -a | grep -v "^\.$" | grep -v "^\..$" | grep -v "^\.git$" | grep -v "^\.DS_Store$" | grep -v "^config$" | grep -v "^tmp$" | grep -v "^log$" | grep -v "^results.*\.html$"`
    do
      if [ ! -L $p2ls_setup_ROOT/$p2ls_setup_THREAD/$p2ls_setup_FILE ]; then
        echorun ln -s $p2ls_setup_PROJECT_ROOT/$p2ls_setup_FILE $p2ls_setup_ROOT/$p2ls_setup_THREAD/$p2ls_setup_FILE || return $?
      fi
    done
    for p2ls_setup_FILE in config
    do
      echorun rsync -a $p2ls_setup_FILE/ $p2ls_setup_ROOT/$p2ls_setup_THREAD/$p2ls_setup_FILE/ || return $?
    done
    for p2ls_setup_FILE in tmp log
    do
      if [ ! -d $p2ls_setup_ROOT/$p2ls_setup_THREAD/$p2ls_setup_FILE ]; then
        echorun mkdir -p $p2ls_setup_ROOT/$p2ls_setup_THREAD/$p2ls_setup_FILE || return $?
      fi
    done
    cd $p2ls_setup_ROOT/$p2ls_setup_THREAD
    local p2ls_setup_SPRING_APPLICATION_ID=`pwd -P | md5`
    SPRING_APPLICATION_ID=$p2ls_setup_SPRING_APPLICATION_ID \
      SPRING_TMP_PATH="$p2ls_setup_ROOT/$p2ls_setup_THREAD/tmp" \
      spring stop
    p2ls_setup_THREAD_DB=`pwd -P | md5`_$p2ls_setup_THREAD || return $?
    cat config/database.yml | sed -e "s/database: .*_test/database: ${p2ls_setup_THREAD_DB}_test/" > config/database.yml.new
    mv config/database.yml.new config/database.yml
    cat config/database.yml | grep "database: .*_test"
    SPRING_APPLICATION_ID=$p2ls_setup_SPRING_APPLICATION_ID \
      SPRING_TMP_PATH="$p2ls_setup_ROOT/$p2ls_setup_THREAD/tmp" \
      spring rake db:test:prepare &
    cd $p2ls_setup_PROJECT_ROOT || return $?

    p2ls_setup_THREAD=`expr $p2ls_setup_THREAD + 1`
  done
  echo "Waiting for parallel rake db:test:prepare ..."
  wait
}
