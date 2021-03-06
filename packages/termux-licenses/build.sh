MCHS_PKG_HOMEPAGE=https://mchs.com
MCHS_PKG_DESCRIPTION="Contains LICENSE files for common licenses"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0
MCHS_PKG_REVISION=1
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_ESSENTIAL=true

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/LICENSES
	for LICENSE in "$MCHS_PKG_BUILDER_DIR/LICENSES/*.txt"; do
		cp -f $LICENSE $MCHS_PREFIX/share/LICENSES/
	done
}
