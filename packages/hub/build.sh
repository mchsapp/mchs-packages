MCHS_PKG_HOMEPAGE=https://hub.github.com/
MCHS_PKG_DESCRIPTION="Command-line wrapper for git that makes you better at GitHub"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.14.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/github/hub/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e19e0fdfd1c69c401e1c24dd2d4ecf3fd9044aa4bd3f8d6fd942ed1b2b2ad21a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="git"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	mchs_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"

	cd "${GOPATH}/src/github.com/github/hub"
	make man-pages
}

mchs_step_make_install() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"

	export GOPATH="${MCHS_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"
	cd "${GOPATH}/src/github.com/github/hub"
	make bin/hub "prefix=$MCHS_PREFIX"
	install -Dm700 ./bin/hub "$MCHS_PREFIX"/bin/hub

	install -D -m 600 -t "$MCHS_PREFIX"/share/man/man1 \
		"$MCHS_PKG_HOSTBUILD_DIR"/gopath/src/github.com/github/hub/share/man/man1/*.1
}
