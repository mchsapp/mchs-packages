MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/m4/m4.html
MCHS_PKG_DESCRIPTION="Traditional Unix macro processor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.19
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/m4/m4-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96
MCHS_PKG_BUILD_DEPENDS="libandroid-spawn"
MCHS_PKG_GROUPS="base-devel"
MCHS_PKG_EXTRA_MAKE_ARGS="
HELP2MAN=:
"
# Avoid automagic dependency on libiconv
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"

mchs_step_pre_configure() {
	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"
}
