MCHS_PKG_HOMEPAGE=https://github.com/OpenAtomFoundation/pika
MCHS_PKG_DESCRIPTION="A persistent huge storage service, compatible with the vast majority of Redis interfaces"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/OpenAtomFoundation/pika.git
MCHS_PKG_DEPENDS="google-glog, libc++, libprotobuf, librocksdb, zlib"
MCHS_PKG_BUILD_IN_SRC=true

# ```
# [...]/src/pika_set.cc:107:58: error: cannot initialize a parameter of type
# 'long *' with an rvalue of type 'int64_t *' (aka 'long long *')
#   if (!slash::string2l(argv_[2].data(), argv_[2].size(), &cursor_)) {
#                                                          ^~~~~~~~
# ```
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_post_get_source() {
	rm -fr third/rocksdb
	rm -fr third/blackwidow/deps/rocksdb
}

mchs_step_pre_configure() {
	mchs_setup_protobuf

	export DISABLE_UPDATE_SB=1
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin output/bin/pika
	install -Dm600 -t $MCHS_PREFIX/share/pika conf/pika.conf
}
