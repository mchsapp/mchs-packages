MCHS_PKG_HOMEPAGE=https://thrysoee.dk/editline/
MCHS_PKG_DESCRIPTION="Library providing line editing, history, and tokenization functions"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20210910-3.1
MCHS_PKG_SRCURL=https://thrysoee.dk/editline/libedit-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6792a6a992050762edcca28ff3318cdb7de37dccf7bc30db59fcd7017eed13c5
MCHS_PKG_DEPENDS="libandroid-support, ncurses"
MCHS_PKG_BREAKS="libedit-dev"
MCHS_PKG_REPLACES="libedit-dev"
MCHS_PKG_RM_AFTER_INSTALL="share/man/man7/editline.7 share/man/man3/history.3"

mchs_step_pre_configure() {
	CFLAGS+=" -D__STDC_ISO_10646__=201103L -DNBBY=CHAR_BIT"
}
