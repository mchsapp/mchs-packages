MCHS_PKG_HOMEPAGE=https://github.com/int128/kubelogin
MCHS_PKG_DESCRIPTION="A kubectl plugin for Kubernetes OpenID Connect (OIDC) authentication"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="Steeve Chailloux"
MCHS_PKG_VERSION=1.25.1
MCHS_PKG_SRCURL=https://github.com/int128/kubelogin/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8934cda16af382e94d224866e7557f09ae10d9268a9db17818f7767287f406eb
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
        mchs_setup_golang
        cd "$MCHS_PKG_SRCDIR"
        mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/int128"
        cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/int128/kubelogin"
        cd "${MCHS_PKG_BUILDDIR}/src/github.com/int128/kubelogin"

        go build -o kubelogin -ldflags "-X main.version=${MCHS_PKG_VERSION}"
}

mchs_step_make_install() {
        install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/int128/kubelogin/kubelogin \
                 $MCHS_PREFIX/bin/kubectl-oidc_login
}
