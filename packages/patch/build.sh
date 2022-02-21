MCHS_PKG_HOMEPAGE=https://savannah.gnu.org/projects/patch/
MCHS_PKG_DESCRIPTION="GNU patch which applies diff files to create patched files"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7.6
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/patch/patch-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=ac610bda97abe0d9f6b7c963255a11dcb196c25e337c61f94e4778d632f1d8fd
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-xattr ac_cv_path_ED=$MCHS_PREFIX/bin/ed"
MCHS_PKG_GROUPS="base-devel"
