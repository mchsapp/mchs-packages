MCHS_PKG_HOMEPAGE=https://kotlinlang.org/
MCHS_PKG_DESCRIPTION="The Kotlin Programming Language"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.10
MCHS_PKG_SRCURL=https://github.com/JetBrains/kotlin/releases/download/v${MCHS_PKG_VERSION}/kotlin-compiler-${MCHS_PKG_VERSION}.zip
MCHS_PKG_SHA256=432267996d0d6b4b17ca8de0f878e44d4a099b7e9f1587a98edc4d27e76c215a
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $MCHS_PREFIX/opt/kotlin
	mkdir -p $MCHS_PREFIX/opt/kotlin
	cp -r ./* $MCHS_PREFIX/opt/kotlin/
	for i in $MCHS_PREFIX/opt/kotlin/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $MCHS_PREFIX/bin/$(basename $i)
	done
}
