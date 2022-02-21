MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/diffutils/
MCHS_PKG_DESCRIPTION="Programs (cmp, diff, diff3 and sdiff) related to finding differences between files"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/diffutils/diffutils-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=a6bdd7d1b31266d11c4f4de6c1b748d4607ab0231af5188fc2533d0ae2438fec
MCHS_PKG_DEPENDS="libiconv"
MCHS_PKG_ESSENTIAL=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_PR_PROGRAM=${MCHS_PREFIX}/bin/pr"
