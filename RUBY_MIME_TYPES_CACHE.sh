# reduce the time of 'require "mime-types"'
# which happens every time you load Rails app
# decrease time from 120-130ms to 100ms
RUBY_MIME_TYPES_CACHE="tmp/mime-types-cache"
export RUBY_MIME_TYPES_CACHE
