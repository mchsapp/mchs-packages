MCHS_PKG_HOMEPAGE=http://eradman.com/entrproject/
MCHS_PKG_DESCRIPTION="Event Notify Test Runner - run arbitrary commands when files change"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.0
MCHS_PKG_SRCURL=http://eradman.com/entrproject/code/entr-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=2a87bb7d9e5e89b6f614495937b557dbb8144ea53d0c1fa1812388982cd41ebb
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	./configure
}

mchs_step_make() {
	make install
}
