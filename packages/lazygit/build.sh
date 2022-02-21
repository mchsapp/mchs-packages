MCHS_PKG_HOMEPAGE=https://github.com/jesseduffield/lazygit
MCHS_PKG_DESCRIPTION="Simple terminal UI for git commands"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.33
MCHS_PKG_SRCURL=https://github.com/jesseduffield/lazygit/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ff7ab429ecd54f6e2aedcfd4835eb8ca17c1990aac2534f8c2a19ce4267ade24
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_RECOMMENDS=git

mchs_step_make() {
        mchs_setup_golang

        cd "$MCHS_PKG_SRCDIR"

        mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/jesseduffield"
        cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit"
        cd "${MCHS_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit"

        go get -d -v
        go build
}

mchs_step_make_install() {
        mkdir -p $MCHS_PREFIX/share/doc/lazygit

        install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit/lazygit \
                $MCHS_PREFIX/bin/lazygit

        cp -a ${MCHS_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit/docs/* \
                $MCHS_PREFIX/share/doc/lazygit/

}
