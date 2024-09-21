#!/usr/bin/env bash

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# get OS from /etc/os-release and install dependencies
LINUX=$(grep "^ID=" /etc/os-release | awk -F= '{print $2}')
case ${LINUX} in
    "ubuntu" | "debian")
        export DEBIAN_FRONTEND=noninteractive
        apt-get -y update && apt-get -y install unzip curl
        ;;
    "centos" | "rhel")
        yum -y install unzip curl
        ;;
    "alpine")
        apk add --no-cache unzip curl
        ;;
    *)
        echo "(!) OS not supported"
        exit 1
        ;;
esac
echo "OS: ${LINUX}"

# get ARCH from uname
ARCH="$(uname -m)"
case ${ARCH} in
    x86_64) ARCH="amd64";;
    aarch64 | armv8*) ARCH="arm64";;
    aarch32 | armv7* | armvhf*) ARCH="arm";;
    i?86) ARCH="386";;
    *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
esac

install_hashicorp_release() {
    local PRODUCT=$1
    local VERSION=$2
    mkdir -p /tmp/${PRODUCT}
    cd /tmp/${PRODUCT}
    echo "Installing ${PRODUCT} ${VERSION}..."
    curl -sSL -o ${PRODUCT}.zip https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_${ARCH}.zip && \
    unzip ${PRODUCT}.zip && \
    mv ${PRODUCT} /usr/local/bin/${PRODUCT} && \
    echo "Done!"
}

if [ ! -z "${TERRAFORM}" ]; then
    install_hashicorp_release "terraform" "${TERRAFORM}"
fi

if [ ! -z "${VAULT}" ]; then
    install_hashicorp_release "vault" "${VAULT}"
fi

if [ ! -z "${CONSUL}" ]; then
    install_hashicorp_release "consul" "${CONSUL}"
fi

if [ ! -z "${NOMAD}" ]; then
    install_hashicorp_release "nomad" "${NOMAD}"
fi

if [ ! -z "${VAGRANT}" ]; then
    install_hashicorp_release "vagrant" "${VAGRANT}"
fi

if [ ! -z "${PACKER}" ]; then
    install_hashicorp_release "packer" "${PACKER}"
fi
