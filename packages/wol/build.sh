MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/wake-on-lan/
MCHS_PKG_DESCRIPTION="Program implementing Wake On LAN functionality"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.1
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/wake-on-lan/wol/${MCHS_PKG_VERSION}/wol-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MCHS_PREFIX/share/man"
MCHS_PKG_RM_AFTER_INSTALL="info/"

mchs_step_pre_configure() {
	export ac_cv_func_mmap_fixed_mapped=yes
	export jm_cv_func_working_malloc=yes
	export ac_cv_func_alloca_works=yes
}
