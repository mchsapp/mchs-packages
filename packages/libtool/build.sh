MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
MCHS_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.6
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3
MCHS_PKG_DEPENDS="bash, grep, sed, libltdl"
MCHS_PKG_CONFLICTS="libtool-dev, libtool-static"
MCHS_PKG_REPLACES="libtool-dev, libtool-static"
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_GROUPS="base-devel"

mchs_step_post_make_install() {
	perl -p -i -e "s|\"/bin/|\"$MCHS_PREFIX/bin/|" $MCHS_PREFIX/bin/{libtool,libtoolize}
}
