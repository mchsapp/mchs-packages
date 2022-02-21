MCHS_PKG_HOMEPAGE=https://k9scli.io
MCHS_PKG_DESCRIPTION="Kubernetes CLI To Manage Your Clusters In Style!"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.25.18
MCHS_PKG_SRCURL=https://github.com/derailed/k9s/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2a911c57011164c0f11e3cdf763182abf189efde80b7a764e361aa070b7e3f46
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
        mchs_setup_golang
        cd "$MCHS_PKG_SRCDIR"
        mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/derailed"
        cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/derailed/k9s"
        cd "${MCHS_PKG_BUILDDIR}/src/github.com/derailed/k9s"

        go get -d -v
        go build
}

mchs_step_make_install() {
        install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/derailed/k9s/k9s \
                 $MCHS_PREFIX/bin/k9s
}
