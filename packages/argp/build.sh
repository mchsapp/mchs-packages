MCHS_PKG_HOMEPAGE=https://www.lysator.liu.se/~nisse/misc/
MCHS_PKG_DESCRIPTION="Standalone version of arguments parsing functions from GLIBC"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://www.lysator.liu.se/~nisse/misc/argp-standalone-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=dec79694da1319acd2238ce95df57f3680fea2482096e483323fddf3d818d8be
MCHS_PKG_NO_STATICSPLIT=true

mchs_step_post_make_install() {
	cp libargp.a $MCHS_PREFIX/lib
	cp $MCHS_PKG_SRCDIR/argp.h $MCHS_PREFIX/include
}
