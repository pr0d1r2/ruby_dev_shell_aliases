function pgreload_mac() {
  local pgreload_mac_PLIST="$HOME/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

  launchctl list | grep -q homebrew.mxcl.postgresql
  if [ $? -eq 0 ]; then
    echorun launchctl unload $pgreload_mac_PLIST || return $?
  fi

  echorun launchctl load $pgreload_mac_PLIST || return $?
}
