| RKE2 version| rke2-cilium | rke2-canal | rke2-calico | rke2-calico-crd | rke2-coredns | rke2-ingress-nginx | rke2-metrics-server | rancher-vsphere-csi | rancher-vsphere-cpi | harvester-cloud-provider | harvester-csi-driver | rke2-snapshot-controller | rke2-snapshot-controller-crd | rke2-snapshot-validation-webhook | Kubernetes | Etcd | Containerd | Runc | Metrics-server | CoreDNS | Ingress-Nginx | Helm-controller | Canal (Default) | Calico | Cilium | Multus  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.29.0+rke2r1 | [1.14.400](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-cilium/rke2-cilium-1.14.400.tgz) | [v3.26.3-build2023110900](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-canal/rke2-canal-v3.26.3-build2023110900.tgz) | [v3.26.300](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-v3.26.300.tgz) | [v3.26.300](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-crd-v3.26.300.tgz) | [1.24.007](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-coredns/rke2-coredns-1.24.007.tgz) | [4.8.200](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-ingress-nginx/rke2-ingress-nginx-4.8.200.tgz) | [2.11.100-build2023051511](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-metrics-server/rke2-metrics-server-2.11.100-build2023051511.tgz) | [3.0.1-rancher101](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-csi/rancher-vsphere-csi-3.0.1-rancher101.tgz) | [1.5.100](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-cpi/rancher-vsphere-cpi-1.5.100.tgz) | [0.2.200](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-cloud-provider-0.2.200.tgz) | [0.1.1600](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-csi-driver-0.1.1600.tgz) | [1.7.202](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-1.7.202.tgz) | [1.7.202](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-crd-1.7.202.tgz) | [1.7.302](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-validation-webhook/rke2-snapshot-validation-webhook-1.7.302.tgz) | [v1.29.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#v1290) | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) | [v1.7.11-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.11-k3s1) | [v1.1.10](https://github.com/opencontainers/runc/releases/tag/v1.1.10) | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [nginx-1.9.3-hardened1](https://github.com/rancher/ingress-nginx/releases/tag/nginx-1.9.3-hardened1) | [v0.15.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.4) | [Flannel v0.23.0](https://github.com/flannel-io/flannel/releases/tag/v0.23.0)<br/>[Calico v3.26.3](https://docs.tigera.io/calico/latest/release-notes/#v3.26) | [v3.26.3](https://docs.tigera.io/calico/latest/release-notes/#v3.26) | [v1.14.4](https://github.com/cilium/cilium/releases/tag/v1.14.4) | [v4.0.2](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v4.0.2)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.29.0+rke2r1](rke2-v1.29.md#release-v1290rke2r1) | Dec 22 2023 | 12/22/23 | 2023-12-22 | Dec 13 2023 | 12/13/23 | 2023-12-13 | 9 days |



# Release v1.29.0+rke2r1
<!-- v1.29.0+rke2r1 -->

This release is RKE2's first in the v1.29 line. This release updates Kubernetes to v1.29.0.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#urgent-upgrade-notes).

**Important Notes**
* The experimental `secrets-encrypt rotate-keys` command, used to perform an abbreviated rotation of secrets
  encryptions keys, has been removed from this release due to changes in the upstream implementation of
  configuration reloading. It will return in a subsequent release; see https://github.com/rancher/rke2/issues/5152
  for more information.

## Changes since v1.28.4+rke2r1:
* Bump k3s version for v1.29 ([#5153](https://github.com/rancher/rke2/pull/5153))
* Bump k3s and kubernetes versions for v1.29.0 ([#5144](https://github.com/rancher/rke2/pull/5144))
* ⚠️ added support for amazon linux 2023 (#4973) ([#4973](https://github.com/rancher/rke2/pull/4973))
* Bump containerd to v1.7.11 ([#5129](https://github.com/rancher/rke2/pull/5129))
* Bumped containerd/runc to v1.7.10/v1.1.10 ([#5117](https://github.com/rancher/rke2/pull/5117))
* Update stable channel to v1.26.11+rke2r1 ([#5099](https://github.com/rancher/rke2/pull/5099))

## Charts Versions
| Component                        | Version                                                                                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| rke2-cilium                      | [1.14.400](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-cilium/rke2-cilium-1.14.400.tgz)                                                 |
| rke2-canal                       | [v3.26.3-build2023110900](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-canal/rke2-canal-v3.26.3-build2023110900.tgz)                     |
| rke2-calico                      | [v3.26.300](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-v3.26.300.tgz)                                               |
| rke2-calico-crd                  | [v3.26.300](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-calico/rke2-calico-crd-v3.26.300.tgz)                                           |
| rke2-coredns                     | [1.24.007](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-coredns/rke2-coredns-1.24.007.tgz)                                               |
| rke2-ingress-nginx               | [4.8.200](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-ingress-nginx/rke2-ingress-nginx-4.8.200.tgz)                                     |
| rke2-metrics-server              | [2.11.100-build2023051511](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-metrics-server/rke2-metrics-server-2.11.100-build2023051511.tgz) |
| rancher-vsphere-csi              | [3.0.1-rancher101](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-csi/rancher-vsphere-csi-3.0.1-rancher101.tgz)                 |
| rancher-vsphere-cpi              | [1.5.100](https://github.com/rancher/rke2-charts/raw/main/assets/rancher-vsphere-cpi/rancher-vsphere-cpi-1.5.100.tgz)                                   |
| harvester-cloud-provider         | [0.2.200](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-cloud-provider-0.2.200.tgz)                         |
| harvester-csi-driver             | [0.1.1600](https://github.com/rancher/rke2-charts/raw/main/assets/harvester-cloud-provider/harvester-csi-driver-0.1.1600.tgz)                           |
| rke2-snapshot-controller         | [1.7.202](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-1.7.202.tgz)                         |
| rke2-snapshot-controller-crd     | [1.7.202](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-controller/rke2-snapshot-controller-crd-1.7.202.tgz)                     |
| rke2-snapshot-validation-webhook | [1.7.302](https://github.com/rancher/rke2-charts/raw/main/assets/rke2-snapshot-validation-webhook/rke2-snapshot-validation-webhook-1.7.302.tgz)         |


## Packaged Component Versions
| Component       | Version                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.29.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#v1290)    |
| Etcd            | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1)                               |
| Containerd      | [v1.7.11-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.11-k3s1)                       |
| Runc            | [v1.1.10](https://github.com/opencontainers/runc/releases/tag/v1.1.10)                               |
| Metrics-server  | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3)                      |
| CoreDNS         | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1)                                   |
| Ingress-Nginx   | [nginx-1.9.3-hardened1](https://github.com/rancher/ingress-nginx/releases/tag/nginx-1.9.3-hardened1) |
| Helm-controller | [v0.15.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.4)                            |

### Available CNIs
| Component       | Version                                                                                                                                                       | FIPS Compliant |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.23.0](https://github.com/flannel-io/flannel/releases/tag/v0.23.0)<br/>[Calico v3.26.3](https://docs.tigera.io/calico/latest/release-notes/#v3.26) | Yes            |
| Calico          | [v3.26.3](https://docs.tigera.io/calico/latest/release-notes/#v3.26)                                                                                          | No             |
| Cilium          | [v1.14.4](https://github.com/cilium/cilium/releases/tag/v1.14.4)                                                                                              | No             |
| Multus          | [v4.0.2](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v4.0.2)                                                                              | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
