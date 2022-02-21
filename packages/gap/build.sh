MCHS_PKG_HOMEPAGE=https://www.gap-system.org/
MCHS_PKG_DESCRIPTION="GAP is a system for computational discrete algebra, with particular emphasis on Computational Group Theory"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.11.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/gap-system/gap/releases/download/v${MCHS_PKG_VERSION}/gap-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6635c5da7d82755f8339486b9cac33766f58712f297e8234fba40818902ea304
MCHS_PKG_DEPENDS="readline, libgmp, zlib"
MCHS_PKG_BREAKS="gap-dev"
MCHS_PKG_REPLACES="gap-dev"
MCHS_PKG_GROUPS="science"

mchs_step_post_make_install() {
	ln -sf $MCHS_PREFIX/bin $MCHS_PREFIX/share/gap/
}
