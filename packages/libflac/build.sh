MCHS_PKG_HOMEPAGE=https://xiph.org/flac/
MCHS_PKG_DESCRIPTION="FLAC (Free Lossless Audio Codec) library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.3
MCHS_PKG_SRCURL=https://github.com/xiph/flac/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=668cdeab898a7dd43cf84739f7e1f3ed6b35ece2ef9968a5c7079fe9adfe1689
MCHS_PKG_DEPENDS="libc++, libogg"
MCHS_PKG_BREAKS="libflac-dev"
MCHS_PKG_REPLACES="libflac-dev"
MCHS_PKG_REVISION=2
mchs_step_pre_configure() {
	./autogen.sh
}
