MCHS_PKG_HOMEPAGE=http://net-tools.sourceforge.net/
MCHS_PKG_DESCRIPTION="Configuration tools for Linux networking"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.10.0
MCHS_PKG_SRCURL=https://sourceforge.net/projects/net-tools/files/net-tools-2.10.tar.xz
MCHS_PKG_SHA256=b262435a5241e89bfa51c3cabd5133753952f7a7b7b93f32e08cb9d96f580d69
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="BINDIR=$MCHS_PREFIX/bin SBINDIR=$MCHS_PREFIX/bin HAVE_HOSTNAME_TOOLS=0"

mchs_step_configure() {
	CFLAGS="$CFLAGS -D_LINUX_IN6_H -Dindex=strchr -Drindex=strrchr"
	sed -i "s#/usr#$MCHS_PREFIX#" $MCHS_PKG_SRCDIR/man/Makefile
	yes "" | make config || true
}
