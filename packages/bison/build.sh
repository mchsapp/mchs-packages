MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/bison/
MCHS_PKG_DESCRIPTION="General-purpose parser generator"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/bison/bison-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=9bba0214ccf7f1079c5d59210045227bcf619519840ebfa80cd3849cff5a5bf2
MCHS_PKG_DEPENDS="m4"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
M4=m4
ac_cv_header_spawn_h=no
"

MCHS_PKG_RM_AFTER_INSTALL="share/info/dir"
MCHS_PKG_GROUPS="base-devel"
