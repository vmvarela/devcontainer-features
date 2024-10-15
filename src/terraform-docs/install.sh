#!/usr/bin/env bash

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

GITHUB_REPO="terraform-docs/terraform-docs"
GITHUB_VERSION_LIST="$(curl -sSL -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/${GITHUB_REPO}/tags" | grep -oP '"name":\s*"v\K[0-9]+\.[0-9]+\.[0-9]+"' | tr -d '"' | sort -rV )"
GITHUB_LATEST="$(echo "${GITHUB_VERSION_LIST}" | head -n 1)"

if [ "${VERSION}" == "latest" ]; then
    VERSION=${GITHUB_LATEST}
fi


curl -L "https://github.com/${GITHUB_REPO}/releases/download/v${VERSION}/terraform-docs-v${VERSION}-linux-amd64.tar.gz" > terraform-docs.tgz
tar -xzf terraform-docs.tgz terraform-docs
rm terraform-docs.tgz
chmod +x terraform-docs
mv terraform-docs /usr/local/bin/

terraform-docs -v
