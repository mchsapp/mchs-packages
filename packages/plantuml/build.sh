MCHS_PKG_HOMEPAGE=https://plantuml.com/
MCHS_PKG_DESCRIPTION="Draws UML diagrams, using a simple and human readable text description"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2021.16
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/plantuml/${MCHS_PKG_VERSION}/plantuml-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a8887c9714d764a7ee44335494fffa689555822a66044d9430d51731a7981c6b
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_BUILD_DEPENDS="ant"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	sh $MCHS_PREFIX/bin/ant dist
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/java
	install -Dm600 plantuml.jar $MCHS_PREFIX/share/java/
	install -Dm700 plantuml $MCHS_PREFIX/bin/
}
