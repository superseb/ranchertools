| RKE2 version| Kubernetes | Etcd | Containerd | Runc | Metrics-server | CoreDNS | Ingress-Nginx | Helm-controller | Canal (Default) | Calico | Cilium | Multus  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.27.1+rke2r1 | [v1.27.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1271) | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1) | [v1.6.19-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.19-k3s1) | [v1.1.5](https://github.com/opencontainers/runc/releases/tag/v1.1.5) | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [4.5.2](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.5.2) | [v0.13.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.2) | [Flannel v0.21.3](https://github.com/k3s-io/flannel/releases/tag/v0.21.3)<br/>[Calico v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | [v1.13.0](https://github.com/cilium/cilium/releases/tag/v1.13.0) | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.27.1+rke2r1](rke2-v1.27.md#release-v1271rke2r1) | Apr 27 2023 | 04/27/23 | 2023-04-27 | Apr 14 2023 | 04/14/23 | 2023-04-14 | 13 days |



# Release v1.27.1+rke2r1
<!-- v1.27.1+rke2r1 -->

This release is RKE2's first in the v1.27 line. This release updates Kubernetes to v1.27.1.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#urgent-upgrade-notes).

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.26.4+rke2r1:
* Bump to kubernetes v1.27.1 ([#4108](https://github.com/rancher/rke2/pull/4108))

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.27.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1271) |
| Etcd            | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1)                            |
| Containerd      | [v1.6.19-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.19-k3s1)                    |
| Runc            | [v1.1.5](https://github.com/opencontainers/runc/releases/tag/v1.1.5)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1)                                |
| Ingress-Nginx   | [4.5.2](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.5.2)                |
| Helm-controller | [v0.13.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.2)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                 | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.21.3](https://github.com/k3s-io/flannel/releases/tag/v0.21.3)<br/>[Calico v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | Yes            |
| Calico          | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250)                                                                                      | No             |
| Cilium          | [v1.13.0](https://github.com/cilium/cilium/releases/tag/v1.13.0)                                                                                                        | No             |
| Multus          | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)                                                                                        | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
