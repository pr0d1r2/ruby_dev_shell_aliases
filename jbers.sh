function jbers() {
  local jbers_LINE
  local jbers_FRAGMENTS
  local jbers_FILE
  local jbers_FILES=()
  for jbers_LINE in $(echo $@ | grep spec | sed -e 's/::/|/' | cut -f 1 -d '|')
  do
    jbers_FRAGMENTS=`echo $(echo $jbers_LINE | tr '.' ' ' | wc -w)`
    jbers_FRAGMENTS=`expr $jbers_FRAGMENTS - 1`
    jbers_FILE="`echo $jbers_LINE | cut -f 1-$jbers_FRAGMENTS -d . | sed -e 's/\./\//g'`.rb"
    case $jbers_FILE in
      *spec/support*)
        ;;
      *)
        case $jbers_FILES in
          *\ $jbers_FILE\ *)
            ;;
          *)
            if [ -f $jbers_FILE ]; then
              jbers_FILES+="$jbers_FILE"
            fi
            ;;
        esac
        ;;
    esac
  done

  echorun bers $jbers_FILES || return $?
}
