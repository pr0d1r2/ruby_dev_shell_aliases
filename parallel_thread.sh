function parallel_thread() {
  local parallel_thread_NUM
  case $1 in
    1)
      parallel_thread_NUM=''
      ;;
    [2-9] | [1-9][0-9] | [1-9][0-9][0-9])
      parallel_thread_NUM=$1
      ;;
    *)
      echo "Please give thread number as first parameter."
      return 8472
      ;;
  esac
  echorun `echo $@ | cut -f2- -d ' '` TEST_ENV_NUMBER=$parallel_thread_NUM
}
