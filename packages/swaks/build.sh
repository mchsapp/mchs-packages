MCHS_PKG_HOMEPAGE=http://jetmore.org/john/code/swaks/
MCHS_PKG_DESCRIPTION="Swiss Army Knife for SMTP"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20201014.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://jetmore.org/john/code/swaks/files/swaks-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=fb0a3b7d487a15b124ba6690f7b01a56617f1af2aa54233fd69013982de95a30
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	install -Dm700 swaks "$MCHS_PREFIX"/bin/swaks
}
