MCHS_PKG_HOMEPAGE=https://stand-up-notes.org
MCHS_PKG_DESCRIPTION="A very simple note taking cli app"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.0
MCHS_PKG_SRCURL=https://github.com/basbossink/sun/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f0c90b8796caa66662dd82790449ca844708e20b39f7e81ef7f1cbce211d1412
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "${MCHS_PKG_BUILDDIR}"/src/github.com/basbossink/
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/basbossink/sun

	cd "$GOPATH"/src/github.com/basbossink/sun
	go build -ldflags "-s -w -X main.Version=${MCHS_PKG_VERSION}" .
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin \
		${MCHS_PKG_BUILDDIR}/src/github.com/basbossink/sun/sun
}
