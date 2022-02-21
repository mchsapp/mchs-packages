MCHS_PKG_HOMEPAGE=https://github.com/txthinking/brook
MCHS_PKG_DESCRIPTION="A cross-platform strong encryption and not detectable proxy. Zero-Configuration."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=20220401
MCHS_PKG_SRCURL=https://github.com/txthinking/brook/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=cd3c467d23f4677c51e6764e0a3203cf39ac6c1081203bfd9f5c79680317be22
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/txthinking
	mkdir -p "$MCHS_PREFIX"/share/doc/brook
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/txthinking/brook
	cd "$GOPATH"/src/github.com/txthinking/brook/cli/brook
	go get -d -v
	go build -o brook 
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/txthinking/brook/cli/brook/brook
	cp -r "$MCHS_PKG_SRCDIR"/docs/* "$MCHS_PREFIX"/share/doc/brook
}
