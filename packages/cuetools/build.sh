MCHS_PKG_HOMEPAGE=https://github.com/svend/cuetools
MCHS_PKG_DESCRIPTION="A set of utilities for working with Cue Sheet (cue) and Table of Contents (toc) files"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.1
MCHS_PKG_SRCURL=https://github.com/svend/cuetools/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=24a2420f100c69a6539a9feeb4130d19532f9f8a0428a8b9b289c6da761eb107

mchs_step_pre_configure() {
	autoreconf -fi
}
