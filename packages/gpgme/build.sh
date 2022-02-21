MCHS_PKG_HOMEPAGE=https://www.gnupg.org/related_software/gpgme/
MCHS_PKG_DESCRIPTION="Library designed to make access to GnuPG easier"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.17.0
MCHS_PKG_SRCURL=ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=4ed3f50ceb7be2fce2c291414256b20c9ebf4c03fddb922c88cda99c119a69f5
MCHS_PKG_DEPENDS="gnupg (>= 2.2.9-1), libassuan, libgpg-error"
MCHS_PKG_BREAKS="gpgme-dev"
MCHS_PKG_REPLACES="gpgme-dev"
# Use "--disable-gpg-test" to avoid "No rule to make target `../../src/libgpgme-pthread.la":
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gpg-test
--enable-languages=cpp
--with-gpg=$MCHS_PREFIX/bin/gpg2
--without-g13
--without-gpgconf
--without-gpgsm
"
