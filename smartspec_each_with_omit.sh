function smartspec_each_with_omit() {
  smartspec_each_with_omit_DONE=`cat smartspec_each.done`

  for smartspec_each_with_omit_SPEC in `echo "$@" | \
         grep "^rspec" | \
         sed -e "s/spec\//#/" | \
         cut -f 2 -d "#" | \
         sed "s/^/spec\//g" | \
         tr "\n" " "`
  do
    case $smartspec_each_with_omit_DONE in
      *$smartspec_each_with_omit_SPEC*)
        echo "Ommiting done feature: $smartspec_each_with_omit_SPEC"
        ;;
      *)
        echo
        echo $smartspec_each_with_omit_SPEC
        echo
        bundle exec rspec $smartspec_each_with_omit_SPEC ; smartspec_each_with_omit_ERR=$?
        if [ $smartspec_each_with_omit_ERR -eq 0 ]; then
          echo $smartspec_each_with_omit_SPEC >> smartspec_each.done
        else
          echo $smartspec_each_with_omit_SPEC >> smartspec_each_omited.done
        fi
        echo
        ;;
    esac
  done
  say "smart spec each OK"

  unset smartspec_each_with_omit_ERR
  unset smartspec_each_with_omit_SPEC
}
