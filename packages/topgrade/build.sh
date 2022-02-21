MCHS_PKG_HOMEPAGE=https://github.com/r-darwish/topgrade/
MCHS_PKG_DESCRIPTION="Upgrade all the things"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@laurentlbm"
MCHS_PKG_VERSION=8.2.0
MCHS_PKG_SRCURL=https://github.com/r-darwish/topgrade/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=54fe60ef70b21b34c50c0d342ec120aff3a9522ef44a9737f42d5700aed7a1c3
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
	install -Dm600 -t $MCHS_PREFIX/share/man/man8 $MCHS_PKG_SRCDIR/topgrade.8
}
