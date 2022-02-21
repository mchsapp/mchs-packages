MCHS_PKG_HOMEPAGE=https://www.nginx.org
MCHS_PKG_DESCRIPTION="Lightweight HTTP server"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.21.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://nginx.org/download/nginx-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=14774aae0d151da350417efc4afda5cce5035056e71894836797e1f6e2d1175a
MCHS_PKG_DEPENDS="libandroid-glob, libcrypt, pcre, openssl, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SERVICE_SCRIPT=("nginx" "mkdir -p $MCHS_ANDROID_HOME/.nginx\nif [ -f \"$MCHS_ANDROID_HOME/.nginx/nginx.conf\" ]; then CONFIG=\"$MCHS_ANDROID_HOME/.nginx/nginx.conf\"; else CONFIG=\"$MCHS_PREFIX/etc/nginx/nginx.conf\"; fi\nexec nginx -p ~/.nginx -g \"daemon off;\" -c \$CONFIG 2>&1")
MCHS_PKG_CONFFILES="
etc/nginx/fastcgi.conf
etc/nginx/fastcgi_params
etc/nginx/koi-win
etc/nginx/koi-utf
etc/nginx/mime.types
etc/nginx/nginx.conf
etc/nginx/scgi_params
etc/nginx/uwsgi_params
etc/nginx/win-utf"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	CPPFLAGS="$CPPFLAGS -DIOV_MAX=1024"
	LDFLAGS="$LDFLAGS -landroid-glob"

	# remove config from previous installs
	rm -rf "$MCHS_PREFIX/etc/nginx"
}

mchs_step_configure() {
	DEBUG_FLAG=""
	$MCHS_DEBUG_BUILD && DEBUG_FLAG="--with-debug"

	./configure \
		--prefix=$MCHS_PREFIX \
		--crossbuild="Linux:3.16.1:$MCHS_ARCH" \
		--crossfile="$MCHS_PKG_SRCDIR/auto/cross/Android" \
		--with-cc=$CC \
		--with-cpp=$CPP \
		--with-cc-opt="$CPPFLAGS $CFLAGS" \
		--with-ld-opt="$LDFLAGS" \
		--with-pcre \
		--with-pcre-jit \
		--with-threads \
		--with-ipv6 \
		--sbin-path="$MCHS_PREFIX/bin/nginx" \
		--conf-path="$MCHS_PREFIX/etc/nginx/nginx.conf" \
		--http-log-path="$MCHS_PREFIX/var/log/nginx/access.log" \
		--pid-path="$MCHS_PREFIX/tmp/nginx.pid" \
		--lock-path="$MCHS_PREFIX/tmp/nginx.lock" \
		--error-log-path="$MCHS_PREFIX/var/log/nginx/error.log" \
		--http-client-body-temp-path="$MCHS_PREFIX/var/lib/nginx/client-body" \
		--http-proxy-temp-path="$MCHS_PREFIX/var/lib/nginx/proxy" \
		--http-fastcgi-temp-path="$MCHS_PREFIX/var/lib/nginx/fastcgi" \
		--http-scgi-temp-path="$MCHS_PREFIX/var/lib/nginx/scgi" \
		--http-uwsgi-temp-path="$MCHS_PREFIX/var/lib/nginx/uwsgi" \
		--with-http_auth_request_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_gunzip_module \
		$DEBUG_FLAG
}

mchs_step_post_make_install() {
	# many parts are taken directly from Arch PKGBUILD
	# https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/nginx

	# set default port to 8080
	sed -i "s| 80;| 8080;|" "$MCHS_PREFIX/etc/nginx/nginx.conf"
	cp conf/mime.types "$MCHS_PREFIX/etc/nginx/"
	rm "$MCHS_PREFIX"/etc/nginx/*.default

	# move default html dir
	sed -e "44s|html|$MCHS_PREFIX/share/nginx/html|" \
		-e "54s|html|$MCHS_PREFIX/share/nginx/html|" \
		-i "$MCHS_PREFIX/etc/nginx/nginx.conf"
	rm -rf "$MCHS_PREFIX/share/nginx"
	mkdir -p "$MCHS_PREFIX/share/nginx"
	mv "$MCHS_PREFIX/html/" "$MCHS_PREFIX/share/nginx"

	# install vim contrib
	for i in ftdetect indent syntax; do
		install -Dm644 "$MCHS_PKG_SRCDIR/contrib/vim/${i}/nginx.vim" \
			"$MCHS_PREFIX/share/vim/vimfiles/${i}/nginx.vim"
	done

	# install man pages
	mkdir -p "$MCHS_PREFIX/share/man/man8"
	cp "$MCHS_PKG_SRCDIR/man/nginx.8" "$MCHS_PREFIX/share/man/man8/"
}

mchs_step_post_massage() {
	# keep empty dirs which were deleted in massage
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/log/nginx"
	for dir in client-body proxy fastcgi scgi uwsgi; do
		mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/lib/nginx/$dir"
	done
}
