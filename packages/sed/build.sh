MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/sed/
MCHS_PKG_DESCRIPTION="GNU stream editor for filtering/transforming text"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.8
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/sed/sed-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="base-devel"

mchs_step_pre_configure() {
	CFLAGS+=" -D__USE_FORTIFY_LEVEL=2"
}

mchs_step_post_configure() {
	touch -d "next hour" $MCHS_PKG_SRCDIR/doc/sed.1
}
