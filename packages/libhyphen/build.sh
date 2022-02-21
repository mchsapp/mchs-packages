MCHS_PKG_HOMEPAGE=https://github.com/hunspell/hyphen
MCHS_PKG_DESCRIPTION="hyphenation library to use converted TeX hyphenation patterns"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.8.8
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/hunspell/hyphen-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=304636d4eccd81a14b6914d07b84c79ebb815288c76fe027b9ebff6ff24d5705

mchs_step_pre_configure() {
	autoreconf -fvi
} 
