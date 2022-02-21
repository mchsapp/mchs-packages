MCHS_PKG_HOMEPAGE=https://bitcoincore.org/
MCHS_PKG_DESCRIPTION="Bitcoin Core"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=22.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/bitcoin/bitcoin/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=d0e9d089b57048b1555efa7cd5a63a7ed042482045f6f33402b1df425bf9613b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_SERVICE_SCRIPT=("bitcoind" 'exec bitcoind 2>&1')
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--with-daemon
--with-gui=no
--without-libs
--prefix=${MCHS_PKG_SRCDIR}/depends/$MCHS_HOST_PLATFORM
--bindir=$MCHS_PREFIX/bin
"

mchs_step_pre_configure() {
	export ANDROID_TOOLCHAIN_BIN="$MCHS_STANDALONE_TOOLCHAIN/bin"
	(cd depends && make HOST=$MCHS_HOST_PLATFORM NO_QT=1 -j $MCHS_MAKE_PROCESSES)
	./autogen.sh
}
