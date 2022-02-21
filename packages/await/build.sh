MCHS_PKG_HOMEPAGE=https://await-cli.app/
MCHS_PKG_DESCRIPTION="Runs list of commands in parallel and waits for their termination"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.91
MCHS_PKG_SRCURL=https://github.com/slavaGanzin/await/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5970d8effb605210dceeabd01bc617af914b7e63e29e39a25e64758515796103

mchs_step_make() {
	$CC $CPPFLAGS $CFLAGS "$MCHS_PKG_SRCDIR"/await.c -o await $LDFLAGS
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin await
}
