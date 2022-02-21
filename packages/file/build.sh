MCHS_PKG_HOMEPAGE=https://darwinsys.com/file/
MCHS_PKG_DESCRIPTION="Command-line tool that tells you in words what kind of data a file contains"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.41
MCHS_PKG_SRCURL=ftp://ftp.astron.com/pub/file/file-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=13e532c7b364f7d57e23dfeea3147103150cb90593a57af86c10e4f6e411603f
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_BREAKS="file-dev"
MCHS_PKG_REPLACES="file-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_mmap_fixed_mapped=yes"
MCHS_PKG_EXTRA_MAKE_ARGS="FILE_COMPILE=$MCHS_PKG_HOSTBUILD_DIR/src/file"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_GROUPS="base-devel"
