MCHS_PKG_HOMEPAGE=https://github.com/chaos/scrub
MCHS_PKG_DESCRIPTION="Iteratively writes patterns on files or disk devices to make retreiving the data more difficult"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/chaos/scrub/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=838b061b2e1932b342fb9695c5579cdff5d2d72506cb41d6d8032eba18aed969
MCHS_PKG_AUTO_UPDATE=true

mchs_step_pre_configure() {
	./autogen.sh
}
