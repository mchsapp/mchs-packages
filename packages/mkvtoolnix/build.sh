MCHS_PKG_HOMEPAGE=https://www.bunkus.org/videotools/mkvtoolnix/
MCHS_PKG_DESCRIPTION="Set of tools to create, edit and inspect Matroska files"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=53.0.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://gitlab.com/mbunkus/mkvtoolnix/-/archive/release-$MCHS_PKG_VERSION/mkvtoolnix-release-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=eca97e3da994799527b31bcf795c676dc9553949787808daa6598100f57aa221
MCHS_PKG_DEPENDS="boost, file, libflac, libogg, libvorbis, pcre2, zlib"
MCHS_PKG_BUILD_DEPENDS="fmt, libebml, libmatroska"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-boost-filesystem=boost_filesystem
--with-boost-system=boost_system
--with-boost-date-time=boost_date_time
"

mchs_step_pre_configure() {
	./autogen.sh
}

mchs_step_make() {
	rake
}

mchs_step_make_install() {
	rake install
}
