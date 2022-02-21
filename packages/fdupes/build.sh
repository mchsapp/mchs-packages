MCHS_PKG_HOMEPAGE=https://github.com/adrianlopezroche/fdupes
MCHS_PKG_DESCRIPTION="Duplicates file detector"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.2
MCHS_PKG_SRCURL=https://github.com/adrianlopezroche/fdupes/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=47536dad3f628b49420d60be55417238e537902a7461e19f199092ab8b24e8f1
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses, pcre2"

mchs_step_pre_configure() {
	autoreconf --install
}
