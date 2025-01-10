| RKE2 version| rke2-cilium | rke2-canal | rke2-calico | rke2-calico-crd | rke2-coredns | rke2-ingress-nginx | rke2-metrics-server | rancher-vsphere-csi | rancher-vsphere-cpi | harvester-cloud-provider | harvester-csi-driver | rke2-snapshot-controller | rke2-snapshot-controller-crd | rke2-snapshot-validation-webhook | Kubernetes | Etcd | Containerd | Runc | Metrics-server | CoreDNS | Ingress-Nginx | Helm-controller | Canal (Default) | Calico | Cilium | Multus  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.32.0+rke2r1 | [1.16.400](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-cilium/rke2-cilium-1.16.400.tgz) | [v3.29.1-build2024121100](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-canal/rke2-canal-v3.29.1-build2024121100.tgz) | [v3.29.100](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-v3.29.100.tgz) | [v3.29.100](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-crd-v3.29.100.tgz) | [1.36.102](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-coredns/rke2-coredns-1.36.102.tgz) | [4.10.503](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-ingress-nginx/rke2-ingress-nginx-4.10.503.tgz) | [3.12.004](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-metrics-server/rke2-metrics-server-3.12.004.tgz) | [3.3.1-rancher800](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-csi/rancher-vsphere-csi-3.3.1-rancher800.tgz) | [1.10.000](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-cpi/rancher-vsphere-cpi-1.10.000.tgz) | [0.2.600](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-cloud-provider-0.2.600.tgz) | [0.1.2100](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-csi-driver-0.1.2100.tgz) | [3.0.601](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-3.0.601.tgz) | [3.0.601](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-crd-3.0.601.tgz) | [1.9.001](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-validation-webhook/rke2-snapshot-validation-webhook-1.9.001.tgz) | [v1.32.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md#v1320) | [v3.5.16-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.16-k3s1) | [v1.7.23-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.23-k3s2) | [v1.1.14](https://github.com/opencontainers/runc/releases/tag/v1.1.14) | [v0.7.1](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.1) | [v1.12.0](https://github.com/coredns/coredns/releases/tag/v1.12.0) | [v1.10.5-hardened6](https://github.com/rancher/ingress-nginx/releases/tag/v1.10.5-hardened6) | [v0.16.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.16.5) | [Flannel v0.26.1](https://github.com/flannel-io/flannel/releases/tag/v0.26.1)<br/>[Calico v3.29.1](https://docs.tigera.io/calico/latest/release-notes/#v3.29) | [v3.29.1](https://docs.tigera.io/calico/latest/release-notes/#v3.29) | [v1.16.4](https://github.com/cilium/cilium/releases/tag/v1.16.4) | [v4.1.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v4.1.3)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.32.0+rke2r1](rke2-v1.32.md#release-v1320rke2r1) | Jan 03 2025 | 01/03/25 | 2025-01-03 | Dec 11 2024 | 12/11/24 | 2024-12-11 | 23 days |



# Release v1.32.0+rke2r1
<!-- v1.32.0+rke2r1 -->

This release is RKE2's first in the v1.32 line. It updates Kubernetes to v1.32.0. 

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.31.4+rke2r1:

* Bump K3s version for release-1.32 [(#7445)](https://github.com/rancher/rke2/pull/7445)
* Validate single branch for tag [(#7451)](https://github.com/rancher/rke2/pull/7451)
* Update rke2-cloud-controller for v1.32.0 [(#7461)](https://github.com/rancher/rke2/pull/7461)


## Charts Versions
| Component | Version |
| --- | --- |
| rke2-cilium | [1.16.400](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-cilium/rke2-cilium-1.16.400.tgz) |
| rke2-canal | [v3.29.1-build2024121100](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-canal/rke2-canal-v3.29.1-build2024121100.tgz) |
| rke2-calico | [v3.29.100](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-v3.29.100.tgz) |
| rke2-calico-crd | [v3.29.100](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-crd-v3.29.100.tgz) |
| rke2-coredns | [1.36.102](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-coredns/rke2-coredns-1.36.102.tgz) |
| rke2-ingress-nginx | [4.10.503](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-ingress-nginx/rke2-ingress-nginx-4.10.503.tgz) |
| rke2-metrics-server | [3.12.004](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-metrics-server/rke2-metrics-server-3.12.004.tgz) |
| rancher-vsphere-csi | [3.3.1-rancher800](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-csi/rancher-vsphere-csi-3.3.1-rancher800.tgz) |
| rancher-vsphere-cpi | [1.10.000](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-cpi/rancher-vsphere-cpi-1.10.000.tgz) |
| harvester-cloud-provider | [0.2.600](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-cloud-provider-0.2.600.tgz) |
| harvester-csi-driver | [0.1.2100](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-csi-driver-0.1.2100.tgz) |
| rke2-snapshot-controller | [3.0.601](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-3.0.601.tgz) |
| rke2-snapshot-controller-crd | [3.0.601](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-crd-3.0.601.tgz) |
| rke2-snapshot-validation-webhook | [1.9.001](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-validation-webhook/rke2-snapshot-validation-webhook-1.9.001.tgz) |


## Packaged Component Versions
| Component | Version |
| --- | --- |
| Kubernetes | [v1.32.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md#v1320) |
| Etcd | [v3.5.16-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.16-k3s1) |
| Containerd | [v1.7.23-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.23-k3s2) |
| Runc | [v1.1.14](https://github.com/opencontainers/runc/releases/tag/v1.1.14) |
| Metrics-server | [v0.7.1](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.1) |
| CoreDNS | [v1.12.0](https://github.com/coredns/coredns/releases/tag/v1.12.0) |
| Ingress-Nginx | [v1.10.5-hardened6](https://github.com/rancher/ingress-nginx/releases/tag/v1.10.5-hardened6) |
| Helm-controller | [v0.16.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.16.5) |

### Available CNIs
| Component | Version | FIPS Compliant |
| --- | --- | --- |
| Canal (Default) | [Flannel v0.26.1](https://github.com/flannel-io/flannel/releases/tag/v0.26.1)<br/>[Calico v3.29.1](https://docs.tigera.io/calico/latest/release-notes/#v3.29) | Yes |
| Calico | [v3.29.1](https://docs.tigera.io/calico/latest/release-notes/#v3.29) | No |
| Cilium | [v1.16.4](https://github.com/cilium/cilium/releases/tag/v1.16.4) | No |
| Multus | [v4.1.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v4.1.3) | No |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
