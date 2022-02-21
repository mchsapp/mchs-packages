MCHS_PKG_HOMEPAGE=https://yarnpkg.com/
MCHS_PKG_DESCRIPTION="Fast, reliable, and secure dependency management"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.22.17
MCHS_PKG_SRCURL=https://yarnpkg.com/downloads/${MCHS_PKG_VERSION}/yarn-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=267982c61119a055ba2b23d9cf90b02d3d16c202c03cb0c3a53b9633eae37249
MCHS_PKG_DEPENDS="nodejs | nodejs-lts"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	cp -r . ${MCHS_PREFIX}/share/yarn/
	ln -f -s ../share/yarn/bin/yarn ${MCHS_PREFIX}/bin/yarn
}
