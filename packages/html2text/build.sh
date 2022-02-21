MCHS_PKG_HOMEPAGE=http://www.mbayer.de/html2text/
MCHS_PKG_DESCRIPTION="Utility that converts HTML documents into plain text"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:2.0.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/grobian/html2text/archive/v${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=061125bfac658c6d89fa55e9519d90c5eeb3ba97b2105748ee62f3a3fa2449de
MCHS_PKG_DEPENDS="libiconv"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CXX="$CXX $CXXFLAGS $CPPFLAGS $LDFLAGS"
	mkdir -p $MCHS_PREFIX/share/man/man1
}
