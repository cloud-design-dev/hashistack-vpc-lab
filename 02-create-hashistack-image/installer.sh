#!/usr/bin/env bash
set -e

# Disable interactive apt prompts
export DEBIAN_FRONTEND=noninteractive

## Set base configuration for hashi-stack pieces
CONSULVERSION=1.12.0
CONSULDOWNLOAD="https://releases.hashicorp.com/consul/${CONSULVERSION}/consul_${CONSULVERSION}_linux_amd64.zip"
CONSULCONFIGDIR=/etc/consul.d
CONSULDIR=/opt/consul

VAULTVERSION=1.10.3
VAULTDOWNLOAD="https://releases.hashicorp.com/vault/${VAULTVERSION}/vault_${VAULTVERSION}_linux_amd64.zip"
VAULTCONFIGDIR=/etc/vault.d
VAULTDIR=/opt/vault

NOMADVERSION=1.3.1
NOMADDOWNLOAD="https://releases.hashicorp.com/nomad/${NOMADVERSION}/nomad_${NOMADVERSION}_linux_amd64.zip"
NOMADCONFIGDIR=/etc/nomad.d
NOMADDIR=/opt/nomad

CONSULTEMPLATEVERSION=0.28.1
CONSULTEMPLATEDOWNLOAD="https://releases.hashicorp.com/consul-template/${CONSULTEMPLATEVERSION}/consul-template_${CONSULTEMPLATEVERSION}_linux_amd64.zip"
CONSULTEMPLATECONFIGDIR=/etc/consul-template.d
CONSULTEMPLATEDIR=/opt/consul-template

install_system_packages() {
    # Install base system dependencies
    DEBIAN_FRONTEND=noninteractive apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -qqy upgrade
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install unzip tree python3-pip git curl build-essential jq wget python3-apt "linux-headers-$(uname -r)"
} 

# Install onsul
install_consul() {
    curl -L $CONSULDOWNLOAD > consul.zip

    ## Install Consul 
    unzip consul.zip -d /usr/local/bin
    chmod 0755 /usr/local/bin/consul
    chown root:root /usr/local/bin/consul

    ## Create Consul directories 
    mkdir -p $CONSULCONFIGDIR
    chmod 755 $CONSULCONFIGDIR
    mkdir -p $CONSULDIR
    chmod 755 $CONSULDIR
} 

# Install Vault
install_vault() {
    ## Download Vault binary 
    curl -L $VAULTDOWNLOAD > vault.zip

    ## Install Vault
    unzip vault.zip -d /usr/local/bin
    chmod 0755 /usr/local/bin/vault
    chown root:root /usr/local/bin/vault

    ## Create Vault directories
    mkdir -p $VAULTCONFIGDIR
    chmod 755 $VAULTCONFIGDIR
    mkdir -p $VAULTDIR
    chmod 755 $VAULTDIR
} 

# Install Nomad
install_nomad() {
    ## Download Nomad binary 
    curl -L $NOMADDOWNLOAD > nomad.zip

    ## Install Nomad
    unzip nomad.zip -d /usr/local/bin
    chmod 0755 /usr/local/bin/nomad
    chown root:root /usr/local/bin/nomad

    ## Create Nomad directories
    mkdir -p $NOMADCONFIGDIR
    chmod 755 $NOMADCONFIGDIR
    mkdir -p $NOMADDIR
    chmod 755 $NOMADDIR
} 

install_consul_template() {
    ## Download Consul Template binary 
    curl -L $CONSULTEMPLATEDOWNLOAD > consul-template.zip

    ## Install Consul Template
    unzip consul-template.zip -d /usr/local/bin
    chmod 0755 /usr/local/bin/consul-template
    chown root:root /usr/local/bin/consul-template

    ## Create Consul Template directories
    mkdir -p $CONSULTEMPLATECONFIGDIR
    chmod 755 $CONSULTEMPLATECONFIGDIR
    mkdir -p $CONSULTEMPLATEDIR
    chmod 755 $CONSULTEMPLATEDIR
} 

install_system_packages
install_consul
install_vault
install_nomad
install_consul_template