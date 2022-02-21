MCHS_PKG_HOMEPAGE=https://ant.apache.org/
MCHS_PKG_DESCRIPTION="Java based build tool like make"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.12
MCHS_PKG_SRCURL=http://apache.mirrors.spacedump.net//ant/binaries/apache-ant-${MCHS_PKG_VERSION}-bin.tar.bz2
MCHS_PKG_SHA256=276ea73f267a5b1a58f02e2eb5ef594a9b2885e33afb05ef995251d4d18377a6
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	mv ./bin/ant .
	rm -f ./bin/*
	mv ./ant ./bin/
	rm -rf manual
	rm -rf $MCHS_PREFIX/opt/ant
	mkdir -p $MCHS_PREFIX/opt/ant
	cp -r ./* $MCHS_PREFIX/opt/ant
	ln -sfr $MCHS_PREFIX/opt/ant/bin/ant $MCHS_PREFIX/bin/ant
}
