MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/cunit/
MCHS_PKG_DESCRIPTION="C Unit Testing Framework"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Thibault Meyer <meyer.thibault@gmail.com>"
MCHS_PKG_VERSION=2.1.3
_VERSION=$(echo "$MCHS_PKG_VERSION" | sed -E 's/(.*)\./\1-/')
MCHS_PKG_SRCURL=https://github.com/Linaro/libcunit/releases/download/${_VERSION}/CUnit-${_VERSION}.tar.bz2
MCHS_PKG_SHA256=f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+.\d+"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-automated
--enable-basic
--enable-console
"

mchs_step_pre_configure() {
	libtoolize --force --copy
	aclocal
	autoheader
	automake --add-missing --include-deps --copy
	autoconf
}
