MCHS_PKG_HOMEPAGE=http://www.mutt.org/
MCHS_PKG_DESCRIPTION="Mail client with patches from neomutt"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.4
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=ftp://ftp.mutt.org/pub/mutt/mutt-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3361b682ea23df88961fa9835196698aefd2ebf0aba494599b29d1c4b1b4db79
MCHS_PKG_DEPENDS="libandroid-support, ncurses, gdbm, openssl, libsasl, mime-support, zlib, libiconv"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
mutt_cv_c99_snprintf=yes
mutt_cv_c99_vsnprintf=yes
--disable-gpgme
--enable-compressed
--enable-hcache
--enable-imap
--enable-pop
--enable-sidebar
--enable-smtp
--with-exec-shell=$MCHS_PREFIX/bin/sh
--with-mailpath=$MCHS_PREFIX/var/mail
--without-idn
--with-sasl
--with-ssl
"

if $MCHS_DEBUG_BUILD; then
	export MCHS_PKG_EXTRA_CONFIGURE_ARGS+="--enable-debug"
fi

MCHS_PKG_RM_AFTER_INSTALL="
bin/flea
bin/muttbug
share/man/man1/muttbug.1
share/man/man1/flea.1
etc/mime.types.dist
"

MCHS_PKG_CONFFILES="etc/Muttrc"

mchs_step_post_configure() {
	# Build wants to run mutt_md5:
	gcc -DHAVE_STDINT_H -DMD5UTIL $MCHS_PKG_SRCDIR/md5.c -o $MCHS_PKG_BUILDDIR/mutt_md5
	touch -d "next hour" $MCHS_PKG_BUILDDIR/mutt_md5
}

mchs_step_post_make_install() {
	cp $MCHS_PKG_SRCDIR/doc/mutt.man $MCHS_PREFIX/share/man/man1/mutt.1.man
	mkdir -p $MCHS_PREFIX/share/examples/mutt/
	cp $MCHS_PKG_SRCDIR/contrib/gpg.rc $MCHS_PREFIX/share/examples/mutt/gpg.rc
}
