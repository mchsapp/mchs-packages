MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/libgcrypt/
MCHS_PKG_DESCRIPTION="General purpose cryptographic library based on the code from GnuPG"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_LICENSE_FILE="LICENSES"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.4
MCHS_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=ea849c83a72454e3ed4267697e8ca03390aee972ab421e7df69dfe42b65caaf7
MCHS_PKG_DEPENDS="libgpg-error"
MCHS_PKG_BREAKS="libgcrypt-dev"
MCHS_PKG_REPLACES="libgcrypt-dev"
# configure tries to detect pthreads by linking with -lpthread, which does not exist on Android:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pthread_pthread_create=yes
--disable-jent-support
"

mchs_step_pre_configure() {
	CFLAGS+=" -no-integrated-as"
	if [ $MCHS_ARCH = "arm" ]; then
		# See http://marc.info/?l=gnupg-devel&m=139136972631909&w=3
		CFLAGS+=" -mno-unaligned-access"
		# Avoid text relocations:
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" gcry_cv_gcc_inline_asm_neon=no"
	elif [ $MCHS_ARCH = "i686" ] || [ $MCHS_ARCH = "x86_64" ]; then
		# Fix i686 android build, also in https://bugzilla.gnome.org/show_bug.cgi?id=724050
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
