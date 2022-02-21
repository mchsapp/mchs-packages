MCHS_PKG_HOMEPAGE=http://npush.sourceforge.net/
MCHS_PKG_DESCRIPTION="Curses-based logic game similar to Sokoban and Boulder Dash"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Dmitry Marakasov <amdmi3@amdmi3.ru>"
MCHS_PKG_VERSION=0.7
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/npush/npush/${MCHS_PKG_VERSION}/npush-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=f216d2b3279e8737784f77d4843c9e6f223fa131ce1ebddaf00ad802aba2bcd9
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_post_get_source() {
	sed -i -e "s|\"levels|\"${MCHS_PREFIX}/share/npush/levels|" npush.cpp
}

mchs_step_make() {
	$CXX $CXXFLAGS $CPPFLAGS $LDFLAGS -lncurses -o npush npush.cpp
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin/ npush
	install -Dm644 -t $MCHS_PREFIX/share/npush/levels levels/* 
}
