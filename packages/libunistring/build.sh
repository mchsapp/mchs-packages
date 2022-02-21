MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/libunistring/
MCHS_PKG_DESCRIPTION="Library providing functions for manipulating Unicode strings"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.10
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/libunistring/libunistring-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a82e5b333339a88ea4608e4635479a1cfb2e01aafb925e1290b65710d43f610b
MCHS_PKG_DEPENDS="libandroid-support, libiconv"
MCHS_PKG_BREAKS="libunistring-dev"
MCHS_PKG_REPLACES="libunistring-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_uselocale=no am_cv_langinfo_codeset=yes"
