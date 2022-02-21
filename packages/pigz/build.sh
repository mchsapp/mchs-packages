MCHS_PKG_HOMEPAGE=https://www.zlib.net/pigz
MCHS_PKG_DESCRIPTION="Parallel implementation of the gzip file compressor"
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7
MCHS_PKG_SRCURL=https://www.zlib.net/pigz/pigz-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=b4c9e60344a08d5db37ca7ad00a5b2c76ccb9556354b722d56d55ca7e8b1c707
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm700 pigz $MCHS_PREFIX/bin/pigz
	ln -sfr $MCHS_PREFIX/bin/pigz $MCHS_PREFIX/bin/unpigz
	install -Dm600 pigz.1 $MCHS_PREFIX/share/man/man1/pigz.1
}
