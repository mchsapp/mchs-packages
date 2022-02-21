MCHS_PKG_HOMEPAGE=https://github.com/haiwen/libsearpc
MCHS_PKG_DESCRIPTION="A simple C language RPC framework (mainly for seafile)"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:3.2.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/haiwen/libsearpc/archive/v${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=cd00197fcc40b45b1d5e892b2d08dfa5947f737e0d80f3ef26419334e75b0bff
MCHS_PKG_DEPENDS="glib, libjansson, python"
MCHS_PKG_BREAKS="libsearpc-dev"
MCHS_PKG_REPLACES="libsearpc-dev"

mchs_step_post_get_source() {
	./autogen.sh
	export PYTHON="python3.10"
}
