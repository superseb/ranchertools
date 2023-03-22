<!-- v1.25.7+rke2r1 -->

This release updates Kubernetes to v1.25.7, and fixes a number of issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.6+rke2r1:

* Don't handle kube-proxy in static pod cleanup [(#3835)](https://github.com/rancher/rke2/pull/3835)
* Bump cilium images [(#3827)](https://github.com/rancher/rke2/pull/3827)
* Update canal chart to v3.25.0-build2023020901 [(#3886)](https://github.com/rancher/rke2/pull/3886)
* Remove pod logs as part of killall [(#3867)](https://github.com/rancher/rke2/pull/3867)
* Bump wharfie and go-containerregistry [(#3864)](https://github.com/rancher/rke2/pull/3864)
* Update Calico to v3.25.0 [(#3890)](https://github.com/rancher/rke2/pull/3890)
* Bump K3s version [(#3898)](https://github.com/rancher/rke2/pull/3898)
  * Fixed an issue where leader-elected controllers for managed etcd did not run on etcd-only nodes
  * RKE2 now functions properly when the cluster CA certificates are signed by an existing root or intermediate CA. You can find a sample script for generating such certificates before RKE2 starts in the K3s repo at [contrib/util/certs.sh](https://github.com/k3s-io/k3s/blob/master/contrib/util/certs.sh).
  * RKE2 now supports `kubeadm` style join tokens. `rke2 token create` now creates join token secrets, optionally with a limited TTL.
  * RKE2 agents joined with an expired or deleted token stay in the cluster using existing client certificates via the NodeAuthorization admission plugin, unless their Node object is deleted from the cluster.
  * ServiceLB now honors the Service's ExternalTrafficPolicy. When set to Local, the LoadBalancer will only advertise addresses of Nodes with a Pod for the Service, and will not forward traffic to other cluster members. (ServiceLB is still disabled by default)
* Bump K3s commit [(#3906)](https://github.com/rancher/rke2/pull/3906)
* Add bootstrap token auth handler [(#3921)](https://github.com/rancher/rke2/pull/3921)
* Bump helm-controller/klipper-helm [(#3937)](https://github.com/rancher/rke2/pull/3937)
  * The embedded helm-controller job image now correctly handles upgrading charts that contain resource types that no longer exist on the target Kubernetes version. This includes properly handling removal of PodSecurityPolicy resources when upgrading from <= v1.24.
* Add sig-storage snapshot controller and validation webhook [(#3943)](https://github.com/rancher/rke2/pull/3943)
* Add a quick host-path CSI snapshot to the basic CI test [(#3947)](https://github.com/rancher/rke2/pull/3947)
* Update kubernetes to v1.25.7 [(#3952)](https://github.com/rancher/rke2/pull/3952)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1257) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
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
<!-- v1.25.6+rke2r1 -->

This release updates Kubernetes to v1.25.6 to backport registry changes and fix two critical issues.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.5+rke2r2:

* Update multus to v3.9.3 and whereabouts to v0.6 [(#3793)](https://github.com/rancher/rke2/pull/3793)
* Generate report and upload test results (#3771) [(#3794)](https://github.com/rancher/rke2/pull/3794)
* Bump harvester cloud provider and harvester csi driver [(#3785)](https://github.com/rancher/rke2/pull/3785)
* Bump containerd to v1.6.15-k3s1 [(#3778)](https://github.com/rancher/rke2/pull/3778)
* Bump K3s version for tls-cipher-suites fix [(#3799)](https://github.com/rancher/rke2/pull/3799)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1256) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
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
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.25.6+rke2r1
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
<!-- v1.25.5+rke2r2 -->

This release updates containerd to v1.6.14 to resolve an issue where pods would lose their CNI information when containerd was restarted.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.5+rke2r1:

* Bump containerd to v1.6.14-k3s1 [(#3746)](https://github.com/rancher/rke2/pull/3746)
  * The embedded containerd version has been bumped to v1.6.14-k3s1. This includes a backported fix for [containerd/7843](https://github.com/containerd/containerd/issues/7843) which caused pods to lose their CNI info when containerd was restarted, which in turn caused the kubelet to recreate the pod. 
  * Windows agents now use the k3s fork of containerd, which includes support for registry rewrites.

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1255) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.6.14-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.14-k3s1)                      |
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
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.25.5+rke2r2
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
<!-- v1.25.5+rke2r1 -->

> ## ⚠️ WARNING
> This release is affected by https://github.com/containerd/containerd/issues/7843, which causes the kubelet to restart all pods whenever RKE2 is restarted. For this reason, we have removed this RKE2 release from the channel server. Please use `v1.25.5+rke2r2` instead.

This release update Kubernetes to v1.25.5+rke2r1, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.4+rke2r1:

* Don't try to validate Linux CIS profile compliance on Windows [(#3568)](https://github.com/rancher/rke2/pull/3568)
* Update channels.yaml for November [(#3575)](https://github.com/rancher/rke2/pull/3575)
* Utilize Jenkins env vars for required cluster creation variables [(#3576)](https://github.com/rancher/rke2/pull/3576)
* Terminate pods directly via CRI instead of waiting for kubelet cleanup [(#3567)](https://github.com/rancher/rke2/pull/3567)
* Bump K3s and component versions [(#3577)](https://github.com/rancher/rke2/pull/3577)
* Refactor Windows Calico code [(#3543)](https://github.com/rancher/rke2/pull/3543)
* Take nodeIP into account to configure the calico networks [(#3530)](https://github.com/rancher/rke2/pull/3530)
* Switching from GCP gcs to AWS s3 buckets [(#3563)](https://github.com/rancher/rke2/pull/3563)
* Remove old docs [(#3584)](https://github.com/rancher/rke2/pull/3584)
* DualStack e2e test fix and additional netpol test [(#3574)](https://github.com/rancher/rke2/pull/3574)
* Create upgrade test in TF and refactor to allow running packages separately [(#3583)](https://github.com/rancher/rke2/pull/3583)
* Fix aws s3 artifact upload issues [(#3601)](https://github.com/rancher/rke2/pull/3601)
* Add more tests to the windows env [(#3594)](https://github.com/rancher/rke2/pull/3594)
* Update tf variable for AWS to be more clear [(#3609)](https://github.com/rancher/rke2/pull/3609)
* Add rke2 standalone install script for Windows [(#3608)](https://github.com/rancher/rke2/pull/3608)
* Support autodetection interface methods in windows [(#3615)](https://github.com/rancher/rke2/pull/3615)
* Update rke2-multus chart to v3.9-build2022102805 [(#3622)](https://github.com/rancher/rke2/pull/3622)
* Update Canal version [(#3625)](https://github.com/rancher/rke2/pull/3625)
* Update rke2-calico chart to v3.24.501 [(#3620)](https://github.com/rancher/rke2/pull/3620)
* Fix Jenkinsfile typo and clarify support for oracle in TF automation [(#3611)](https://github.com/rancher/rke2/pull/3611)
* Updated cilium version and added new cilium images [(#3642)](https://github.com/rancher/rke2/pull/3642)
* Bump metrics-server tag [(#3647)](https://github.com/rancher/rke2/pull/3647)
* Bump K3s version for v1.25 [(#3646)](https://github.com/rancher/rke2/pull/3646)
* Bump ingress-nginx to 1.4.1 [(#3653)](https://github.com/rancher/rke2/pull/3653)
* Update to version 1.25.5 [(#3670)](https://github.com/rancher/rke2/pull/3670)
* Bump K3s and containerd versions for v1.25 [(#3675)](https://github.com/rancher/rke2/pull/3675)
* [Backport v1.25] Fixed cilium chart when enabled hubble images [(#3688)](https://github.com/rancher/rke2/pull/3688)
* Bump ingress-nginx [(#3709)](https://github.com/rancher/rke2/pull/3709)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1255) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.6.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.12-k3s1)                      |
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
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.25.5+rke2r1
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
<!-- v1.25.4+rke2r1 -->

This release update Kubernetes to v1.25.4+rke2r1, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.3+rke2r1:

* Updated cilium chart for private registry [(#3483)](https://github.com/rancher/rke2/pull/3483)
* Fixed dualstack e2e tests [(#3472)](https://github.com/rancher/rke2/pull/3472)
* Fix handling of manifests with multiple resources [(#3470)](https://github.com/rancher/rke2/pull/3470)
* Remove the CNI plugin binaries when uninstalling rke2 [(#3500)](https://github.com/rancher/rke2/pull/3500)
* Sync docs with rke2-docs [(#3506)](https://github.com/rancher/rke2/pull/3506)
* Update Cilium and use portmap as default [(#3507)](https://github.com/rancher/rke2/pull/3507)
* Revert "Unconditionally set egress-selector-mode to disabled" [(#3495)](https://github.com/rancher/rke2/pull/3495)
* Put sensitive variables in Jenkins creds [(#3514)](https://github.com/rancher/rke2/pull/3514)
* Typo in the -Channel option [(#3521)](https://github.com/rancher/rke2/pull/3521)
* Read VXLAN_ADAPTER env and use it to create the external network [(#3517)](https://github.com/rancher/rke2/pull/3517)
* Update Trivy version to `0.31.3` [(#3348)](https://github.com/rancher/rke2/pull/3348)
* Bump K3s version for v1.25 [(#3527)](https://github.com/rancher/rke2/pull/3527)
* Bump vsphere charts [(#3537)](https://github.com/rancher/rke2/pull/3537)
* Use the Cilium chart that fixes the portmap issue with system_default… [(#3553)](https://github.com/rancher/rke2/pull/3553)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1254) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.6.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.8-k3s1)                      |
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
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.25.4+rke2r1
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
<!-- v1.25.3+rke2r1 -->

This release update Kubernetes to v1.25.3+rke2r1, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.2+rke2r1:

* Update docs with extra option [(#3336)](https://github.com/rancher/rke2/pull/3336)
* Upgrade Calico version on Windows [(#3346)](https://github.com/rancher/rke2/pull/3346)
* Update docs with iptables requirement on canal and calico [(#3367)](https://github.com/rancher/rke2/pull/3367)
* Add support for Calico interface overrides for Windows [(#3375)](https://github.com/rancher/rke2/pull/3375)
* Update latest in channels.yaml to v1.24.6+rke2r1 [(#3389)](https://github.com/rancher/rke2/pull/3389)
* Bump vsphere csi/cpi charts and images [(#3356)](https://github.com/rancher/rke2/pull/3356)
* The embedded metrics-server version has been bumped to v0.6.1 [(#3399)](https://github.com/rancher/rke2/pull/3399)
* Update docs for multus with cilium [(#3326)](https://github.com/rancher/rke2/pull/3326)
* Bump k3s for servicelb ccm change; add servicelb support [(#3404)](https://github.com/rancher/rke2/pull/3404)
* Add v1.25 channel to the channel server [(#3382)](https://github.com/rancher/rke2/pull/3382)
* Allow CNI none on windows [(#3403)](https://github.com/rancher/rke2/pull/3403)
* Update fips_support.md [(#3405)](https://github.com/rancher/rke2/pull/3405)
* Change static pod uid/hash generation/checking [(#3415)](https://github.com/rancher/rke2/pull/3415)
* Pass through kubelet-args to temporary kubelet [(#3418)](https://github.com/rancher/rke2/pull/3418)
* Initial terraform automation [(#3390)](https://github.com/rancher/rke2/pull/3390)
* Bump vsphere CSI to v2.6.1 [(#3420)](https://github.com/rancher/rke2/pull/3420)
* Updated Canal chart to fix token renewal from calico-node [(#3426)](https://github.com/rancher/rke2/pull/3426)
* E2E: Parallel and Logging Improvements [(#3433)](https://github.com/rancher/rke2/pull/3433)
* Bump K3s version for v1.25 [(#3434)](https://github.com/rancher/rke2/pull/3434)
* Update canal to v3.24.1 [(#3444)](https://github.com/rancher/rke2/pull/3444)
* Update release docs to include content discussed during release retro [(#3421)](https://github.com/rancher/rke2/pull/3421)
* Update documentation with PSP removal [(#3360)](https://github.com/rancher/rke2/pull/3360)
* October RKE2 K8s Update v1.25.3 [(#3460)](https://github.com/rancher/rke2/pull/3460)
* Bump CCM image tag [(#3465)](https://github.com/rancher/rke2/pull/3465)
* Add fapolicyd configuration rules [(#3416)](https://github.com/rancher/rke2/pull/3416)
* Prevent script fail when `fapolicyd` doesn't exist [(#3478)](https://github.com/rancher/rke2/pull/3478)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1253) |
| Etcd            | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                       |
| Containerd      | [v1.6.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.8-k3s1)                      |
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
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.25.3+rke2r1
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
<!-- v1.25.2+rke2r1 -->

This release update Kubernetes to v1.25.2+rke2r1, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.25.0+rke2r1:

* Update for 1.25 patches [(#3352)](https://github.com/rancher/rke2/pull/3352)
* Add exception for tigera-operator namespace (#3365) [(#3366)](https://github.com/rancher/rke2/pull/3366)
* Update k8s to 1.25.2 [(#3374)](https://github.com/rancher/rke2/pull/3374)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1252) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.6.8-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.6.8-k3s2)                      |
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
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.25.2+rke2r1
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
<!-- v1.25.0+rke2r1 -->

This release is RKE2's first in the v1.25 line. This release updates Kubernetes to v1.25.0.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#urgent-upgrade-notes).

**Important Notes**

1. If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

    You may retrieve the token value from any server already joined to the cluster:
    ```bash
    cat /var/lib/rancher/rke2/server/token
    ```

2. Kubernetes v1.25 removes the beta `PodSecurityPolicy` admission plugin. Please follow the [upstream documentation](https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp/) to migrate from PSP if using the built-in PodSecurity Admission Plugin, prior to upgrading to v1.25.0+rke2r1.

3. RKE2 now supports version 1.23 of the CIS Benchmark for Kubernetes. The legacy CIS 1.5 and 1.6 profiles (`profile: cis-1.5` and `profile: cis-1.6`) have been removed as they do not apply to Kubernetes 1.25. Servers using one of the legacy profiles must be updated to specify the `cis-1.23` profile when upgrading to RKE2 1.25, or RKE2 will fail to start.

## Changes since v1.24.4+rke2r1:

* Update Cilium version and remove startup-script [(#3274)](https://github.com/rancher/rke2/pull/3274)
* Update channel server stable to 1.24.4 [(#3269)](https://github.com/rancher/rke2/pull/3269)
* Update canal version [(#3272)](https://github.com/rancher/rke2/pull/3272)
* Bump the cilium chart version [(#3289)](https://github.com/rancher/rke2/pull/3289)
* Rework vagrant install tests [(#3237)](https://github.com/rancher/rke2/pull/3237)
* Add PSA to Kubernetes v1.25 [(#3282)](https://github.com/rancher/rke2/pull/3282)
* Update Kubernetes image to v1.25.0-rke2r1-build20220901 [(#3295)](https://github.com/rancher/rke2/pull/3295)
* Fix static pod cleanup when using container-runtime-endpoint [(#3308)](https://github.com/rancher/rke2/pull/3308)
* Bump containerd v1.6.8 / runc v1.1.4 [(#3300)](https://github.com/rancher/rke2/pull/3300)
* Update calico to v3.23.3 [(#3317)](https://github.com/rancher/rke2/pull/3317)
* Bump K3s version for v1.25 [(#3323)](https://github.com/rancher/rke2/pull/3323)
* Update install script with option to skip reload [(#3248)](https://github.com/rancher/rke2/pull/3248)
* Add exception for cis-operator-system namespace [(#3324)](https://github.com/rancher/rke2/pull/3324)
* Fix config directory permissions [(#3338)](https://github.com/rancher/rke2/pull/3338)
* Update calico to v3.24.1 [(#3340)](https://github.com/rancher/rke2/pull/3340)

## Packaged Component Versions
| Component       | Version                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------- |
| Kubernetes      | [v1.25.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md#v1250) |
| Etcd            | [v3.5.4](https://github.com/k3s-io/etcd/releases/tag/v3.5.4)                       |
| Containerd      | [v1.6.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.6.8-k3s1)                      |
| Runc            | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                              |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                   |
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

## Helpful Links

As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
