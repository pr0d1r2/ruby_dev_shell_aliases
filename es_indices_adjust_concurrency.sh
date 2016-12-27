function es_indices_adjust_concurrency() {
  local es_indices_adjust_concurrency_INDEX

  case $1 in
    [1-9] | [1-9][0-9] | [1-9][0-9][0-9] | [1-9][0-9][0-9][0-9])
      local es_indices_adjust_concurrency_THREADS="$1"
      ;;
    *)
      local es_indices_adjust_concurrency_THREADS=`nproc`
      ;;
  esac

  for es_indices_adjust_concurrency_INDEX in `es_indices`
  do
    echorun curl -XPOST "http://$ES_HOST:$ES_PORT/$es_indices_adjust_concurrency_INDEX/_close"

    echorun curl -XPUT "http://$ES_HOST:$ES_PORT/$es_indices_adjust_concurrency_INDEX/_settings" \
         -d "{\"index\": { \"index_concurrency\": $es_indices_adjust_concurrency_THREADS } }"

    echorun curl -XPOST "http://$ES_HOST:$ES_PORT/$es_indices_adjust_concurrency_INDEX/_open"
  done

}
