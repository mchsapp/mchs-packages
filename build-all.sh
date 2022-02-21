#!/bin/bash
# build-all.sh - script to build all packages with a build order specified by buildorder.py

set -e -u -o pipefail

if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	echo "On-device execution of this script is not supported."
	exit 1
fi

# Read settings from .mchsrc if existing
test -f "$HOME"/.mchsrc && . "$HOME"/.mchsrc
: ${MCHS_TOPDIR:="$HOME/.mchs-build"}
: ${MCHS_ARCH:="aarch64"}
: ${MCHS_DEBUG_BUILD:=""}
: ${MCHS_INSTALL_DEPS:="-s"}
# Set MCHS_INSTALL_DEPS to -s unless set to -i

_show_usage() {
	echo "Usage: ./build-all.sh [-a ARCH] [-d] [-i] [-o DIR]"
	echo "Build all packages."
	echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	echo "  -d Build with debug symbols."
	echo "  -i Build dependencies."
	echo "  -o Specify deb directory. Default: debs/."
	exit 1
}

while getopts :a:hdio: option; do
case "$option" in
	a) MCHS_ARCH="$OPTARG";;
	d) MCHS_DEBUG_BUILD='-d';;
	i) MCHS_INSTALL_DEPS='-i';;
	o) MCHS_OUTPUT_DIR="$(realpath -m "$OPTARG")";;
	h) _show_usage;;
	*) _show_usage >&2 ;;
esac
done
shift $((OPTIND-1))
if [ "$#" -ne 0 ]; then _show_usage; fi

if [[ ! "$MCHS_ARCH" =~ ^(all|aarch64|arm|i686|x86_64)$ ]]; then
	echo "ERROR: Invalid arch '$MCHS_ARCH'" 1>&2
	exit 1
fi

BUILDSCRIPT=$(dirname "$0")/build-package.sh
BUILDALL_DIR=$MCHS_TOPDIR/_buildall-$MCHS_ARCH
BUILDORDER_FILE=$BUILDALL_DIR/buildorder.txt
BUILDSTATUS_FILE=$BUILDALL_DIR/buildstatus.txt

if [ -e "$BUILDORDER_FILE" ]; then
	echo "Using existing buildorder file: $BUILDORDER_FILE"
else
	mkdir -p "$BUILDALL_DIR"
	./scripts/buildorder.py > "$BUILDORDER_FILE"
fi
if [ -e "$BUILDSTATUS_FILE" ]; then
	echo "Continuing build-all from: $BUILDSTATUS_FILE"
fi

exec >	>(tee -a "$BUILDALL_DIR"/ALL.out)
exec 2> >(tee -a "$BUILDALL_DIR"/ALL.err >&2)
trap 'echo ERROR: See $BUILDALL_DIR/${PKG}.err' ERR

while read -r PKG PKG_DIR; do
	# Check build status (grepping is a bit crude, but it works)
	if [ -e "$BUILDSTATUS_FILE" ] && grep "^$PKG\$" "$BUILDSTATUS_FILE" >/dev/null; then
		printf "Skipping \033[0;32m$PKG\033[0m\n"
		continue
	fi

	printf "\033[0;34m[McHs]:\033[0m Building \033[0;32m$PKG\033[0m"
	BUILD_START=$(date "+%s")
	bash -x "$BUILDSCRIPT" -a "$MCHS_ARCH" $MCHS_DEBUG_BUILD \
		${MCHS_OUTPUT_DIR+-o $MCHS_OUTPUT_DIR} $MCHS_INSTALL_DEPS "$PKG_DIR" \
		> "$BUILDALL_DIR"/"${PKG}".out 2> "$BUILDALL_DIR"/"${PKG}".err
	BUILD_END=$(date "+%s")
	BUILD_SECONDS=$(( BUILD_END - BUILD_START ))
	printf ", Done in \033[0;32m$BUILD_SECONDS\033[0m\n"
	find ~/.mchs-build/* -maxdepth 1 -type d -not -name "_*" -not -name "${PKG}" -exec rm -rf {} \;

	# Update build status
	echo "$PKG" >> "$BUILDSTATUS_FILE"
done<"${BUILDORDER_FILE}"

# Update build status
rm -f "$BUILDSTATUS_FILE"
printf "\033[0;34m[Result]:\033[0m \033[0;32mPackages Build Finished.\033[0m"
