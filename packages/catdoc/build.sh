MCHS_PKG_HOMEPAGE=http://www.wagner.pp.ru/~vitus/software/catdoc/
MCHS_PKG_DESCRIPTION="Program which reads MS-Word file and prints readable ASCII text to stdout"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.95
MCHS_PKG_SRCURL=http://ftp.wagner.pp.ru/pub/catdoc/catdoc-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=514a84180352b6bf367c1d2499819dfa82b60d8c45777432fa643a5ed7d80796
MCHS_PKG_DEPENDS="libandroid-glob"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
