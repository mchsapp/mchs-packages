MCHS_PKG_HOMEPAGE=https://cmake.org/
MCHS_PKG_DESCRIPTION="Family of tools designed to build, test and package software"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
# When updating version here, please update mchs_setup_cmake.sh as well.
MCHS_PKG_VERSION=3.22.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.cmake.org/files/v${MCHS_PKG_VERSION:0:4}/cmake-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0e998229549d7b3f368703d20e248e7ee1f853910d42704aa87918c213ea82c0
MCHS_PKG_DEPENDS="libarchive, libc++, libcurl, libexpat, jsoncpp, libuv, rhash, make, clang, zlib"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DKWSYS_LFS_WORKS=ON -DBUILD_CursesDialog=ON"
