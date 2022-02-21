MCHS_PKG_HOMEPAGE=https://github.com/wez/atomicparsley
MCHS_PKG_DESCRIPTION="Read, parse and set metadata of MPEG-4 and 3gp files"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:20210715.151551.e7ad03a
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/wez/atomicparsley/archive/${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=546dcb5f3b625aff4f6bf22d27a0a636d15854fd729402a6933d31f3d0417e0d
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, zlib"

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin AtomicParsley
}
