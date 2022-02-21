MCHS_PKG_HOMEPAGE=http://qpdf.sourceforge.net
MCHS_PKG_DESCRIPTION="Content-Preserving PDF Transformation System"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=10.3.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/qpdf/qpdf/releases/download/release-qpdf-$MCHS_PKG_VERSION/qpdf-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=062808c40ef8741ec8160ae00168638a712cfa1d4bf673e8e595ab5eba1da947
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_DEPENDS="libc++, libjpeg-turbo, zlib"
MCHS_PKG_BREAKS="qpdf-dev"
MCHS_PKG_REPLACES="qpdf-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-random=/dev/urandom"

mchs_step_pre_configure() {
	./autogen.sh
}
