MCHS_PKG_HOMEPAGE=https://github.com/mchs
MCHS_PKG_DESCRIPTION="GPG public keys for the official McHs repositories"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_ESSENTIAL=true

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/etc/apt/trusted.gpg.d

	# Maintainer-specific keys.
	install -Dm600 $MCHS_PKG_BUILDER_DIR/grimler.gpg $MCHS_PREFIX/etc/apt/trusted.gpg.d/
	install -Dm600 $MCHS_PKG_BUILDER_DIR/kcubeterm.gpg $MCHS_PREFIX/etc/apt/trusted.gpg.d/
	install -Dm600 $MCHS_PKG_BUILDER_DIR/landfillbaby.gpg $MCHS_PREFIX/etc/apt/trusted.gpg.d/

	# Key for automatic builds (via CI).
	install -Dm600 $MCHS_PKG_BUILDER_DIR/mchs-autobuilds.gpg $MCHS_PREFIX/etc/apt/trusted.gpg.d/
}
