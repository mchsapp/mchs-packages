MCHS_PKG_HOMEPAGE=https://gradle.org/
MCHS_PKG_DESCRIPTION="Powerful build system for the JVM"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:7.4
MCHS_PKG_SRCURL=https://services.gradle.org/distributions/gradle-${MCHS_PKG_VERSION:2}-bin.zip
MCHS_PKG_SHA256=8cc27038d5dbd815759851ba53e70cf62e481b87494cc97cfd97982ada5ba634
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $MCHS_PREFIX/opt/gradle
	mkdir -p $MCHS_PREFIX/opt/gradle
	cp -r ./* $MCHS_PREFIX/opt/gradle/
	for i in $MCHS_PREFIX/opt/gradle/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $MCHS_PREFIX/bin/$(basename $i)
	done
}

