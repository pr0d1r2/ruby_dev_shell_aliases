function smartspec_each() {
  smartspec_each_DONE=`cat smartspec_each.done`

  for smartspec_each_SPEC in `echo "$@" | \
         grep "^rspec" | \
         sed -e "s/spec\//#/" | \
         cut -f 2 -d "#" | \
         sed "s/^/spec\//g" | \
         tr "\n" " "`
  do
    case $smartspec_each_DONE in
      *$smartspec_each_SPEC*)
        echo "Ommiting done feature: $smartspec_each_SPEC"
        ;;
      *)
        echo
        echo $smartspec_each_SPEC
        echo
        bundle exec rspec $smartspec_each_SPEC ; smartspec_each_ERR=$?
        if [ $smartspec_each_ERR -eq 0 ]; then
          echo $smartspec_each_SPEC >> smartspec_each.done
        else
          mvim $smartspec_each_SPEC
          say "smart spec each error"
          return $smartspec_each_ERR
        fi
        echo
        ;;
    esac
  done
  say "smart spec each OK"

  unset smartspec_each_ERR
  unset smartspec_each_SPEC
}
