MCHS_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Tools
MCHS_PKG_DESCRIPTION="Vulkan Tools and Utilities"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.205
MCHS_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Tools/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=58a0a9fc0babc3b643b390b33c4986ef9a3e5b5df6a428081a63c127a1185139
MCHS_PKG_BUILD_DEPENDS="vulkan-headers, vulkan-loader-android"
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_CUBE=OFF
-DBUILD_ICD=OFF
-DBUILD_WSI_XCB_SUPPORT=OFF
-DBUILD_WSI_XLIB_SUPPORT=OFF
-DBUILD_WSI_WAYLAND_SUPPORT=OFF
"