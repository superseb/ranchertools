| RKE2 version| Kubernetes | Etcd | Containerd | Runc | Metrics-server | CoreDNS | Ingress-Nginx | Helm-controller | Canal (Default) | Calico | Cilium | Multus  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.27.2+rke2r1 | [v1.27.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1272) | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1) | [v1.7.1-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.1-k3s1) | [v1.1.7](https://github.com/opencontainers/runc/releases/tag/v1.1.7) | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [4.5.2](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.5.2) | [v0.14.0](https://github.com/k3s-io/helm-controller/releases/tag/v0.14.0) | [Flannel v0.21.3](https://github.com/k3s-io/flannel/releases/tag/v0.21.3)<br/>[Calico v3.25.1](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3251) | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | [v1.13.2](https://github.com/cilium/cilium/releases/tag/v1.13.2) | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)  |
| v1.27.1+rke2r1 | [v1.27.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1271) | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1) | [v1.6.19-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.19-k3s1) | [v1.1.5](https://github.com/opencontainers/runc/releases/tag/v1.1.5) | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [4.5.2](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.5.2) | [v0.13.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.2) | [Flannel v0.21.3](https://github.com/k3s-io/flannel/releases/tag/v0.21.3)<br/>[Calico v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | [v1.13.0](https://github.com/cilium/cilium/releases/tag/v1.13.0) | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.27.2+rke2r1](rke2-v1.27.md#release-v1272rke2r1) | May 30 2023 | 05/30/23 | 2023-05-30 | May 17 2023 | 05/17/23 | 2023-05-17 | 13 days |
| [v1.27.1+rke2r1](rke2-v1.27.md#release-v1271rke2r1) | Apr 27 2023 | 04/27/23 | 2023-04-27 | Apr 14 2023 | 04/14/23 | 2023-04-14 | 13 days |



# Release v1.27.2+rke2r1
<!-- v1.27.2+rke2r1 -->

This release updates Kubernetes to v1.27.2, and fixes a number of issues.

**Important Notes**

1. If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

2. Many systems have updated their packages with newer version of container-selinux (> v2.191.0) which is incompatible with our rke2-selinux policy and require a change in policy. We have updated our policy; you will notice the rke2-selinux package being upgraded from version v0.11.1 to newer version v0.12.0.

## Changes since v1.27.1+rke2r1:

* V1.27.2+rke2r1 [(#4261)](https://github.com/rancher/rke2/pull/4261)
* Update stable channel to v1.25.9+rke2r1 [(#4138)](https://github.com/rancher/rke2/pull/4138)
* Updating dev doc [(#3111)](https://github.com/rancher/rke2/pull/3111)
* Add dependabot [(#4133)](https://github.com/rancher/rke2/pull/4133)
* Add updatecli [(#4135)](https://github.com/rancher/rke2/pull/4135)
* Fix hardcoded file mount handling for default audit log filename [(#4139)](https://github.com/rancher/rke2/pull/4139)
* Add ability to have write custom files during TF tests for specialized configurations [(#4132)](https://github.com/rancher/rke2/pull/4132)
* Bump ubuntu from 20.04 to 22.04 [(#4154)](https://github.com/rancher/rke2/pull/4154)
* Add reviewers to dependabot PRs [(#4156)](https://github.com/rancher/rke2/pull/4156)
* Introduce updatecli to repo and validate basic functionality [(#4155)](https://github.com/rancher/rke2/pull/4155)
* Add label to dependabot PRs [(#4169)](https://github.com/rancher/rke2/pull/4169)
* Create 'upgrade traditional with workloads' test automated for RKE2 [(#4118)](https://github.com/rancher/rke2/pull/4118)
* Update Cilium to v1.13.2 [(#4170)](https://github.com/rancher/rke2/pull/4170)
* Fix drone dispatch step [(#4147)](https://github.com/rancher/rke2/pull/4147)
* Enable --with-node-id flag [(#4131)](https://github.com/rancher/rke2/pull/4131)
* Chore: replace `github.com/ghodss/yaml` with `sigs.k8s.io/yaml` [(#4163)](https://github.com/rancher/rke2/pull/4163)
* Remove Trivy install from Dockerfile [(#4187)](https://github.com/rancher/rke2/pull/4187)
* Move Drone dispatch pipeline [(#4202)](https://github.com/rancher/rke2/pull/4202)
* Bump K3s/containerd/runc versions [(#4210)](https://github.com/rancher/rke2/pull/4210)
  * The bundled containerd and runc versions have been bumped to v1.7.1-k3s1/v1.1.7
* Update Calico image on Canal [(#4214)](https://github.com/rancher/rke2/pull/4214)
* Upgrade docker/docker package [(#4225)](https://github.com/rancher/rke2/pull/4225)
* Add rke2-upgrade to image list [(#4237)](https://github.com/rancher/rke2/pull/4237)
* Bump metrics-server to v0.6.3 [(#4244)](https://github.com/rancher/rke2/pull/4244)
* Fix fapolicyd checks in install script [(#4249)](https://github.com/rancher/rke2/pull/4249)
* Bump vsphere csi/cpi and csi snapshot charts [(#4271)](https://github.com/rancher/rke2/pull/4271)
* Bump vsphere csi to remove duplicate CSI deployment. [(#4295)](https://github.com/rancher/rke2/pull/4295)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.27.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1272) |
| Etcd            | [v3.5.7-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.7-k3s1)                       |
| Containerd      | [v1.7.1-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.7.1-k3s1)                      |
| Runc            | [v1.1.7](https://github.com/opencontainers/runc/releases/tag/v1.1.7)                              |
| Metrics-server  | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3)                   |
| CoreDNS         | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1)                                  |
| Ingress-Nginx   | [4.5.2](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.5.2)                                  |
| Helm-controller | [v0.14.0](https://github.com/k3s-io/helm-controller/releases/tag/v0.14.0)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.21.3](https://github.com/k3s-io/flannel/releases/tag/v0.21.3)<br/>[Calico v3.25.1](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3251) | Yes            |
| Calico          | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250)                                                                    | No             |
| Cilium          | [v1.13.2](https://github.com/cilium/cilium/releases/tag/v1.13.2)                                                                                                                      | No             |
| Multus          | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)                                                                                                    | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
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
