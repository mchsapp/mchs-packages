MCHS_PKG_HOMEPAGE=https://rustscan.github.io/RustScan
MCHS_PKG_DESCRIPTION="The modern,fast,smart and effective port scanner"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
MCHS_PKG_VERSION=2.0.1
MCHS_PKG_DEPENDS="nmap"
MCHS_PKG_SRCURL=https://github.com/RustScan/RustScan/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1d458cb081cbed2db38472ff33f9546a6640632148b4396bd12f0229ca9de7eb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -r Makefile
}
