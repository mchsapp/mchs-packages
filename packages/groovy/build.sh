MCHS_PKG_HOMEPAGE=https://groovy-lang.org/
MCHS_PKG_DESCRIPTION="A powerful multi-faceted programming language for the JVM platform"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.0.0
MCHS_PKG_SRCURL=https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-$MCHS_PKG_VERSION.zip
MCHS_PKG_SHA256=bd5b8af69c169f41c5c7aea00cb8832a6e232ee697f626e29d8f92adebe30df9
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $MCHS_PREFIX/opt/groovy
	mkdir -p $MCHS_PREFIX/opt/groovy
	cp -r ./* $MCHS_PREFIX/opt/groovy/
	for i in $MCHS_PREFIX/opt/groovy/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $MCHS_PREFIX/bin/$(basename $i)
	done
}
