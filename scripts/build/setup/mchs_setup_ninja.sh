mchs_setup_ninja() {
	local NINJA_VERSION=1.10.2
	local NINJA_FOLDER

	if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
		NINJA_FOLDER=${MCHS_SCRIPTDIR}/build-tools/ninja-${NINJA_VERSION}
	else
		NINJA_FOLDER=${MCHS_COMMON_CACHEDIR}/ninja-$NINJA_VERSION
	fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -x "$NINJA_FOLDER/ninja" ]; then
			mkdir -p "$NINJA_FOLDER"
			local NINJA_ZIP_FILE=$MCHS_PKG_TMPDIR/ninja-$NINJA_VERSION.zip
			mchs_download https://github.com/ninja-build/ninja/releases/download/v$NINJA_VERSION/ninja-linux.zip \
				"$NINJA_ZIP_FILE" \
				763464859c7ef2ea3a0a10f4df40d2025d3bb9438fcb1228404640410c0ec22d
			unzip "$NINJA_ZIP_FILE" -d "$NINJA_FOLDER"
			chmod 755 $NINJA_FOLDER/ninja
		fi
		export PATH=$NINJA_FOLDER:$PATH
	else
		local NINJA_PKG_VERSION=$(bash -c ". $MCHS_SCRIPTDIR/packages/ninja/build.sh; echo \$MCHS_PKG_VERSION")
		if ([ ! -e "$MCHS_BUILT_PACKAGES_DIRECTORY/ninja" ] ||
		    [ "$(cat "$MCHS_BUILT_PACKAGES_DIRECTORY/ninja")" != "$NINJA_PKG_VERSION" ]) &&
		   ([[ "$MCHS_MAIN_PACKAGE_FORMAT" = "debian" && "$(dpkg-query -W -f '${db:Status-Status}\n' ninja 2>/dev/null)" != "installed" ]] ||
		    [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "pacman" && ! "$(pacman -Q ninja 2>/dev/null)" ]]); then
			echo "Package 'ninja' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install ninja"
			echo
			echo "  pacman -S ninja"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh ninja"
			echo
			exit 1
		fi
	fi
}
