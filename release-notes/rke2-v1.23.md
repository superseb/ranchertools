<!-- v1.23.17+rke2r1 -->

This release updates Kubernetes to v1.23.17, and fixes a number of issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.16+rke2r1:

* Don't handle kube-proxy in static pod cleanup [(#3837)](https://github.com/rancher/rke2/pull/3837)
* Bump cilium images [(#3825)](https://github.com/rancher/rke2/pull/3825)
* Remove pod logs as part of killall [(#3869)](https://github.com/rancher/rke2/pull/3869)
* Bump wharfie and go-containerregistry [(#3866)](https://github.com/rancher/rke2/pull/3866)
* Bump k3s version [(#3900)](https://github.com/rancher/rke2/pull/3900)
  * Fixed an issue where leader-elected controllers for managed etcd did not run on etcd-only nodes
  * RKE2 now functions properly when the cluster CA certificates are signed by an existing root or intermediate CA. You can find a sample script for generating such certificates before RKE2 starts in the K3s repo at [contrib/util/certs.sh](https://github.com/k3s-io/k3s/blob/master/contrib/util/certs.sh).
  * RKE2 now supports `kubeadm` style join tokens. `rke2 token create` now creates join token secrets, optionally with a limited TTL.
  * RKE2 agents joined with an expired or deleted token stay in the cluster using existing client certificates via the NodeAuthorization admission plugin, unless their Node object is deleted from the cluster.
  * ServiceLB now honors the Service's ExternalTrafficPolicy. When set to Local, the LoadBalancer will only advertise addresses of Nodes with a Pod for the Service, and will not forward traffic to other cluster members. (ServiceLB is still disabled by default)
* Bump K3s commit [(#3908)](https://github.com/rancher/rke2/pull/3908)
* Backport Calico and canal update [(#3912)](https://github.com/rancher/rke2/pull/3912)
* Add bootstrap token auth handler [(#3923)](https://github.com/rancher/rke2/pull/3923)
* Update to kubernetes v1.23.17 [(#3951)](https://github.com/rancher/rke2/pull/3951)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.17](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12317) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.16-k3s2-1-22](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s2-1-22)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.21.1](https://github.com/k3s-io/flannel/releases/tag/v0.21.1)<br/>[Calico v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | Yes            |
| Calico          | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250)                                                                    | No             |
| Cilium          | [v1.12.5](https://github.com/cilium/cilium/releases/tag/v1.12.5)                                                                                                                      | No             |
| Multus          | [v3.9](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9)                                                                                                    | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
<!-- v1.23.16+rke2r1 -->

This release updates Kubernetes to v1.23.16 to backport registry changes and fix two critical issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.15+rke2r1:

* Generate report and upload test results (#3771) [(#3796)](https://github.com/rancher/rke2/pull/3796)
* Bump harvester cloud provider and harvester csi driver [(#3783)](https://github.com/rancher/rke2/pull/3783)
* Bump K3s version for tls-cipher-suites fix [(#3797)](https://github.com/rancher/rke2/pull/3797)
* Bump vSphere CPI chart to v1.23.3 [(#3807)](https://github.com/rancher/rke2/pull/3807)
* Update to v1.23.16 [(#3809)](https://github.com/rancher/rke2/pull/3809)
* Bump containerd to v1.5.16-k3s2 [(#3831)](https://github.com/rancher/rke2/pull/3831)
  * The embedded containerd version has been bumped to v1.5.16-k3s2. This includes a backported fix for [containerd/7843](https://github.com/containerd/containerd/issues/7843) which caused pods to lose their CNI info when containerd was restarted, which in turn caused the kubelet to recreate the pod. 
  * Windows agents now use the k3s fork of containerd, which includes support for registry rewrites.

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.16](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12316) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.16-k3s2-1-22](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s2-1-22)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.20.2](https://github.com/k3s-io/flannel/releases/tag/v0.20.2)<br/>[Calico v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245) | Yes            |
| Calico          | [v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245)                                                                    | No             |
| Cilium          | [v1.12.4](https://github.com/cilium/cilium/releases/tag/v1.12.4)                                                                                                                      | No             |
| Multus          | [v3.9](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.16+rke2r1
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
<!-- v1.23.15+rke2r1 -->

This release updates Kubernetes to v1.23.15, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.14+rke2r1:

* Add more tests to the windows env [(#3607)](https://github.com/rancher/rke2/pull/3607)
* Update Canal version [(#3627)](https://github.com/rancher/rke2/pull/3627)
* [Backport 1.23] update multus chart to v3.9-build2022102805 [(#3637)](https://github.com/rancher/rke2/pull/3637)
* [Backport 1.23] update rke2-calico chart to v3.24.501 [(#3631)](https://github.com/rancher/rke2/pull/3631)
* Backports for 2022-12 [(#3649)](https://github.com/rancher/rke2/pull/3649)
* Updated cilium version and added new cilium images [(#3644)](https://github.com/rancher/rke2/pull/3644)
* Bump ingress-nginx to 1.4.1 [(#3654)](https://github.com/rancher/rke2/pull/3654)
* Update to version 1.23.15 [(#3658)](https://github.com/rancher/rke2/pull/3658)
* Bump K3s and containerd versions for v1.23 [(#3677)](https://github.com/rancher/rke2/pull/3677)
* [Backport v1.23] Fixed cilium chart when enabled hubble images [(#3690)](https://github.com/rancher/rke2/pull/3690)
* Bump ingress-nginx [(#3704)](https://github.com/rancher/rke2/pull/3704)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12315) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.16-k3s1-1-22](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s1-1-22)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.20.2](https://github.com/k3s-io/flannel/releases/tag/v0.20.2)<br/>[Calico v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245) | Yes            |
| Calico          | [v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245)                                                                    | No             |
| Cilium          | [v1.12.4](https://github.com/cilium/cilium/releases/tag/v1.12.4)                                                                                                                      | No             |
| Multus          | [v3.9](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.15+rke2r1
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
<!-- v1.23.14+rke2r1 -->

This release updates Kubernetes to v1.23.14, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.13+rke2r1:

* Remove the CNI plugin binaries when uninstalling rke2 [(#3505)](https://github.com/rancher/rke2/pull/3505)
* Update Cilium to 1.12.3 and use portmap as default [(#3513)](https://github.com/rancher/rke2/pull/3513)
* Read VXLAN_ADAPTER env and use it to create the external network [(#3526)](https://github.com/rancher/rke2/pull/3526)
* Bump K3s version for v1.23 [(#3529)](https://github.com/rancher/rke2/pull/3529)
* Update Calico chart to support PSP for CIS 1.6 [(#3534)](https://github.com/rancher/rke2/pull/3534)
* Fix cilium system default registry123 [(#3555)](https://github.com/rancher/rke2/pull/3555)
* Update crictl image tag, remove silent failure ignores [(#3560)](https://github.com/rancher/rke2/pull/3560)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.14](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12314) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.1](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.1)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.13.0](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.0)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241) | Yes            |
| Calico          | [v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241)                                                                    | No             |
| Cilium          | [v1.12.3](https://github.com/cilium/cilium/releases/tag/v1.12.3)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.14+rke2r1
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
<!-- v1.23.13+rke2r1 -->

This release updates Kubernetes to v1.23.13, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.12+rke2r1:

* Windows update 1.23 [(#3397)](https://github.com/rancher/rke2/pull/3397)
* Don't create force-restart dir in current working dir when restoring [(#3334)](https://github.com/rancher/rke2/pull/3334)
* Updated Canal chart to fix token renewal from calico-node [(#3432)](https://github.com/rancher/rke2/pull/3432)
* K3s pull-through and backports from master  [(#3436)](https://github.com/rancher/rke2/pull/3436)
* Update canal to v3.24.1 [(#3448)](https://github.com/rancher/rke2/pull/3448)
* Bump CCM image tag  [(#3467)](https://github.com/rancher/rke2/pull/3467)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.13](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12313) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.1](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.1)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241) | Yes            |
| Calico          | [v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241)                                                                    | No             |
| Cilium          | [v1.12.1](https://github.com/cilium/cilium/releases/tag/v1.12.1)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.13+rke2r1
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
<!-- v1.23.12+rke2r1 -->

This release updates Kubernetes to v1.23.12, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.10+rke2r1:

* [Release 1.23] Update Cilium version [(#3279)](https://github.com/rancher/rke2/pull/3279)
* [Release 1.23] Bump the cilium chart version [(#3293)](https://github.com/rancher/rke2/pull/3293)
* [Release 1.23] Update canal version [(#3286)](https://github.com/rancher/rke2/pull/3286)
* The bundled version of runc has been bumped to v1.1.4 [(#3302)](https://github.com/rancher/rke2/pull/3302)
* [Release 1.23] Update calico to v3.23.3 [(#3319)](https://github.com/rancher/rke2/pull/3319)
* [release-1.23] Fix static pod cleanup when using container-runtime-endpoint [(#3333)](https://github.com/rancher/rke2/pull/3333)
* [Release 1.23] Update calico to v3.24.1 [(#3345)](https://github.com/rancher/rke2/pull/3345)
* update to latest 1.23 patch [(#3350)](https://github.com/rancher/rke2/pull/3350)
* Update k8s to 1.23.12 [(#3373)](https://github.com/rancher/rke2/pull/3373)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.12](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12312) |
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
| Canal (Default) | [Flannel v0.19.1](https://github.com/k3s-io/flannel/releases/tag/v0.19.1)<br/>[Calico v3.23.3](https://projectcalico.docs.tigera.io/archive/v3.23/release-notes/#v3233) | Yes            |
| Calico          | [v3.24.1](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3241)                                                                    | No             |
| Cilium          | [v1.12.1](https://github.com/cilium/cilium/releases/tag/v1.12.1)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.12+rke2r1
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
<!-- v1.23.10+rke2r1 -->

This release updates Kubernetes to v1.23.10, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.9+rke2r1:

* [Backport release-1.23] Update cilium to v1.12.0 [(#3189)](https://github.com/rancher/rke2/pull/3189)
* [Release-1.23] Bump K3s and remotedialer [(#3209)](https://github.com/rancher/rke2/pull/3209)
* [Release-1.23] Add ingress network policy [(#3222)](https://github.com/rancher/rke2/pull/3222)
* [Release-1.23] Use container-runtime-endpoint flag for criConnection [(#3235)](https://github.com/rancher/rke2/pull/3235)
* Convert codespell from Drone to GH actions (#3246) [(#3250)](https://github.com/rancher/rke2/pull/3250)
* Upgrade to v1.23.10-rke2r1 [(#3251)](https://github.com/rancher/rke2/pull/3251)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12310) |
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
| Calico          | [v3.23.1](https://projectcalico.docs.tigera.io/archive/v3.23/release-notes/#v3231)                                                                    | No             |
| Cilium          | [v1.12.0](https://github.com/cilium/cilium/releases/tag/v1.12.0)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.10+rke2r1
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
<!-- v1.23.9+rke2r1 -->

This release updates Kubernetes to v1.23.9, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.8+rke2r1:

* [Release-1.23] Bump ingress-nginx to 4.1.004 [(#3132)](https://github.com/rancher/rke2/pull/3132)
* [Release-1.23] Bump harvester cloud provider 0.1.13 [(#3139)](https://github.com/rancher/rke2/pull/3139)
* July release 1.23 r1 [(#3151)](https://github.com/rancher/rke2/pull/3151)
* [Release-1.23] Bump CRI timeout to 34 minutes [(#3159)](https://github.com/rancher/rke2/pull/3159)
* [Release-1.23] Consolidate staticPod timeout to static 30 minutes [(#3169)](https://github.com/rancher/rke2/pull/3169)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1239) |
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
| Calico          | [v3.23.1](https://projectcalico.docs.tigera.io/archive/v3.23/release-notes/#v3231)                                                                    | No             |
| Cilium          | [v1.11.5](https://github.com/cilium/cilium/releases/tag/v1.11.5)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.9+rke2r1
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
<!-- v1.23.8+rke2r1 -->

This release updates Kubernetes to v1.23.8, fixes a number of minor issues, and includes security updates.

**Important Notes**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.7+rke2r2:

* Remove kube-ipvs0 interface when cleaning up [(#3050)](https://github.com/rancher/rke2/pull/3050)
* Add Static Pod Startup Hook + K3s Bump + CoreDNS bump [(#3058)](https://github.com/rancher/rke2/pull/3058)
* Updated cilium chart to support IPv6 only config [(#3070)](https://github.com/rancher/rke2/pull/3070)
* Update multus charts to v3.8-build2021110403 [(#3047)](https://github.com/rancher/rke2/pull/3047)
* Use serializable health checks for etcd probes [(#3074)](https://github.com/rancher/rke2/pull/3074)
* Bump K3s and helm-controller versions [(#3080)](https://github.com/rancher/rke2/pull/3080)
* June release 1.23 [(#3087)](https://github.com/rancher/rke2/pull/3087)
* Double number of steps for criBackoff
* Bump K3s version for cluster upgrade egress-selector-mode fix [(#3124)](https://github.com/rancher/rke2/pull/3124)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1238) |
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
| Calico          | [v3.23.1](https://projectcalico.docs.tigera.io/archive/v3.23/release-notes/#v3231)                                                                    | No             |
| Cilium          | [v1.11.5](https://github.com/cilium/cilium/releases/tag/v1.11.5)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.8+rke2r1
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
<!-- v1.23.7+rke2r2 -->

This release updates Kubernetes to v1.23.7, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.6+rke2r2:

* Bump upgrade controller version and improve readability [(#2818)](https://github.com/rancher/rke2/pull/2818)
* Updating the vSphere CPI chart version. [(#2868)](https://github.com/rancher/rke2/pull/2868)
* Update Cilium version [(#2865)](https://github.com/rancher/rke2/pull/2865)
* Update calico version [(#2866)](https://github.com/rancher/rke2/pull/2866)
* Update Multus chart and sriov/multus images [(#2854)](https://github.com/rancher/rke2/pull/2854)
* Update rke2 channel [(#2872)](https://github.com/rancher/rke2/pull/2872)
* Multiple docs updates [(#2894)](https://github.com/rancher/rke2/pull/2894)
* [Release 1.23] Update canal to 3.22.2 [(#2906)](https://github.com/rancher/rke2/pull/2906)
* [Release 1.23] Update calico to 3.23.0 [(#2908)](https://github.com/rancher/rke2/pull/2908)
* [Release 1.23] Update multus to the latest chart version [(#2922)](https://github.com/rancher/rke2/pull/2922)
* [Release 1.23] Move windows validation to CI [(#2915)](https://github.com/rancher/rke2/pull/2915)
* [Release 1.23] Support dev rpm creation and installation [(#2936)](https://github.com/rancher/rke2/pull/2936)
* [Release 1.23] Ignore windows binaries when creating linux bundle [(#2945)](https://github.com/rancher/rke2/pull/2945)
* [Release 1.23] ipv6 support [(#2952)](https://github.com/rancher/rke2/pull/2952)
* [Release 1.23] Updated Calico to v3.23.1 [(#2954)](https://github.com/rancher/rke2/pull/2954)
* [Release 1.23] Added flannel wireguard interface deletion [(#2963)](https://github.com/rancher/rke2/pull/2963)
* [Release 1.23] Bump k3s and etcd [(#2855)](https://github.com/rancher/rke2/pull/2855)
* [Release 1.23] Fixed canal chart for IPv6 only setup [(#2967)](https://github.com/rancher/rke2/pull/2967)
* [Release 1.23] Bump K3s for calico egress-selector fix [(#2969)](https://github.com/rancher/rke2/pull/2969)
* [Release 1.23] Fix calico chart to accept ipPool value [(#2980)](https://github.com/rancher/rke2/pull/2980)
* [Release 1.23] Update Cilium to 1.11.5 [(#2973)](https://github.com/rancher/rke2/pull/2973)
* Update k8s to v1.23.7 [(#2994)](https://github.com/rancher/rke2/pull/2994)
* [Release 1.23] Disable egress-selector for calico/multus/none [(#3013)](https://github.com/rancher/rke2/pull/3013)
* [Release 1.23] Bump containerd, runc, k3s [(#3023)](https://github.com/rancher/rke2/pull/3023)
* [Release 1.23] Remove cni-based egress-selector config and bump k3s [(#3026)](https://github.com/rancher/rke2/pull/3026)
* May release v1.23.7+rke2r2 [(#3029)](https://github.com/rancher/rke2/pull/3029)
* [Release 1.23] Unconditionally set egress-selector-mode to disabled [(#3036)](https://github.com/rancher/rke2/pull/3036)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1237) |
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
| Calico          | [v3.23.1](https://projectcalico.docs.tigera.io/archive/v3.23/release-notes/#v3231)                                                                    | No             |
| Cilium          | [v1.11.5](https://github.com/cilium/cilium/releases/tag/v1.11.5)                                                                                                                      | No             |
| Multus          | [v3.8](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.8)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.7+rke2r2
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
<!-- v1.23.6+rke2r2 -->

This release updates a number of RKE2 components to address and resolve some minor issues identified on `v1.23.6+rke2r1` release.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.6+rke2r1:

* Added flannel-v6.1 delete on killall script [(#2811)](https://github.com/rancher/rke2/pull/2811)
* Mark 1.22.9 as stable [(#2840)](https://github.com/rancher/rke2/pull/2840)
* Bump rke2-ingress-nginx to remove accidentally committed .orig files [(#2841)](https://github.com/rancher/rke2/pull/2841)
* Bump dynamiclistener to fix apiserver outage issue [(#2833)](https://github.com/rancher/rke2/pull/2833)
* update Kubernetes to 1.23.6 r2 [(#2830)](https://github.com/rancher/rke2/pull/2830)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1236) |
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
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.22.1](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3221) | Yes            |
| Calico          | [v3.22.1](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3221)                                                                    | No             |
| Cilium          | [v1.11.2](https://github.com/cilium/cilium/releases/tag/v1.11.2)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#2857](https://github.com/rancher/rke2/issues/2857) - Cannot join nodes back after cluster-reset when not restoring from snapshot
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.6+rke2r2
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
<!-- v1.23.6+rke2r1 -->

This release updates Kubernetes to v1.23.6, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.5+rke2r1:

* Update developer docs [(#2488)](https://github.com/rancher/rke2/pull/2488)
* Mark v1.22.8 stable [(#2718)](https://github.com/rancher/rke2/pull/2718)
* Fix windows dev images to include proper runtime tag [(#2696)](https://github.com/rancher/rke2/pull/2696)
* Add explicit string to kubeconfig mode in E2E tests [(#2706)](https://github.com/rancher/rke2/pull/2706)
* E2E Add option for different CNIs in the validatecluster test [(#2703)](https://github.com/rancher/rke2/pull/2703)
* E2E Dualstack CNI Support [(#2730)](https://github.com/rancher/rke2/pull/2730)
* Add message in the killall script [(#2727)](https://github.com/rancher/rke2/pull/2727)
* Update Kubernetes upgrade documentation [(#2736)](https://github.com/rancher/rke2/pull/2736)
* Add --output/-o to secrets-encrypt status [(#2681)](https://github.com/rancher/rke2/pull/2681)
* Hide overridden secrets-encryption flag [(#2722)](https://github.com/rancher/rke2/pull/2722)
* Remove --with-node-id in docs for rke2 [(#2690)](https://github.com/rancher/rke2/pull/2690)
* Remove kube-proxy static pod manifest when --disable-kube-proxy is set [(#2731)](https://github.com/rancher/rke2/pull/2731)
* [Docs] Add Secrets Encryption page to navigation [(#2663)](https://github.com/rancher/rke2/pull/2663)
* [Docs] Document registry mirror rewrite configuration [(#2708)](https://github.com/rancher/rke2/pull/2708)
* Update cilium to support automatic dual-stack config [(#2744)](https://github.com/rancher/rke2/pull/2744)
* List downstream release projects [(#2739)](https://github.com/rancher/rke2/pull/2739)
* Updating to the latest vSphere charts [(#2755)](https://github.com/rancher/rke2/pull/2755)
* Bump harvester cloud provider 0.1.11 [(#2754)](https://github.com/rancher/rke2/pull/2754)
* Bump containerd to v1.5.11-k3s1 [(#2768)](https://github.com/rancher/rke2/pull/2768)
* Bump Harvester csi to v0.1.11 [(#2777)](https://github.com/rancher/rke2/pull/2777)
* E2E: New MixedOS test with linux and windows agents [(#2745)](https://github.com/rancher/rke2/pull/2745)
* Bump etcd to v3.5.3-k3s1 [(#2763)](https://github.com/rancher/rke2/pull/2763)
* Update k8s to v1.23.6 [(#2796)](https://github.com/rancher/rke2/pull/2796)
* Update containerd for Windows [(#2801)](https://github.com/rancher/rke2/pull/2801)
* Also inject system-default-registry as global.cattle.systemDefaultRegistry [(#2805)](https://github.com/rancher/rke2/pull/2805)
* Bump k3s for April Fixes [(#2814)](https://github.com/rancher/rke2/pull/2814)
* Bump containerd for selinux fix [(#2820)](https://github.com/rancher/rke2/pull/2820)
* Upgrade ingress nginx chart and images [(#2824)](https://github.com/rancher/rke2/pull/2824)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1236) |
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
| Canal (Default) | [Flannel v0.17.0](https://github.com/k3s-io/flannel/releases/tag/v0.17.0)<br/>[Calico v3.21.4](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3221) | Yes            |
| Calico          | [v3.22.1](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3221)                                                                    | No             |
| Cilium          | [v1.11.2](https://github.com/cilium/cilium/releases/tag/v1.11.2)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.6+rke2r1
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
<!-- v1.23.5+rke2r1 -->

This release updates Kubernetes to v1.23.5, fixes a number of minor issues, and includes security updates.

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

## Changes since v1.23.4+rke2r2:

* add containerd version checks for windows and linux [(#2578)](https://github.com/rancher/rke2/pull/2578)
* ensure the fossa pipeline is ran on all drone-publish runs [(#2586)](https://github.com/rancher/rke2/pull/2586)
* Update Cilium to 1.11.2 [(#2607)](https://github.com/rancher/rke2/pull/2607)
* [docs] Update cilium docs [(#2615)](https://github.com/rancher/rke2/pull/2615)
* Explicitly retag runtime for linux and windows [(#2601)](https://github.com/rancher/rke2/pull/2601)
* Fix windows commit installs [(#2544)](https://github.com/rancher/rke2/pull/2544)
* E2E DualStack Test [(#2528)](https://github.com/rancher/rke2/pull/2528)
* Add support for s390x arch [(#2597)](https://github.com/rancher/rke2/pull/2597)
* ADR for SLE RPM support [(#2409)](https://github.com/rancher/rke2/pull/2409)
* Fix canal bugs [(#2631)](https://github.com/rancher/rke2/pull/2631)
* update channel server [(#2632)](https://github.com/rancher/rke2/pull/2632)
* Add rpm installation support for SLE systems [(#2549)](https://github.com/rancher/rke2/pull/2549)
* Replace CentOS 8 with Rocky Linux 8 for install testing [(#2637)](https://github.com/rancher/rke2/pull/2637)
* Fix doc inconsistency with --disable flag [(#2624)](https://github.com/rancher/rke2/pull/2624)
* Add force-restart file when cluster-reset-restore-path is passed [(#2645)](https://github.com/rancher/rke2/pull/2645)
* Bump coredns to 1.9.1 [(#2654)](https://github.com/rancher/rke2/pull/2654)
* Update K3s and helm-controller [(#2659)](https://github.com/rancher/rke2/pull/2659)
* March release v1.23.5 [(#2642)](https://github.com/rancher/rke2/pull/2642)
* Revert "Explicitly retag runtime for linux and windows" [(#2665)](https://github.com/rancher/rke2/pull/2665)
* hardcode linker flag for windows runtime image [(#2668)](https://github.com/rancher/rke2/pull/2668)
* Update nginx from hardened2 to hardened4 [(#2675)](https://github.com/rancher/rke2/pull/2675)
* Fix uninstall script on SLES [(#2692)](https://github.com/rancher/rke2/pull/2692)
* Bump K3s version for v1.23 [(#2687)](https://github.com/rancher/rke2/pull/2687)
* [master] k3s pin for containerd npipe fix + calico panic fix [(#2700)](https://github.com/rancher/rke2/pull/2700)
* Cilium update brings an important change in how the helm chart is consumed when a user wants to set some customized values via helmChartConfig. Please see [this link for more details](https://github.com/rancherlabs/release-notes/pull/232#issuecomment-1087171935)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1235) |
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

| Calico          | [v3.22.1](https://projectcalico.docs.tigera.io/archive/v3.22/release-notes/#v3221)                                                                                                                      | No             |
| Cilium          | [v1.11.2](https://github.com/cilium/cilium/releases/tag/v1.11.2)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- The etcd maintainers have recommended against the use of etcd 3.5.0-3.5.2 for new production workloads, due to a recently discovered bug that may cause data loss when etcd is killed under high load. [Please see this link for more details.](https://forums.rancher.com/t/rancher-kubernetes-distributions-and-etcd-3-5-updates/37485)

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.5+rke2r1
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

-----
<!-- v1.21.10+rke2r1 -->

This release updates Kubernetes to v1.21.10, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.21.9+rke2r1:

* [release 1.21] Fix a typo in the meta-data endpoint [(#2423)](https://github.com/rancher/rke2/pull/2423)
* [release-1.21] Wait for CRI service to become available before starting temp kubelet [(#2396)](https://github.com/rancher/rke2/pull/2396)
* [Release 1.21] Update canal to newer chart with bugfix [(#2430)](https://github.com/rancher/rke2/pull/2430)
* [Release-1.21] Made audit-policy-file flag independent of CIS profile flag [(#2448)](https://github.com/rancher/rke2/pull/2448)
* [Release 1.21] Update canal to v3.21.4 [(#2453)](https://github.com/rancher/rke2/pull/2453)
* add seccomp annotations to unrestricted PSP (#2440) [(#2449)](https://github.com/rancher/rke2/pull/2449)
* [release-1.21] Helm Chart improvements [(#2459)](https://github.com/rancher/rke2/pull/2459)
* Fixed a regression that prevented `--disable` from removing previously installed components. [(#2473)](https://github.com/rancher/rke2/pull/2473)
* Update Kubernetes release v1.21.10 [(#2495)](https://github.com/rancher/rke2/pull/2495)
* update kube-proxy for February release [(#2496)](https://github.com/rancher/rke2/pull/2496)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.21.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.21.md#v12110) |
| Etcd            | [v3.4.18-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.18-k3s1)                          |
| Containerd      | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.12-k3s1)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| CNI Plugins     | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1)                      |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5)                                  |
| Ingress-Nginx   | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases)                                  |
| Helm-controller | [v0.11.9](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.9)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.16.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.16.0-rancher1)<br/>[Calico v3.21.2](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3212) | Yes            |
| Calico          | [v3.19.2](https://projectcalico.docs.tigera.io/archive/v3.19/release-notes/#v3192)                                                                                                                     | No             |
| Cilium          | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.21.10+rke2r1
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
<!-- v1.23.3+rke2r1 -->

This release updates Kubernetes to v1.23.3, fixes a number of minor issues, and includes security updates. We have skipped over v1.23.2 since upstream did an emergency patch release the same day as they release v1.23.2.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.23.1+rke2r2:

* Fixed typo. [(#2344)](https://github.com/rancher/rke2/pull/2344)
* Allow override `--kubelet-preferred-address-types` for kube-apiserver [(#2279)](https://github.com/rancher/rke2/pull/2279)
* Add Adminstrator check to windows install.ps1 [(#2346)](https://github.com/rancher/rke2/pull/2346)
* Update canal chart [(#2353)](https://github.com/rancher/rke2/pull/2353)
* Revert "Add Adminstrator check to windows install.ps1" [(#2357)](https://github.com/rancher/rke2/pull/2357)
* Update Cilium to 1.11.0 [(#2364)](https://github.com/rancher/rke2/pull/2364)
* Update etcd, containerd, and k3s [(#2365)](https://github.com/rancher/rke2/pull/2365)
* Readme typo fix [(#2146)](https://github.com/rancher/rke2/pull/2146)
* Update helm.md [(#2155)](https://github.com/rancher/rke2/pull/2155)
* Removed rke2-kube-proxy disable list option from documentation [(#2036)](https://github.com/rancher/rke2/pull/2036)
* Remove duplicate `cordon` parameter in automated_upgrade.md [(#2363)](https://github.com/rancher/rke2/pull/2363)
* Update canal to latest [(#2371)](https://github.com/rancher/rke2/pull/2371)
* Modify install script to enable SLE Micro rpm installation [(#2366)](https://github.com/rancher/rke2/pull/2366)
* [ master ] - Update RKE2 k8s version for January release [(#2375)](https://github.com/rancher/rke2/pull/2375)
* Update Cilium to 1.11.1 [(#2379)](https://github.com/rancher/rke2/pull/2379)
* Revert "Modify install script to enable SLE Micro installation (#2366)" [(#2380)](https://github.com/rancher/rke2/pull/2380)
* Add information about wireguard [(#2376)](https://github.com/rancher/rke2/pull/2376)
* Update known_issues.md [(#2384)](https://github.com/rancher/rke2/pull/2384)
* Added additional inbound rules for Calico, Canal, Cilium [(#2381)](https://github.com/rancher/rke2/pull/2381)
* Updated airgap docs to specify dependencies required for Selinux, Cent/Rhel 8  [(#2385)](https://github.com/rancher/rke2/pull/2385)
* Updated CNI ports per Slack feedback [(#2386)](https://github.com/rancher/rke2/pull/2386)
* [docs] update windows requirements and list of args [(#2394)](https://github.com/rancher/rke2/pull/2394)
* Adding Windows installer vagrant tests. [(#2398)](https://github.com/rancher/rke2/pull/2398)
* Update k8s to 1.23.3 [(#2397)](https://github.com/rancher/rke2/pull/2397)
* Add ADR template + ADR for RPM publishing [(#2402)](https://github.com/rancher/rke2/pull/2402)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.23.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1233) |
| Etcd            | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1)                            |
| Containerd      | [v1.5.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.9-k3s1)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                              |
| CNI Plugins     | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1)                      |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
| CoreDNS         | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5)                                  |
| Ingress-Nginx   | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases)                                     |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.6)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1)<br/>[Calico v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) | Yes            |
| Calico          | [v3.21.2](https://docs.projectcalico.org/release-notes/#v3212)                                                                                                                      | No             |
| Cilium          | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.3+rke2r1
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
<!-- v1.23.1+rke2r2 -->
This release fixes several issues, including an issue with the --agent-token flag that could prevent servers from joining managed etcd clusters when this flag was used.
<!--
This release is RKE2's first in the v1.23 line. This release updates Kubernetes to v1.23.1.

As this release includes a number of significant changes from previous versions, we will not make v1.23 available via the stable release channel until v1.23.2+rke2r1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#urgent-upgrade-notes).
-->

## Known Issues
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.1+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Changes since RKE2 v1.23.1+rke2r1
* Bump versions for v1.23.1-rc1+rke2r2 ([#2331](https://github.com/rancher/rke2/pull/2331))
* Update calico to v3.21.2 ([#2322](https://github.com/rancher/rke2/pull/2322))
* Add s390x to install script ([#2260](https://github.com/rancher/rke2/pull/2260))
* Bump stable to v1.22.5+rke2r1; add v1.23 channel ([#2313](https://github.com/rancher/rke2/pull/2313))
<!-- https://github.com/rancher/rke2/compare/v1.23.1+rke2r1...v1.23.1+rke2r2 -->

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1231) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s3](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s2) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.8) |

### Available CNIs
| Component | Version | FIPS Compliant |
|---|---|---|
| Canal (Default) | [Flannel v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1)<br/>[Calico v3.20.2](https://docs.projectcalico.org/archive/v3.20/release-notes/#v3201)  | Yes |
| Calico | [v3.21.2](https://docs.projectcalico.org/release-notes/#v3212) | No |
| Cilium | [v1.10.4](https://github.com/cilium/cilium/releases/tag/v1.10.4) | No |
| Multus | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1) | No |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
<!-- v1.23.1+rke2r1 -->
This release is RKE2's first in the v1.23 line. This release updates Kubernetes to v1.23.1.

As this release includes a number of significant changes from previous versions, we will not make v1.23 available via the stable release channel until v1.23.2+rke2r1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#urgent-upgrade-notes).

## Known Issues
* [#2323](https://github.com/rancher/rke2/issues/2323): When using embedded etcd and the initial server is started with --agent-token, and this agent-only token does not match the server --token value, additional servers cannot join the cluster. This will be fixed in a subsequent release.
- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.23.1+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Changes since RKE2 v1.22.5+rke2r1 (when the **release-1.22** branch was forked from **master**)
* Disable windows crictl version check ([#2308](https://github.com/rancher/rke2/pull/2308))
* Bump versions for v1.23.1-rc1+rke2r1 ([#2307](https://github.com/rancher/rke2/pull/2307))
<!-- https://github.com/rancher/rke2/compare/ce3e572376cbb1d8157f46e2ae29d7d7834067f1...v1.23.1+rke2r1 -->

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1231) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s3](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s2) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
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
