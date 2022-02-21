MCHS_PKG_HOMEPAGE=https://github.com/muesli/duf
MCHS_PKG_DESCRIPTION="Disk usage/free utility"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.8.1
MCHS_PKG_SRCURL=https://github.com/muesli/duf/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ebc3880540b25186ace220c09af859f867251f4ecaef435525a141d98d71a27a
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
        mchs_setup_golang

        cd "$MCHS_PKG_SRCDIR"

        mkdir -p "${MCHS_PKG_BUILDDIR}/src/github.com/muesli"
        cp -a "${MCHS_PKG_SRCDIR}" "${MCHS_PKG_BUILDDIR}/src/github.com/muesli/duf"
        cd "${MCHS_PKG_BUILDDIR}/src/github.com/muesli/duf"

        go get -d -v
        go build
}

mchs_step_make_install() {
        install -Dm700 ${MCHS_PKG_BUILDDIR}/src/github.com/muesli/duf/duf \
                         $MCHS_PREFIX/bin/duf
        mkdir -p $MCHS_PREFIX/share/doc/duf

        install ${MCHS_PKG_BUILDDIR}/src/github.com/muesli/duf/README.md \
                        $MCHS_PREFIX/share/doc/duf
}
