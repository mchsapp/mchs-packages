MCHS_PKG_HOMEPAGE=https://www.cipherdyne.org/fwknop/
MCHS_PKG_DESCRIPTION="fwknop: Single Packet Authorization > Port Knocking"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.10
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://www.cipherdyne.org/fwknop/download/fwknop-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=f6c09bec97ed8e474a98ae14f9f53e1bcdda33393f20667b6af3fb6bb894ca77
MCHS_PKG_DEPENDS="gpgme"
MCHS_PKG_BREAKS="fwknop-dev"
MCHS_PKG_REPLACES="fwknop-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-server
--with-gpgme
--with-gpg=$MCHS_PREFIX/bin/gpg2
"
