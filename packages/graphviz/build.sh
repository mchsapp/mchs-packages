MCHS_PKG_HOMEPAGE=https://www.graphviz.org/
MCHS_PKG_DESCRIPTION="Rich set of graph drawing tools"
MCHS_PKG_LICENSE="EPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.50.0
MCHS_PKG_SRCURL=https://gitlab.com/graphviz/graphviz/-/archive/$MCHS_PKG_VERSION/graphviz-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=afa48581f764a35e148909cc96a0308ec2356b5225b64af12492f3392f20ef1c
MCHS_PKG_DEPENDS="libandroid-glob, libc++, libcairo, pango, libexpat, libltdl, librsvg, libgd, zlib"
MCHS_PKG_BREAKS="graphviz-dev"
MCHS_PKG_REPLACES="graphviz-dev"
MCHS_PKG_BUILD_DEPENDS="libtool"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"

mchs_step_post_make_install() {
	# Some binaries (dot_builtins, gvpack) links against these:
	cd $MCHS_PREFIX/lib
	for lib in graphviz/*.so*; do
		ln -s -f $lib $(basename $lib)
	done
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "dot -c" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
