#!usr/bin/env bash
! type stack &> /dev/null && brew install stack
brew list xcodegen || brew install xcodegen
brew list karabiner-elements || brew install karabiner-elements

if ! type kmonad &> /dev/null; then
	[[ ! -d ~/.sources/kmonad ]] && git clone --recursive https://github.com/kmonad/kmonad.git ~/.sources/kmonad
	cd ~/.sources/kmonad

	macos_version=$(sw_vers | grep ProductVersion | cut -d':' -f2 | sed 's/\t//g')
	should_use_kext=$(echo $macos_version'<'11 | bc -l)
	should_use_dext=$(echo $macos_version'>='11 | bc -l)

	if [[ $should_use_dext -eq 1 ]]; then
		dext_version=$(defaults read /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/Info.plist CFBundleVersion)

		if [[ ! $dext_version == '1.15.0' ]]; then
			#installing dext using GUI from .dmg
			dmg_path=c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/dist/Karabiner-DriverKit-VirtualHIDDevice-1.15.0.dmg
			MOUNTDEV=$(hdiutil mount $dmg_path | awk '/dev.disk/{print$1}')
			MOUNTDIR="$(mount | grep $MOUNTDEV | awk '{$1=$2="";sub(" [(].*","");sub("^  ","");print}')"
			sudo installer -pkg "${MOUNTDIR}/"*.pkg -target /
			hdiutil unmount "$MOUNTDIR"

			#activating dext
			/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
		fi

		#installing kmonad
		stack install --flag kmonad:dext --extra-include-dirs=c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit:c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include
	else
		stack build --flag kmonad:kext --extra-include-dirs=c_src/mac/Karabiner-VirtualHIDDevice/dist/include
	fi
fi

