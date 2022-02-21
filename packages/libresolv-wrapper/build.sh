MCHS_PKG_HOMEPAGE=https://cwrap.org/resolv_wrapper.html
MCHS_PKG_DESCRIPTION="A wrapper for DNS name resolving or DNS faking"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.7
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://ftp.samba.org/pub/cwrap/resolv_wrapper-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=460ae7fd5e53485be7dd99a55c5922f1cb1636b9e8821981d49ad16507c8a074

mchs_step_pre_configure() {
	CFLAGS+=" -DANDROID_CHANGES -DLIBC_SO=\\\"libc.so\\\""
}
