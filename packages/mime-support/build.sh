MCHS_PKG_HOMEPAGE=https://pagure.io/mailcap
MCHS_PKG_DESCRIPTION="Modern mime.types file from mailcap"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
_VERSION=2.1.53
MCHS_PKG_VERSION=1:${_VERSION}
MCHS_PKG_SRCURL=https://pagure.io/mailcap/archive/r${_VERSION//./-}/mailcap-r${_VERSION//./-}.tar.gz
MCHS_PKG_SHA256=4f4195e2b3c7ffb656fe36ae05038fa31d81cd87efc4067f130d060ecdc863b2
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_CONFFILES="etc/mime.types"
# etc/mime.types was previously in mutt:
MCHS_PKG_CONFLICTS="mutt (<< 1.8.3-1)"

mchs_step_make_install() {
	install -Dm600 $MCHS_PKG_SRCDIR/mime.types $MCHS_PREFIX/etc/mime.types
}
