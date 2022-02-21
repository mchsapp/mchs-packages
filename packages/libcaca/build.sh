MCHS_PKG_HOMEPAGE=http://caca.zoy.org/wiki/libcaca
MCHS_PKG_DESCRIPTION="Graphics library that outputs text instead of pixels"
MCHS_PKG_LICENSE="WTFPL"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.99.beta19
MCHS_PKG_REVISION=9
MCHS_PKG_SRCURL=http://fossies.org/linux/privat/libcaca-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4
MCHS_PKG_DEPENDS="imlib2, libc++, ncurses, zlib"
MCHS_PKG_BREAKS="libcaca-dev"
MCHS_PKG_REPLACES="libcaca-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-doc
--disable-java
--disable-python
--disable-ruby
--enable-imlib2
"

mchs_step_post_configure() {
	if [ $MCHS_ARCH = x86_64 ]; then
		# Remove troublesome asm usage:
		perl -p -i -e 's/#define HAVE_FLDLN2 1//' $MCHS_PKG_BUILDDIR/config.h
	fi
}
