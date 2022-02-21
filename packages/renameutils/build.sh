MCHS_PKG_HOMEPAGE=https://www.nongnu.org/renameutils/
MCHS_PKG_DESCRIPTION="A set of programs designed to make renaming of files faster and less cumbersome"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://savannah.nongnu.org/download/renameutils/renameutils-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=cbd2f002027ccf5a923135c3f529c6d17fabbca7d85506a394ca37694a9eb4a3
MCHS_PKG_DEPENDS="libandroid-wordexp, readline"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-wordexp"
}
