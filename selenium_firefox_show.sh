function selenium_firefox_show() {
  echo "5,6d4
< 	<key>LSBackgroundOnly</key>
< 	<string>True</string>" | patch -p0 /Applications/Firefox.app/Contents/Info.plist
}
