MCHS_PKG_HOMEPAGE=https://pyyaml.org/wiki/LibYAML
MCHS_PKG_DESCRIPTION="LibYAML is a YAML 1.1 parser and emitter written in C"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2.5
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/yaml/libyaml/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=fa240dbf262be053f3898006d502d514936c818e422afdcf33921c63bed9bf2e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libyaml-dev"
MCHS_PKG_REPLACES="libyaml-dev"

mchs_step_pre_configure() {
	./bootstrap
}

mchs_step_post_make_install() {
	cd $MCHS_PREFIX/lib
	ln -s -f libyaml-0.so libyaml.so
}
