function fix_osx_readline_problems() {
  if [ ! -L /usr/local/opt/readline/lib/libreadline.6.dylib ]; then
    ln -s \
      /usr/local/opt/readline/lib/libreadline.7.0.dylib \
      /usr/local/opt/readline/lib/libreadline.6.dylib
  fi
}
