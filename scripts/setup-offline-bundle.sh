#!/usr/bin/env bash
##
## Download all package sources and install all build tools whether possible,
## so they will be available offline.
##

set -e -u

if [ "$(uname -o)" = "Android" ] || [ "$(uname -m)" != "x86_64" ]; then
	echo "This script supports only x86_64 GNU/Linux systems."
	exit 1
fi

export MCHS_SCRIPTDIR="$(dirname "$(readlink -f "$0")")/../"
mkdir -p "$MCHS_SCRIPTDIR"/build-tools

export MCHS_PACKAGES_OFFLINE=true
export MCHS_ARCH=aarch64
export MCHS_ON_DEVICE_BUILD=false
export MCHS_PKG_TMPDIR=$MCHS_SCRIPTDIR/build-tools/_tmp
export MCHS_COMMON_CACHEDIR=$MCHS_PKG_TMPDIR
export CC=gcc CXX=g++ LD=ld AR=ar STRIP=strip PKG_CONFIG=pkg-config
export CPPFLAGS="" CFLAGS="" CXXFLAGS="" LDFLAGS=""
mkdir -p "$MCHS_PKG_TMPDIR"

# Build tools.
. "$MCHS_SCRIPTDIR"/scripts/build/mchs_download.sh
(. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_cmake.sh
	mchs_setup_cmake
)
# GHC fails. Skipping for now.
#(. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_ghc.sh
#	mchs_setup_ghc
#)
(. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_golang.sh
	mchs_setup_golang
)
(
	. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_ninja.sh
	. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_meson.sh
	mchs_setup_meson
)
(. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_protobuf.sh
	mchs_setup_protobuf
)
# Offline rust is not supported yet.
#(. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_rust.sh
#	mchs_setup_rust
#)
(. "$MCHS_SCRIPTDIR"/scripts/build/setup/mchs_setup_zig.sh
	mchs_setup_zig
)
rm -rf "${MCHS_PKG_TMPDIR}"
(test -d "$MCHS_SCRIPTDIR"/build-tools/android-sdk && test -d "$MCHS_SCRIPTDIR"/build-tools/android-ndk && exit 0
	"$MCHS_SCRIPTDIR"/scripts/setup-android-sdk.sh
)

# Package sources.
for p in "$MCHS_SCRIPTDIR"/packages/*; do
	(
		. "$MCHS_SCRIPTDIR"/scripts/properties.sh
		. "$MCHS_SCRIPTDIR"/scripts/build/get_source/mchs_step_get_source.sh
		. "$MCHS_SCRIPTDIR"/scripts/build/get_source/mchs_git_clone_src.sh
		. "$MCHS_SCRIPTDIR"/scripts/build/get_source/mchs_download_src_archive.sh
		. "$MCHS_SCRIPTDIR"/scripts/build/get_source/mchs_unpack_src_archive.sh

		# Disable archive extraction in mchs_step_get_source.sh.
		mchs_extract_src_archive() {
			:
		}

		MCHS_PKG_NAME=$(basename "$p")
		MCHS_PKG_BUILDER_DIR="${p}"
		MCHS_PKG_CACHEDIR="${p}/cache"
		MCHS_PKG_METAPACKAGE=false

		# Set some variables to dummy values to avoid errors.
		MCHS_PKG_TMPDIR="${MCHS_PKG_CACHEDIR}/.tmp"
		MCHS_PKG_SRCDIR="${MCHS_PKG_CACHEDIR}/.src"
		MCHS_PKG_BUILDDIR="$MCHS_PKG_SRCDIR"
		MCHS_PKG_HOSTBUILD_DIR=$MCHS_PKG_TMPDIR
		MCHS_HOST_PLATFORM=aarch64-linux-android
		MCHS_ARCH_BITS=64
		MCHS_BUILD_TUPLE=x86_64-pc-linux-gnu
		MCHS_PKG_GIT_BRANCH=""
		MCHS_DEBUG_BUILD=false
		MCHS_MAKE_PROCESSES=1

		mkdir -p "$MCHS_PKG_CACHEDIR" "$MCHS_PKG_TMPDIR" "$MCHS_PKG_SRCDIR"
		cd "$MCHS_PKG_CACHEDIR"

		. "${p}"/build.sh || true
		if ! ${MCHS_PKG_METAPACKAGE}; then
			echo "Downloading sources for '$MCHS_PKG_NAME'..."
			mchs_step_get_source

			# Delete dummy src and tmp directories.
			rm -rf "$MCHS_PKG_TMPDIR" "$MCHS_PKG_SRCDIR"
		fi
	)
done

# Mark to tell build-package.sh to enable offline mode.
touch "$MCHS_SCRIPTDIR"/build-tools/.installed
