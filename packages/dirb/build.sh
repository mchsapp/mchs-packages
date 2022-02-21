MCHS_PKG_HOMEPAGE=http://dirb.sourceforge.net/
MCHS_PKG_DESCRIPTION="Web Directory Fuzzer."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.22
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://sourceforge.net/projects/dirb/files/dirb/${MCHS_PKG_VERSION}/dirb${MCHS_PKG_VERSION/./}.tar.gz
MCHS_PKG_SHA256=f3748ade231ca211a01acbec31cc6a3b576f6c56c906d73329d7dbb79f60fc2c
MCHS_PKG_DEPENDS="libcurl"

mchs_step_post_get_source() {
	# dirb222.tar.gz has directory permission problem
	chmod +x -R "$MCHS_PKG_SRCDIR"
}

mchs_step_post_make_install() {
	mkdir -p "$MCHS_PREFIX"/share/dirb
	cp -rf  "$MCHS_PKG_SRCDIR"/wordlists "$MCHS_PREFIX"/share/dirb/wordlists
	find "$MCHS_PREFIX"/share/dirb/wordlists -type f | xargs chmod 600
	mv -f "$MCHS_PREFIX"/bin/gendict "$MCHS_PREFIX"/bin/dirb-gendict
}
