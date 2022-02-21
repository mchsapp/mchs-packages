MCHS_PKG_HOMEPAGE=https://git-lfs.github.com/
MCHS_PKG_DESCRIPTION="Git extension for versioning large files"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.2
MCHS_PKG_SRCURL=https://github.com/git-lfs/git-lfs/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=5c9bc449068d0104ea124c25f596af16da85e7b5bf256bc544d8ce5f4fe231f2
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p "$GOPATH"/github.com/git-lfs
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/github.com/git-lfs/git-lfs

	cd "$GOPATH"/github.com/git-lfs/git-lfs
	! $MCHS_ON_DEVICE_BUILD && GOOS=linux GOARCH=amd64 CC=gcc LD=gcc go generate github.com/git-lfs/git-lfs/commands
	go build git-lfs.go
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/github.com/git-lfs/git-lfs/git-lfs \
		"$MCHS_PREFIX"/bin/git-lfs
}

mchs_step_post_make_install() {
	# Remove read-only files generated in build process.
	chmod -R 700 "$MCHS_PKG_BUILDDIR"/pkg
	rm -rf "$MCHS_PKG_BUILDDIR"/pkg
}
