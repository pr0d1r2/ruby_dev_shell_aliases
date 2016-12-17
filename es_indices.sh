function es_indices() {
  curl "$ES_HOST:$ES_PORT/_cat/indices?v" 2>/dev/null | cut -b15- | cut -f 1 -d " "| grep -v "^index$"
}
