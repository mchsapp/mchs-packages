MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/oleo/
MCHS_PKG_DESCRIPTION="The GNU Spreadsheet"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.99.16
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=http://ftp.gnu.org/gnu/oleo/oleo-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6598df85d06ff2534ec08ed0657508f17dbbc58dd02d419160989de7c487bc86
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-x --infodir=$MCHS_PREFIX/share/info"
MCHS_PKG_KEEP_INFOPAGES=true

MCHS_PKG_RM_AFTER_INSTALL="
Oleo/*
share/oleo/oleo.html"

mchs_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}
