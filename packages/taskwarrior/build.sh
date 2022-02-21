MCHS_PKG_HOMEPAGE=https://taskwarrior.org
MCHS_PKG_DESCRIPTION="Utility for managing your TODO list"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v${MCHS_PKG_VERSION}/task-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=00aa6032b3d8379a5cfa29afb66d2b0703a69e3d1fea733d225d654dbcb0084f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libgnutls, libuuid, libandroid-glob"
MCHS_CMAKE_BUILD="Unix Makefiles"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

