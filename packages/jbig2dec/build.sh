MCHS_PKG_HOMEPAGE=https://jbig2dec.com/
MCHS_PKG_DESCRIPTION="Decoder implementation of the JBIG2 image compression format"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.19
MCHS_PKG_SRCURL=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9530/jbig2dec-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=279476695b38f04939aa59d041be56f6bade3422003a406a85e9792c27118a37
MCHS_PKG_DEPENDS="libpng"
MCHS_PKG_BREAKS="jbig2dec-dev"
MCHS_PKG_REPLACES="jbig2dec-dev"

mchs_step_pre_configure() {
	./autogen.sh
}
