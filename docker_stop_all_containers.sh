function docker_stop_all_containers() {
  docker ps | cut -f 1  -d " " | grep -v "^CONTAINER" | parallel docker stop
}
