# X11 package
MCHS_PKG_HOMEPAGE=https://xcb.freedesktop.org/
MCHS_PKG_DESCRIPTION="XML-XCB protocol descriptions"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.14.1
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=f04add9a972ac334ea11d9d7eb4fc7f8883835da3e4859c9afa971efdf57fcc3
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_CONFLICTS="xcbproto"
MCHS_PKG_REPLACES="xcbproto"

mchs_step_pre_configure() {
	export PYTHON_VERSION=$(. $MCHS_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	export PYTHON=python$PYTHON_VERSION
	MCHS_PKG_RM_AFTER_INSTALL="lib/${PYTHON}/site-packages/xcbgen/__pycache__"
}
