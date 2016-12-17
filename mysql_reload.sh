function mysql_reload() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mysql55.plist
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql55.plist
}
