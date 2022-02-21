MCHS_PKG_HOMEPAGE=https://github.com/gopasspw/gopass
MCHS_PKG_DESCRIPTION="The slightly more awesome standard unix password manager for teams."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.13.1
MCHS_PKG_SRCURL=https://github.com/gopasspw/gopass/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=c59006956758b63847fcd2f4b05990ad01b94489df1eef2849d6587840d9945a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="git, gnupg"
MCHS_PKG_SUGGESTS="mchs-api, openssh"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p ./src
	mkdir -p ./src/github.com/gopasspw
	ln -sf "$MCHS_PKG_SRCDIR" ./src/github.com/gopasspw/gopass

	rm -f ./src/github.com/gopasspw/gopass/gopass
	make -C ./src/github.com/gopasspw/gopass build CLIPHELPERS="-X github.com/gopasspw/gopass/pkg/clipboard.Helpers=mchs-api'"
	install -Dm700 \
		./src/github.com/gopasspw/gopass/gopass \
		"$MCHS_PREFIX"/bin/gopass
}
