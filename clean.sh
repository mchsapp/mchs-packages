#!/bin/sh
# clean.sh - clean everything.
set -e -u

# Checking if script is running on Android with 2 different methods.
# Needed for safety to prevent execution of potentially dangerous
# operations such as 'rm -rf /data/*' on Android device.
if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	MCHS_ON_DEVICE_BUILD=true
else
	MCHS_ON_DEVICE_BUILD=false
fi

if [ "$(id -u)" = "0" ] && $MCHS_ON_DEVICE_BUILD; then
	echo "On-device execution of this script as root is disabled."
	exit 1
fi

# Read settings from .mchsrc if existing
test -f "$HOME/.mchsrc" && . "$HOME/.mchsrc"
: "${MCHS_TOPDIR:="$HOME/.mchs-build"}"
: "${TMPDIR:=/tmp}"
export TMPDIR

# Lock file. Same as used in build-package.sh.
MCHS_BUILD_LOCK_FILE="${TMPDIR}/.mchs-build.lck"
if [ ! -e "$MCHS_BUILD_LOCK_FILE" ]; then
	touch "$MCHS_BUILD_LOCK_FILE"
fi

{
	if ! flock -n 5; then
		printf "\033[0;31m[Error]\033[0m - Not cleaning build directory since you have unfinished build running."
		exit 1
	fi

	if [ -d "$MCHS_TOPDIR" ]; then
		chmod +w -R "$MCHS_TOPDIR" || true
	fi

	if $MCHS_ON_DEVICE_BUILD; then
		# For on-device build cleanup /data shouldn't be erased.
		rm -Rf "$MCHS_TOPDIR"
	else
		rm -Rf /data/* "$MCHS_TOPDIR"
	fi
} 5< "$MCHS_BUILD_LOCK_FILE"
