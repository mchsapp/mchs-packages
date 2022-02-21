MCHS_PKG_HOMEPAGE=https://github.com/openstreetmap/OSM-binary/
MCHS_PKG_DESCRIPTION="osmpbf is a Java/C library to read and write OpenStreetMap PBF files"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/openstreetmap/OSM-binary/archive/v${MCHS_PKG_VERSION}.zip
MCHS_PKG_SHA256=6738a5684bb68e3f890adda1b4116a6e04df9953d96788192052be53921107cd
MCHS_PKG_DEPENDS="libprotobuf"
MCHS_PKG_GROUPS="science"

mchs_step_pre_configure() {
  mchs_setup_protobuf
}
