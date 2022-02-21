MCHS_PKG_HOMEPAGE=https://github.com/schollz/croc
MCHS_PKG_DESCRIPTION="Easily and securely send things from one computer to another."
MCHS_PKG_LICENSE=MIT
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.5.1
MCHS_PKG_SRCURL=https://github.com/schollz/croc/releases/download/v${MCHS_PKG_VERSION}/croc_${MCHS_PKG_VERSION}_src.tar.gz
MCHS_PKG_SHA256=f459ff099e9a6edbe926a75c459b9dbc3cb994b88419d42dcff15636e7ddd3b2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	cd $MCHS_PKG_SRCDIR

	mchs_setup_golang

	go build -o croc -trimpath
}

mchs_step_make_install() {
	install -m755 croc $MCHS_PREFIX/bin/croc
}
