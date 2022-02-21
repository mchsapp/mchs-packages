MCHS_PKG_HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"
MCHS_PKG_DESCRIPTION="The Swiss Army Knife of RFID Research - RRG/Iceman repo"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Marlin Sööse <marlin.soose@laro.se>"
_COMMIT=7310834b69197efdaa9302aa83a510fafb295e04
MCHS_PKG_VERSION="2022.02.19-${_COMMIT:0:8}"
MCHS_PKG_SRCURL="https://github.com/RfidResearchGroup/proxmark3/archive/7310834b69197efdaa9302aa83a510fafb295e04.tar.gz"
MCHS_PKG_SHA256="a63380969a809793d2e9c99a7f517dcb90933c13674470fbbb857aec3ae21147"
MCHS_PKG_DEPENDS="libbz2, libc++, readline"
MCHS_PKG_BUILD_IN_SRC="true"
MCHS_PKG_BLACKLISTED_ARCHES="i686, x86_64"

mchs_step_post_configure() {
        LDLIBS="-L${MCHS_PREFIX}/lib" INCLUDES_CLIENT="-I${MCHS_PREFIX}/include" CFLAGS="-I${MCHS_PREFIX}/include"
        MCHS_PKG_EXTRA_MAKE_ARGS="client -j $MCHS_MAKE_PROCESSES CC=$CC CXX=$CXX LD=$CXX cpu_arch=generic SKIPREVENGTEST=1 SKIPQT=1 SKIPBT=1 SKIPPTHREAD=1 SKIPGPU=1 PLATFORM=PM3GENERIC"
}

mchs_step_make_install() {
        install -Dm700 "$MCHS_PKG_BUILDDIR"/client/proxmark3 \
                "$MCHS_PREFIX"/bin/proxmark3
}
