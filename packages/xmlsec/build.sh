MCHS_PKG_HOMEPAGE=https://www.aleksey.com/xmlsec/
MCHS_PKG_DESCRIPTION="XML Security Library"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.31
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://www.aleksey.com/xmlsec/download/xmlsec1-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=9b10bc52cc31e4f76162e3975e50db26b71ab49c571d810b311ca626be5a0b26
MCHS_PKG_DEPENDS="libxslt, openssl, libgcrypt, libgpg-error, libxml2"
MCHS_PKG_BREAKS="xmlsec-dev"
MCHS_PKG_REPLACES="xmlsec-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-crypto-dl
--without-gnutls
"
