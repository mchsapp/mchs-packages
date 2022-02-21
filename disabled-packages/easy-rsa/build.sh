MCHS_PKG_HOMEPAGE=https://openvpn.net/easyrsa.html
MCHS_PKG_VERSION=3.0.1
MCHS_PKG_DEPENDS="openssl-tool"
MCHS_PKG_SRCURL=https://github.com/OpenVPN/easy-rsa/releases/download/$MCHS_PKG_VERSION/EasyRSA-$MCHS_PKG_VERSION.tgz
MCHS_PKG_SHA256=dbdaf5b9444b99e0c5221fd4bcf15384c62380c1b63cea23d42239414d7b2d4e
MCHS_PKG_CONFFILES="etc/easy-rsa/openssl-1.0.cnf, etc/easy-rsa/vars"
MCHS_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
    install -D -m0755 easyrsa "${MCHS_PREFIX}"/bin/easyrsa

    install -D -m0644 openssl-1.0.cnf "${MCHS_PREFIX}"/etc/easy-rsa/openssl-1.0.cnf
    install -D -m0644 vars.example "${MCHS_PREFIX}"/etc/easy-rsa/vars
    install -d -m0755 "${MCHS_PREFIX}"/etc/easy-rsa/x509-types/
    install -m0644 x509-types/* "${MCHS_PREFIX}"/etc/easy-rsa/x509-types/
}
