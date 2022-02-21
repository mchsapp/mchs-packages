MCHS_PKG_HOMEPAGE=https://troydhanson.github.io/uthash/
MCHS_PKG_DESCRIPTION="C preprocessor implementations of a hash table and a linked list"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.0
MCHS_PKG_SRCURL=https://github.com/troydhanson/uthash/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e10382ab75518bad8319eb922ad04f907cb20cccb451a3aa980c9d005e661acc
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	cd src
	install -Dm600 -t $MCHS_PREFIX/include *.h
}
