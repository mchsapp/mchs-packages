MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/barcode/
MCHS_PKG_DESCRIPTION="Tool to convert text strings to printed bars"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.99
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=http://mirrors.kernel.org/gnu/barcode/barcode-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=e87ecf6421573e17ce35879db8328617795258650831affd025fba42f155cdc6
MCHS_PKG_BUILD_DEPENDS="gettext"

mchs_step_pre_configure() {
	CPPFLAGS+=" -I$MCHS_PREFIX/share/gettext"
}
