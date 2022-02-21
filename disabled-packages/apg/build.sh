## Note: APG project seems dead. Official homepage & src urls
## disappeared.

MCHS_PKG_HOMEPAGE=http://www.adel.nursat.kz/apg/index.shtml
MCHS_PKG_DESCRIPTION="Automated Password Generator"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_VERSION=2.3.0b
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/mchs/distfiles/releases/download/2021.01.04/apg-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d1e52029709e2d7f9cb99bedce3e02ee7a63cff7b8e2b4c2bc55b3dc03c28b92
MCHS_PKG_DEPENDS="libcrypt"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_extract_package() {
	# Fix permissions.
	find "$MCHS_PKG_SRCDIR" -type d -exec chmod 700 "{}" \;
	find "$MCHS_PKG_SRCDIR" -type f -executable -exec chmod 700 "{}" \;
	find "$MCHS_PKG_SRCDIR" -type f ! -executable -exec chmod 600 "{}" \;
}
