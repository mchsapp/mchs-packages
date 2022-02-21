MCHS_PKG_HOMEPAGE=https://racket-lang.org
MCHS_PKG_DESCRIPTION="Full-spectrum programming language going beyond Lisp and Scheme"
MCHS_PKG_LICENSE="GPL-3.0, LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=7.4
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://www.cs.utah.edu/plt/installers/${MCHS_PKG_VERSION}/racket-minimal-${MCHS_PKG_VERSION}-src-builtpkgs.tgz
MCHS_PKG_SHA256=c819608cee733c98241e329274f3567956baaaa7283e061e45342f533bd9a51b
MCHS_PKG_DEPENDS="libffi, libiconv"
MCHS_PKG_NO_DEVELSPLIT=true
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-racket=$MCHS_PKG_HOSTBUILD_DIR/racket/racketcgc
--enable-libs
--disable-shared
--disable-gracket
--enable-libffi"

mchs_step_host_build() {
	"$MCHS_PKG_SRCDIR"/src/configure \
		$MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -j "$MCHS_MAKE_PROCESSES"
}

mchs_step_pre_configure() {
	CPPFLAGS+=" -I$MCHS_PKG_SRCDIR/src/racket/include -I$MCHS_PKG_BUILDDIR/racket"
	LDFLAGS+=" -liconv -llog"
	export MCHS_PKG_SRCDIR="$MCHS_PKG_SRCDIR/src"
}
