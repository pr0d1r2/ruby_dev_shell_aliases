PACKER_CACHE_DIR="$HOME/tmp/packer_cache"
export PACKER_CACHE_DIR
if [ ! -d "$PACKER_CACHE_DIR" ]; then
  mkdir -p "$PACKER_CACHE_DIR"
fi
