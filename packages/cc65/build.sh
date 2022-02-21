MCHS_PKG_HOMEPAGE=https://cc65.github.io/
MCHS_PKG_DESCRIPTION="A free compiler for 6502 based system."
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.19
MCHS_PKG_SRCURL=https://github.com/cc65/cc65/archive/refs/tags/V${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=157b8051aed7f534e5093471e734e7a95e509c577324099c3c81324ed9d0de77
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
    cd $MCHS_PKG_SRCDIR
    make clean
    make
}

mchs_step_pre_configure() {
	# hostbuild step have to be run everytime currently
	rm -Rf $MCHS_PKG_HOSTBUILD_DIR
}

mchs_step_make() {
    make clean -C src
    make bin
}
