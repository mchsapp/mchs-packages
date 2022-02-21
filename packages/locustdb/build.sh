MCHS_PKG_HOMEPAGE=https://github.com/cswinter/LocustDB
MCHS_PKG_DESCRIPTION="An experimental analytics database"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_LICENSE_FILE="LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.3.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/cswinter/LocustDB/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b4ac9e44edc541522b7663ebbb6dfeafaf58a1a4fd060e86af59ed3baec6574a
MCHS_PKG_BUILD_IN_SRC=true

# ```
# error: this arithmetic operation will overflow
#    --> src/locustdb.rs:189:36
#     |
# 189 |             mem_size_limit_tables: 8 * 1024 * 1024 * 1024, // 8 GiB
#     |                                    ^^^^^^^^^^^^^^^^^^^^^^ attempt to multiply with overflow
#     |
#     = note: `#[deny(arithmetic_overflow)]` on by default
# ```
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make() {
	mchs_setup_rust

	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -T target/${CARGO_TARGET_NAME}/release/repl $MCHS_PREFIX/bin/locustdb
}
