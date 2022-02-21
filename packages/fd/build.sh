MCHS_PKG_HOMEPAGE=https://github.com/sharkdp/fd
MCHS_PKG_DESCRIPTION="Simple, fast and user-friendly alternative to find"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.3.2
MCHS_PKG_SRCURL=https://github.com/sharkdp/fd/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=9cc2354c652ee38369a4ce865404f284e94fa9daf043bb31d36297e7a2d7cd45
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
	mkdir -p  $MCHS_PREFIX/share/man/man1
	cp $MCHS_PKG_SRCDIR/doc/fd.1 $MCHS_PREFIX/share/man/man1/fd.1
}
