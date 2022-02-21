mchs_setup_zig() {
	local ZIG_VERSION=0.9.0
	local ZIG_FOLDER

	if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
		ZIG_FOLDER=${MCHS_SCRIPTDIR}/build-tools/zig-${ZIG_VERSION}
	else
		ZIG_FOLDER=${MCHS_COMMON_CACHEDIR}/zig-${ZIG_VERSION}
	fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -x "$ZIG_FOLDER/zig" ]; then
			mkdir -p "$ZIG_FOLDER"
			local ZIG_TARBALL=$MCHS_PKG_TMPDIR/zig-$ZIG_VERSION.zip
			mchs_download https://ziglang.org/download/$ZIG_VERSION/zig-linux-x86_64-$ZIG_VERSION.tar.xz \
				"$ZIG_TARBALL" \
				5c55344a877d557fb1b28939785474eb7f4f2f327aab55293998f501f7869fa6
			tar xf "$ZIG_TARBALL" -C "$ZIG_FOLDER" --strip-components=1
		fi
		export PATH=$ZIG_FOLDER:$PATH
	else
		local ZIG_PKG_VERSION=$(bash -c ". $MCHS_SCRIPTDIR/packages/zig/build.sh; echo \$MCHS_PKG_VERSION")
		if ([ ! -e "$MCHS_BUILT_PACKAGES_DIRECTORY/zig" ] ||
		    [ "$(cat "$MCHS_BUILT_PACKAGES_DIRECTORY/zig")" != "$ZIG_PKG_VERSION" ]) &&
		   [ "$(dpkg-query -W -f '${db:Status-Status}\n' zig 2>/dev/null)" != "installed" ]; then
			echo "Package 'zig' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install zig"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh zig"
			echo
			exit 1
		fi
	fi

	if [ $MCHS_ARCH = "i686" ]; then
		ZIG_TARGET_NAME=i386-linux-android
	else
		ZIG_TARGET_NAME=$MCHS_ARCH-linux-android
	fi
}
