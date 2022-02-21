MCHS_PKG_HOMEPAGE=https://www.passwordstore.org
MCHS_PKG_DESCRIPTION="Lightweight directory-based password manager"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://git.zx2c4.com/password-store/snapshot/password-store-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=cfa9faf659f2ed6b38e7a7c3fb43e177d00edbacc6265e6e32215ff40e3793c0
MCHS_PKG_DEPENDS="bash, coreutils, gnupg (>= 2.2.9-1), tree"
MCHS_PKG_RECOMMENDS="git"
MCHS_PKG_SUGGESTS="pass-otp"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_EXTRA_MAKE_ARGS="WITH_ALLCOMP=yes"
