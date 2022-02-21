MCHS_PKG_HOMEPAGE=https://github.com/twogood/unshield
MCHS_PKG_DESCRIPTION="Tool and library to extract CAB files from InstallShield installers"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.1
MCHS_PKG_SRCURL=https://github.com/twogood/unshield/archive/1.4.3.tar.gz
MCHS_PKG_SHA256=aa8c978dc0eb1158d266eaddcd1852d6d71620ddfc82807fe4bf2e19022b7bab
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libiconv, openssh, zlib"

mchs_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
