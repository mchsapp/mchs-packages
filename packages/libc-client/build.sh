MCHS_PKG_HOMEPAGE=https://www.washington.edu/imap/ # Gone.
MCHS_PKG_DESCRIPTION="UW IMAP c-client library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2007f
MCHS_PKG_SRCURL=https://www.mirrorservice.org/sites/ftp.cac.washington.edu/imap/imap-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=53e15a2b5c1bc80161d42e9f69792a3fa18332b7b771910131004eb520004a28
MCHS_PKG_DEPENDS="libcrypt, openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -fPIC $CPPFLAGS -DFNDELAY=O_NONBLOCK -DL_SET=SEEK_SET"
	LDFLAGS+=" -lcrypt -lssl -lcrypto"
}

mchs_step_configure() {
	:
}

mchs_step_make() {
	make -e slx

	mv c-client/{,lib}c-client.a
	$CC -Wl,--whole-archive c-client/libc-client.a -Wl,--no-whole-archive -shared -o c-client/libc-client.so -Wl,-soname=libc-client.so $LDFLAGS
}

mchs_step_make_install() {
	install -Dm600 -t $MCHS_PREFIX/lib c-client/libc-client.{a,so}
	install -Dm600 -t $MCHS_PREFIX/include/c-client c-client/linkage.[ch] src/c-client/*.h src/osdep/unix/*.h
	cp -a c-client/osdep.h $MCHS_PREFIX/include/c-client/
}
