MCHS_PKG_HOMEPAGE=https://swi-prolog.org/
MCHS_PKG_DESCRIPTION="Most popular and complete prolog implementation"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
# Use "development" versions.
MCHS_PKG_VERSION=8.5.2
MCHS_PKG_SRCURL=https://www.swi-prolog.org/download/devel/src/swipl-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4f582b70e5aef59ca95338a1cac3630360f3c2fe6623a0701bd49b46079a5aa4
MCHS_PKG_DEPENDS="libarchive, libcrypt, libgmp, libjpeg-turbo, libyaml, ncurses, ncurses-ui-libs, pcre, readline, ossp-uuid, zlib"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DINSTALL_DOCUMENTATION=OFF
-DUSE_GMP=ON
-DSWIPL_NATIVE_FRIEND=${MCHS_PKG_HOSTBUILD_DIR}
-DPOSIX_SHELL=${MCHS_PREFIX}/bin/sh
-DSWIPL_TMP_DIR=${MCHS_PREFIX}/tmp
-DSWIPL_INSTALL_IN_LIB=ON
-DSWIPL_PACKAGES_BDB=OFF
-DSWIPL_PACKAGES_ODBC=OFF
-DSWIPL_PACKAGES_QT=OFF
-DSWIPL_PACKAGES_X=OFF
-DINSTALL_TESTS=OFF
-DBUILD_TESTING=OFF
-DSYSTEM_CACERT_FILENAME=${MCHS_PREFIX}/etc/tls/cert.pem"

# We do this to produce:
# a native host build to produce
# boot<nn>.prc, INDEX.pl, ssl cetificate tests,
# SWIPL_NATIVE_FRIEND tells SWI-Prolog to use
# this build for the artifacts needed to build the
# Android version
mchs_step_host_build() {
	mchs_setup_cmake
	mchs_setup_ninja

	if [ $MCHS_ARCH_BITS = 32 ]; then
		export LDFLAGS=-m32
		export CFLAGS=-m32
		export CXXFLAGS=-m32
		CMAKE_EXTRA_DEFS="-DCMAKE_LIBRARY_PATH=/usr/lib/i386-linux-gnu"
	else
		CMAKE_EXTRA_DEFS=""
	fi

	cmake "$MCHS_PKG_SRCDIR"          \
		-G "Ninja"                      \
		$CMAKE_EXTRA_DEFS               \
		-DINSTALL_DOCUMENTATION=OFF     \
		-DSWIPL_PACKAGES=ON             \
		-DUSE_GMP=OFF                   \
		-DBUILD_TESTING=ON              \
		-DSWIPL_SHARED_LIB=OFF          \
		-DSWIPL_PACKAGES_BDB=OFF        \
		-DSWIPL_PACKAGES_ODBC=OFF       \
		-DSWIPL_PACKAGES_QT=OFF         \
		-DSWIPL_PACKAGES_X=OFF
	ninja

	unset LDFLAGS
	unset CFLAGS
	unset CXXFLAGS
}

mchs_step_post_make_install() {
	# Remove host build because future builds may be
	# of a different word size (e.g. 32bit or 64bit)
	rm -rf "$MCHS_PKG_HOSTBUILD_DIR"
}
