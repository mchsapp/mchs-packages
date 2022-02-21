MCHS_PKG_HOMEPAGE=https://github.com/Dreamacro/clash
MCHS_PKG_DESCRIPTION="A rule-based tunnel in Go."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Philipp Schmitt <philipp@schmitt.co>"
MCHS_PKG_VERSION=1.9.0
MCHS_PKG_SRCURL="https://github.com/Dreamacro/clash/archive/v${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=a276b1e7247e847fe44fe336a67bdecbb442748a1e7fa01d9c1ce0d52f9168ef
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"

	GOBUILD=CGO_ENABLED=0 \
		go build \
			-trimpath \
			-ldflags "-X 'github.com/Dreamacro/clash/constant.Version=${MCHS_PKG_VERSION}'
								-X 'github.com/Dreamacro/clash/constant.BuildTime=$(date -u)'
								-w -s -buildid='" \
			-o "clash.bin" \
			main.go
}

mchs_step_make_install() {
	mv ./clash.bin "${MCHS_PREFIX}/bin/clash"
}
