MCHS_PKG_HOMEPAGE=http://gnuplot.info/
MCHS_PKG_DESCRIPTION="Command-line driven graphing utility"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.4.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/gnuplot/gnuplot/${MCHS_PKG_VERSION}/gnuplot-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e57c75e1318133951d32a83bcdc4aff17fed28722c4e71f2305cfc2ae1cae7ba
MCHS_PKG_DEPENDS="libandroid-support, libc++, libgd, libiconv, libx11, pango, readline, zlib"
MCHS_PKG_BREAKS="gnuplot-x"
MCHS_PKG_REPLACES="gnuplot-x"
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-x
--without-lua
--with-bitmap-terminals
--without-latex
"

mchs_step_host_build() {
	"$MCHS_PKG_SRCDIR/configure"
	make -C docs/ gnuplot.gih
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/share/gnuplot/${MCHS_PKG_VERSION:0:3}/

	cp $MCHS_PKG_HOSTBUILD_DIR/docs/gnuplot.gih \
	   $MCHS_PREFIX/share/gnuplot/${MCHS_PKG_VERSION:0:3}/gnuplot.gih
}
