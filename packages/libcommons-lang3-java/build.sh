MCHS_PKG_HOMEPAGE=https://commons.apache.org/proper/commons-lang/
MCHS_PKG_DESCRIPTION="A host of helper utilities for the java.lang API"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.12.0
MCHS_PKG_SRCURL=https://dlcdn.apache.org/commons/lang/source/commons-lang3-${MCHS_PKG_VERSION}-src.tar.gz
MCHS_PKG_SHA256=fb73e7475cb76fc400a58da92b8d8d930717424917f96b80bb70f4366fd8ac25
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	cd src/main/java
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name "*.java")
	_BUILD_JARFILE="$MCHS_PKG_BUILDDIR/commons-lang3.jar"
	rm -f "$_BUILD_JARFILE"
	jar cf "$_BUILD_JARFILE" $(find . -name "*.class")
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/share/java
	install -Dm600 "$_BUILD_JARFILE" $MCHS_PREFIX/share/java/
}
