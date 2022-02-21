mchs_setup_cmake() {
	local MCHS_CMAKE_MAJORVESION=3.22
	local MCHS_CMAKE_MINORVERSION=1
	local MCHS_CMAKE_VERSION=$MCHS_CMAKE_MAJORVESION.$MCHS_CMAKE_MINORVERSION
	local MCHS_CMAKE_TARNAME=cmake-${MCHS_CMAKE_VERSION}-linux-x86_64.tar.gz
	local MCHS_CMAKE_TARFILE=$MCHS_PKG_TMPDIR/$MCHS_CMAKE_TARNAME
	local MCHS_CMAKE_FOLDER

	if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
		MCHS_CMAKE_FOLDER=$MCHS_SCRIPTDIR/build-tools/cmake-$MCHS_CMAKE_VERSION
	else
		MCHS_CMAKE_FOLDER=$MCHS_COMMON_CACHEDIR/cmake-$MCHS_CMAKE_VERSION
	fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -d "$MCHS_CMAKE_FOLDER" ]; then
			mchs_download https://cmake.org/files/v$MCHS_CMAKE_MAJORVESION/$MCHS_CMAKE_TARNAME \
				"$MCHS_CMAKE_TARFILE" \
				73565c72355c6652e9db149249af36bcab44d9d478c5546fd926e69ad6b43640
			rm -Rf "$MCHS_PKG_TMPDIR/cmake-${MCHS_CMAKE_VERSION}-linux-x86_64"
			tar xf "$MCHS_CMAKE_TARFILE" -C "$MCHS_PKG_TMPDIR"
			mv "$MCHS_PKG_TMPDIR/cmake-${MCHS_CMAKE_VERSION}-linux-x86_64" \
				"$MCHS_CMAKE_FOLDER"
		fi

		export PATH=$MCHS_CMAKE_FOLDER/bin:$PATH
	else
		if [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "debian" && "$(dpkg-query -W -f '${db:Status-Status}\n' cmake 2>/dev/null)" != "installed" ]] ||
                   [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "pacman" && ! "$(pacman -Q cmake 2>/dev/null)" ]]; then
			echo "Package 'cmake' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install cmake"
			echo
			echo "  pacman -S cmake"
			echo
			exit 1
		fi
	fi

	export CMAKE_INSTALL_ALWAYS=1
}
