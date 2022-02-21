MCHS_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libgpg-error/
MCHS_PKG_DESCRIPTION="Small library that defines common error values for all GnuPG components"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.43
MCHS_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=a9ab83ca7acc442a5bd846a75b920285ff79bdb4e3d34aa382be88ed2c3aebaf
MCHS_PKG_BREAKS="libgpg-error-dev"
MCHS_PKG_REPLACES="libgpg-error-dev"
MCHS_PKG_RM_AFTER_INSTALL="share/common-lisp"

mchs_step_post_get_source() {
	# Upstream only has Android definitions for platform-specific lock objects.
	# See https://lists.gnupg.org/pipermail/gnupg-devel/2014-January/028203.html
	# for how to generate a lock-obj header file on devices.

	# For aarch64 this was generated on a device:
	cp $MCHS_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h $MCHS_PKG_SRCDIR/src/syscfg/

	if [ $MCHS_ARCH = i686 ]; then
		# Android i686 has same config as arm (verified by generating a file on a i686 device):
		cp $MCHS_PKG_SRCDIR/src/syscfg/lock-obj-pub.arm-unknown-linux-androideabi.h \
		   $MCHS_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	elif [ $MCHS_ARCH = x86_64 ]; then
		# FIXME: Generate on device.
		cp $MCHS_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h \
			$MCHS_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	fi
}

mchs_step_pre_configure() {
	autoreconf -fi
	# USE_POSIX_THREADS_WEAK is being enabled for on-device build and causes
	# errors, so force-disable it.
	sed -i 's/USE_POSIX_THREADS_WEAK/DONT_USE_POSIX_THREADS_WEAK/g' configure
}
