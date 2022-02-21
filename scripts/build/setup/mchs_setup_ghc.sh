# Utility function to setup a GHC toolchain.
mchs_setup_ghc() {
	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		local MCHS_GHC_VERSION=8.10.1
		local MCHS_GHC_TEMP_FOLDER="${MCHS_COMMON_CACHEDIR}/ghc-${MCHS_GHC_VERSION}"
		local MCHS_GHC_TAR="${MCHS_GHC_TEMP_FOLDER}.tar.xz"
		local MCHS_GHC_RUNTIME_FOLDER

		if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
			MCHS_GHC_RUNTIME_FOLDER="${MCHS_SCRIPTDIR}/build-tools/ghc-${MCHS_GHC_VERSION}-runtime"
		else
			MCHS_GHC_RUNTIME_FOLDER="${MCHS_COMMON_CACHEDIR}/ghc-${MCHS_GHC_VERSION}-runtime"
		fi

		export PATH="$MCHS_GHC_RUNTIME_FOLDER/bin:$PATH"

		if [ -d "$MCHS_GHC_RUNTIME_FOLDER" ]; then return; fi

		mchs_download "https://downloads.haskell.org/~ghc/${MCHS_GHC_VERSION}/ghc-${MCHS_GHC_VERSION}-x86_64-deb10-linux.tar.xz" \
			"$MCHS_GHC_TAR" \
			c1e31d798b013699b3c0de4fda27fb4cda47f572df0e75e3bd598a3012060615

		rm -Rf "$MCHS_GHC_TEMP_FOLDER"
		tar xf "$MCHS_GHC_TAR" -C "$MCHS_COMMON_CACHEDIR"

		(set -e
			unset CC CXX CFLAGS CXXFLAGS CPPFLAGS LDFLAGS AR AS CPP LD RANLIB READELF STRIP
			cd "$MCHS_GHC_TEMP_FOLDER"
			./configure --prefix="$MCHS_GHC_RUNTIME_FOLDER"
			make install
		)

		rm -Rf "$MCHS_GHC_TEMP_FOLDER"
	else
		if [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "debian" && "$(dpkg-query -W -f '${db:Status-Status}\n' ghc 2>/dev/null)" != "installed" ]] ||
                   [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "pacman" && ! "$(pacman -Q ghc 2>/dev/null)" ]]; then
			echo "Package 'ghc' is not installed."
			exit 1
		fi
	fi
}
