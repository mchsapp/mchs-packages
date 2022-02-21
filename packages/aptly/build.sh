MCHS_PKG_HOMEPAGE=https://www.aptly.info
MCHS_PKG_DESCRIPTION="A Swiss Army knife for Debian repository management."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/aptly-dev/aptly/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=4172d54613139f6c34d5a17396adc9675d7ed002e517db8381731d105351fbe5
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/github.com/aptly-dev/
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/aptly-dev/aptly
	cd "$GOPATH"/src/github.com/aptly-dev/aptly

	go mod init
	go mod vendor
	make install VERSION=$MCHS_PKG_VERSION
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/bin/${GOOS}_${GOARCH}/aptly \
		"$MCHS_PREFIX"/bin/aptly

	install -Dm600 \
		"$MCHS_PKG_SRCDIR"/man/aptly.1 \
		"$MCHS_PREFIX"/share/man/man1/aptly.1
}
