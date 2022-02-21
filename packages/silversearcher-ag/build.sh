MCHS_PKG_HOMEPAGE=https://geoff.greer.fm/ag/
MCHS_PKG_DESCRIPTION="Fast grep-like program, alternative to ack-grep"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.0
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://geoff.greer.fm/ag/releases/the_silver_searcher-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d9621a878542f3733b5c6e71c849b9d1a830ed77cb1a1f6c2ea441d4b0643170
MCHS_PKG_DEPENDS="pcre, liblzma, zlib"

mchs_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}
