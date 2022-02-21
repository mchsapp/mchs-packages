MCHS_PKG_HOMEPAGE=https://restic.net/
MCHS_PKG_DESCRIPTION="Fast, secure, efficient backup program"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/restic/restic/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=a9c88d5288ce04a6cc78afcda7590d3124966dab3daa9908de9b3e492e2925fb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_SUGGESTS="openssh, rclone, restic-server"

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/restic

	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/restic/restic
	cd "$GOPATH"/src/github.com/restic/restic

	(
		# Separately building for host so we can generate manpages.
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go build -ldflags "-X 'main.version=${MCHS_PKG_VERSION}'" ./cmd/...
		./restic generate --man doc/man
		rm -f ./restic
	)

	go build -ldflags "-X 'main.version=${MCHS_PKG_VERSION}'" ./cmd/...
}

mchs_step_make_install() {
	cd "$GOPATH"/src/github.com/restic/restic
	install -Dm700 restic "$MCHS_PREFIX"/bin/restic
	install -Dm600 -t "$MCHS_PREFIX/share/man/man1/" doc/man/*.1
}
