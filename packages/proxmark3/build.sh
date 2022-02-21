MCHS_PKG_HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"
MCHS_PKG_DESCRIPTION="The Swiss Army Knife of RFID Research - RRG/Iceman repo"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Marlin Sööse <marlin.soose@laro.se>"
MCHS_PKG_REVISION=2
MCHS_PKG_VERSION=1:4.14831
MCHS_PKG_SRCURL=https://github.com/RfidResearchGroup/proxmark3/archive/v${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=36006cf30c30a533027de851fe9a96593a093e2e03cddf1703aa81940b9bb9a9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libbz2, libc++, readline"
MCHS_PKG_BUILD_IN_SRC="true"
MCHS_PKG_BLACKLISTED_ARCHES="i686, x86_64"

mchs_step_post_configure() {
	export LDLIBS="-L${MCHS_PREFIX}/lib"
	export INCLUDES="-I${MCHS_PREFIX}/include"
	MCHS_PKG_EXTRA_MAKE_ARGS="client CC=$CC CXX=$CXX LD=$CXX cpu_arch=generic SKIPREVENGTEST=1 SKIPQT=1 SKIPPTHREAD=1 PLATFORM=PM3GENERIC DEBUG=1"
}

mchs_step_make_install() {
	install -Dm700 "$MCHS_PKG_BUILDDIR"/client/proxmark3 \
		"$MCHS_PREFIX"/bin/proxmark3
}
