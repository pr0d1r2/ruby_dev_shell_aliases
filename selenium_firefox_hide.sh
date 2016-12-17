function selenium_firefox_hide() {
  echo "4a5,6
> 	<key>LSBackgroundOnly</key>
> 	<string>True</string>" | patch -p0 /Applications/Firefox.app/Contents/Info.plist
}
