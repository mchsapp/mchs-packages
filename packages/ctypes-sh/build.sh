MCHS_PKG_HOMEPAGE=https://github.com/taviso/ctypes.sh
MCHS_PKG_DESCRIPTION="A foreign function interface for bash"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/taviso/ctypes.sh/releases/download/v${MCHS_PKG_VERSION}/ctypes-sh-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8896334f5fa88f656057bff807ec6921c8f76fc6de801d996d2057fcb18b3a68
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="bash, libelf, libdw, libffi, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -vif
}
