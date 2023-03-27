| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.26.2+rke2r1](rke2-v1.26#release-v1262rke2r1) | Mar 10 2023 | 03/10/23 | 2023-03-10 |
| [v1.26.1+rke2r1](rke2-v1.26#release-v1261rke2r1) | Jan 26 2023 | 01/26/23 | 2023-01-26 |
| [v1.26.0+rke2r2](rke2-v1.26#release-v1260rke2r2) | Jan 10 2023 | 01/10/23 | 2023-01-10 |
| [v1.26.0+rke2r1](rke2-v1.26#release-v1260rke2r1) | Dec 15 2022 | 12/15/22 | 2022-12-15 |



# Release v1.26.2+rke2r1
<!-- v1.26.2+rke2r1 -->

This release updates Kubernetes to v1.26.2, and fixes a number of issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.26.1+rke2r1:

* Remove pod logs as part of killall [(#3821)](https://github.com/rancher/rke2/pull/3821)
* Update channel server [(#3853)](https://github.com/rancher/rke2/pull/3853)
* Bump cilium images [(#3802)](https://github.com/rancher/rke2/pull/3802)
* Update canal chart to v3.25.0-build2023020901 [(#3877)](https://github.com/rancher/rke2/pull/3877)
* Bump wharfie and go-containerregistry [(#3863)](https://github.com/rancher/rke2/pull/3863)
* Update Calico to v3.25.0 [(#3887)](https://github.com/rancher/rke2/pull/3887)
* Updated RKE2 README's header image to point to the new rke2-docs repo [(#3727)](https://github.com/rancher/rke2/pull/3727)
* Bump K3s version [(#3897)](https://github.com/rancher/rke2/pull/3897)
  * Fixed an issue where leader-elected controllers for managed etcd did not run on etcd-only nodes
  * RKE2 now functions properly when the cluster CA certificates are signed by an existing root or intermediate CA. You can find a sample script for generating such certificates before RKE2 starts in the K3s repo at [contrib/util/certs.sh](https://github.com/k3s-io/k3s/blob/master/contrib/util/certs.sh).
  * RKE2 now supports `kubeadm` style join tokens. `rke2 token create` now creates join token secrets, optionally with a limited TTL.
  * RKE2 agents joined with an expired or deleted token stay in the cluster using existing client certificates via the NodeAuthorization admission plugin, unless their Node object is deleted from the cluster.
  * ServiceLB now honors the Service's ExternalTrafficPolicy. When set to Local, the LoadBalancer will only advertise addresses of Nodes with a Pod for the Service, and will not forward traffic to other cluster members. (ServiceLB is still disabled by default)
* Bump K3s commit [(#3905)](https://github.com/rancher/rke2/pull/3905)
* Add bootstrap token auth handler [(#3920)](https://github.com/rancher/rke2/pull/3920)
* Add support for legacy kubelet logging flags [(#3932)](https://github.com/rancher/rke2/pull/3932)
* Bump helm-controller/klipper-helm [(#3936)](https://github.com/rancher/rke2/pull/3936)
  * The embedded helm-controller job image now correctly handles upgrading charts that contain resource types that no longer exist on the target Kubernetes version. This includes properly handling removal of PodSecurityPolicy resources when upgrading from <= v1.24.
* Add sig-storage snapshot controller and validation webhook [(#3944)](https://github.com/rancher/rke2/pull/3944)
* Add a quick host-path CSI snapshot to the basic CI test [(#3946)](https://github.com/rancher/rke2/pull/3946)
* Update kubernetes to v1.26.2 [(#3953)](https://github.com/rancher/rke2/pull/3953)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.26.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#v1262) |
| Etcd            | [v3.5.5-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.5-k3s1)                       |
| Containerd      | [v1.6.15-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.15-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                                  |
| Helm-controller | [v0.13.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.2)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.21.1](https://github.com/k3s-io/flannel/releases/tag/v0.21.1)<br/>[Calico v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250) | Yes            |
| Calico          | [v3.25.0](https://projectcalico.docs.tigera.io/archive/v3.25/release-notes/#v3250)                                                                    | No             |
| Cilium          | [v1.12.5](https://github.com/cilium/cilium/releases/tag/v1.12.5)                                                                                                                      | No             |
| Multus          | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)                                                                                                    | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.26.1+rke2r1
<!-- v1.26.1+rke2r1 -->

This release updates Kubernetes to v1.26.1 to backport registry changes and fix two critical issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.26.0+rke2r2:

* Don't clean up kube-proxy every time agents start [(#3737)](https://github.com/rancher/rke2/pull/3737)
* Add rke2 e2e test run script and adjustments [(#3766)](https://github.com/rancher/rke2/pull/3766)
* Update channels [(#3768)](https://github.com/rancher/rke2/pull/3768)
* Bump containerd to v1.6.15-k3s1 [(#3767)](https://github.com/rancher/rke2/pull/3767)
* Fix typos [(#3741)](https://github.com/rancher/rke2/pull/3741)
* Generate report and upload test results [(#3771)](https://github.com/rancher/rke2/pull/3771)
* Update multus to v3.9.3 and whereabouts to v0.6 [(#3789)](https://github.com/rancher/rke2/pull/3789)
* Bump harvester cloud provider and harvester csi driver [(#3781)](https://github.com/rancher/rke2/pull/3781)
* Bump K3s version for tls-cipher-suites and etcd snapshot conflict fix [(#3772)](https://github.com/rancher/rke2/pull/3772)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.26.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#v1261) |
| Etcd            | [v3.5.5-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.5-k3s1)                       |
| Containerd      | [v1.6.15-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.15-k3s1)                      |
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
| Multus          | [v3.9.3](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9.3)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.26.1+rke2r1
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
# Release v1.26.0+rke2r2
<!-- v1.26.0+rke2r2 -->

This release updates containerd to v1.6.14 to resolve an issue where pods would lose their CNI information when containerd was restarted.

## Changes since v1.26.0+rke2r1:

* Bump containerd to v1.6.14-k3s1 [(#3746)](https://github.com/rancher/rke2/pull/3746)
  * The embedded containerd version has been bumped to v1.6.14-k3s1. This includes a backported fix for [containerd/7843](https://github.com/containerd/containerd/issues/7843) which caused pods to lose their CNI info when containerd was restarted, which in turn caused the kubelet to recreate the pod. 
  * Windows agents now use the k3s fork of containerd, which includes support for registry rewrites.

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.26.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#v1260) |
| Etcd            | [v3.5.5](https://github.com/k3s-io/etcd/releases/tag/v3.5.5)                                      |
| Containerd      | [v1.6.14-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.14-k3s1)                    |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                |
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.20.2](https://github.com/k3s-io/flannel/releases/tag/v0.20.2)<br/>[Calico v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245) | Yes            |
| Calico          | [v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245)                                                                                      | No             |
| Cilium          | [v1.12.4](https://github.com/cilium/cilium/releases/tag/v1.12.4)                                                                                                        | No             |
| Multus          | [v3.9](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9)                                                                                            | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.26.0+rke2r1
<!-- v1.26.0+rke2r1 -->

> ## ⚠️ WARNING
> This release is affected by https://github.com/containerd/containerd/issues/7843, which causes the kubelet to restart all pods whenever RKE2 is restarted. For this reason, we have removed this RKE2 release from the channel server. Please use `v1.26.0+rke2r2` instead.

This release is RKE2's first in the v1.26 line. This release updates Kubernetes to v1.26.0.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#urgent-upgrade-notes).


## Changes since v1.25.4+rke2r1:

* Bump ingress-nginx ([#3703](https://github.com/rancher/rke2/pull/3703))
* Fixed cilium chart when enabled hubble images ([#3687](https://github.com/rancher/rke2/pull/3687))
* Update kubernetes to v1.26.0 ([#3599](https://github.com/rancher/rke2/pull/3599))
* Bump ingress-nginx to 1.4.1 ([#3653](https://github.com/rancher/rke2/pull/3653))
* Bump k3s version for v1.25 ([#3646](https://github.com/rancher/rke2/pull/3646))
* Bump metrics-server tag ([#3647](https://github.com/rancher/rke2/pull/3647))
* Updated cilium version and added new cilium images ([#3642](https://github.com/rancher/rke2/pull/3642))
* Fix jenkinsfile typo and clarify support for oracle in tf automation ([#3611](https://github.com/rancher/rke2/pull/3611))
* Update rke2-calico chart to v3.24.501 ([#3620](https://github.com/rancher/rke2/pull/3620))
* Update canal version ([#3625](https://github.com/rancher/rke2/pull/3625))
* Update rke2-multus chart to v3.9-build2022102805 ([#3622](https://github.com/rancher/rke2/pull/3622))
* Support autodetection interface methods in windows ([#3615](https://github.com/rancher/rke2/pull/3615))
* Add rke2 standalone install script for windows ([#3608](https://github.com/rancher/rke2/pull/3608))
* Update tf variable for aws to be more clear ([#3609](https://github.com/rancher/rke2/pull/3609))
* Add more tests to the windows env ([#3594](https://github.com/rancher/rke2/pull/3594))
* Fix aws s3 artifact upload issues ([#3601](https://github.com/rancher/rke2/pull/3601))
* Create upgrade test in tf and refactor to allow running packages separately ([#3583](https://github.com/rancher/rke2/pull/3583))
* Dualstack e2e test fix and additional netpol test ([#3574](https://github.com/rancher/rke2/pull/3574))
* Remove old docs ([#3584](https://github.com/rancher/rke2/pull/3584))
* Switching from gcp gcs to aws s3 buckets ([#3563](https://github.com/rancher/rke2/pull/3563))
* Take nodeip into account to configure the calico networks ([#3530](https://github.com/rancher/rke2/pull/3530))
* Refactor windows calico code ([#3543](https://github.com/rancher/rke2/pull/3543))
* Bump k3s and component versions ([#3577](https://github.com/rancher/rke2/pull/3577))
* Terminate pods directly via cri instead of waiting for kubelet cleanup ([#3567](https://github.com/rancher/rke2/pull/3567))
* Utilize jenkins env vars for required cluster creation variables ([#3576](https://github.com/rancher/rke2/pull/3576))
* Update channels.yaml for november ([#3575](https://github.com/rancher/rke2/pull/3575))
* Don't try to validate linux cis profile compliance on windows ([#3568](https://github.com/rancher/rke2/pull/3568))

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.26.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#v1260) |
| Etcd            | [v3.5.5](https://github.com/k3s-io/etcd/releases/tag/v3.5.5)                                      |
| Containerd      | [v1.6.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.12-k3s1)                    |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2)                   |
| CoreDNS         | [v1.9.3](https://github.com/coredns/coredns/releases/tag/v1.9.3)                                  |
| Ingress-Nginx   | [4.1.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.0)                |
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1)                         |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.20.2](https://github.com/k3s-io/flannel/releases/tag/v0.20.2)<br/>[Calico v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245) | Yes            |
| Calico          | [v3.24.5](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245)                                                                                      | No             |
| Cilium          | [v1.12.4](https://github.com/cilium/cilium/releases/tag/v1.12.4)                                                                                                        | No             |
| Multus          | [v3.9](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.9)                                                                                            | No             |

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
