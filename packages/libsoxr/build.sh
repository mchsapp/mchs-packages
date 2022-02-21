MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/soxr/
MCHS_PKG_DESCRIPTION="High quality, one-dimensional sample-rate conversion library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://sourceforge.net/projects/soxr/files/soxr-$MCHS_PKG_VERSION-Source.tar.xz
MCHS_PKG_SHA256=b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889
MCHS_PKG_BREAKS="libsoxr-dev"
MCHS_PKG_REPLACES="libsoxr-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	return 0
}

mchs_step_make() {
	mchs_setup_cmake
	./go
}
