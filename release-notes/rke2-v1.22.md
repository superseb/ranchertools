| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.22.17+rke2r1](rke2-v1.22.md#release-v12217rke2r1) | Dec 20 2022 | 12/20/22 | 2022-12-20 |
| [v1.22.16+rke2r1](rke2-v1.22.md#release-v12216rke2r1) | Nov 18 2022 | 11/18/22 | 2022-11-18 |
| [v1.22.15+rke2r2](rke2-v1.22.md#release-v12215rke2r2) | Oct 13 2022 | 10/13/22 | 2022-10-13 |
| [v1.22.15+rke2r1](rke2-v1.22.md#release-v12215rke2r1) | Sep 27 2022 | 09/27/22 | 2022-09-27 |
| [v1.22.13+rke2r1](rke2-v1.22.md#release-v12213rke2r1) | Aug 26 2022 | 08/26/22 | 2022-08-26 |
| [v1.22.12+rke2r1](rke2-v1.22.md#release-v12212rke2r1) | Jul 21 2022 | 07/21/22 | 2022-07-21 |
| [v1.22.11+rke2r1](rke2-v1.22.md#release-v12211rke2r1) | Jul 05 2022 | 07/05/22 | 2022-07-05 |
| [v1.22.10+rke2r2](rke2-v1.22.md#release-v12210rke2r2) | Jun 13 2022 | 06/13/22 | 2022-06-13 |
| [v1.22.9+rke2r2](rke2-v1.22.md#release-v1229rke2r2) | May 05 2022 | 05/05/22 | 2022-05-05 |
| [v1.22.9+rke2r1](rke2-v1.22.md#release-v1229rke2r1) | Apr 28 2022 | 04/28/22 | 2022-04-28 |
| [v1.22.8+rke2r1](rke2-v1.22.md#release-v1228rke2r1) | Mar 31 2022 | 03/31/22 | 2022-03-31 |
| [v1.22.7+rke2r2](rke2-v1.22.md#release-v1227rke2r2) | Mar 14 2022 | 03/14/22 | 2022-03-14 |
| [v1.22.7+rke2r1](rke2-v1.22.md#release-v1227rke2r1) | Feb 23 2022 | 02/23/22 | 2022-02-23 |
| [v1.22.6+rke2r1](rke2-v1.22.md#release-v1226rke2r1) | Jan 26 2022 | 01/26/22 | 2022-01-26 |
| [v1.22.5+rke2r2](rke2-v1.22.md#release-v1225rke2r2) | Jan 11 2022 | 01/11/22 | 2022-01-11 |
| [v1.22.5+rke2r1](rke2-v1.22.md#release-v1225rke2r1) | Dec 23 2021 | 12/23/21 | 2021-12-23 |
| [v1.22.4+rke2r2](rke2-v1.22.md#release-v1224rke2r2) | Dec 06 2021 | 12/06/21 | 2021-12-06 |
| [v1.22.4+rke2r1](rke2-v1.22.md#release-v1224rke2r1) | Dec 02 2021 | 12/02/21 | 2021-12-02 |
| [v1.22.3+rke2r1](rke2-v1.22.md#release-v1223rke2r1) | Nov 06 2021 | 11/06/21 | 2021-11-06 |



# Release v1.22.17+rke2r1
<!-- v1.22.17+rke2r1 -->

This release updates Kubernetes to v1.22.17 to backport registry changes and fix two critical issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.16+rke2r1:

* Update to use aws [(#3668)](https://github.com/rancher/rke2/pull/3668)
* Update to version 1.22.17 [(#3657)](https://github.com/rancher/rke2/pull/3657)
* Update Cilium to 1.12.3 and use portmap as default [(#3681)](https://github.com/rancher/rke2/pull/3681)
* Bump K3s and containerd versions for v1.22 [(#3678)](https://github.com/rancher/rke2/pull/3678)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.17](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12217) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.16-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.12.3](https://github.com/cilium/cilium/releases/tag/v1.12.3)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.17+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.16+rke2r1
<!-- v1.22.16+rke2r1 -->

This release updates Kubernetes to v1.22.16 to address the following vulnerabilities:

CVE-2022-3162: Unauthorized read of Custom Resources
A security issue was discovered in Kubernetes where users authorized to list or watch one type of namespaced custom resource cluster-wide can read custom resources of a different type in the same API group they are not authorized to read.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.15+rke2r2:

* Update to November 1.22.16 [(#3549)](https://github.com/rancher/rke2/pull/3549)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.16](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12216) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.12.1](https://github.com/cilium/cilium/releases/tag/v1.12.1)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.16+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.15+rke2r2
<!-- v1.22.15+rke2r2 -->

This release updates Canal to v3.24.1 to address a critical bug fix.

## Changes since v1.22.15+rke2r1:

* Update canal to v3.24.1 [(#3450)](https://github.com/rancher/rke2/pull/3450)


## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12215) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.12.1](https://github.com/cilium/cilium/releases/tag/v1.12.1)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.15+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.15+rke2r1
<!-- v1.22.15+rke2r1 -->

This release updates Kubernetes to v1.22.15, fixes a number of minor issues, and includes security updates.
**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.13+rke2r1:

* [Release 1.22] Update Cilium version [(#3281)](https://github.com/rancher/rke2/pull/3281)
* [Release 1.22] Bump the cilium chart version [(#3294)](https://github.com/rancher/rke2/pull/3294)
* [Release 1.22] Update canal version [(#3287)](https://github.com/rancher/rke2/pull/3287)
* The bundled version of runc has been bumped to v1.1.4 [(#3303)](https://github.com/rancher/rke2/pull/3303)
* update to latest 1.22 patch [(#3349)](https://github.com/rancher/rke2/pull/3349)
* Update k8s to 1.22.15 [(#3372)](https://github.com/rancher/rke2/pull/3372)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12215) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.12.1](https://github.com/cilium/cilium/releases/tag/v1.12.1)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.15+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.13+rke2r1
<!-- v1.22.13+rke2r1 -->

This release updates Kubernetes to v1.22.13, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.12+rke2r1:

* [Backport release-1.22] Update cilium to v1.12.0 [(#3190)](https://github.com/rancher/rke2/pull/3190)
* [Release-1.22] Bump K3s and remotedialer  [(#3212)](https://github.com/rancher/rke2/pull/3212)
* [Release-1.22] Add ingress network policy [(#3223)](https://github.com/rancher/rke2/pull/3223)
* [Release-1.22] Use container-runtime-endpoint flag for criConnection [(#3236)](https://github.com/rancher/rke2/pull/3236)
* Convert codespell from Drone to GH actions (#3246) [(#3249)](https://github.com/rancher/rke2/pull/3249)
* August release [(#3252)](https://github.com/rancher/rke2/pull/3252)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.13](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12213) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.2](https://github.com/opencontainers/runc/releases/tag/v1.1.2)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.22.2](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3222) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.12.0](https://github.com/cilium/cilium/releases/tag/v1.12.0)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.13+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.12+rke2r1
<!-- v1.22.12+rke2r1 -->

This release updates Kubernetes to v1.22.12, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.11+rke2r1:

* [Release-1.22] Bump ingress-nginx to 4.1.004 [(#3133)](https://github.com/rancher/rke2/pull/3133)
* [Release-1.22]Bump harvester cloud provider 0.1.13 [(#3140)](https://github.com/rancher/rke2/pull/3140)
* July release 1.22 r1 [(#3150)](https://github.com/rancher/rke2/pull/3150)
* [Release-1.22] Bump CRI timeout to 34 minutes [(#3160)](https://github.com/rancher/rke2/pull/3160)
* [Release-1.22] Consolidate staticPod timeout to static 30 minutes [(#3170)](https://github.com/rancher/rke2/pull/3170)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.12](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12212) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.2](https://github.com/opencontainers/runc/releases/tag/v1.1.2)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.22.2](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v32222) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.11.5](https://github.com/cilium/cilium/releases/tag/v1.11.5)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.12+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.11+rke2r1
<!-- v1.22.11+rke2r1 -->

This release updates Kubernetes to v1.22.11, fixes a number of minor issues, and includes security updates.

**Important Notes**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.10+rke2r2:

* Remove kube-ipvs0 interface when cleaning up [(#3052)](https://github.com/rancher/rke2/pull/3052)
* Add Static Pod Startup Hook + K3s Bump + CoreDNS bump [(#3062)](https://github.com/rancher/rke2/pull/3062)
* Updated cilium chart to support IPv6 only config [(#3071)](https://github.com/rancher/rke2/pull/3071)
* Update multus charts to v3.8-build2021110403 [(#3046)](https://github.com/rancher/rke2/pull/3046)
* Use serializable health checks for etcd probes [(#3075)](https://github.com/rancher/rke2/pull/3075)
* Bump K3s and helm-controller versions [(#3081)](https://github.com/rancher/rke2/pull/3081)
* June release 1.22 [(#3086)](https://github.com/rancher/rke2/pull/3086)
* Double number of steps for criBackoff
* Bump K3s version for cluster upgrade egress-selector-mode fix [(#3123)](https://github.com/rancher/rke2/pull/3123)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12211) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.2](https://github.com/opencontainers/runc/releases/tag/v1.1.2)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.22.2](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3222) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.11.5](https://github.com/cilium/cilium/releases/tag/v1.11.5)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.11+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.10+rke2r2
<!-- v1.22.10+rke2r2 -->

This release updates Kubernetes to v1.22.10, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.9+rke2r2:

* [Release 1.22] Updating the vSphere CPI chart version. [(#2870)](https://github.com/rancher/rke2/pull/2870)
* [Release 1.22] Update Cilium version [(#2876)](https://github.com/rancher/rke2/pull/2876)
* [Release 1.22] Update Calico in 1.22 [(#2888)](https://github.com/rancher/rke2/pull/2888)
* [Release 1.22] Updated canal to 3.22.2 [(#2910)](https://github.com/rancher/rke2/pull/2910)
* Update calico to newest version to fix bug [(#2902)](https://github.com/rancher/rke2/pull/2902)
* [Release 1.22] Update multus to the latest chart version [(#2923)](https://github.com/rancher/rke2/pull/2923)
* [Release 1.22] Move windows dependencies check to CI (#2880) [(#2916)](https://github.com/rancher/rke2/pull/2916)
* [Release 1.22] Support dev rpm creation and installation [(#2937)](https://github.com/rancher/rke2/pull/2937)
* [Release 1.22] Ignore windows binaries when creating linux bundle [(#2946)](https://github.com/rancher/rke2/pull/2946)
* [Release 1.22] Fixed IPv6 only support [(#2956)](https://github.com/rancher/rke2/pull/2956)
* [Release 1.22] Bump k3s and etcd [(#2856)](https://github.com/rancher/rke2/pull/2856)
* [Release 1.22] Fixed canal chart for IPv6 only setup [(#2976)](https://github.com/rancher/rke2/pull/2976)
* [Release 1.22] Update Cilium to 1.11.5 [(#2975)](https://github.com/rancher/rke2/pull/2975)
* Upgrade kubernetes to v1.22.10 [(#2993)](https://github.com/rancher/rke2/pull/2993)
* [Release 1.22] Disable egress-selector for calico/multus/none [(#3014)](https://github.com/rancher/rke2/pull/3014)
* [Release 1.22] Bump containerd, runc, k3s [(#3021)](https://github.com/rancher/rke2/pull/3021)
* [Release 1.22] Remove cni-based egress-selector config and bump k3s [(#3027)](https://github.com/rancher/rke2/pull/3027)
* May release v1.22.10+rke2r2 [(#3031)](https://github.com/rancher/rke2/pull/3031)
* [Release 1.22] Unconditionally set egress-selector-mode to disabled [(#3037)](https://github.com/rancher/rke2/pull/3037)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12210) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.2](https://github.com/opencontainers/runc/releases/tag/v1.1.2)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.22.2](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3222) | Yes            |
| Calico          | [v3.21.5](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3215)                                                                    | No             |
| Cilium          | [v1.11.5](https://github.com/cilium/cilium/releases/tag/v1.11.5)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.10+rke2r2
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.9+rke2r2
<!-- v1.22.9+rke2r2 -->

This release updates a number of RKE2 components to address and resolve some minor issues identified on `v1.22.9+rke2r1` release.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.9+rke2r1:

* Bump rke2-ingress-nginx to remove accidentally committed .orig files [(#2842)](https://github.com/rancher/rke2/pull/2842)
* Bump dynamiclistener to fix apiserver outage issue [(#2846)](https://github.com/rancher/rke2/pull/2846)
* update Kubernetes to 1.22.9 r2 [(#2831)](https://github.com/rancher/rke2/pull/2831)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1229) |
| Etcd            | [v3.5.3-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.3-k3s1)                       |
| Containerd      | [v1.5.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.11-k3s2)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3214) | Yes            |
| Calico          | [v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3214)                                                                    | No             |
| Cilium          | [v1.11.2](https://github.com/cilium/cilium/releases/tag/v1.11.2)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#2858](https://github.com/rancher/rke2/issues/2858) - Cannot join nodes back after cluster-reset when not restoring from snapshot
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.9+rke2r2
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.9+rke2r1
<!-- v1.22.9+rke2r1 -->

This release updates Kubernetes to v1.22.9, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.8+rke2r1:

* Fix windows dev images to include proper runtime tag  [(#2734)](https://github.com/rancher/rke2/pull/2734)
* Add message in the killall script [(#2742)](https://github.com/rancher/rke2/pull/2742)
* Update cilium to support automatic dual-stack config [(#2748)](https://github.com/rancher/rke2/pull/2748)
* vSphere Chart Updates [(#2759)](https://github.com/rancher/rke2/pull/2759)
* Bump harvester cloud provider 0.1.11 [(#2767)](https://github.com/rancher/rke2/pull/2767)
* Bump containerd to v1.5.11-k3s1 [(#2769)](https://github.com/rancher/rke2/pull/2769)
* Bump Harvester csi to v0.1.11 [(#2779)](https://github.com/rancher/rke2/pull/2779)
* Bump etcd to v3.5.3-k3s1 [(#2764)](https://github.com/rancher/rke2/pull/2764)
* Remove kube-proxy static pod manifest when --disable-kube-proxy is set [(#2786)](https://github.com/rancher/rke2/pull/2786)
* Update k8s to v1.22.9 [(#2795)](https://github.com/rancher/rke2/pull/2795)
* Secrets-encrypt backports [(#2798)](https://github.com/rancher/rke2/pull/2798)
* Remove failure:ignore tag for s390x pipeline [(#2791)](https://github.com/rancher/rke2/pull/2791)
* Revert "[Release-1.22] Remove failure:ignore tag for s390x pipeline" [(#2802)](https://github.com/rancher/rke2/pull/2802)
* Also inject system-default-registry as global.cattle.systemDefaultRegistry [(#2806)](https://github.com/rancher/rke2/pull/2806)
* Bump k3s for April Fixes [(#2813)](https://github.com/rancher/rke2/pull/2813)
* Bump containerd for selinux fix [(#2821)](https://github.com/rancher/rke2/pull/2821)
* Upgrade ingress nginx chart and images [(#2825)](https://github.com/rancher/rke2/pull/2825)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1229) |
| Etcd            | [v3.5.3-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.3)                          |
| Containerd      | [v1.5.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.11-k3s2)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3214) | Yes            |
| Calico          | [v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3214)                                                                    | No             |
| Cilium          | [v1.11.2](https://github.com/cilium/cilium/releases/tag/v1.11.2)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.9+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.8+rke2r1
<!-- v1.22.8+rke2r1 -->

This release updates Kubernetes to v1.22.8, fixes a number of minor issues, and includes security updates.

### Important Note
#### This release includes a breaking change to how Cilium helm chart values are customized.
Previously, the cilium CNI was bundled as a subchart of the rke2-cilium chart, and all chart values were nested under the top-level `cilium` key within the `valuesContent` section. As of this release, the subchart has been removed and nesting is no longer necessary. Chart values should be placed directly within the `valuesContent` section.
For example, if you previously had:
```yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-cilium
  namespace: kube-system
spec:
  valuesContent: |-
    cilium:
      ipv6:
        enabled: true

```
That should be converted to:
```yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-cilium
  namespace: kube-system
spec:
  valuesContent: |-
    ipv6:
      enabled: true

```

#### Cluster Join Token
If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.7+rke2r2:

* Update Cilium to 1.11.2 [(#2609)](https://github.com/rancher/rke2/pull/2609)
* bump containerd to 1.5.10 for windows, rm wins/flannel [(#2612)](https://github.com/rancher/rke2/pull/2612)
* Update CentOS 8 smoke vm's with vault repositories [(#2613)](https://github.com/rancher/rke2/pull/2613)
* Bump containerd to v1.5.10-k3s1 [(#2568)](https://github.com/rancher/rke2/pull/2568)
* Explicitly retag runtime for linux and windows [(#2617)](https://github.com/rancher/rke2/pull/2617)
* - Add s390x support [(#2618)](https://github.com/rancher/rke2/pull/2618)
* Fix canal bug [(#2634)](https://github.com/rancher/rke2/pull/2634)
* Add force-restart file when cluster-reset-restore-path is passed [(#2657)](https://github.com/rancher/rke2/pull/2657)
* Bump coredns to 1.9.1 [(#2655)](https://github.com/rancher/rke2/pull/2655)
* Update K3s and helm-controller [(#2660)](https://github.com/rancher/rke2/pull/2660)
* March release v1.22.8 [(#2641)](https://github.com/rancher/rke2/pull/2641)
* Revert "[Release-1.22] Explicitly retag runtime for linux and windows" [(#2666)](https://github.com/rancher/rke2/pull/2666)
* hardcode linker flag for windows runtime image [(#2669)](https://github.com/rancher/rke2/pull/2669)
* Update nginx from hardened2 to hardened4 [(#2674)](https://github.com/rancher/rke2/pull/2674)
* Fix uninstall script in SLES systems [(#2693)](https://github.com/rancher/rke2/pull/2693)
* Bump K3s version for v1.22 [(#2688)](https://github.com/rancher/rke2/pull/2688)
* k3s pin for containerd npipe fix + calico panic fix [(#2701)](https://github.com/rancher/rke2/pull/2701)
* Cilium update brings an important change in how the helm chart is consumed when a user wants to set some customized values via helmChartConfig. Please see [this link for more details](https://github.com/rancherlabs/release-notes/pull/232#issuecomment-1087171935)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1228) |
| Etcd            | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1)                          |
| Containerd      | [v1.5.10-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.10-k3s1)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1)                                  |
| Ingress-Nginx   | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3)                                  |
| Helm-controller | [v0.12.0](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.0)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3214) | Yes            |
| Calico          | [v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.21/release-notes/#v3214)                                                                                                                      | No             |
| Cilium          | [v1.11.2](https://github.com/cilium/cilium/releases/tag/v1.11.2)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- The etcd maintainers have recommended against the use of etcd 3.5.0-3.5.2 for new production workloads, due to a recently discovered bug that may cause data loss when etcd is killed under high load. [Please see this link for more details.](https://forums.rancher.com/t/rancher-kubernetes-distributions-and-etcd-3-5-updates/37485)

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.8+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.


-----
# Release v1.22.7+rke2r2

-----
# Release v1.22.7+rke2r1
<!-- v1.22.7+rke2r1 -->

This release updates Kubernetes to v1.22.7, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.7+rke2r1:

* [release 1.22] Fix a typo in the meta-data endpoint [(#2422)](https://github.com/rancher/rke2/pull/2422)
* [Release 1.22] Upgrade calico [(#2433)](https://github.com/rancher/rke2/pull/2433)
* [release-1.22] Wait for CRI service to become available before starting temp kubelet [(#2395)](https://github.com/rancher/rke2/pull/2395)
* [Release 1.22] Update canal to newer chart with bugfix [(#2429)](https://github.com/rancher/rke2/pull/2429)
* [Release 1.22] Update canal to v3.21.4 [(#2452)](https://github.com/rancher/rke2/pull/2452)
* Add seccomp annotations to unrestricted PSP (#2440) [(#2450)](https://github.com/rancher/rke2/pull/2450)
* [release-1.22] Helm Chart improvements [(#2458)](https://github.com/rancher/rke2/pull/2458)
* Fixed a regression that prevented `--disable` from removing previously installed components. [(#2472)](https://github.com/rancher/rke2/pull/2472)
* Update Kubernetes to v1.22.7 [(#2494)](https://github.com/rancher/rke2/pull/2494)
* [v1.22] Pin Calico to v3.21.4 for windows [(#2499)](https://github.com/rancher/rke2/pull/2499)


## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1227) |
| Etcd            | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1)                          |
| Containerd      | [v1.5.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.9-k3s1)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| CNI Plugins     | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1)                      |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5)                                  |
| Ingress-Nginx   | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases)                                  |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.16.1-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.16.1-rancher1)<br/>[Calico v3.21.4](https://docs.projectcalico.org/archive/v3.21/release-notes/#v3214) | Yes            |
| Calico          | [v3.21.4](https://docs.projectcalico.org/release-notes/#v3192)                                                                                                                      | No             |
| Cilium          | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.7+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

Currently an [issue](https://github.com/rancher/windows/issues/161) is preventing the airgap install on Windows from starting properly. A workaround is to pass `--runtime-image=rancher/rke2-runtime:<VERSION>-windows-amd64` as an additonal flag or add `runtime-image: rancher/rke2-runtime:<VERSION>-windows-amd64` to the config.yaml.

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.6+rke2r1
<!-- v1.22.6+rke2r1 -->

This release updates Kubernetes to v1.22.6, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.22.5+rke2r2:

* [release-1.22] Update canal chart [(#2358)](https://github.com/rancher/rke2/pull/2358)
* [release-1.22] Update etcd, containerd, and k3s [(#2367)](https://github.com/rancher/rke2/pull/2367)
* [release-1.22] Update RKE2 k8s version for January release [(#2374)](https://github.com/rancher/rke2/pull/2374)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.22.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1226) |
| Etcd            | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1)                            |
| Containerd      | [v1.5.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.9-k3s1)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| CNI Plugins     | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1)                      |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5)                                  |
| Ingress-Nginx   | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases)                                     |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.16.1-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.16.1-rancher1)<br/>[Calico v3.20.201](https://docs.projectcalico.org/archive/v3.20/release-notes/#v320201) | Yes            |
| Calico          | [v3.20.201](https://docs.projectcalico.org/release-notes/#v320201)                                                                                                                      | No             |
| Cilium          | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.6+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.5+rke2r2
<!-- v1.22.5+rke2r2 -->
This release fixes several issues, including an issue with the --agent-token flag that could prevent servers from joining managed etcd clusters when this flag was used.
<!--
This release updates Kubernetes to v1.22.5, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.21.md#changelog-since-v1224).
-->

## Known Issues
- [#2309](https://github.com/rancher/rke2/issues/2309) - The default cluster CIDR cannot be changed when using the Canal CNI plugin. This will be fixed in a subsequent release. If you use a custom cluster-cidr, you should apply the following HelmChartConfig:

```yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-canal
  namespace: kube-system
spec:
  valuesContent: |-
    podCidr: $YOUR_CLUSTER_CIDR
```
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.3+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Changes since v1.22.5+rke2r1:
* Bump versions for v1.22.5-rc1+rke2r2 ([#2332](https://github.com/rancher/rke2/pull/2332))
<!-- https://github.com/rancher/rke2/compare/v1.22.5+rke2r1...v1.22.5+rke2r2 -->

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1225) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s2) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8) |

### Available CNIs
| Component | Version | FIPS Compliant |
|---|---|---|
| Canal (Default) | [Flannel v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1)<br/>[Calico v3.20.2](https://docs.projectcalico.org/archive/v3.20/release-notes/#v3201)  | Yes |
| Calico | [v3.20.2](https://docs.projectcalico.org/release-notes/#v3202) | No |
| Cilium | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4) | No |
| Multus | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1) | No |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.5+rke2r1
<!-- v1.22.5+rke2r1 -->
This release updates Kubernetes to v1.22.5, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.21.md#changelog-since-v1224).

## Known Issues
* [#2323](https://github.com/rancher/rke2/issues/2323): When using embedded etcd and the initial server is started with --agent-token, and this agent-only token does not match the server --token value, additional servers cannot join the cluster. This will be fixed in a subsequent release.
* [#1447](https://github.com/rancher/rke2/issues/1447): When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.3+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Changes since v1.22.4+rke2r2:
* Update wharfie for tar path separator fix ([#2302](https://github.com/rancher/rke2/pull/2302))
* Bump versions for v1.22.5-rc3+rke2r1 ([#2297](https://github.com/rancher/rke2/pull/2297))
* Add check for etcd group ([#2290](https://github.com/rancher/rke2/pull/2290))
* Bump RKE2 to v1.22.5-rc2+rke2r1 ([#2284](https://github.com/rancher/rke2/pull/2284))
* Bump RKE2 to v1.22.5-rc1+rke2r1 ([#2281](https://github.com/rancher/rke2/pull/2281))
* Update K3s to fix cold restart issue ([#2276](https://github.com/rancher/rke2/pull/2276))
* Bump harvester cloud provider and harvester csi driver ([#2268](https://github.com/rancher/rke2/pull/2268))
* Bump K3s in master ([#2266](https://github.com/rancher/rke2/pull/2266))
* Bump minimum requirements for RKE2 to reasonable minimums ([#2267](https://github.com/rancher/rke2/pull/2267))
* Bump RKE2 to v1.22.4-rc1+rke2r3 ([#2255](https://github.com/rancher/rke2/pull/2255))
* Add startup hook to watch/delete static pods on node delete ([#2249](https://github.com/rancher/rke2/pull/2249))
* Bump k3s and related modules ([#2239](https://github.com/rancher/rke2/pull/2239))
* Bump multus image tags to match build2021111906 chart version ([#2237](https://github.com/rancher/rke2/pull/2237))
* Secrets Encryption CLI: key rotation and enable/disable ([#2234](https://github.com/rancher/rke2/pull/2234))
* Always fetch the latest uninstall and killal scripts ([#2226](https://github.com/rancher/rke2/pull/2226))
* Adding certificate rotation command to rke2 ([#2220](https://github.com/rancher/rke2/pull/2220))
<!-- https://github.com/rancher/rke2/compare/v1.22.4+rke2r2...v1.22.5+rke2r1 -->

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1225) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s2) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8) |

### Available CNIs
| Component | Version | FIPS Compliant |
|---|---|---|
| Canal (Default) | [Flannel v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1)<br/>[Calico v3.20.2](https://docs.projectcalico.org/archive/v3.20/release-notes/#v3201)  | Yes |
| Calico | [v3.20.2](https://docs.projectcalico.org/release-notes/#v3202) | No |
| Cilium | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4) | No |
| Multus | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1) | No |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.4+rke2r2
<!-- v1.22.4+rke2r2 -->
This release provides some minor fixes around tooling and updates additional Windows support.

## Changes since v1.22.4+rke2r1:

* Add newly available etcd-arg to the docs [(#2205)](https://github.com/rancher/rke2/pull/2205)
* Remove socat from dockerfile [(#2210)](https://github.com/rancher/rke2/pull/2210)
* Mark 1.22.4 stable [(#2213)](https://github.com/rancher/rke2/pull/2213)
* Fixing bugs with a local binary install without local images. [(#2214)](https://github.com/rancher/rke2/pull/2214)
* Update to r2 build [(#2218)](https://github.com/rancher/rke2/pull/2218)
* [BugFix - Linux - Ubuntu/Debian] Make sure to remove systemd service on debian based systems [(#2217)](https://github.com/rancher/rke2/pull/2217))


## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1223) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s2) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8) |

### Available CNIs
| Component | Version | FIPS Compliant |
|---|---|---|
| Canal (Default) | [Flannel v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1)<br/>[Calico v3.20.2](https://docs.projectcalico.org/archive/v3.20/release-notes/#v3201)  | Yes |
| Calico | [v3.20.2](https://docs.projectcalico.org/release-notes/#v3202) | No |
| Cilium | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4) | No |
| Multus | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1) | No |

## Known Issues
- [#2085](https://github.com/rancher/rke2/issues/2085) - The rke2-metrics-server helm chart may fail to upgrade due to API version deprecations not handled by the MapKubeAPIs Helm plugin, leaving the metrics-server service non-functional following the upgrade. This will be fixed in the next release, but can be resolved by running:

```bash
kubectl delete helmchart -n kube-system rke2-metrics-server
systemctl restart rke2-server
```
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.3+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.22.4+rke2r1
<!-- v1.22.4+rke2r1 -->
This release updates Kubernetes to v1.22.4.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#urgent-upgrade-notes).
Special attention should be paid to the [removal of several beta Kubernetes APIs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#removal-of-several-beta-kubernetes-apis), as this is a breaking change for users with `apiextensions.k8s.io/v1beta1 CustomResourceDefinition` or `networking.k8s.io/v1beta1 Ingress` resources in their manifests.

## Changes since v1.22.4+rke2r1:

* Update cut_release.md [(#2082)](https://github.com/rancher/rke2/pull/2082)
* testing: assert that install.sh works correctly [(#2084)](https://github.com/rancher/rke2/pull/2084)
* Add image sources doc [(#2066)](https://github.com/rancher/rke2/pull/2066)
* Update Calico chart to v3.20.2 [(#2064)](https://github.com/rancher/rke2/pull/2064)
* Bump harvester cloud provider 0.1.3 and csi driver 0.1.4 [(#2072)](https://github.com/rancher/rke2/pull/2072)
* Upgrading pause image and build to support Windows 2022. [(#2094)](https://github.com/rancher/rke2/pull/2094)
* Updating to new signals package in wrangler [(#2098)](https://github.com/rancher/rke2/pull/2098)
* Dump logs with docker cp [(#2108)](https://github.com/rancher/rke2/pull/2108)
* Update Calico chart to v3.20.2 [(#2064)](https://github.com/rancher/rke2/pull/2064)
* Tests: vagrant/install/ubuntu-focal [(#2099)](https://github.com/rancher/rke2/pull/2099)
* Updating to new signals package in wrangler [(#2098)](https://github.com/rancher/rke2/pull/2098)
* The rke2-metrics-server chart should now update properly when upgrading from previous releases of RKE2 [(#2116)](https://github.com/rancher/rke2/pull/2116)
* Configuring http proxy settings [(#2092)](https://github.com/rancher/rke2/pull/2092)
* tests/vagrant/install: updated workflow [(#2120)](https://github.com/rancher/rke2/pull/2120)
* Recommend systemd-sysctl service usage only initially [(#2113)](https://github.com/rancher/rke2/pull/2113)
* Fix typo in windows pause image [(#2128)](https://github.com/rancher/rke2/pull/2128)
* Add etcd extra-args support to RKE2 [(#2136)](https://github.com/rancher/rke2/pull/2136)
* K3s bump [(#2133)](https://github.com/rancher/rke2/pull/2133)
* Bump Go and k3s versions [(#2147)](https://github.com/rancher/rke2/pull/2147)
* SR-IOV chart lives in rancher-charts [(#2153)](https://github.com/rancher/rke2/pull/2153)
* Bump charts and chart images [(#2154)](https://github.com/rancher/rke2/pull/2154)
* Get node name from metadata if AWS cloud provider is enabled [(#2163)](https://github.com/rancher/rke2/pull/2163)
* Bump vsphere charts+images [(#2177)](https://github.com/rancher/rke2/pull/2177)
* Update master k8s to 1.22.4 [(#2183)](https://github.com/rancher/rke2/pull/2183)
* Mark v1.22.3+rke2r1 as stable [(#2197)](https://github.com/rancher/rke2/pull/2197)
* Enable Rke2 parser to skip flags [(#2200)](https://github.com/rancher/rke2/pull/2200)
* Added new section for hardened images [(#2189)](https://github.com/rancher/rke2/pull/2189)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1223) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s2) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8) |

### Available CNIs
| Component | Version | FIPS Compliant |
|---|---|---|
| Canal (Default) | [Flannel v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1)<br/>[Calico v3.20.2](https://docs.projectcalico.org/archive/v3.20/release-notes/#v3201)  | Yes |
| Calico | [v3.20.2](https://docs.projectcalico.org/release-notes/#v3202) | No |
| Cilium | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4) | No |
| Multus | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1) | No |

## Known Issues
- [#2085](https://github.com/rancher/rke2/issues/2085) - The rke2-metrics-server helm chart may fail to upgrade due to API version deprecations not handled by the MapKubeAPIs Helm plugin, leaving the metrics-server service non-functional following the upgrade. This will be fixed in the next release, but can be resolved by running:

```bash
kubectl delete helmchart -n kube-system rke2-metrics-server
systemctl restart rke2-server
```
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.3+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.22.3+rke2r1
<!-- v1.22.3+rke2r1 -->
This release is RKE2's first in the v1.22 line. This release updates Kubernetes to v1.22.3.

As this release includes a number of significant changes from previous versions, we will not make v1.22 available via the stable release channel until v1.22.4+rke2r1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#urgent-upgrade-notes).
Special attention should be paid to the [removal of several beta Kubernetes APIs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#removal-of-several-beta-kubernetes-apis), as this is a breaking change for users with `apiextensions.k8s.io/v1beta1 CustomResourceDefinition` or `networking.k8s.io/v1beta1 Ingress` resources in their manifests.

## Changes since RKE2 v1.21.2-rke2r1 (when the **release-1.21** branch was forked from **master**)
* Bump containerd to v1.5.7-k3s2 ([#2078](https://github.com/rancher/rke2/pull/2078))
* Bump RKE2 to v1.22.3-rc1+rke2r1 ([#2058](https://github.com/rancher/rke2/pull/2058))
* Bump k3s to revert reconcile bootstrap data ([#2055](https://github.com/rancher/rke2/pull/2055))
* Update to latest of k3s ([#2049](https://github.com/rancher/rke2/pull/2049))
* Bump K3s module versions ([#2029](https://github.com/rancher/rke2/pull/2029))
* Remove confirm=false for windows uninstall script ([#2024](https://github.com/rancher/rke2/pull/2024))
* Bump rke2-canal flannel version for vxlan fix ([#2000](https://github.com/rancher/rke2/pull/2000))
* Update K3s and update executors to delay etcd join ([#1952](https://github.com/rancher/rke2/pull/1952))
* Bump rke2-coredns helm chart to include pod hostname anti-affinity rule ([#1993](https://github.com/rancher/rke2/pull/1993))
* Strict mode bug fix for install.ps1 ([#1994](https://github.com/rancher/rke2/pull/1994))
* Move to newer rke2 cloud provider version ([#1981](https://github.com/rancher/rke2/pull/1981))
* Don't create static pod tempfiles in static pod dir ([#1966](https://github.com/rancher/rke2/pull/1966))
* Migrate to Wins Logging ([#1979](https://github.com/rancher/rke2/pull/1979))
* Ensure that the legacy rke2-kube-proxy chart is disabled ([#1971](https://github.com/rancher/rke2/pull/1971))
* 1.22 version bumps and use stable cni-plugins release ([#1838](https://github.com/rancher/rke2/pull/1838))
* Bump containerd to 1.5.7 ([#1947](https://github.com/rancher/rke2/pull/1947))
* Update to Kubernetes / K3s 1.22.2 ([#1827](https://github.com/rancher/rke2/pull/1827))
* Bug fixes and logic improvements for windows scripts ([#1949](https://github.com/rancher/rke2/pull/1949))
* update windows uninstall and install scripts ([#1872](https://github.com/rancher/rke2/pull/1872))
* Update rke2 to v1.21.5+rke2r2 and embedded k3s ([#1931](https://github.com/rancher/rke2/pull/1931))
* Disable embedded CCM when enabling packaged cloud-provider charts ([#1862](https://github.com/rancher/rke2/pull/1862))
* Increment Calico chart version ([#1878](https://github.com/rancher/rke2/pull/1878))
* Cleaning up the PowerShell installation script ([#1867](https://github.com/rancher/rke2/pull/1867))
* Adding default for AIRGAP_TARBALL_URL ([#1853](https://github.com/rancher/rke2/pull/1853))
* Add Permit Port Sharing Flag to Scheduler and Controller Manager ([#1841](https://github.com/rancher/rke2/pull/1841))
* Update calico chart ([#1828](https://github.com/rancher/rke2/pull/1828))
* Remove the broken/unused/unneeded $AIRGAP_CHECKSUMS_URL argument ([#1805](https://github.com/rancher/rke2/pull/1805))
* Bump K3s engine-1.21 to latest commit for bugfix ([#1823](https://github.com/rancher/rke2/pull/1823))
* Update K3s to latest engine-1.21 ([#1818](https://github.com/rancher/rke2/pull/1818))
* Cilium: Bump chart version to 1.10.402 ([#1811](https://github.com/rancher/rke2/pull/1811))
* Bump k3s for etcd metrics fix ([#1798](https://github.com/rancher/rke2/pull/1798))
* Bump wharfie to v0.4.2 ([#1786](https://github.com/rancher/rke2/pull/1786))
* Support Harvester CCM and CSI ([#1679](https://github.com/rancher/rke2/pull/1679))
* Cilium: Update to 1.10.4 ([#1781](https://github.com/rancher/rke2/pull/1781))
* Bump containerd to v1.4.9-k3s1, runc to v1.0.1 ([#1772](https://github.com/rancher/rke2/pull/1772))
* Add 2 new helm global values that separate v4 and v6 ([#1720](https://github.com/rancher/rke2/pull/1720))
* Adding support for External IP for Windows nodes Rancher installer.. ([#1753](https://github.com/rancher/rke2/pull/1753))
* Update k3s to engine-1.21 ([#1747](https://github.com/rancher/rke2/pull/1747))
* Update calico chart ([#1692](https://github.com/rancher/rke2/pull/1692))
* Add linux nodeSelector to coredns and helm jobs ([#1688](https://github.com/rancher/rke2/pull/1688))
* Bump chart versions to pull in linux nodeSelectors ([#1672](https://github.com/rancher/rke2/pull/1672))
* Upgrade k3s master ([#1663](https://github.com/rancher/rke2/pull/1663))
* Refactored how we start calico with kubelet context to cancel ([#1619](https://github.com/rancher/rke2/pull/1619))
* Use FQDN for node name if cloud provider is set to AWS ([#1631](https://github.com/rancher/rke2/pull/1631))
* Add missing kubeproxy extra env and mounts ([#1626](https://github.com/rancher/rke2/pull/1626))
* Calico: Update the chart to v3.19.2-202 ([#1623](https://github.com/rancher/rke2/pull/1623))
* switch info and config calls around for proper headers to hit first ([#1612](https://github.com/rancher/rke2/pull/1612))
* Bumped k3s version to bring in updated HNS Network  call. ([#1605](https://github.com/rancher/rke2/pull/1605))
* Allows getting the version from Rancher and passes it to the installer. ([#1602](https://github.com/rancher/rke2/pull/1602))
* Bump hardened-kubernetes to v1.21.3-rke2r2 ([#1582](https://github.com/rancher/rke2/pull/1582))
* Update k3s to resolve for s3 folder handling when listing snapshots ([#1597](https://github.com/rancher/rke2/pull/1597))
* Bump calico to 3.19.2 for windows ([#1591](https://github.com/rancher/rke2/pull/1591))
* Update Calico version to v3.19.2 ([#1585](https://github.com/rancher/rke2/pull/1585))
* Switching to only using curl for windows scripts. ([#1571](https://github.com/rancher/rke2/pull/1571))
* Fixing issues with windows installation scripts. ([#1567](https://github.com/rancher/rke2/pull/1567))
* Update k3s to fix node stuck on removal ([#1542](https://github.com/rancher/rke2/pull/1542))
* Update coredns chart ([#1540](https://github.com/rancher/rke2/pull/1540))
* Update labels to be annotations ([#1531](https://github.com/rancher/rke2/pull/1531))
* Bump to calico chart ([#1527](https://github.com/rancher/rke2/pull/1527))
* Custom resource requests/limits, extra binds, and extra env for control plane static pod components ([#1463](https://github.com/rancher/rke2/pull/1463))
* Add psp labels ([#1517](https://github.com/rancher/rke2/pull/1517))
* Start using hardened dns images ([#1513](https://github.com/rancher/rke2/pull/1513))
* Switching to 3.5 pause images ([#1516](https://github.com/rancher/rke2/pull/1516))
* Bump k3s in go.mod to address issue with disabling kube-proxy ([#1462](https://github.com/rancher/rke2/pull/1462))
* Update service watching logic for windows service manager ([#1475](https://github.com/rancher/rke2/pull/1475))
* Provide support for nodelocal DNSCache ([#1466](https://github.com/rancher/rke2/pull/1466))
* Upgrade k3s in master ([#1489](https://github.com/rancher/rke2/pull/1489))
* Add Windows RKE2 Uninstall script ([#1488](https://github.com/rancher/rke2/pull/1488))
* Bump versions in Windows Dockerfile ([#1480](https://github.com/rancher/rke2/pull/1480))
* Bump ingress-nginx chart to 3.34.002 ([#1476](https://github.com/rancher/rke2/pull/1476))
* Add new coredns chart ([#1464](https://github.com/rancher/rke2/pull/1464))
* Remove tables and interfaces created by cilium & calico ([#1456](https://github.com/rancher/rke2/pull/1456))
* Add Windows Installation for Rancher, Update existing Installer ([#1461](https://github.com/rancher/rke2/pull/1461))
* Upgrade k3s bootstrap  ([#1431](https://github.com/rancher/rke2/pull/1431))
* Made audit-policy-file flag independent of CIS profile flag ([#1419](https://github.com/rancher/rke2/pull/1419))
* Bump kubernetes versions to GA build ([#1420](https://github.com/rancher/rke2/pull/1420))
* Rewrite to pass in WaitGroup ([#1408](https://github.com/rancher/rke2/pull/1408))
* The embedded containerd version has been updated to v1.4.8-k3s1 to resolve GHSA-c72p-9xmj-rx3w ([#1397](https://github.com/rancher/rke2/pull/1397))
* Upgrade kube-proxy version ([#1303](https://github.com/rancher/rke2/pull/1303))
* Switching to using StartupHookArgs and adding Disables/Skips ([#1381](https://github.com/rancher/rke2/pull/1381))
* Adding the volume mount for the docker socket ([#1379](https://github.com/rancher/rke2/pull/1379))
* Hardcode rancher namespace for rke2-runtime manifest ([#1374](https://github.com/rancher/rke2/pull/1374))
* Kube-proxy deployed twice and without needed permissions ([#1346](https://github.com/rancher/rke2/pull/1346))
* Added privileged to static pod args ([#1326](https://github.com/rancher/rke2/pull/1326))
* Windows and Calico support ([#1268](https://github.com/rancher/rke2/pull/1268))
* Adding agent service sub command for Windows ([#1281](https://github.com/rancher/rke2/pull/1281))

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1223) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.7-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s2) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |

### Available CNIs
| Component | Version | FIPS Compliant |
|---|---|---|
| Canal (Default) | [Flannel v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1)<br/>[Calico v3.20.1](https://docs.projectcalico.org/archive/v3.20/release-notes/#v3201)  | Yes |
| Calico | [v3.20.1](https://docs.projectcalico.org/release-notes/#v3201) | No |
| Cilium | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4) | No |
| Multus | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1) | No |

## Known Issues
- [#2085](https://github.com/rancher/rke2/issues/2085) - The rke2-metrics-server helm chart may fail to upgrade due to API version deprecations not handled by the MapKubeAPIs Helm plugin, leaving the metrics-server service non-functional following the upgrade. This will be fixed in the next release, but can be resolved by running:

```bash
kubectl delete helmchart -n kube-system rke2-metrics-server
systemctl restart rke2-server
```
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.22.3+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
