MCHS_PKG_HOMEPAGE=https://maven.apache.org/
MCHS_PKG_DESCRIPTION="A Java software project management and comprehension tool"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@masterjavaofficial"
MCHS_PKG_VERSION=3.8.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://dlcdn.apache.org/maven/maven-3/${MCHS_PKG_VERSION}/binaries/apache-maven-${MCHS_PKG_VERSION}-bin.tar.gz
MCHS_PKG_SHA256=2cdc9c519427bb20fdc25bef5a9063b790e4abd930e7b14b4e9f4863d6f9f13c
MCHS_PKG_DEPENDS="libjansi, openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	# Remove starter scripts for Windows
	rm -f bin/*.cmd
	# Remove DLL for Windows
	rm -rf lib/jansi-native/Windows
	ln -sf $MCHS_PREFIX/lib/libjansi.so lib/jansi-native/
	rm -rf $MCHS_PREFIX/opt/maven
	mkdir -p $MCHS_PREFIX/opt
	cp -a $MCHS_PKG_SRCDIR $MCHS_PREFIX/opt/maven/
	# Symlink only starter scripts for Linux
	ln -sfr $MCHS_PREFIX/opt/maven/bin/mvn $MCHS_PREFIX/bin/mvn
	ln -sfr $MCHS_PREFIX/opt/maven/bin/mvnDebug $MCHS_PREFIX/bin/mvnDebug
	ln -sfr $MCHS_PREFIX/opt/maven/bin/mvnyjp $MCHS_PREFIX/bin/mvnyjp
}
