MCHS_PKG_HOMEPAGE=http://www.pps.jussieu.fr/~jch/software/polipo/
MCHS_PKG_DESCRIPTION="A small and fast caching web proxy"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.1
MCHS_PKG_SRCURL=http://www.pps.univ-paris-diderot.fr/~jch/software/files/polipo/polipo-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=a259750793ab79c491d05fcee5a917faf7d9030fb5d15e05b3704e9c9e4ee015
MCHS_PKG_DEPENDS="resolv-conf"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFFILES="etc/polipo/config"

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

mchs_step_post_make_install() {
	install -Dm600 config.sample "$MCHS_PREFIX"/etc/polipo/config.sample
	install -Dm600 forbidden.sample "$MCHS_PREFIX"/etc/polipo/forbidden.sample
	install -Dm600 "$MCHS_PKG_BUILDER_DIR"/mchs.config \
		"$MCHS_PREFIX"/etc/polipo/config
}

mchs_step_post_massage() {
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/cache/polipo
}
