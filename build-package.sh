#!/bin/bash
# shellcheck disable=SC1117

set -e -o pipefail -u

SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct 2>/dev/null || date "+%s")
export SOURCE_DATE_EPOCH

: "${TMPDIR:=/tmp}"
export TMPDIR

if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	if [ "$(id -u)" = "0" ]; then
		echo "On-device execution of this script as root is disabled."
		exit 1
	fi

	# This variable tells all parts of build system that build
	# is performed on device.
	export MCHS_ON_DEVICE_BUILD=true
else
	export MCHS_ON_DEVICE_BUILD=false
fi

cd "$(realpath "$(dirname "$0")")"
MCHS_SCRIPTDIR=$(pwd)
export MCHS_SCRIPTDIR

# Automatically enable offline set of sources and build tools.
# Offline mchs-packages bundle can be created by executing
# script ./scripts/setup-offline-bundle.sh.
if [ -f "${MCHS_SCRIPTDIR}/build-tools/.installed" ]; then
	export MCHS_PACKAGES_OFFLINE=true
fi

# Lock file to prevent parallel running in the same environment.
MCHS_BUILD_LOCK_FILE="${TMPDIR}/.mchs-build.lck"
if [ ! -e "$MCHS_BUILD_LOCK_FILE" ]; then
	touch "$MCHS_BUILD_LOCK_FILE"
fi

# Special variable for internal use. It forces script to ignore
# lock file.
: "${MCHS_BUILD_IGNORE_LOCK:=false}"

# Utility function to log an error message and exit with an error code.
# shellcheck source=scripts/build/mchs_error_exit.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_error_exit.sh"

# Utility function to download a resource with an expected checksum.
# shellcheck source=scripts/build/mchs_download.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_download.sh"

# Utility function for setting up GHC toolchain.
# shellcheck source=scripts/build/setup/mchs_setup_ghc.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_ghc.sh"

# Utility function for setting up GN toolchain.
# shellcheck source=scripts/build/setup/mchs_setup_gn.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_gn.sh"

# Utility function for golang-using packages to setup a go toolchain.
# shellcheck source=scripts/build/setup/mchs_setup_golang.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_golang.sh"

# Utility function for rust-using packages to setup a rust toolchain.
# shellcheck source=scripts/build/setup/mchs_setup_rust.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_rust.sh"

# Utility function for zig-using packages to setup a zig toolchain.
# shellcheck source=scripts/build/setup/mchs_setup_zig.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_zig.sh"

# Utility function to setup a current ninja build system.
# shellcheck source=scripts/build/setup/mchs_setup_ninja.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_ninja.sh"

# Utility function to setup a current meson build system.
# shellcheck source=scripts/build/setup/mchs_setup_meson.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_meson.sh"

# Utility function to setup a current cmake build system
# shellcheck source=scripts/build/setup/mchs_setup_cmake.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_cmake.sh"

# Utility function to setup protobuf:
# shellcheck source=scripts/build/setup/mchs_setup_protobuf.sh
source "$MCHS_SCRIPTDIR/scripts/build/setup/mchs_setup_protobuf.sh"

# Setup variables used by the build. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_setup_variables.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_setup_variables.sh"

# Save away and restore build setups which may change between builds.
# shellcheck source=scripts/build/mchs_step_handle_buildarch.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_handle_buildarch.sh"

# Function to get MCHS_PKG_VERSION from build.sh
# shellcheck source=scripts/build/mchs_extract_dep_info.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_extract_dep_info.sh"

# Function that downloads a .deb (using the mchs_download function)
# shellcheck source=scripts/build/mchs_download_deb_pac.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_download_deb_pac.sh"

# Script to download InRelease, verify it's signature and then download Packages.xz by hash
# shellcheck source=scripts/build/mchs_get_repo_files.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_get_repo_files.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_get_dependencies.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_get_dependencies.sh"

# Handle config scripts that needs to be run during build. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_override_config_scripts.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_override_config_scripts.sh"

# Remove old src and build folders and create new ones
# shellcheck source=scripts/build/mchs_step_setup_build_folders.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_setup_build_folders.sh"

# Source the package build script and start building. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_start_build.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_start_build.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_create_timestamp_file.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_create_timestamp_file.sh"

# Run just after sourcing $MCHS_PKG_BUILDER_SCRIPT. Can be overridden by packages.
# shellcheck source=scripts/build/get_source/mchs_step_get_source.sh
source "$MCHS_SCRIPTDIR/scripts/build/get_source/mchs_step_get_source.sh"

# Run from mchs_step_get_source if MCHS_PKG_SRCURL ends with .git.
# shellcheck source=scripts/build/get_source/mchs_step_get_source.sh
source "$MCHS_SCRIPTDIR/scripts/build/get_source/mchs_git_clone_src.sh"

# Run from mchs_step_get_source if MCHS_PKG_SRCURL does not ends with .git.
# shellcheck source=scripts/build/get_source/mchs_download_src_archive.sh
source "$MCHS_SCRIPTDIR/scripts/build/get_source/mchs_download_src_archive.sh"

# Run from mchs_step_get_source after mchs_download_src_archive.
# shellcheck source=scripts/build/get_source/mchs_unpack_src_archive.sh
source "$MCHS_SCRIPTDIR/scripts/build/get_source/mchs_unpack_src_archive.sh"

# Hook for packages to act just after the package sources have been obtained.
# Invoked from $MCHS_PKG_SRCDIR.
mchs_step_post_get_source() {
	return
}

# Optional host build. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_handle_hostbuild.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_handle_hostbuild.sh"

# Perform a host build. Will be called in $MCHS_PKG_HOSTBUILD_DIR.
# After mchs_step_post_get_source() and before mchs_step_patch_package()
# shellcheck source=scripts/build/mchs_step_host_build.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_host_build.sh"

# Setup a standalone Android NDK toolchain. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_setup_toolchain.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_setup_toolchain.sh"

# Apply all *.patch files for the package. Not to be overridden by packages.
# shellcheck source=scripts/build/mchs_step_patch_package.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_patch_package.sh"

# Replace autotools build-aux/config.{sub,guess} with ours to add android targets.
# shellcheck source=scripts/build/mchs_step_replace_guess_scripts.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_replace_guess_scripts.sh"

# For package scripts to override. Called in $MCHS_PKG_BUILDDIR.
mchs_step_pre_configure() {
	return
}

# Setup configure args and run $MCHS_PKG_SRCDIR/configure. This function is called from mchs_step_configure
# shellcheck source=scripts/build/configure/mchs_step_configure_autotools.sh
source "$MCHS_SCRIPTDIR/scripts/build/configure/mchs_step_configure_autotools.sh"

# Setup configure args and run cmake. This function is called from mchs_step_configure
# shellcheck source=scripts/build/configure/mchs_step_configure_cmake.sh
source "$MCHS_SCRIPTDIR/scripts/build/configure/mchs_step_configure_cmake.sh"

# Setup configure args and run meson. This function is called from mchs_step_configure
# shellcheck source=scripts/build/configure/mchs_step_configure_meson.sh
source "$MCHS_SCRIPTDIR/scripts/build/configure/mchs_step_configure_meson.sh"

# Configure the package
# shellcheck source=scripts/build/configure/mchs_step_configure.sh
source "$MCHS_SCRIPTDIR/scripts/build/configure/mchs_step_configure.sh"

# Hook for packages after configure step
mchs_step_post_configure() {
	return
}

# Make package, either with ninja or make
# shellcheck source=scripts/build/mchs_step_make.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_make.sh"

# Make install, either with ninja, make of cargo
# shellcheck source=scripts/build/mchs_step_make_install.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_make_install.sh"

# Hook function for package scripts to override.
mchs_step_post_make_install() {
	return
}

# Add service scripts from array MCHS_PKG_SERVICE_SCRIPT, if it is set
# shellcheck source=scripts/build/mchs_step_install_service_scripts.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_install_service_scripts.sh"

# Link/copy the LICENSE for the package to $MCHS_PREFIX/share/$MCHS_PKG_NAME/
# shellcheck source=scripts/build/mchs_step_install_license.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_install_license.sh"

# Function to cp (through tar) installed files to massage dir
# shellcheck source=scripts/build/mchs_step_extract_into_massagedir.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_extract_into_massagedir.sh"

# Hook function to create {pre,post}install, {pre,post}rm-scripts for subpkgs
mchs_step_create_subpkg_debscripts() {
	return
}

# Create all subpackages. Run from mchs_step_massage
# shellcheck source=scripts/build/mchs_create_debian_subpackages.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_create_debian_subpackages.sh"

# Create all subpackages. Run from mchs_step_massage
# shellcheck source=scripts/build/mchs_create_pacman_subpackages.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_create_pacman_subpackages.sh"

# Function to run various cleanup/fixes
# shellcheck source=scripts/build/mchs_step_massage.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_massage.sh"

# Hook for packages after massage step
mchs_step_post_massage() {
	return
}

# Hook function to create {pre,post}install, {pre,post}rm-scripts and similar
mchs_step_create_debscripts() {
	return
}

# Convert Debian maintainer scripts into pacman-compatible installation hooks.
# This is used only when creating pacman packages.
# shellcheck source=scripts/build/mchs_step_create_pacman_install_hook.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_create_pacman_install_hook.sh"

# Create the build deb file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/mchs_step_create_debian_package.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_create_debian_package.sh"

# Create the build .pkg.tar.xz file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/mchs_step_create_pacman_package.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_create_pacman_package.sh"

# Finish the build. Not to be overridden by package scripts.
# shellcheck source=scripts/build/mchs_step_finish_build.sh
source "$MCHS_SCRIPTDIR/scripts/build/mchs_step_finish_build.sh"

################################################################################

# shellcheck source=scripts/properties.sh
. "$MCHS_SCRIPTDIR/scripts/properties.sh"

if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
	# For on device builds cross compiling is not supported.
	# Target architecture must be same as for environment used currently.
	case "$MCHS_MAIN_PACKAGE_FORMAT" in
		"debian") MCHS_ARCH=$(dpkg --print-architecture);;
		"pacman") MCHS_ARCH=$(pacman-conf | grep Architecture | sed 's/Architecture = //g');;
	esac
	export MCHS_ARCH
fi

# Special hook to prevent use of "sudo" inside package build scripts.
# build-package.sh shouldn't perform any privileged operations.
sudo() {
	mchs_error_exit "Do not use 'sudo' inside build scripts. Build environment should be configured through ./scripts/setup-ubuntu.sh."
}

_show_usage() {
	echo "Usage: ./build-package.sh [options] PACKAGE_1 PACKAGE_2 ..."
	echo
	echo "Build a package by creating a .deb file in the debs/ folder."
	echo
	echo "Available options:"
	[ "$MCHS_ON_DEVICE_BUILD" = "false" ] && echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	echo "  -d Build with debug symbols."
	echo "  -D Build a disabled package in disabled-packages/."
	echo "  -f Force build even if package has already been built."
	[ "$MCHS_ON_DEVICE_BUILD" = "false" ] && echo "  -i Download and extract dependencies instead of building them."
	echo "  -I Download and extract dependencies instead of building them, keep existing $MCHS_BASE_DIR files."
	echo "  -q Quiet build."
	echo "  -s Skip dependency check."
	echo "  -o Specify directory where to put built packages. Default: output/."
	echo "  --format Specify package output format (debian, pacman)."
	exit 1
}

declare -a PACKAGE_LIST=()

if [ "$#" -lt 1 ]; then _show_usage; fi
while (($# >= 1)); do
	case "$1" in
		--) shift 1; break;;
		-h|--help) _show_usage;;
		--format)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					mchs_error_exit "./build-package.sh: argument to '--format' should not be empty"
				fi

				case "$1" in
					debian|pacman) MCHS_PACKAGE_FORMAT="$1";;
					*) mchs_error_exit "./build-package.sh: only 'debian' and 'pacman' formats are supported";;
				esac
			else
				mchs_error_exit "./build-package.sh: option '--format' requires an argument"
			fi
			;;
		-a)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					mchs_error_exit "Argument to '-a' should not be empty."
				fi
				if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
					mchs_error_exit "./build-package.sh: option '-a' is not available for on-device builds"
				else
					export MCHS_ARCH="$1"
				fi
			else
				mchs_error_exit "./build-package.sh: option '-a' requires an argument"
			fi
			;;
		-d) export MCHS_DEBUG_BUILD=true;;
		-D) MCHS_IS_DISABLED=true;;
		-f) MCHS_FORCE_BUILD=true;;
		-i)
			if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
				mchs_error_exit "./build-package.sh: option '-i' is not available for on-device builds"
			else
				export MCHS_INSTALL_DEPS=true
			fi
			;;
		-I) export MCHS_INSTALL_DEPS=true && export MCHS_NO_CLEAN=true;;
		-q) export MCHS_QUIET_BUILD=true;;
		-s) export MCHS_SKIP_DEPCHECK=true;;
		-o)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					mchs_error_exit "./build-package.sh: argument to '-o' should not be empty"
				fi
				MCHS_OUTPUT_DIR=$(realpath -m "$1")
			else
				mchs_error_exit "./build-package.sh: option '-o' requires an argument"
			fi
			;;
		-c) MCHS_CONTINUE_BUILD=true;;
		-*) mchs_error_exit "./build-package.sh: illegal option '$1'";;
		*) PACKAGE_LIST+=("$1");;
	esac
	shift 1
done
unset -f _show_usage

if [ "${MCHS_INSTALL_DEPS-false}" = "true" ]; then
	# Setup PGP keys for verifying integrity of dependencies.
	# Keys are obtained from our keyring package.
	gpg --list-keys 2C7F29AE97891F6419A9E2CDB0076E490B71616B > /dev/null 2>&1 || {
		gpg --import "$MCHS_SCRIPTDIR/packages/mchs-keyring/grimler.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny")  --edit-key 2C7F29AE97891F6419A9E2CDB0076E490B71616B
	}
	gpg --list-keys CC72CF8BA7DBFA0182877D045A897D96E57CF20C > /dev/null 2>&1 || {
		gpg --import "$MCHS_SCRIPTDIR/packages/mchs-keyring/mchs-autobuilds.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny")  --edit-key CC72CF8BA7DBFA0182877D045A897D96E57CF20C
	}
fi

for ((i=0; i<${#PACKAGE_LIST[@]}; i++)); do
	# Following commands must be executed under lock to prevent running
	# multiple instances of "./build-package.sh".
	#
	# To provide sane environment for each package, builds are done
	# in subshell.
	(
		if ! $MCHS_BUILD_IGNORE_LOCK; then
			flock -n 5 || mchs_error_exit "Another build is already running within same environment."
		fi

		# Handle 'all' arch:
		if [ "$MCHS_ON_DEVICE_BUILD" = "false" ] && [ -n "${MCHS_ARCH+x}" ] && [ "${MCHS_ARCH}" = 'all' ]; then
			for arch in 'aarch64' 'arm' 'i686' 'x86_64'; do
				env MCHS_ARCH="$arch" MCHS_BUILD_IGNORE_LOCK=true ./build-package.sh \
					${MCHS_FORCE_BUILD+-f} ${MCHS_INSTALL_DEPS+-i} ${MCHS_IS_DISABLED+-D} \
					${MCHS_DEBUG_BUILD+-d} ${MCHS_OUTPUT_DIR+-o $MCHS_OUTPUT_DIR} \
					--format ${MCHS_PACKAGE_FORMAT:=debian} "${PACKAGE_LIST[i]}"
			done
			exit
		fi

		# Check the package to build:
		MCHS_PKG_NAME=$(basename "${PACKAGE_LIST[i]}")
		if [[ ${PACKAGE_LIST[i]} == *"/"* ]]; then
			# Path to directory which may be outside this repo:
			if [ ! -d "${PACKAGE_LIST[i]}" ]; then mchs_error_exit "'${PACKAGE_LIST[i]}' seems to be a path but is not a directory"; fi
			export MCHS_PKG_BUILDER_DIR
			MCHS_PKG_BUILDER_DIR=$(realpath "${PACKAGE_LIST[i]}")
		else
			# Package name:
			if [ -n "${MCHS_IS_DISABLED=""}" ]; then
				export MCHS_PKG_BUILDER_DIR=$MCHS_SCRIPTDIR/disabled-packages/$MCHS_PKG_NAME
			else
				export MCHS_PKG_BUILDER_DIR=$MCHS_SCRIPTDIR/packages/$MCHS_PKG_NAME
			fi
		fi
		MCHS_PKG_BUILDER_SCRIPT=$MCHS_PKG_BUILDER_DIR/build.sh
		if test ! -f "$MCHS_PKG_BUILDER_SCRIPT"; then
			mchs_error_exit "No build.sh script at package dir $MCHS_PKG_BUILDER_DIR!"
		fi

		mchs_step_setup_variables
		mchs_step_handle_buildarch

		if [ "$MCHS_CONTINUE_BUILD" == "false" ]; then
			mchs_step_setup_build_folders
		fi

		mchs_step_start_build

		if [ "$MCHS_CONTINUE_BUILD" == "false" ]; then
			mchs_step_get_dependencies
			mchs_step_override_config_scripts
		fi

		mchs_step_create_timestamp_file

		if [ "$MCHS_CONTINUE_BUILD" == "false" ]; then
			cd "$MCHS_PKG_CACHEDIR"
			mchs_step_get_source
			cd "$MCHS_PKG_SRCDIR"
			mchs_step_post_get_source
			mchs_step_handle_hostbuild
		fi

		mchs_step_setup_toolchain

		if [ "$MCHS_CONTINUE_BUILD" == "false" ]; then
			mchs_step_patch_package
			mchs_step_replace_guess_scripts
			cd "$MCHS_PKG_SRCDIR"
			mchs_step_pre_configure
		fi

		# Even on continued build we might need to setup paths
		# to tools so need to run part of configure step
		cd "$MCHS_PKG_BUILDDIR"
		mchs_step_configure

		if [ "$MCHS_CONTINUE_BUILD" == "false" ]; then
			cd "$MCHS_PKG_BUILDDIR"
			mchs_step_post_configure
		fi
		cd "$MCHS_PKG_BUILDDIR"
		mchs_step_make
		cd "$MCHS_PKG_BUILDDIR"
		mchs_step_make_install
		cd "$MCHS_PKG_BUILDDIR"
		mchs_step_post_make_install
		mchs_step_install_service_scripts
		mchs_step_install_license
		cd "$MCHS_PKG_MASSAGEDIR"
		mchs_step_extract_into_massagedir
		mchs_step_massage
		cd "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"
		mchs_step_post_massage
		cd "$MCHS_PKG_MASSAGEDIR"
		if [ "$MCHS_PACKAGE_FORMAT" = "debian" ]; then
			mchs_step_create_debian_package
		elif [ "$MCHS_PACKAGE_FORMAT" = "pacman" ]; then
			mchs_step_create_pacman_package
		else
			mchs_error_exit "Unknown packaging format '$MCHS_PACKAGE_FORMAT'."
		fi
		mchs_step_finish_build
	) 5< "$MCHS_BUILD_LOCK_FILE"
done
