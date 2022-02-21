MCHS_PKG_HOMEPAGE=https://cfengine.com/
MCHS_PKG_DESCRIPTION="CFEngine is a configuration management technology."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@craigcomstock"
MCHS_PKG_VERSION=1:3.18.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=(https://github.com/cfengine/core/archive/${MCHS_PKG_VERSION:2}.zip
                   https://github.com/cfengine/masterfiles/archive/12b52c25e03439341aa7a6a5c7917efa06826f8d.zip
                   https://github.com/cfengine/libntech/archive/118d6e4bf5ae2611236fe3883b422d50f10da45c.zip)
MCHS_PKG_SHA256=(846f4cf2a6154817c730b847cacc6f9aacd32c51abc00c137f56650d85e47134
                   9372e0c65322dc85c5f6f95be175ac0858c94d5ffb54317e8e332ddac634657a
                   49e03c1daf913bbe370a56aac03b0d2a7250d108c91b39780487304b3e6ac047)
MCHS_PKG_DEPENDS="liblmdb, openssl, libandroid-glob, pcre, libyaml, libxml2"
# core doesn't work with out-of-tree builds
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-workdir=$MCHS_PREFIX/var/lib/cfengine --without-pam --without-selinux-policy --without-systemd-service --with-lmdb=$MCHS_PREFIX --with-openssl=$MCHS_PREFIX --with-yaml=$MCHS_PREFIX --with-pcre=$MCHS_PREFIX --with-prefix=$MCHS_PREFIX --with-libxml2=$MCHS_PREFIX"

mchs_step_post_get_source() {
  # commit-based zips from github include the commit sha so rename to normalize for later steps
  mv masterfiles-* masterfiles
  rm -rf libntech
  mv libntech-* libntech
}

mchs_step_pre_configure() {
  export EXPLICIT_VERSION=${MCHS_PKG_VERSION:2}
  export LDFLAGS+=" -landroid-glob"
  NO_CONFIGURE=1 ./autogen.sh $MCHS_PKG_EXTRA_CONFIGURE_ARGS --prefix=$MCHS_PREFIX/var/lib/cfengine --bindir=$MCHS_PREFIX/bin

  cd masterfiles
  ./autogen.sh --prefix=$MCHS_PREFIX/var/lib/cfengine --bindir=$MCHS_PREFIX/bin
  make install
}

mchs_step_create_debscripts() {
        cat << EOF > ./postinst
        #!$MCHS_PREFIX/bin/sh
        # Generate a host key
        if [ ! -f $MCHS_PREFIX/var/lib/cfengine/ppkeys/localhost.priv ]; then
          $MCHS_PREFIX/bin/cf-key >/dev/null || :
        fi
EOF
}
