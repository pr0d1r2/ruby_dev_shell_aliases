function rspec_memory_entries() {
  local rspec_memory_entries_ENTRY
  local rspec_memory_entries_COUNT
  local rspec_memory_entries_CLASS
  local rspec_memory_entries_BYTES
  for rspec_memory_entries_ENTRY in $(
    echo "$@" | \
      sed -e "s/allocated/\nallocated/g" | \
      sed -e 's/, but it was not specified,//' | \
      sed -e 's/^allocated //g' | \
      sed -e 's/ instances, /,/' | \
      sed -e 's/ bytes//' | \
      sed -e 's/ /,/g' | \
      cut -f 1-3 -d ','
    )
  do
    rspec_memory_entries_COUNT="$(echo $rspec_memory_entries_ENTRY | cut -f 1 -d ',')"
    rspec_memory_entries_CLASS="$(echo $rspec_memory_entries_ENTRY | cut -f 2 -d ',')"
    rspec_memory_entries_BYTES="$(echo $rspec_memory_entries_ENTRY | cut -f 3 -d ',')"

    echo "$rspec_memory_entries_CLASS => {count: $rspec_memory_entries_COUNT, size: $rspec_memory_entries_BYTES},"
  done
}
