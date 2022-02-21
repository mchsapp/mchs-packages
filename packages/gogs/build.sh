MCHS_PKG_HOMEPAGE=https://gogs.io
MCHS_PKG_DESCRIPTION="A painless self-hosted Git service."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Injamul Mohammad Mollah <mrinjamul@gmail.com>"
MCHS_PKG_VERSION=0.12.4
MCHS_PKG_SRCURL=https://github.com/gogs/gogs/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e6b0ab345b5bc1eb53478e81a2cb9b34cc558e3196a21ca51978da2f69380c8a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="dash, git"
MCHS_PKG_CONFFILES="etc/gogs/app.ini"
MCHS_PKG_HOSTBUILD=true

mchs_step_handle_hostbuild() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_HOSTBUILD_DIR
	mkdir -p $MCHS_PKG_HOSTBUILD_DIR
	cd $MCHS_PKG_HOSTBUILD_DIR
	go get -u github.com/kevinburke/go-bindata/...
}

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/gogs.io
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/gogs.io/gogs
	cd "$GOPATH"/src/gogs.io/gogs

	LDFLAGS=""
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.CustomConf=$MCHS_PREFIX/etc/gogs/app.ini"
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.AppWorkPath=$MCHS_PREFIX/var/lib/gogs"
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.CustomPath=$MCHS_PREFIX/var/lib/gogs"

	PATH=$PATH:$MCHS_PKG_HOSTBUILD_DIR/bin GOGS_VERSION=v"$MCHS_PKG_VERSION" TAGS="bindata sqlite" make all
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/gogs.io/gogs/gogs \
		"$MCHS_PREFIX"/bin/gogs

	mkdir -p "$MCHS_PREFIX"/etc/gogs
	sed "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
		"$MCHS_PKG_BUILDER_DIR"/app.ini > "$MCHS_PREFIX"/etc/gogs/app.ini
}

mchs_step_post_massage() {
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/lib/gogs
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/log/gogs
}
