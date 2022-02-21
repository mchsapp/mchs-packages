MCHS_PKG_HOMEPAGE=https://github.com/shenwei356/rush
MCHS_PKG_DESCRIPTION="A cross-platform command-line tool for executing jobs in parallel"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.4.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/shenwei356/rush/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=801b17e279406c1649b401a2214148d344f673d0a1c9eed1b417655c1fefd114
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make_install() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"

	export GOPATH="${MCHS_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/shenwei356"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/shenwei356/rush"
	cd "${GOPATH}/src/github.com/shenwei356/rush"
	go mod init rush
	go get -d -v
	go install

	install -Dm700 $MCHS_PKG_BUILDDIR/bin/*/rush $MCHS_PREFIX/bin/
}
