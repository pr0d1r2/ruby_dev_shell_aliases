# Fix for ImageMagick 7
# Fixes "Installing rmagick 2.16.0 with native extensions"
# Failing with:
# - "Can't install RMagick 2.16.0. Can't find MagickWand.h"
# - "./rmagick.h:47:10: fatal error: 'magick/MagickCore.h' file not found"
function fix_macos_rmagick_compilation() { ##Darwin
  find /usr/local -name MagickWand.h | \ ##Darwin
    parallel "ln -sf {//} '{= s/MagickWand\/MagickWand.h$/wand/ =}'" ##Darwin

  find /usr/local -name MagickCore.h | \ ##Darwin
    parallel "ln -sf {//} '{= s/MagickCore\/MagickCore.h$/magick/ =}'" ##Darwin
} ##Darwin
