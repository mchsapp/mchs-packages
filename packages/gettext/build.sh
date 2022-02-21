MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
MCHS_PKG_DESCRIPTION="GNU Internationalization utilities"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.21
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=d20fcbb537e02dcf1383197ba05bd0734ef7bf5db06bdb241eb69b7d16b73192
MCHS_PKG_DEPENDS="libc++, libiconv, pcre, liblzma, libxml2, libcroco, ncurses, libunistring, zlib"
MCHS_PKG_BREAKS="gettext-dev"
MCHS_PKG_REPLACES="gettext-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-openmp"
MCHS_PKG_GROUPS="base-devel"

mchs_step_pre_configure() {
	autoreconf
}
