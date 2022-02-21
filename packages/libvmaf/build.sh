MCHS_PKG_HOMEPAGE=https://github.com/Netflix/vmaf
MCHS_PKG_DESCRIPTION="A perceptual video quality assessment algorithm developed by Netflix"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.0
MCHS_PKG_SRCURL=https://github.com/Netflix/vmaf/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d8dcc83f8e9686e6855da4c33d8c373f1735d87294edbd86ed662ba2f2f89277

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/libvmaf
}
