MCHS_PKG_HOMEPAGE=https://www.cs.unm.edu/~mccune/prover9/
MCHS_PKG_DESCRIPTION="An automated theorem prover for first-order and equational logic"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2009-11A
MCHS_PKG_SRCURL=https://www.cs.unm.edu/~mccune/mace4/download/LADR-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c32bed5807000c0b7161c276e50d9ca0af0cb248df2c1affb2f6fc02471b51d0
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-e all"
MCHS_MAKE_PROCESSES=1

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin bin/*
}
