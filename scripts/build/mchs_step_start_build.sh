mchs_step_start_build() {
	MCHS_STANDALONE_TOOLCHAIN="$MCHS_COMMON_CACHEDIR/android-r${MCHS_NDK_VERSION}-api-${MCHS_PKG_API_LEVEL}"
	# Bump the below version if a change is made in toolchain setup to ensure
	# that everyone gets an updated toolchain:
	MCHS_STANDALONE_TOOLCHAIN+="-v6"

	# shellcheck source=/dev/null
	source "$MCHS_PKG_BUILDER_SCRIPT"
	# Path to hostbuild marker, for use if package has hostbuild step
	MCHS_HOSTBUILD_MARKER="$MCHS_PKG_HOSTBUILD_DIR/MCHS_BUILT_FOR_$MCHS_PKG_VERSION"

	if [ "$MCHS_PKG_METAPACKAGE" = "true" ]; then
		# Metapackage has no sources and therefore platform-independent.
		MCHS_PKG_SKIP_SRC_EXTRACT=true
		MCHS_PKG_PLATFORM_INDEPENDENT=true
	fi

	if [ -n "${MCHS_PKG_BLACKLISTED_ARCHES:=""}" ] && [ "$MCHS_PKG_BLACKLISTED_ARCHES" != "${MCHS_PKG_BLACKLISTED_ARCHES/$MCHS_ARCH/}" ]; then
		printf "Skipping building \033[0;32m$MCHS_PKG_NAME\033[0m for arch \033[0;33m$MCHS_ARCH\033[0m\n"
		exit 0
	fi

	MCHS_PKG_FULLVERSION=$MCHS_PKG_VERSION
	if [ "$MCHS_PKG_REVISION" != "0" ] || [ "$MCHS_PKG_FULLVERSION" != "${MCHS_PKG_FULLVERSION/-/}" ]; then
		# "0" is the default revision, so only include it if the upstream versions contains "-" itself
		MCHS_PKG_FULLVERSION+="-$MCHS_PKG_REVISION"
	fi
	# full format version for pacman
	local MCHS_PKG_VERSION_EDITED=${MCHS_PKG_VERSION//-/.}
	local INCORRECT_SYMBOLS=$(echo $MCHS_PKG_VERSION_EDITED | grep -o '[0-9][a-z]')
	if [ -n "$INCORRECT_SYMBOLS" ]; then
		local MCHS_PKG_VERSION_EDITED=${MCHS_PKG_VERSION_EDITED//${INCORRECT_SYMBOLS:0:1}${INCORRECT_SYMBOLS:1:1}/${INCORRECT_SYMBOLS:0:1}.${INCORRECT_SYMBOLS:1:1}}
	fi
	MCHS_PKG_FULLVERSION_FOR_PACMAN="${MCHS_PKG_VERSION_EDITED}"
	if [ -n "$MCHS_PKG_REVISION" ]; then
		MCHS_PKG_FULLVERSION_FOR_PACMAN+="-${MCHS_PKG_REVISION}"
	else
		MCHS_PKG_FULLVERSION_FOR_PACMAN+="-0"
	fi

	if [ "$MCHS_DEBUG_BUILD" = "true" ]; then
		if [ "$MCHS_PKG_HAS_DEBUG" = "true" ]; then
			DEBUG="-dbg"
		else
			printf "Skipping building debug build for \033[0;33m$MCHS_PKG_NAME\033[0m\n"
			exit 0
		fi
	else
		DEBUG=""
	fi

	if [ "$MCHS_DEBUG_BUILD" = "false" ] && [ "$MCHS_FORCE_BUILD" = "false" ]; then
		if [ -e "$MCHS_BUILT_PACKAGES_DIRECTORY/$MCHS_PKG_NAME" ] &&
			[ "$(cat "$MCHS_BUILT_PACKAGES_DIRECTORY/$MCHS_PKG_NAME")" = "$MCHS_PKG_FULLVERSION" ]; then
			printf "\033[0;34m$MCHS_PKG_NAME@$MCHS_PKG_FULLVERSION\033[0m built - skipping (rm \033[0;32m$MCHS_BUILT_PACKAGES_DIRECTORY/$MCHS_PKG_NAME\033[0m to force rebuild)\n"
			exit 0
		elif [ "$MCHS_ON_DEVICE_BUILD" = "true" ] &&
			([[ "$MCHS_MAIN_PACKAGE_FORMAT" = "debian" && "$(dpkg-query -W -f '${db:Status-Status} ${Version}\n' "$MCHS_PKG_NAME" 2>/dev/null)" = "installed $MCHS_PKG_FULLVERSION" ]] ||
			 [[ "$MCHS_MAIN_PACKAGE_FORMAT" = "pacman" && "$(pacman -Q $MCHS_PKG_NAME 2>/dev/null)" = "$MCHS_PKG_NAME $MCHS_PKG_FULLVERSION_FOR_PACMAN" ]]); then
			printf "\033[0;36m$MCHS_PKG_NAME@$MCHS_PKG_FULLVERSION\033[0m installed - skipping"
			exit 0
		fi
	fi

	printf "\033[0;34m[McHs]\033[0m - Building \033[0;32m$MCHS_PKG_NAME\033[0m For ARCH \033[0;36m$MCHS_ARCH\033[0m...\n"
	test -t 1 && printf "\033]0;%s...\007" "$MCHS_PKG_NAME"

	# Avoid exporting PKG_CONFIG_LIBDIR until after mchs_step_host_build.
	export MCHS_PKG_CONFIG_LIBDIR=$MCHS_PREFIX/lib/pkgconfig

	if [ "$MCHS_PKG_BUILD_IN_SRC" = "true" ]; then
		printf "Building in src due to \033[0;34mMCHS_PKG_BUILD_IN_SRC\033[0m being set to true" > "\033[0;32m$MCHS_PKG_BUILDDIR/BUILDING_IN_SRC.txt\033[0m"
		MCHS_PKG_BUILDDIR=$MCHS_PKG_SRCDIR
	fi

	if [ "$MCHS_CONTINUE_BUILD" == "true" ]; then
		# If the package has a hostbuild step, verify that it has been built
		if [ "$MCHS_PKG_HOSTBUILD" == "true" ] && [ ! -f "$MCHS_HOSTBUILD_MARKER" ]; then
			mchs_error_exit "Cannot continue this build, hostbuilt tools are missing"
		fi

		# The rest in this function can be skipped when doing
		# a continued build
		return
	fi

	# Make $MCHS_PREFIX/bin/sh executable on the builder, so that build
	# scripts can assume that it works on both builder and host later on:
	[ "$MCHS_ON_DEVICE_BUILD" = "false" ] && ln -sf /bin/sh "$MCHS_PREFIX/bin/sh"

	local MCHS_ELF_CLEANER_SRC=$MCHS_COMMON_CACHEDIR/mchs-elf-cleaner.cpp
	local MCHS_ELF_CLEANER_VERSION
	MCHS_ELF_CLEANER_VERSION=$(bash -c ". $MCHS_SCRIPTDIR/packages/mchs-elf-cleaner/build.sh; echo \$MCHS_PKG_VERSION")
	mchs_download \
		"https://raw.githubusercontent.com/mchs/mchs-elf-cleaner/v$MCHS_ELF_CLEANER_VERSION/mchs-elf-cleaner.cpp" \
		"$MCHS_ELF_CLEANER_SRC" \
		022197c19129c4e57a37515bd4adcc19e05f9aa7f9ba4fbcab85a20210c39632
	if [ "$MCHS_ELF_CLEANER_SRC" -nt "$MCHS_ELF_CLEANER" ]; then
		g++ -std=c++11 -Wall -Wextra -pedantic -Os -D__ANDROID_API__=$MCHS_PKG_API_LEVEL \
			"$MCHS_ELF_CLEANER_SRC" -o "$MCHS_ELF_CLEANER"
	fi
}
