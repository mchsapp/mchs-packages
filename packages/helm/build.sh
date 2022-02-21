MCHS_PKG_HOMEPAGE=https://helm.sh
MCHS_PKG_DESCRIPTION="Helm helps you manage Kubernetes applications"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8.0
MCHS_PKG_SRCURL=https://github.com/helm/helm/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4f3c8cbe01a2ca9c0a639aa82cb2c27319466c04f92fd145f861108e50d4ed60
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang
	cd "$MCHS_PKG_SRCDIR"
	mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/helm"
	cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/helm/helm"
	cd "${MCHS_PKG_BUILDDIR}/src/github.com/helm/helm"
	make
}

mchs_step_make_install() {
	install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/helm/helm/bin/helm \
		$MCHS_PREFIX/bin/helm
}
