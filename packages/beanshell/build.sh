MCHS_PKG_HOMEPAGE=https://github.com/beanshell/beanshell
MCHS_PKG_DESCRIPTION="Small, free, embeddable, source level Java interpreter with object based scripting language features written in Java"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.0
MCHS_PKG_SRCURL=https://github.com/beanshell/beanshell/releases/download/$MCHS_PKG_VERSION/bsh-$MCHS_PKG_VERSION.jar
MCHS_PKG_SHA256=e9a68515dd69d54a648c4497875264a874f6c69ff52d0ddaf4be2204f0f18652
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="dash, mchs-tools"
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_download \
		"$MCHS_PKG_SRCURL" \
		"$MCHS_PKG_CACHEDIR/bsh-$MCHS_PKG_VERSION.jar" \
		"$MCHS_PKG_SHA256"
}

mchs_step_make() {
	"$ANDROID_HOME/build-tools/${MCHS_ANDROID_BUILD_TOOLS_VERSION}/dx" \
		--dex --output=beanshell.jar "$MCHS_PKG_CACHEDIR/bsh-$MCHS_PKG_VERSION.jar"
}

mchs_step_make_install() {
	install -Dm600 beanshell.jar "$MCHS_PREFIX/share/dex/beanshell.jar"

	{
		echo "#!$MCHS_PREFIX/bin/sh"
		echo "dalvikvm -Xcompiler-option --compiler-filter=speed -cp $MCHS_PREFIX/share/dex/beanshell.jar bsh.Interpreter \"\$@\""
	} > "$MCHS_PREFIX"/bin/beanshell

	chmod 700 "$MCHS_PREFIX"/bin/beanshell
	ln -sfr "$MCHS_PREFIX"/bin/beanshell "$MCHS_PREFIX"/bin/bsh
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${MCHS_PREFIX}/bin/bash
	rm -f $MCHS_PREFIX/share/dex/oat/*/beanshell.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}
