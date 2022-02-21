# keep repology-metadata in sync with this

MCHS_ANDROID_BUILD_TOOLS_VERSION=30.0.3
MCHS_NDK_VERSION_NUM=23
MCHS_NDK_REVISION="b"
MCHS_NDK_VERSION=$MCHS_NDK_VERSION_NUM$MCHS_NDK_REVISION
# when changing the above:
# remove MCHS_PKG_REVISION in:
#   libc++, ndk-multilib, ndk-sysroot, vulkan-loader-android
# update SHA256 sums in scripts/setup-android-sdk.sh
# check all packages build and run correctly and bump if needed

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
	export ANDROID_HOME=${MCHS_SCRIPTDIR}/build-tools/android-sdk
	export NDK=${MCHS_SCRIPTDIR}/build-tools/android-ndk
else
	: "${ANDROID_HOME:="${HOME}/lib/android-sdk"}"
	: "${NDK:="${HOME}/lib/android-ndk"}"
fi

# McHs packages configuration.
MCHS_APP_PACKAGE="com.mchs"
MCHS_BASE_DIR="/data/data/${MCHS_APP_PACKAGE}/files"
MCHS_CACHE_DIR="/data/data/${MCHS_APP_PACKAGE}/cache"
MCHS_ANDROID_HOME="${MCHS_BASE_DIR}/home"
MCHS_PREFIX="${MCHS_BASE_DIR}/usr"

# Allow to override setup.
if [ -f "$HOME/.mchsrc" ]; then
	. "$HOME/.mchsrc"
fi
