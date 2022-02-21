MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/cpio/
MCHS_PKG_DESCRIPTION="CPIO implementation from the GNU project"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.13
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/cpio/cpio-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=eab5bdc5ae1df285c59f2a4f140a98fc33678a0bf61bdba67d9436ae26b46f6d
MCHS_PKG_DEPENDS="tar"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-rmt=$MCHS_PREFIX/libexec/rmt"

