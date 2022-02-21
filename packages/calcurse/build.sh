MCHS_PKG_HOMEPAGE=https://calcurse.org/
MCHS_PKG_DESCRIPTION="calcurse is a calendar and scheduling application for the command line"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.7.1
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://calcurse.org/files/calcurse-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=0a7c55d07674569d166c0b0e7587b2972d3da8160cdb7d60b1dbd2895803afb0
MCHS_PKG_DEPENDS="libandroid-support, ncurses"
MCHS_PKG_RECOMMENDS="calcurse-caldav"

mchs_step_pre_configure() {
	export ac_cv_lib_pthread_pthread_create=yes
}
