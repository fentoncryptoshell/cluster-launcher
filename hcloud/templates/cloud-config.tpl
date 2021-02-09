#cloud-config
# vim: syntax=yaml

groups:
  - docker

users:
  - name: ${user.name}
    groups: users, admin, docker
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${user.key}

write_files:
  - path: /etc/sysctl.d/k8s.conf
    content: |
      net.bridge.bridge-nf-call-ip6tables = 1
      net.bridge.bridge-nf-call-iptables = 1

apt:
  sources:
    docker:
      source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
      keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88
    kubernetes:
      source: "deb http://apt.kubernetes.io/ kubernetes-xenial main"
      keyid: 54A647F9048D5688D7DA2ABE6A030B21BA07F4FB

package_update: true
package_upgrade: true
packages:
  - git
  - jq
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common
%{ for item in custom_packages ~}
  - ${item}
%{ endfor ~}

runcmd:
  - swapoff -a
  - sysctl --system
  - touch /home/${user.name}/cloud-init-has-finished