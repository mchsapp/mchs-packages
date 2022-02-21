MCHS_PKG_HOMEPAGE=https://lftp.tech/
MCHS_PKG_DESCRIPTION="FTP/HTTP client and file transfer program"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.9.2
MCHS_PKG_SRCURL=https://lftp.tech/ftp/lftp-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=c517c4f4f9c39bd415d7313088a2b1e313b2d386867fe40b7692b83a20f0670d
MCHS_PKG_REVISION=2
MCHS_PKG_DEPENDS="libandroid-support, libc++, libexpat, libiconv, openssl, readline, libidn2, zlib"

# (1) Android has dn_expand, but lftp assumes that dn_skipname then exists, which it does not on android.
# (2) Use --with-openssl to use openssl instead of gnutls.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
ac_cv_func_dn_expand=no
--with-openssl
--with-expat=$MCHS_PREFIX
--with-readline=$MCHS_PREFIX
--with-zlib=$MCHS_PREFIX
"

mchs_step_pre_configure() {
	CXXFLAGS+=" -DNO_INLINE_GETPASS=1"
}
