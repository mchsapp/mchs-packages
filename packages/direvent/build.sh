MCHS_PKG_HOMEPAGE=https://www.gnu.org.ua/software/direvent/
MCHS_PKG_DESCRIPTION="Monitor of events in file system directories"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/direvent/direvent-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=239822cdda9ecbbbc41a69181b34505b2d3badd4df5367e765a0ceb002883b55
MCHS_PKG_DEPENDS="libandroid-glob"

mchs_step_pre_configure() {
       export LIBS="-landroid-glob"
}
