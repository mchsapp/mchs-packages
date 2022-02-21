MCHS_PKG_HOMEPAGE=http://dotat.at/prog/unifdef/
MCHS_PKG_DESCRIPTION="Remove #ifdef'ed lines"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.12
MCHS_PKG_SRCURL=https://dotat.at/prog/unifdef/unifdef-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	mkdir -p "$MCHS_PREFIX"/share/man/man1/
	install -Dm700 unifdef "$MCHS_PREFIX"/bin/
	install -Dm600 unifdef.1 "$MCHS_PREFIX"/share/man/man1/
}
