#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
. "$SCRIPT_DIR"/properties.sh

check_package() { # path
	local path=$1
	local pkg=$(basename "$path")
	MCHS_PKG_REVISION=0
	MCHS_ARCH=aarch64
	. "$path"/build.sh
	if [ "$MCHS_PKG_REVISION" != "0" ] || [ "$MCHS_PKG_VERSION" != "${MCHS_PKG_VERSION/-/}" ]; then
		MCHS_PKG_VERSION+="-$MCHS_PKG_REVISION"
	fi
	echo "$pkg=$MCHS_PKG_VERSION"
}

for path in "${SCRIPT_DIR}"/../packages/*; do
(
	check_package "$path"
)
done
