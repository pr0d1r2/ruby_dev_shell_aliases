function rspec_ensure_no_focus() {
  ensure_command rg || return $?
  # shellcheck disable=SC2046
  if ( rg -e \
         ", :focus | , focus: true | fit do | fit '| fit \"| fspecify do | fspecify '| fspecify \"| fcontext do | fcontext '| fcontext \"| fdescribe do | fdescribe '| fdescribe \"" \
         $(spec_directories)
     ); then
    echo "ERROR: specs contain :focus !!!"
    return 100
  fi
}
