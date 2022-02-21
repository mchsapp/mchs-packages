MCHS_PKG_HOMEPAGE=https://www.gnutls.org/
MCHS_PKG_DESCRIPTION="Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.7.3
MCHS_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnutls/v${MCHS_PKG_VERSION:0:3}/gnutls-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=fc59c43bc31ab20a6977ff083029277a31935b8355ce387b634fa433f8f6c49a
MCHS_PKG_DEPENDS="libgmp, libnettle, ca-certificates, libidn2, libunistring, unbound"
MCHS_PKG_BREAKS="libgnutls-dev"
MCHS_PKG_REPLACES="libgnutls-dev"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-cxx
--disable-hardware-acceleration
--disable-openssl-compatibility
--with-default-trust-store-file=$MCHS_PREFIX/etc/tls/cert.pem
--with-system-priority-file=${MCHS_PREFIX}/etc/gnutls/default-priorities
--with-unbound-root-key-file=$MCHS_PREFIX/etc/unbound/root.key
--with-included-libtasn1
--enable-local-libopts
--without-p11-kit
--disable-guile
--disable-doc
"

mchs_step_pre_configure() {
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
}
