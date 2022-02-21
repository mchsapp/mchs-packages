MCHS_PKG_HOMEPAGE=https://github.com/google/brotli
MCHS_PKG_DESCRIPTION="lossless compression algorithm and format (command line utility)"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.9
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/google/brotli/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="brotli-dev"
MCHS_PKG_REPLACES="brotli-dev"
MCHS_PKG_FORCE_CMAKE=true

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/share/man/man{1,3}
	cp $MCHS_PKG_SRCDIR/docs/brotli.1 $MCHS_PREFIX/share/man/man1/
	cp $MCHS_PKG_SRCDIR/docs/*.3 $MCHS_PREFIX/share/man/man3/
}
