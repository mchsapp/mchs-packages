mchs_step_setup_variables() {
	: "${MCHS_PACKAGE_FORMAT:="$([ ! -z "${MCHS_MAIN_PACKAGE_FORMAT+x}" ] && echo "$MCHS_MAIN_PACKAGE_FORMAT" || echo "debian")"}" # debian, pacman
	: "${MCHS_ARCH:="aarch64"}" # arm, aarch64, i686 or x86_64.
	: "${MCHS_OUTPUT_DIR:="${MCHS_SCRIPTDIR}/output"}"
	: "${MCHS_DEBUG_BUILD:="false"}"
	: "${MCHS_FORCE_BUILD:="false"}"
	: "${MCHS_INSTALL_DEPS:="false"}"
	: "${MCHS_MAKE_PROCESSES:="$(nproc)"}"
	: "${MCHS_NO_CLEAN:="false"}"
	: "${MCHS_PACKAGES_DIRECTORIES:="packages"}"
	: "${MCHS_PKG_API_LEVEL:="24"}"
	: "${MCHS_CONTINUE_BUILD:="false"}"
	: "${MCHS_QUIET_BUILD:="false"}"
	: "${MCHS_SKIP_DEPCHECK:="false"}"
	: "${MCHS_TOPDIR:="$HOME/.mchs-build"}"
	: "${MCHS_PACMAN_PACKAGE_COMPRESSION:="xz"}"

	if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
		# For on-device builds cross-compiling is not supported so we can
		# store information about built packages under $MCHS_TOPDIR.
		MCHS_BUILT_PACKAGES_DIRECTORY="$MCHS_TOPDIR/.built-packages"
		MCHS_NO_CLEAN="true"

		# On-device builds without mchs-exec are unsupported.
		if ! grep -q "${MCHS_PREFIX}/lib/libmchs-exec.so" <<< "${LD_PRELOAD-x}"; then
			mchs_error_exit "On-device builds without mchs-exec are not supported."
		fi
	else
		MCHS_BUILT_PACKAGES_DIRECTORY="/data/data/.built-packages"
	fi

	# MCHS_PKG_MAINTAINER should be explicitly set in build.sh of the package.
	: "${MCHS_PKG_MAINTAINER:="default"}"

	MCHS_REPO_URL=(
		https://tuberboy.com/McHs/apt
	)

	MCHS_REPO_DISTRIBUTION=(
		stable
	)

	MCHS_REPO_COMPONENT=(
		main
	)

	if [ "x86_64" = "$MCHS_ARCH" ] || [ "aarch64" = "$MCHS_ARCH" ]; then
		MCHS_ARCH_BITS=64
	else
		MCHS_ARCH_BITS=32
	fi

	MCHS_HOST_PLATFORM="${MCHS_ARCH}-linux-android"
	if [ "$MCHS_ARCH" = "arm" ]; then MCHS_HOST_PLATFORM="${MCHS_HOST_PLATFORM}eabi"; fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ] && [ ! -d "$NDK" ]; then
		mchs_error_exit 'NDK not pointing at a directory!'
	fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ] && ! grep -s -q "Pkg.Revision = $MCHS_NDK_VERSION_NUM" "$NDK/source.properties"; then
		mchs_error_exit "Wrong NDK version - we need $MCHS_NDK_VERSION"
	fi

	# The build tuple that may be given to --build configure flag:
	MCHS_BUILD_TUPLE=$(sh "$MCHS_SCRIPTDIR/scripts/config.guess")

	# We do not put all of build-tools/$MCHS_ANDROID_BUILD_TOOLS_VERSION/ into PATH
	# to avoid stuff like arm-linux-androideabi-ld there to conflict with ones from
	# the standalone toolchain.
	MCHS_D8=$ANDROID_HOME/build-tools/$MCHS_ANDROID_BUILD_TOOLS_VERSION/d8

	MCHS_COMMON_CACHEDIR="$MCHS_TOPDIR/_cache"
	MCHS_ELF_CLEANER=$MCHS_COMMON_CACHEDIR/mchs-elf-cleaner

	export prefix=${MCHS_PREFIX}
	export PREFIX=${MCHS_PREFIX}

	if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
		# In "offline" mode store/pick cache from directory with
		# build.sh script.
		MCHS_PKG_CACHEDIR=$MCHS_PKG_BUILDER_DIR/cache
	else
		MCHS_PKG_CACHEDIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/cache
	fi
	MCHS_CMAKE_BUILD=Ninja # Which cmake generator to use
	MCHS_PKG_BREAKS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	MCHS_PKG_BUILDDIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/build
	MCHS_PKG_BUILD_DEPENDS=""
	MCHS_PKG_BUILD_IN_SRC=false
	MCHS_PKG_CONFFILES=""
	MCHS_PKG_CONFLICTS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-conflicts
	MCHS_PKG_DEPENDS=""
	MCHS_PKG_DESCRIPTION="FIXME:Add description"
	MCHS_PKG_ESSENTIAL=false
	MCHS_PKG_EXTRA_CONFIGURE_ARGS=""
	MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS=""
	MCHS_PKG_EXTRA_MAKE_ARGS=""
	MCHS_PKG_FORCE_CMAKE=false # if the package has autotools as well as cmake, then set this to prefer cmake
	MCHS_PKG_GIT_BRANCH="" # branch defaults to 'v$MCHS_PKG_VERSION' unless this variable is defined
	MCHS_PKG_HAS_DEBUG=true # set to false if debug build doesn't exist or doesn't work, for example for python based packages
	MCHS_PKG_HOMEPAGE=""
	MCHS_PKG_HOSTBUILD=false # Set if a host build should be done in MCHS_PKG_HOSTBUILD_DIR:
	MCHS_PKG_HOSTBUILD_DIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/host-build
	MCHS_PKG_LICENSE_FILE="" # Relative path from $MCHS_PKG_SRCDIR to LICENSE file. It is installed to $MCHS_PREFIX/share/$MCHS_PKG_NAME.
	MCHS_PKG_MASSAGEDIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/massage
	MCHS_PKG_METAPACKAGE=false
	MCHS_PKG_NO_ELF_CLEANER=false # set this to true to disable running of mchs-elf-cleaner on built binaries
	MCHS_PKG_NO_STATICSPLIT=false
	MCHS_PKG_PACKAGEDIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/package
	MCHS_PKG_PLATFORM_INDEPENDENT=false
	MCHS_PKG_PRE_DEPENDS=""
	MCHS_PKG_PROVIDES="" #https://www.debian.org/doc/debian-policy/#virtual-packages-provides
	MCHS_PKG_RECOMMENDS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	MCHS_PKG_REPLACES=""
	MCHS_PKG_REVISION="0" # http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
	MCHS_PKG_RM_AFTER_INSTALL=""
	MCHS_PKG_SHA256=""
	MCHS_PKG_SRCDIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/src
	MCHS_PKG_SUGGESTS=""
	MCHS_PKG_TMPDIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/tmp
	MCHS_PKG_SERVICE_SCRIPT=() # Fill with entries like: ("daemon name" 'script to execute'). Script is echoed with -e so can contain \n for multiple lines
	MCHS_PKG_GROUPS="" # https://wiki.archlinux.org/title/Pacman#Installing_package_groups
	MCHS_PKG_NO_SHEBANG_FIX=false # if true, skip fixing shebang accordingly to MCHS_PREFIX

	unset CFLAGS CPPFLAGS LDFLAGS CXXFLAGS
}
