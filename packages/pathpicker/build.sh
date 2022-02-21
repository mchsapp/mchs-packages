MCHS_PKG_HOMEPAGE=https://facebook.github.io/PathPicker/
MCHS_PKG_DESCRIPTION="Facebook PathPicker - a terminal-based file picker"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.5
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/facebook/PathPicker/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b0142676ed791085d619d9b3d28d28cab989ffc3b260016766841c70c97c2a52
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="bash,python"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	_PKG_DIR=$MCHS_PREFIX/share/pathpicker
	rm -Rf $_PKG_DIR src/tests
	mkdir -p $_PKG_DIR
	cp -Rf src/ $_PKG_DIR
	cp fpp $_PKG_DIR/fpp
	cd $MCHS_PREFIX/bin
	ln -f -s ../share/pathpicker/fpp fpp
	chmod +x fpp
}
