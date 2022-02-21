MCHS_PKG_HOMEPAGE=https://www.djcbsoftware.nl/code/mu/
MCHS_PKG_DESCRIPTION="Maildir indexer/searcher and Emacs client (mu4e)"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.9
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/djcb/mu/releases/download/$MCHS_PKG_VERSION-signed/mu-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=8d99430a4f6942eb3122008bb897c4480cda64b30ff4575c32ded86d7edbaf58
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="emacs, glib, libc++, libxapian, libgmime"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk --disable-webkit"

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	echo "(setq byte-compile-warnings nil)" > $MCHS_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el
	LC_ALL=C $MCHS_PREFIX/bin/emacs -no-site-file -q -batch -l $MCHS_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el -f batch-byte-compile $MCHS_PREFIX/share/emacs/site-lisp/mu4e/*.el
	rm -f $MCHS_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.elc
	chmod 644 $MCHS_PREFIX/share/emacs/site-lisp/mu4e/*.elc
	EOF

	cat <<- EOF > ./prerm
	rm -f $MCHS_PREFIX/share/emacs/site-lisp/mu4e/*.elc
	EOF
}
