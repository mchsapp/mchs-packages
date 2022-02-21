MCHS_PKG_HOMEPAGE=https://vtm.netxs.online/
MCHS_PKG_DESCRIPTION="Terminal multiplexer with TUI window manager and multi-party session sharing"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.15
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/netxs-group/vtm/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=fa18ae2f1eee9615c6e0df5be4b248fb15268c5e7401380f129ccee8cb9254f0
MCHS_PKG_DEPENDS="libandroid-spawn"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+=/src
	CXXFLAGS+=" -pthread"
	LDFLAGS+=" -landroid-spawn"
}

mchs_step_install_license() {
	install -Dm600 -t $MCHS_PREFIX/share/doc/vtm \
		$MCHS_PKG_SRCDIR/../LICENSE
}
