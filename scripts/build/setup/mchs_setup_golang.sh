# Utility function for golang-using packages to setup a go toolchain.
mchs_setup_golang() {
	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		local MCHS_GO_VERSION=go1.17.7
		local MCHS_GO_PLATFORM=linux-amd64

		local MCHS_BUILDGO_FOLDER
		if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
			MCHS_BUILDGO_FOLDER=${MCHS_SCRIPTDIR}/build-tools/${MCHS_GO_VERSION}
		else
			MCHS_BUILDGO_FOLDER=${MCHS_COMMON_CACHEDIR}/${MCHS_GO_VERSION}
		fi

		export GOROOT=$MCHS_BUILDGO_FOLDER
		export PATH=${GOROOT}/bin:${PATH}

		if [ -d "$MCHS_BUILDGO_FOLDER" ]; then return; fi

		local MCHS_BUILDGO_TAR=$MCHS_COMMON_CACHEDIR/${MCHS_GO_VERSION}.${MCHS_GO_PLATFORM}.tar.gz
		rm -Rf "$MCHS_COMMON_CACHEDIR/go" "$MCHS_BUILDGO_FOLDER"
		mchs_download https://golang.org/dl/${MCHS_GO_VERSION}.${MCHS_GO_PLATFORM}.tar.gz \
			"$MCHS_BUILDGO_TAR" \
			02b111284bedbfa35a7e5b74a06082d18632eff824fd144312f6063943d49259

		( cd "$MCHS_COMMON_CACHEDIR"; tar xf "$MCHS_BUILDGO_TAR"; mv go "$MCHS_BUILDGO_FOLDER"; rm "$MCHS_BUILDGO_TAR" )
	else
		if [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "debian" && "$(dpkg-query -W -f '${db:Status-Status}\n' golang 2>/dev/null)" != "installed" ]] ||
                   [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "pacman" && ! "$(pacman -Q golang 2>/dev/null)" ]]; then
			echo "Package 'golang' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install golang"
			echo
			echo "  pacman -S golang"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh golang"
			echo
			exit 1
		fi

		export GOROOT="$MCHS_PREFIX/lib/go"
	fi
}
