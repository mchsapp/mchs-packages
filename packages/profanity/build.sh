MCHS_PKG_HOMEPAGE=https://profanity-im.github.io
MCHS_PKG_DESCRIPTION="Profanity is a console based XMPP client written in C using ncurses and libstrophe, inspired by Irssi"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_VERSION=0.11.1
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/profanity-im/profanity/releases/download/$MCHS_PKG_VERSION/profanity-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6f1b4df6c2971f51d03d48d2bfd4f69b4404410d800b43f029ea1cf08a02bd45
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libandroid-support, libffi, ncurses, glib, libmesode, libcurl, readline, libuuid, libotr, gpgme, python, libassuan, libgpg-error, zlib, libsignal-protocol-c"
MCHS_PKG_BREAKS="profanity-dev"
MCHS_PKG_REPLACES="profanity-dev"
# openssl, libexpat needed by libmesode, pcre needed by glib:
MCHS_PKG_BUILD_DEPENDS="openssl, libexpat, pcre, libgcrypt, libcrypt"
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" --disable-python-plugins --without-xscreensaver"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CPPFLAGS+=" -I$MCHS_PREFIX/include/python3.10"
	LDFLAGS+=" -lpython3.10"
}

mchs_step_post_configure() {
	# Enable python support manually, as trying to go using --enable-python-plugins
	# causes configure trying to execute python:
	echo '#define HAVE_PYTHON 1' >> $MCHS_PKG_SRCDIR/src/config.h
	perl -p -i -e 's|#am__objects_2|am__objects_2|' $MCHS_PKG_SRCDIR/Makefile
}
