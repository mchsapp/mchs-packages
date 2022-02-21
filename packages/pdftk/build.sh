MCHS_PKG_HOMEPAGE=https://gitlab.com/pdftk-java/pdftk
MCHS_PKG_DESCRIPTION="A simple tool for doing everyday things with PDF documents"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.1
MCHS_PKG_SRCURL=https://gitlab.com/pdftk-java/pdftk/-/archive/v${MCHS_PKG_VERSION}/pdftk-v${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=1d1199b02108b4f762209534b8342e79f474c007384dfa70174514e91205a2a7
MCHS_PKG_DEPENDS="libbcprov-java, libcommons-lang3-java, openjdk-17"
MCHS_PKG_BUILD_DEPENDS="ant"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mkdir -p lib
	ln -sf $MCHS_PREFIX/share/java/commons-lang3.jar lib/
	ln -sf $MCHS_PREFIX/share/java/bcprov.jar lib/
}

mchs_step_make() {
	sh $MCHS_PREFIX/bin/ant jar
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/java
	install -Dm600 build/jar/pdftk.jar $MCHS_PREFIX/share/java/
	install -Dm700 pdftk $MCHS_PREFIX/bin/
}
