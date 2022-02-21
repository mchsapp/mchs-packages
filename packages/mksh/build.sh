MCHS_PKG_HOMEPAGE=http://www.mirbsd.org/mksh.htm
MCHS_PKG_DESCRIPTION="The MirBSD Korn Shell - an enhanced version of the public domain ksh"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=59c
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R${MCHS_PKG_VERSION/./}.tgz
MCHS_PKG_SHA256=77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	sh Build.sh -r
}

mchs_step_make_install() {
	install -Dm700 mksh "$MCHS_PREFIX"/bin/mksh
	install -Dm600 mksh.1 "$MCHS_PREFIX"/share/man/man1/mksh.1
}
