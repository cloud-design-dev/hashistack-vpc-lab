#!/usr/bin/env bash
set -e

mkdir -p /opt/vault/raft/data

install_system_packages() {
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    DEBIAN_FRONTEND=noninteractive apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -qqy upgrade
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install unzip tree python3-pip git vault consul nomad curl build-essential jq wget linux-headers-$(uname -r)
} 

install_consul_template() {
    CONSULTEMPLATEVERSION=0.28.1
    CONSULTEMPLATEDOWNLOAD="https://releases.hashicorp.com/consul-template/${CONSULTEMPLATEVERSION}/consul-template_${CONSULTEMPLATEVERSION}_linux_amd64.zip"
    CONSULTEMPLATECONFIGDIR=/etc/consul-template.d
    CONSULTEMPLATEDIR=/opt/consul-template

    curl -L $CONSULTEMPLATEDOWNLOAD > consul-template.zip

    unzip consul-template.zip -d /usr/local/bin
    chmod 0755 /usr/local/bin/consul-template
    chown root:root /usr/local/bin/consul-template

    mkdir -p $CONSULTEMPLATECONFIGDIR
    chmod 755 $CONSULTEMPLATECONFIGDIR
    mkdir -p $CONSULTEMPLATEDIR
    chmod 755 $CONSULTEMPLATEDIR
} 

install_system_packages
install_consul_template
