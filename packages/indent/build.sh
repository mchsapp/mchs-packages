MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/indent/
MCHS_PKG_DESCRIPTION="C language source code formatting program"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.12
MCHS_PKG_SRCURL=http://mirrors.kernel.org/gnu/indent/indent-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=b745a5dfc68f86a483d7f96dc1cda7aafd1e78ecba3c7d8ad304709e91e1defb
MCHS_PKG_DEPENDS="libandroid-support"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setlocale=no"
MCHS_PKG_RM_AFTER_INSTALL="bin/texinfo2man"
