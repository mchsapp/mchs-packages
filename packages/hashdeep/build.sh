MCHS_PKG_HOMEPAGE=http://md5deep.sourceforge.net/
MCHS_PKG_DESCRIPTION="Programs to compute hashsums of arbitrary number of files recursively"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.4
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=https://github.com/jessek/hashdeep/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=ad78d42142f9a74fe8ec0c61bc78d6588a528cbb9aede9440f50b6ff477f3a7f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"

mchs_step_pre_configure() {
	sh bootstrap.sh
}
