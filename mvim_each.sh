function mvim_each() {
  parallel \
    "test -d {} && find {} -type f | parallel -I '<>' 'mvim <> ; echo <>' ; test -f {} && mvim {} ; echo {}" \
    ::: \
    "$@" \
    2>/dev/null
}
