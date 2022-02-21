MCHS_PKG_HOMEPAGE=https://github.com/emersion/hydroxide
MCHS_PKG_DESCRIPTION="A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2.21
MCHS_PKG_SRCURL=https://github.com/emersion/hydroxide/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=efbb1fc0461b3fcca9a9e42b31c7298ef0023e458c171be0b00886f9692648c4
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	cd $MCHS_PKG_SRCDIR
	go build ./cmd/hydroxide
}

mchs_step_make_install() {
	install -Dm755 -t "${MCHS_PREFIX}"/bin "${MCHS_PKG_SRCDIR}"/hydroxide
}
