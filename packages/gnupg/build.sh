MCHS_PKG_HOMEPAGE=https://www.gnupg.org/
MCHS_PKG_DESCRIPTION="Implementation of the OpenPGP standard for encrypting and signing data and communication"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.4
MCHS_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=f3468ecafb1d7f9ad7b51fd1db7aebf17ceb89d2efa8a05cf2f39b4d405402ae
MCHS_PKG_DEPENDS="libassuan, libbz2, libgcrypt, libgnutls, libgpg-error, libksba, libnpth, libsqlite, readline, pinentry, resolv-conf, zlib"
MCHS_PKG_CONFLICTS="gnupg2 (<< 2.2.9-1), dirmngr (<< 2.2.17-1)"
MCHS_PKG_REPLACES="gnupg2 (<< 2.2.9-1), dirmngr (<< 2.2.17-1)"
MCHS_PKG_SUGGESTS="scdaemon"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ldap
--enable-sqlite
--enable-tofu
"
# Remove non-english help files and man pages shipped with the gnupg (1) package:
MCHS_PKG_RM_AFTER_INSTALL="share/gnupg/help.*.txt share/man/man1/gpg-zip.1 share/man/man7/gnupg.7"

mchs_step_pre_configure() {
	CPPFLAGS+=" -Ddn_skipname=__dn_skipname"
}

mchs_step_post_make_install() {
	cd $MCHS_PREFIX/bin
	ln -sf gpg gpg2
}
