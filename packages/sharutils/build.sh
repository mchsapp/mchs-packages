MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/sharutils/
MCHS_PKG_DESCRIPTION="Utilities for packaging and unpackaging shell archives"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.15.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/sharutils/sharutils-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=2b05cff7de5d7b646dc1669bc36c35fdac02ac6ae4b6c19cb3340d87ec553a9a
MCHS_PKG_DEPENDS="libandroid-support"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
"
