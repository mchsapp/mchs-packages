MCHS_PKG_HOMEPAGE=https://github.com/mstorsjo/fdk-aac
MCHS_PKG_DESCRIPTION="Fraunhofer FDK AAC Codec Library"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_MAINTAINER="@DLC01"
MCHS_PKG_VERSION=2.0.2
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/mstorsjo/fdk-aac/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7812b4f0cf66acda0d0fe4302545339517e702af7674dd04e5fe22a5ade16a90
MCHS_PKG_LICENSE_FILE=NOTICE

mchs_step_pre_configure() {
	./autogen.sh
}
