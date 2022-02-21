MCHS_PKG_HOMEPAGE=https://github.com/kkdai/youtube
MCHS_PKG_DESCRIPTION="Download youtube video in Golang"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=2.7.10
MCHS_PKG_SRCURL=https://github.com/kkdai/youtube/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=04a4f0b745094884fb2902945ac3b1c966fbe4fbd67a027cb482d491662900f9
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"
	export GOPATH="${MCHS_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/kkdai/"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/kkdai/youtube"
	cd "${GOPATH}/src/github.com/kkdai/youtube/"
	go get -d -v
	cd cmd/youtubedr
	go build .
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/kkdai/youtube/cmd/youtubedr/youtubedr
}
