MCHS_PKG_HOMEPAGE=https://www.wavpack.com/
MCHS_PKG_DESCRIPTION="A completely open audio compression format providing lossless, high-quality lossy, and a unique hybrid compression mode"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.4.0
MCHS_PKG_SRCURL=https://github.com/dbry/WavPack/releases/download/${MCHS_PKG_VERSION}/wavpack-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=4bde6a6b2a86614a6bd2579e60dcc974e2c8f93608d2281110a717c1b3c28b79
MCHS_PKG_DEPENDS="libandroid-glob, libiconv"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
