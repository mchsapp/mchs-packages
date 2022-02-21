MCHS_PKG_HOMEPAGE=http://cscope.sourceforge.net/
MCHS_PKG_DESCRIPTION="A developers tool for browsing program code"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=15.9
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/cscope-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
hw_cv_func_snprintf_c99=yes
hw_cv_func_vsnprintf_c99=yes
--with-ncurses=$MCHS_PREFIX
"

mchs_step_pre_configure() {
	export LEXLIB=""
}
