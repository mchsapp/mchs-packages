MCHS_PKG_HOMEPAGE=https://launchpad.net/hollywood
MCHS_PKG_DESCRIPTION="Fill your console with Hollywood melodrama technobabble"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.21
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://launchpad.net/hollywood/trunk/${MCHS_PKG_VERSION}/+download/hollywood_${MCHS_PKG_VERSION}.orig.tar.gz
MCHS_PKG_SHA256=793ef1f022b376e131c75e05ff1b55a010c0f4193225bb79018855cb9ab89acb
MCHS_PKG_DEPENDS="bmon, byobu, cmatrix, coreutils, dash, gawk, htop-legacy, man, tree, util-linux"
MCHS_PKG_RECOMMENDS="apg"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	install -dm0700 "$MCHS_PREFIX"/{bin,lib/hollywood,share/{man/man1,hollywood}}
	install -m 0700 "$MCHS_PKG_SRCDIR"/bin/hollywood  "$MCHS_PREFIX"/bin/
	install -m 0700 "$MCHS_PKG_SRCDIR"/lib/hollywood/* "$MCHS_PREFIX"/lib/hollywood/
	install -m 0600 "$MCHS_PKG_SRCDIR"/share/hollywood/*  "$MCHS_PREFIX"/share/hollywood/
	install -m 0600 "$MCHS_PKG_SRCDIR"/share/man/man1/*  "$MCHS_PREFIX"/share/man/man1/
}
