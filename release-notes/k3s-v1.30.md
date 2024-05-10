| k3s version| Kubernetes | Kine | SQLite | Etcd | Containerd | Runc | Flannel | Metrics-server | Traefik | CoreDNS | Helm-controller | Local-path-provisioner  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.30.0+k3s1 | [v1.30.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md#v1300) | [v0.11.8](https://github.com/k3s-io/kine/releases/tag/v0.11.7) | [3.44.0](https://sqlite.org/releaselog/3_44_0.html) | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) | [v1.7.15-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.15-k3s1) | [v1.1.12](https://github.com/opencontainers/runc/releases/tag/v1.1.12) | [v0.24.2](https://github.com/flannel-io/flannel/releases/tag/v0.24.2) | [v0.7.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.0) | [v2.10.7](https://github.com/traefik/traefik/releases/tag/v2.10.7) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [v0.16.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.9) | [v0.0.26](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.26)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.30.0+k3s1](k3s-v1.30.md#release-v1300k3s1) | May 10 2024 | 05/10/24 | 2024-05-10 | Apr 17 2024 | 04/17/24 | 2024-04-17 | 23 days |



# Release v1.30.0+k3s1
<!-- v1.30.0+k3s1 -->


This release is K3S's first in the v1.30 line. This release updates Kubernetes to v1.30.0.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md#changelog-since-v1290).

## Changes since v1.29.4+k3s1:

* Kubernetes V1.30.0-k3s1 [(#10063)](https://github.com/k3s-io/k3s/pull/10063)
* Update stable channel to v1.29.4+k3s1 [(#10031)](https://github.com/k3s-io/k3s/pull/10031)
* Add E2E Split Server to Drone, support parrallel testing in Drone [(#9940)](https://github.com/k3s-io/k3s/pull/9940)
* Bump E2E opensuse leap to 15.6, fix btrfs test [(#10057)](https://github.com/k3s-io/k3s/pull/10057)
* Remove depracated `pod-infra-container-image` kubelet flag [(#7409)](https://github.com/k3s-io/k3s/pull/7409)
* Fix e2e tests [(#10061)](https://github.com/k3s-io/k3s/pull/10061)


## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.30.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md#v1300) |
| Kine | [v0.11.8](https://github.com/k3s-io/kine/releases/tag/v0.11.7) |
| SQLite | [3.44.0](https://sqlite.org/releaselog/3_44_0.html) |
| Etcd | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) |
| Containerd | [v1.7.15-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.15-k3s1) |
| Runc | [v1.1.12](https://github.com/opencontainers/runc/releases/tag/v1.1.12) |
| Flannel | [v0.24.2](https://github.com/flannel-io/flannel/releases/tag/v0.24.2) | 
| Metrics-server | [v0.7.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.0) |
| Traefik | [v2.10.7](https://github.com/traefik/traefik/releases/tag/v2.10.7) |
| CoreDNS | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | 
| Helm-controller | [v0.16.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.9) |
| Local-path-provisioner | [v0.0.26](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.26) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
