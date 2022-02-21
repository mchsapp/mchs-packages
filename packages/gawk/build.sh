MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gawk/
MCHS_PKG_DESCRIPTION="Programming language designed for text processing"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.1.1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gawk/gawk-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=d87629386e894bbea11a5e00515fc909dc9b7249529dad9e6a3a2c77085f7ea2
MCHS_PKG_DEPENDS="libandroid-support, libgmp, libmpfr, readline"
MCHS_PKG_BREAKS="gawk-dev"
MCHS_PKG_REPLACES="gawk-dev"
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_RM_AFTER_INSTALL="bin/gawk-* bin/igawk share/man/man1/igawk.1"
MCHS_PKG_GROUPS="base-devel"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Remove old symlink to force a fresh timestamp:
	rm -f $MCHS_PREFIX/bin/awk

	# http://cross-lfs.org/view/CLFS-2.1.0/ppc64-64/temp-system/gawk.html
	cp -v extension/Makefile.in{,.orig}
	sed -e 's/check-recursive all-recursive: check-for-shared-lib-support/check-recursive all-recursive:/' extension/Makefile.in.orig > extension/Makefile.in
}
