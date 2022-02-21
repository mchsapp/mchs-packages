MCHS_PKG_HOMEPAGE=https://github.com/radare/posixvala
MCHS_PKG_DESCRIPTION="Aims to bring back the posix profile for Vala"
MCHS_PKG_LICENSE="GPL-3.0, LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2
MCHS_PKG_SRCURL=https://github.com/radare/posixvala/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d35d1e333d7941e130e094b0f55d53132855b990a7df699c14061e0a0e6853e8
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"

mchs_step_make() {
	:
}
