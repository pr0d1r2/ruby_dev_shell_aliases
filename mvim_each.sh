function mvim_each() {
  parallel \
    -v \
    "test -d {} && find {} -type f | parallel -I '<>' 'mvim <> ; echo <>' ; test -f {} && mvim {} ; echo {}" \
    ::: \
    "$@" \
    2>/dev/null
}
