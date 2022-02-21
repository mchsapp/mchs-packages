MCHS_PKG_HOMEPAGE=https://keybase.io
MCHS_PKG_DESCRIPTION="Key directory that maps social media identities to encryption keys"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.8.1
MCHS_PKG_SRCURL=https://github.com/keybase/client/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=25539ff5b3bad939c9a481ccae89913c1d14aab7f2ac9756a4c231b01ce3fc61
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_REPLACES="kbfs"
MCHS_PKG_CONFLICTS="kbfs"

mchs_step_make() {
	mchs_setup_golang

	cd $MCHS_PKG_SRCDIR

	mkdir -p .gopath/src/github.com/keybase
	ln -sf "$PWD" .gopath/src/github.com/keybase/client
	export GOPATH="$PWD/.gopath"

	# https://github.com/keybase/client/issues/24479#issuecomment-803013019
	go env -w GO111MODULE=auto

	go build -v -tags 'production' -o keybase github.com/keybase/client/go/keybase
	go build -v -tags 'production' -o git-remote-keybase github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase
	go build -v -tags 'production' -o kbfsfusebin github.com/keybase/client/go/kbfs/kbfsfuse
}

mchs_step_make_install() {
	cp $MCHS_PKG_SRCDIR/keybase $MCHS_PREFIX/bin/keybase
	cp $MCHS_PKG_SRCDIR/git-remote-keybase $MCHS_PREFIX/bin/git-remote-keybase
	cp $MCHS_PKG_SRCDIR/kbfsfusebin $MCHS_PREFIX/bin/kbfsfuse
}
