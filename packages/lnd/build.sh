MCHS_PKG_HOMEPAGE=https://github.com/lightningnetwork/lnd
MCHS_PKG_DESCRIPTION="Lightning Network Daemon"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.13.3-beta
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=(https://github.com/lightningnetwork/lnd/archive/v${MCHS_PKG_VERSION}.tar.gz
                   https://github.com/lightningnetwork/lnd/releases/download/v${MCHS_PKG_VERSION}/vendor.tar.gz)
MCHS_PKG_SHA256=(c642c14bbf34e61d1ac566d22a9775e97e3671fff90552a0060d791e533a5af2
                   304a59ce38ffc03c1fd4bdf9294560793865f6b19646aea03b1d5da482ff83d3)
MCHS_PKG_DEPENDS="bitcoin"
MCHS_PKG_SERVICE_SCRIPT=("lnd" 'exec lnd 2>&1')
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang
	GO111MODULE=on go build -tags linux -v -mod=vendor -ldflags "-X github.com/lightningnetwork/lnd/build.Commit=v$MCHS_PKG_VERSION" ./cmd/lnd
	GO111MODULE=on go build -tags linux -v -mod=vendor -ldflags "-X github.com/lightningnetwork/lnd/build.Commit=v$MCHS_PKG_VERSION" ./cmd/lncli
}

mchs_step_make_install() {
	install -Dm700 lnd lncli "$MCHS_PREFIX"/bin/
}
