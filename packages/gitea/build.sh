MCHS_PKG_HOMEPAGE=https://gitea.io
MCHS_PKG_DESCRIPTION="Git with a cup of tea, painless self-hosted git service"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.14.6
MCHS_PKG_SRCURL=https://github.com/go-gitea/gitea/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6953049817b86dafa3b8327b7a1b463ef7880f617a9574f03a4b4eb1ea4b6c4d
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="dash, git"
MCHS_PKG_CONFFILES="etc/gitea/app.ini"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/code.gitea.io
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/code.gitea.io/gitea
	cd "$GOPATH"/src/code.gitea.io/gitea

	LDFLAGS=""
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.CustomConf=$MCHS_PREFIX/etc/gitea/app.ini"
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.AppWorkPath=$MCHS_PREFIX/var/lib/gitea"
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.CustomPath=$MCHS_PREFIX/var/lib/gitea"
	GITEA_VERSION=v"$MCHS_PKG_VERSION" TAGS="bindata sqlite" make all
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/code.gitea.io/gitea/gitea \
		"$MCHS_PREFIX"/bin/gitea

	mkdir -p "$MCHS_PREFIX"/etc/gitea
	sed "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
		"$MCHS_PKG_BUILDER_DIR"/app.ini > "$MCHS_PREFIX"/etc/gitea/app.ini
}

mchs_step_post_massage() {
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/lib/gitea
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/log/gitea
}
