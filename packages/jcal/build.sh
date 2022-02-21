MCHS_PKG_HOMEPAGE="http://nongnu.org/jcal"
MCHS_PKG_DESCRIPTION="UNIX-cal-like tool to display Jalali (Persian/Iranian) calendar"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.1
MCHS_PKG_SRCURL="https://github.com/persiancal/jcal/archive/v$MCHS_PKG_VERSION.tar.gz"
MCHS_PKG_SHA256=b55edc605eda0a5b25b8009391dcaeb3c8ba88d1fb3337a071f555983a114c12
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
    cd sources
    ./autogen.sh
    sed --in-place 's/$RM "$cfgfile"/$RM -f "$cfgfile"/g' configure
    MCHS_PKG_SRCDIR+="/sources"
}

mchs_step_post_configure() {
    # removing tests
    sed --in-place 's/test_kit//g' sources/Makefile.am
}
