MCHS_PKG_HOMEPAGE=http://rigaux.org/hexedit.html
MCHS_PKG_DESCRIPTION="view and edit files in hexadecimal or in ASCII"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5
MCHS_PKG_SRCURL=https://github.com/pixel/hexedit/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=27a2349f659e995d7731ad672450f61a2e950330049a6fb59b77490c5e0015ac
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./autogen.sh
}
