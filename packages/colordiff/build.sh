MCHS_PKG_HOMEPAGE=https://www.colordiff.org/
MCHS_PKG_DESCRIPTION="Tool to colorize 'diff' output"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_VERSION=1.0.19
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://www.colordiff.org/colordiff-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=46e8c14d87f6c4b77a273cdd97020fda88d5b2be42cf015d5d84aca3dfff3b19
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make() {
	# Skip the 'make' invocation as it only tries to
	# rebuild the documentation.
	continue
}

mchs_step_post_configure() {
	export INSTALL_DIR=${PREFIX}/bin
	export MAN_DIR=${PREFIX}/share/man/man1
	export ETC_DIR=${PREFIX}/etc
}
