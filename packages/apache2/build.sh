MCHS_PKG_HOMEPAGE=https://httpd.apache.org
MCHS_PKG_DESCRIPTION="Apache Web Server"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:2.4.52
MCHS_PKG_SRCURL=https://www.apache.org/dist/httpd/httpd-${MCHS_PKG_VERSION:2}.tar.bz2
MCHS_PKG_SHA256=0127f7dc497e9983e9c51474bed75e45607f2f870a7675a86dc90af6d572f5c9
MCHS_PKG_DEPENDS="apr, apr-util, pcre, openssl, libcrypt, libandroid-support, libnghttp2, libexpat, libuuid, zlib"
MCHS_PKG_BREAKS="apache2-dev"
MCHS_PKG_REPLACES="apache2-dev"
MCHS_PKG_CONFFILES="
etc/apache2/httpd.conf
etc/apache2/extra/httpd-autoindex.conf
etc/apache2/extra/httpd-dav.conf
etc/apache2/extra/httpd-default.conf
etc/apache2/extra/httpd-info.conf
etc/apache2/extra/httpd-languages.conf
etc/apache2/extra/httpd-manual.conf
etc/apache2/extra/httpd-mpm.conf
etc/apache2/extra/httpd-multilang-errordoc.conf
etc/apache2/extra/httpd-ssl.conf
etc/apache2/extra/httpd-userdir.conf
etc/apache2/extra/httpd-vhosts.conf
etc/apache2/extra/proxy-html.conf
etc/apache2/mime.types
etc/apache2/magic
"

# providing manual paths to libs because it picks up host libs on some systems
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-apr=$MCHS_PREFIX
--with-apr-util=$MCHS_PREFIX
--with-pcre=$MCHS_PREFIX
--enable-suexec
--enable-layout=McHs
--enable-so
--enable-authnz-fcgi
--enable-cache
--enable-disk-cache
--enable-mem-cache
--enable-file-cache
--enable-ssl
--with-ssl
--enable-deflate
--enable-cgi
--enable-cgid
--enable-proxy
--enable-proxy-connect
--enable-proxy-http
--enable-proxy-ftp
--enable-dbd
--enable-imagemap
--enable-ident
--enable-cern-meta
--enable-http2
--enable-mpms-shared=all
--enable-modules=all
--enable-mods-shared=all
--disable-brotli
--disable-lua
--disable-mods-static
--disable-md
--with-port=8080
--with-sslport=8443
--enable-unixd
--without-libxml2
--libexecdir=$MCHS_PREFIX/libexec/apache2
ac_cv_func_getpwnam=yes
ac_cv_have_threadsafe_pollset=no
"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_RM_AFTER_INSTALL="share/apache2/manual etc/apache2/original share/man/man8/suexec.8 libexec/httpd.exp"
MCHS_PKG_EXTRA_MAKE_ARGS="-s"
MCHS_PKG_SERVICE_SCRIPT=("httpd" 'exec httpd -DNO_DETACH 2>&1')
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	gcc -O2 -DCROSS_COMPILE $MCHS_PKG_SRCDIR/server/gen_test_char.c \
		-o gen_test_char
}

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# remove old files
	rm -rf "$MCHS_PREFIX"/{libexec,share,etc}/apache2
	rm -rf "$MCHS_PREFIX"/lib/cgi-bin

	if [ $MCHS_ARCH_BITS -eq 32 ]; then
		export ap_cv_void_ptr_lt_long=4
	else
		export ap_cv_void_ptr_lt_long=8
	fi

	LDFLAGS="$LDFLAGS -lapr-1 -laprutil-1"

	# use custom layout
	cat $MCHS_PKG_BUILDER_DIR/McHs.layout > $MCHS_PKG_SRCDIR/config.layout

	make -C $MCHS_PKG_SRCDIR/libdummy
	ldflags_tmp="-L$MCHS_PKG_SRCDIR/libdummy -Wl,--as-needed"
	for m in cache dav proxy session watchdog; do
		ldflags_tmp+=,-ldummy-mod_$m
	done
	libexecdir=$MCHS_PREFIX/libexec/apache2
	LDFLAGS+=" $ldflags_tmp -Wl,-rpath=$libexecdir"
}

mchs_step_post_configure() {
	install -m700 $MCHS_PKG_HOSTBUILD_DIR/gen_test_char \
		$MCHS_PKG_BUILDDIR/server/gen_test_char
	touch -d "1 hour" $MCHS_PKG_BUILDDIR/server/gen_test_char
}

mchs_step_post_make_install() {
	sed -e "s#/$MCHS_PREFIX/libexec/apache2/#modules/#" \
		-e 's|#\(LoadModule negotiation_module \)|\1|' \
		-e 's|#\(LoadModule include_module \)|\1|' \
		-e 's|#\(LoadModule userdir_module \)|\1|' \
		-e 's|#\(LoadModule slotmem_shm_module \)|\1|' \
		-e 's|#\(Include extra/httpd-multilang-errordoc.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-autoindex.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-languages.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-userdir.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-default.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-mpm.conf\)|\1|' \
		-e 's|User daemon|#User daemon|' \
		-e 's|Group daemon|#Group daemon|' \
		-i "$MCHS_PREFIX/etc/apache2/httpd.conf"
	echo -e "#\n#  Load config files from the config directory 'conf.d'.\n#\nInclude etc/apache2/conf.d/*.conf" >> $MCHS_PREFIX/etc/apache2/httpd.conf
}

mchs_step_post_massage() {
	# sometimes it creates a $MCHS_PREFIX/bin/sh -> /bin/sh
	rm -f ${MCHS_PKG_MASSAGEDIR}${MCHS_PREFIX}/bin/sh

	mkdir -p ${MCHS_PKG_MASSAGEDIR}${MCHS_PREFIX}/etc/apache2/conf.d
	touch ${MCHS_PKG_MASSAGEDIR}${MCHS_PREFIX}/etc/apache2/conf.d/placeholder.conf
	mkdir -p ${MCHS_PKG_MASSAGEDIR}${MCHS_PREFIX}/var/run/apache2
	mkdir -p ${MCHS_PKG_MASSAGEDIR}${MCHS_PREFIX}/var/log/apache2
}
