MCHS_PKG_HOMEPAGE=https://debugmo.de/2009/04/bgrep-a-binary-grep/
MCHS_PKG_DESCRIPTION="Binary string grep tool"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/rsharo/bgrep/archive/bgrep-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ba5ddae672e84bf2d8ce91429a4ce8a5e3a154ee7e64d1016420f7dc7481ec0a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./bootstrap
}
