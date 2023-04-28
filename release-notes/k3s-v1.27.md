| k3s version| Kubernetes | Kine | SQLite | Etcd | Containerd | Runc | Flannel | Metrics-server | Traefik | CoreDNS | Helm-controller | Local-path-provisioner  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.27.1+k3s1 | [v1.27.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1271) | [v0.9.9](https://github.com/k3s-io/kine/releases/tag/v0.9.9) | [3.39.2](https://sqlite.org/releaselog/3_39_2.html) | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1) | [v1.6.19-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.19-k3s1) | [v1.1.5](https://github.com/opencontainers/runc/releases/tag/v1.1.5) | [v0.21.4](https://github.com/flannel-io/flannel/releases/tag/v0.21.4) | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) | [v2.9.4](https://github.com/traefik/traefik/releases/tag/v2.9.4) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [v0.13.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.3) | [v0.0.24](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.24)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.27.1+k3s1](k3s-v1.27.md#release-v1271k3s1) | Apr 27 2023 | 04/27/23 | 2023-04-27 | Apr 14 2023 | 04/14/23 | 2023-04-14 | 13 days |



# Release v1.27.1+k3s1
<!-- v1.27.1+k3s1 -->
This release is K3S's first in the v1.27 line. This release updates Kubernetes to v1.27.1.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#urgent-upgrade-notes).

## Changes since v1.26.4+k3s1:

* Kubernetes 1.27.1 [(#7271)](https://github.com/k3s-io/k3s/pull/7271)
* V1.27.1 CLI Deprecation [(#7311)](https://github.com/k3s-io/k3s/pull/7311)
  * `--flannel-backed=wireguard` has been completely replaced with `--flannel-backend=wireguard-native`
  * The `k3s etcd-snapshot` command will now print a help message, to save a snapshot use: `k3s etcd-snapshot save`
  * The following flags will now cause fatal errors (with full removal coming in v1.28.0):
    * `--flannel-backed=ipsec`: replaced with `--flannel-backend=wireguard-native` [see docs for more info.](https://docs.k3s.io/installation/network-options#migrating-from-wireguard-or-ipsec-to-wireguard-native)
    * Supplying multiple `--flannel-backend` values is no longer valid. Use `--flannel-conf` instead.
* Changed command -v redirection for iptables bin check [(#7315)](https://github.com/k3s-io/k3s/pull/7315)
* Update channel server for april 2023 [(#7327)](https://github.com/k3s-io/k3s/pull/7327)
* Bump cri-dockerd [(#7347)](https://github.com/k3s-io/k3s/pull/7347)
* Cleanup help messages [(#7369)](https://github.com/k3s-io/k3s/pull/7369)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.27.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1271) |
| Kine | [v0.9.9](https://github.com/k3s-io/kine/releases/tag/v0.9.9) |
| SQLite | [3.39.2](https://sqlite.org/releaselog/3_39_2.html) |
| Etcd | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1) |
| Containerd | [v1.6.19-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.19-k3s1) |
| Runc | [v1.1.5](https://github.com/opencontainers/runc/releases/tag/v1.1.5) |
| Flannel | [v0.21.4](https://github.com/flannel-io/flannel/releases/tag/v0.21.4) | 
| Metrics-server | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) |
| Traefik | [v2.9.4](https://github.com/traefik/traefik/releases/tag/v2.9.4) |
| CoreDNS | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | 
| Helm-controller | [v0.13.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.3) |
| Local-path-provisioner | [v0.0.24](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.24) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
