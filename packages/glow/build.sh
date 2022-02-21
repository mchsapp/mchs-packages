MCHS_PKG_HOMEPAGE=https://github.com/charmbracelet/glow
MCHS_PKG_DESCRIPTION="Render markdown on the CLI, with pizzazz!"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@charmbracelet"
MCHS_PKG_VERSION=1.4.1
MCHS_PKG_SRCURL=https://github.com/charmbracelet/glow/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ff6dfd7568f0bac5144ffa3a429ed956dcbdb531487ef6e38ac61365322c9601
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_RECOMMENDS=git

mchs_step_make() {
        mchs_setup_golang

        cd "$MCHS_PKG_SRCDIR"

        mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/charmbracelet"
        cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/charmbracelet/glow"
        cd "${MCHS_PKG_BUILDDIR}/src/github.com/charmbracelet/glow"

        go get -d -v
        go build
}

mchs_step_make_install() {
        install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/charmbracelet/glow/glow \
                $MCHS_PREFIX/bin/glow
}
