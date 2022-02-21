MCHS_PKG_HOMEPAGE=https://asymptote.sourceforge.io/
MCHS_PKG_DESCRIPTION="A powerful descriptive vector graphics language for technical drawing"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=(2.74)
MCHS_PKG_VERSION+=(0.9.9.8)
MCHS_PKG_SRCURL=(https://downloads.sourceforge.net/asymptote/asymptote-${MCHS_PKG_VERSION}.src.tgz
                   https://github.com/g-truc/glm/archive/${MCHS_PKG_VERSION[1]}.tar.gz)
MCHS_PKG_SHA256=(d48e8a5a9029af01da1f845e73c03e78b60c805ab9e974005bcfbeaefaebb3ba
                   7d508ab72cb5d43227a3711420f06ff99b0a0cb63ee2f93631b162bfe1fe9592)
MCHS_PKG_DEPENDS="libc++, libtirpc, ncurses, readline, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gc
"

mchs_step_post_get_source() {
	mv glm-${MCHS_PKG_VERSION[1]} glm
}

mchs_step_pre_configure() {
	touch GL/glu.h

	local glm_inc=$MCHS_PKG_BUILDDIR/_glm/include
	mkdir -p $glm_inc
	cp -r glm/glm $glm_inc/
	CPPFLAGS+=" -I${glm_inc}"
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin asy
	cp -rT base $MCHS_PREFIX/share/asymptote
}
