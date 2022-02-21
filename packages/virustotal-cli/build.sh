MCHS_PKG_HOMEPAGE=https://github.com/VirusTotal/vt-cli
MCHS_PKG_DESCRIPTION="Command line interface for VirusTotal"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.10.0
MCHS_PKG_SRCURL=https://github.com/VirusTotal/vt-cli/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=88ef4d2c7708be1bc27c2290181996b6c18e08d5f56a8765de8a5ec13f68e6ac
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="vt-cli"
MCHS_PKG_REPLACES="vt-cli"

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/VirusTotal
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/VirusTotal/vt-cli

	cd "$GOPATH"/src/github.com/VirusTotal/vt-cli

	go build \
		-ldflags "-X github.com/VirusTotal/vt-cli/cmd.Version=$MCHS_PKG_VERSION" \
		-o "$MCHS_PREFIX"/bin/vt-cli \
		./vt/main.go
}

mchs_step_make_install() {
	ln -sfr "$MCHS_PREFIX"/bin/vt-cli "$MCHS_PREFIX"/bin/vt
}
