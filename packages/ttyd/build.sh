MCHS_PKG_HOMEPAGE=https://tsl0922.github.io/ttyd/
MCHS_PKG_DESCRIPTION="Command-line tool for sharing terminal over the web"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.3
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://github.com/tsl0922/ttyd/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=1116419527edfe73717b71407fb6e06f46098fc8a8e6b0bb778c4c75dc9f64b9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="json-c, libuv, libwebsockets, zlib, libcap"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_XXD=$MCHS_PKG_TMPDIR/xxd"

mchs_step_pre_configure() {
	mchs_download \
		https://raw.githubusercontent.com/vim/vim/v8.1.0427/src/xxd/xxd.c \
		$MCHS_PKG_CACHEDIR/xxd.c \
		021b38e02cd31951a80ef5185271d71f2def727eb8ff65b7a07aecfbd688b8e1
	gcc $MCHS_PKG_CACHEDIR/xxd.c -o $MCHS_PKG_TMPDIR/xxd
}
