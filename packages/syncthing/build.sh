MCHS_PKG_HOMEPAGE=https://syncthing.net/
MCHS_PKG_DESCRIPTION="Decentralized file synchronization"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# NOTE: as of 1.12.0 compilation fails when package zstd is
# present in MCHS_PREFIX.
MCHS_PKG_VERSION=1.19.0
MCHS_PKG_SRCURL=https://github.com/syncthing/syncthing/releases/download/v${MCHS_PKG_VERSION}/syncthing-source-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6fcd4e45c252d23148eaa0814d85c44e1bc9af0b9b2fa70b1f01aa87b76e688d
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make(){
	mchs_setup_golang

	# The build.sh script doesn't with our compiler
	# so small adjustments to file locations are needed
	# so the build.go is fine.
	mkdir -p go/src/github.com/syncthing/syncthing
	cp $MCHS_PKG_SRCDIR/vendor/* ./go/src/ -r
	cp $MCHS_PKG_SRCDIR/*  go/src/github.com/syncthing/syncthing -r

	# Set gopath so dependencies are built as in go get etc.
	export GOPATH=$(pwd)/go

	cd go/src/github.com/syncthing/syncthing

	# Unset GOARCH so building build.go works.
	export GO_ARCH=$GOARCH
	export _CC=$CC
	unset GOOS GOARCH CC

	# Now file structure is same as go get etc.
	go build build.go
	export CC=$_CC
	./build -goos android \
		-goarch $GO_ARCH \
		-no-upgrade \
		-version v$MCHS_PKG_VERSION \
		build
}

mchs_step_make_install() {
	cp go/src/github.com/syncthing/syncthing/syncthing $MCHS_PREFIX/bin/

	for section in 1 5 7; do
		local MANDIR=$MCHS_PREFIX/share/man/man$section
		mkdir -p $MANDIR
		cp $MCHS_PKG_SRCDIR/man/*.$section $MANDIR
	done
}
