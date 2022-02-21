MCHS_PKG_HOMEPAGE=https://github.com/google/gumbo-parser
MCHS_PKG_DESCRIPTION="An HTML5 parsing library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.10.1
MCHS_PKG_SRCURL=https://github.com/google/gumbo-parser/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=28463053d44a5dfbc4b77bcf49c8cee119338ffa636cc17fc3378421d714efad
MCHS_PKG_AUTO_UPDATE=true

mchs_step_pre_configure() {
	./autogen.sh
}
