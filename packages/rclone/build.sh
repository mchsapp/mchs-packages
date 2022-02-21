MCHS_PKG_HOMEPAGE=https://rclone.org/
MCHS_PKG_DESCRIPTION="rsync for cloud storage"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.57.0
MCHS_PKG_SRCURL=https://github.com/rclone/rclone/releases/download/v${MCHS_PKG_VERSION}/rclone-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3a762c02c202a9142c2d5c1a3927563a556d1683abadd25d2f695e237e4ea693
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR

	mchs_setup_golang

	mkdir -p .gopath/src/github.com/rclone
	ln -sf "$PWD" .gopath/src/github.com/rclone/rclone
	export GOPATH="$PWD/.gopath"

	go build -v -ldflags "-X github.com/rclone/rclone/fs.Version=${MCHS_PKG_VERSION}-mchs" -tags noselfupdate -o rclone

	# XXX: Fix read-only files which prevents removal of src dir.
	chmod u+w -R .

	cp rclone $MCHS_PREFIX/bin/rclone
	mkdir -p $MCHS_PREFIX/share/man/man1/
	cp rclone.1 $MCHS_PREFIX/share/man/man1/
}
