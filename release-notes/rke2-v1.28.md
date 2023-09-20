| RKE2 version| Kubernetes | Etcd | Containerd | Runc | Metrics-server | CoreDNS | Ingress-Nginx | Helm-controller | Canal (Default) | Calico | Cilium | Multus  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.28.2+rke2r1 | [v1.28.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md#v1282) | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) | [v1.7.3-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.3-k3s1) | [v1.1.8](https://github.com/opencontainers/runc/releases/tag/v1.1.8) | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [4.6.1](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.6.1) | [v0.15.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.4) | [Flannel v0.22.1](https://github.com/flannel-io/flannel/releases/tag/v0.22.1)<br/>[Calico v3.26.1](https://docs.tigera.io/calico/latest/release-notes/#v3.26) | [v3.26.1](https://docs.tigera.io/calico/latest/release-notes/#v3.26) | [v1.14.1](https://github.com/cilium/cilium/releases/tag/v1.14.1) | [v4.0.2](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v4.0.2)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.28.2+rke2r1](rke2-v1.28.md#release-v1282rke2r1) | Sep 18 2023 | 09/18/23 | 2023-09-18 | Sep 13 2023 | 09/13/23 | 2023-09-13 | 5 days |



# Release v1.28.2+rke2r1
<!-- v1.28.2+rke2r1 -->

This release updates Kubernetes to v1.28.2.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.28.1+rke2r1:

* Support new generic "cis" profile [(#4708)](https://github.com/rancher/rke2/pull/4708)
* Update cilium to 1.14.1 [(#4755)](https://github.com/rancher/rke2/pull/4755)
* Update Kubernetes to v1.28.2 Go to v1.20.8 [(#4760)](https://github.com/rancher/rke2/pull/4760)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.28.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md#v1282) |
| Etcd            | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1)                            |
| Containerd      | [v1.7.3-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.3-k3s1)                      |
| Runc            | [v1.1.8](https://github.com/opencontainers/runc/releases/tag/v1.1.8)                              |
| Metrics-server  | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3)                   |
| CoreDNS         | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1)                                |
| Ingress-Nginx   | [4.6.1](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.6.1)                |
| Helm-controller | [v0.15.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.4)                         |

### Available CNIs
| Component       | Version                                                                                                                                                   | FIPS Compliant |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.22.1](https://github.com/flannel-io/flannel/releases/tag/v0.22.1)<br/>[Calico v3.26.1](https://docs.tigera.io/calico/latest/release-notes/#v3.26) | Yes            |
| Calico          | [v3.26.1](https://docs.tigera.io/calico/latest/release-notes/#v3.26)                                                                                      | No             |
| Cilium          | [v1.14.1](https://github.com/cilium/cilium/releases/tag/v1.14.1)                                                                                          | No             |
| Multus          | [v4.0.2](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v4.0.2)                                                                          | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
