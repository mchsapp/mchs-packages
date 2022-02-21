MCHS_PKG_HOMEPAGE=https://notmuchmail.org
MCHS_PKG_DESCRIPTION="Thread-based email index, search and tagging system"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.32.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://notmuchmail.org/releases/notmuch-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=8e0a7eb8ff2e6011ef48b2bf11d79b9c4bb74511cfe2987758b64898c2a2ded7
MCHS_PKG_DEPENDS="glib, libc++, libgmime, libtalloc, libxapian, zlib"
MCHS_PKG_BREAKS="notmuch-dev"
MCHS_PKG_REPLACES="notmuch-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	# Use python3 so that the python3-sphinx package is
	# found for man page generation.
	export PYTHON=python3

	cd $MCHS_PKG_SRCDIR
	XAPIAN_CONFIG=$MCHS_PREFIX/bin/xapian-config ./configure \
		--prefix=$MCHS_PREFIX \
		--without-api-docs \
		--without-desktop \
		--without-emacs \
		--without-ruby
}
