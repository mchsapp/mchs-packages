MCHS_PKG_HOMEPAGE=http://tinyscheme.sourceforge.net/home.html
MCHS_PKG_DESCRIPTION="Very small scheme implementation"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.42
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/tinyscheme/tinyscheme/tinyscheme-${MCHS_PKG_VERSION}/tinyscheme-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=17b0b1bffd22f3d49d5833e22a120b339039d2cfda0b46d6fc51dd2f01b407ad
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	AR+=" crs"
	LD=$CC
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/share/tinyscheme/
	cp $MCHS_PKG_SRCDIR/init.scm $MCHS_PREFIX/share/tinyscheme/
}
