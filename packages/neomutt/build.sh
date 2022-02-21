MCHS_PKG_HOMEPAGE=https://neomutt.org/
MCHS_PKG_DESCRIPTION="A version of mutt with added features"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20211029
MCHS_PKG_SRCURL=https://github.com/neomutt/neomutt/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=08245cfa7aec80b895771fd1adcbb7b86e9c0434dfa64574e3c8c4d692aaa078
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d{8}"
MCHS_PKG_DEPENDS="gdbm, krb5, libiconv, libsasl, ncurses, notmuch, openssl, zlib, zstd"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFFILES="etc/neomuttrc"

mchs_step_configure() {
	./configure --host=$MCHS_HOST_PLATFORM \
		--prefix=$MCHS_PREFIX --with-mailpath=$MCHS_PREFIX/var/mail \
		--notmuch \
		--disable-gpgme --disable-idn --zstd --sasl --ssl --gdbm --gss
}
