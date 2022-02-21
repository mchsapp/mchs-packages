MCHS_PKG_HOMEPAGE=https://github.com/logrotate/logrotate
MCHS_PKG_DESCRIPTION="Simplify the administration of log files on a system which generates a lot of log files"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.19.0
MCHS_PKG_SRCURL=https://github.com/logrotate/logrotate/releases/download/${MCHS_PKG_VERSION}/logrotate-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=ddd5274d684c5c99ca724e8069329f343ebe376e07493d537d9effdc501214ba
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libpopt, libandroid-glob"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
