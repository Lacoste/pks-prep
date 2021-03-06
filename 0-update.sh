#!/bin/sh
#bdereims@vmware.com
#Only tested on Ubuntu 16.04/18.04 LTS

BINDIR=/usr/local/bin
BOSHRELEASE=3.0.1
HELMRELEASE=2.9.0
OMRELEASE=0.37.0

sudo apt-get update ; sudo apt-get upgrade
sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 sshpass jq dnsmasq iperf3

# uuac
sudo gem install cf-uaac

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo cp kubectl $BINDIR/kubectl
rm kubectl

# bosh
curl -LO https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSHRELEASE}-linux-amd64
sudo cp bosh-cli-${BOSHRELEASE}-linux-amd64 ${BINDIR}/bosh
sudo chmod ugo+x ${BINDIR}/bosh 
rm bosh-cli-${BOSHRELEASE}-linux-amd64

# om
curl -LO https://github.com/pivotal-cf/om/releases/download/${OMRELEASE}/om-linux
sudo chown root om-linux
sudo chmod ugo+x om-linux
sudo mv om-linux ${BINDIR}/om

# helm
curl -LO https://kubernetes-helm.storage.googleapis.com/helm-v${HELMRELEASE}-linux-amd64.tar.gz
tar xvzf helm-v${HELMRELEASE}-linux-amd64.tar.gz linux-amd64/helm
chmod +x linux-amd64/helm
sudo cp linux-amd64/helm ${BINDIR}/helm
rm -fr linux-amd64
rm helm-v${HELMRELEASE}-linux-amd64.tar.gz

# pks
sudo chown root:root pks
sudo chmod +x pks
sudo cp pks ${BINDIR}/pks
