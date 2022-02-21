MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/xorriso
MCHS_PKG_DESCRIPTION="Tool for creating ISO files."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:1.5.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.gnu.org/software/xorriso/xorriso-${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=3ac155f0ca53e8dbeefacc7f32205a98f4f27d2d348de39ee0183ba8a4c9e392
MCHS_PKG_DEPENDS="libiconv, libandroid-support, readline, libbz2, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-jtethreads"

mchs_step_pre_configure() {
	./bootstrap
}
