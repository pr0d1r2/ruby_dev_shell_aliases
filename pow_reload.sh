function pow_reload() {
  sudo pow --install-system
  pow --install-local
  sudo launchctl unload -w /Library/LaunchDaemons/cx.pow.firewall.plist
  sudo launchctl load -w /Library/LaunchDaemons/cx.pow.firewall.plist
  launchctl unload -w ~/Library/LaunchAgents/cx.pow.powd.plist
  launchctl load -w ~/Library/LaunchAgents/cx.pow.powd.plist
}
