MCHS_PKG_HOMEPAGE=https://source.android.com/devices/graphics/arch-vulkan
MCHS_PKG_DESCRIPTION="Vulkan Loader for Android"
MCHS_PKG_LICENSE="NCSA"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=$MCHS_NDK_VERSION
MCHS_PKG_REVISION=2
MCHS_PKG_SKIP_SRC_EXTRACT=true

# Desktop Vulkan Loader
# https://github.com/KhronosGroup/Vulkan-Loader
# https://github.com/KhronosGroup/Vulkan-Loader/blob/master/loader/LoaderAndLayerInterface.md

# Android Vulkan Loader
# https://source.android.com/devices/graphics/arch-vulkan
# https://android.googlesource.com/platform/frameworks/native/+/master/vulkan

# Vulkan functions exported by Android Vulkan Loader depending on API version
# https://android.googlesource.com/platform/frameworks/native/+/master/vulkan/libvulkan/libvulkan.map.txt

# For now this package provides the NDK stub libvulkan.so
# The package will symbolic link system provided libvulkan.so to McHs Prefix
# if available

mchs_step_post_make_install() {
	cp -fv "$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libvulkan.so" \
		"$MCHS_PREFIX/lib/libvulkan.so"
}

mchs_step_create_debscripts() {
	if [ "$MCHS_ARCH_BITS" = 64 ]; then _BITS=64; else _BITS=""; fi
	cat <<- EOF > postinst
	#!$MCHS_PREFIX/bin/sh
	if [ -e /system/lib${_BITS}/libvulkan.so ]; then
		echo "Symlink /system/lib${_BITS}/libvulkan.so to $MCHS_PREFIX/lib/libvulkan.so ..."
		ln -fsT "/system/lib${_BITS}/libvulkan.so" "$MCHS_PREFIX/lib/libvulkan.so"
	fi
	EOF

	cat <<- EOF > postrm
	#!$MCHS_PREFIX/bin/sh
	rm -f "$MCHS_PREFIX/lib/libvulkan.so"
	EOF
	unset _BITS
}
