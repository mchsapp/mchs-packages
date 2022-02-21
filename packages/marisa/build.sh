MCHS_PKG_HOMEPAGE=https://github.com/s-yata/marisa-trie
MCHS_PKG_DESCRIPTION="Matching Algorithm with Recursively Implemented StorAge."
MCHS_PKG_LICENSE="BSD 2-Clause, LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2.6
MCHS_PKG_SRCURL=https://github.com/s-yata/marisa-trie/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1063a27c789e75afa2ee6f1716cc6a5486631dcfcb7f4d56d6485d2462e566de
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -fi
}
