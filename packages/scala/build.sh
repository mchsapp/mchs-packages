MCHS_PKG_HOMEPAGE=https://www.scala-lang.org
MCHS_PKG_DESCRIPTION="Scala 3 compiler and standard library."
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.1
MCHS_PKG_SRCURL=https://github.com/lampepfl/dotty/releases/download/$MCHS_PKG_VERSION/scala3-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=fe83eeffe8b2124752f5afd7a0e5b5b390b9cc499208162cb724f5677e36916b
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $MCHS_PREFIX/opt/scala
	mkdir -p $MCHS_PREFIX/opt/scala
	cp -r ./* $MCHS_PREFIX/opt/scala/
	for i in $MCHS_PREFIX/opt/scala/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $MCHS_PREFIX/bin/$(basename $i)
	done
}
