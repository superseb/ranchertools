| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| v1.20.15+rke2r2 | Feb 23 2022 | 02/23/22 | 2022-02-23 |
| v1.20.15+rke2r1 | Jan 26 2022 | 01/26/22 | 2022-01-26 |
| v1.20.14+rke2r2 | Jan 11 2022 | 01/11/22 | 2022-01-11 |
| v1.20.14+rke2r1 | Dec 23 2021 | 12/23/21 | 2021-12-23 |
| v1.20.13+rke2r1 | Dec 02 2021 | 12/02/21 | 2021-12-02 |
| v1.20.12+rke2r1 | Oct 30 2021 | 10/30/21 | 2021-10-30 |
| v1.20.11+rke2r2 | Oct 07 2021 | 10/07/21 | 2021-10-07 |
| v1.20.11+rke2r1 | Sep 23 2021 | 09/23/21 | 2021-09-23 |
| v1.20.10+rke2r1 | Aug 26 2021 | 08/26/21 | 2021-08-26 |
| v1.20.9+rke2r2 | Aug 09 2021 | 08/09/21 | 2021-08-09 |
| v1.20.8+rke2r1 | Jun 23 2021 | 06/23/21 | 2021-06-23 |
| v1.20.7+rke2r2 | May 26 2021 | 05/26/21 | 2021-05-26 |
| v1.20.7+rke2r1 | May 22 2021 | 05/22/21 | 2021-05-22 |
| v1.20.6+rke2r1 | Apr 21 2021 | 04/21/21 | 2021-04-21 |
| v1.20.5+rke2r1 | Apr 02 2021 | 04/02/21 | 2021-04-02 |
| v1.20.4+rke2r1 | Mar 09 2021 | 03/09/21 | 2021-03-09 |



# Release v1.20.15+rke2r2

-----
# Release v1.20.15+rke2r1
<!-- v1.20.15+rke2r1 -->

This release updates Kubernetes to v1.20.15, fixes a number of minor issues, and includes security updates.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since v1.20.14+rke2r2:

* [release-1.20] Update etcd and k3s [(#2369)](https://github.com/rancher/rke2/pull/2369)
* [release-1.20] Update RKE2 k8s version for January release [(#2372)](https://github.com/rancher/rke2/pull/2372)

## Packaged Component Versions
| Component       | Version                                                                                             |
| --------------- | -------------------------------------------------------------------------------------------------   |
| Kubernetes      | [v1.20.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12015) |
| Etcd            | [v3.4.18-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.18-k3s1)                            |
| Containerd      | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.12-k3s1)                      |
| Runc            | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3)                                |
| CNI Plugins     | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.8.7)                        |
| Metrics-server  | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0)                     |
| CoreDNS         | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5)                                    |
| Ingress-Nginx   | [4.0.3](https://github.com/kubernetes/ingress-nginx/releases)                                       |
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7)                           |

### Available CNIs
| Component       | Version                                                                                                                                                                             | FIPS Compliant |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Canal (Default) | [Flannel v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1)<br/>[Calico v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) | Yes            |
| Calico          | [v3.19.2](https://docs.projectcalico.org/release-notes/#v3192)                                                                                                                      | No             |
| Cilium          | [v1.9.604](https://github.com/cilium/cilium/releases/tag/v1.9.6)                                                                                                                      | No             |
| Multus          | [v3.7.1](https://github.com/k8snetworkplumbingwg/multus-cni/releases/tag/v3.7.1)                                                                                                    | No             |

## Known Issues

- [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:

```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.15+rke2r1
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
# Release v1.20.14+rke2r2
<!-- v1.20.14+rke2r2 -->
This release fixes several issues, including an issue with the --agent-token flag that could prevent servers from joining managed etcd clusters when this flag was used.
<!--
This release updates Kubernetes to v1.20.14, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12013).
-->

## Known Issues
* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.11+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Changes since v1.20.14+rke2r1:
* Bump versions for v1.20.14-rc1+rke2r2 ([#2334](https://github.com/rancher/rke2/pull/2334))
* Update canal chart to fix bug ([#2310](https://github.com/rancher/rke2/pull/2310))
<!-- https://github.com/rancher/rke2/compare/v1.20.14+rke2r1...v1.20.14+rke2r2 -->

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.14](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12014) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [v4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.20.14+rke2r1
<!-- v1.20.14+rke2r1 -->
This release updates Kubernetes to v1.20.14, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12013).

## Known Issues
* [#2323](https://github.com/rancher/rke2/issues/2323): When using embedded etcd and the initial server is started with --agent-token, and this agent-only token does not match the server --token value, additional servers cannot join the cluster. This will be fixed in a subsequent release.
* [#1447](https://github.com/rancher/rke2/issues/1447): When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.11+rke2r1
rke2 server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT> --token <token used in the original cluster>
rke2-killall.sh
systemctl enable rke2-server
systemctl start rke2-server
```

## Changes since v1.20.13+rke2r1:
* Update wharfie for tar path separator fix ([#2304](https://github.com/rancher/rke2/pull/2304))
* Bump versions for v1.20.14-rc3+rke2r1 ([#2299](https://github.com/rancher/rke2/pull/2299))
* Add check for etcd group (#2290) ([#2295](https://github.com/rancher/rke2/pull/2295))
* Bump RKE2 to v1.20.14-rc2+rke2r1 ([#2286](https://github.com/rancher/rke2/pull/2286))
* Bump K3s to v1.21.8-k3s1 ([#2283](https://github.com/rancher/rke2/pull/2283))
* Bump RKE2 to v1.20.14-rc1+rke2r1 ([#2274](https://github.com/rancher/rke2/pull/2274))
* Update K3s in release-1.20 ([#2265](https://github.com/rancher/rke2/pull/2265))
* Bump RKE2 to v1.20.13-rc1+rke2r2 ([#2257](https://github.com/rancher/rke2/pull/2257))
* Add startup hook to watch/delete static pods on node delete ([#2251](https://github.com/rancher/rke2/pull/2251))
* Bump k3s and related modules ([#2241](https://github.com/rancher/rke2/pull/2241))
* Adding certificate rotation command to rke2 ([#2225](https://github.com/rancher/rke2/pull/2225))
* Remove socat from dockerfile (#2210) ([#2212](https://github.com/rancher/rke2/pull/2212))
<!-- https://github.com/rancher/rke2/compare/v1.20.13+rke2r1...v1.20.14+rke2r1 -->

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.14](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12014) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [v4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.20.13+rke2r1
<!-- v1.20.13+rke2r1 -->
This release updates Kubernetes to v1.20.13, fixes a number of minor issues, and includes security updates.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12012).

## Changes since v1.20.12+rke2r1:

* Bump runc on release-1.20 branch [(#2117)](https://github.com/rancher/rke2/pull/2117)
* Add etcd extra-args support to RKE2  [(#2140)](https://github.com/rancher/rke2/pull/2140)
* Bump K3s for parser fixes [(#2142)](https://github.com/rancher/rke2/pull/2142)
* Bump Go and k3s versions [(#2149)](https://github.com/rancher/rke2/pull/2149)
* Backport chart bumps from master [(#2170)](https://github.com/rancher/rke2/pull/2170)
* Update k8s v1.20.13 [(#2182)](https://github.com/rancher/rke2/pull/2182)
* Enable Rke2 parser to skip flags [(#2198)](https://github.com/rancher/rke2/pull/2198)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.13](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12013) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| CNI Plugins | [v0.9.1](https://github.com/containernetworking/plugins/releases/tag/v0.9.1) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| CoreDNS | [v1.8.5](https://github.com/coredns/coredns/releases/tag/v1.8.5) |
| Ingress-Nginx | [v4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |

## Known Issues
* [#2309](https://github.com/rancher/rke2/issues/2309) - Custom Cluster CIDRs are not honored when using the Canal CNI Plugin. If you specify a `--cluster-cidr` other than 10.42.0.0/16, you should apply the following manifest to your cluster:

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

* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.11+rke2r1
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
# Release v1.20.12+rke2r1
<!-- v1.20.12+rke2r1 -->
This release updates Kubernetes to v1.20.12, fixes a number of minor issues, and includes an update to ingress-nginx that resolves CVE-2021-25742.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12011).

## Changes since [v1.20.11+rke2r2](https://github.com/rancher/rke2/releases/tag/v1.20.11%2Brke2r2)
* Update Kubernetes to v1.20.12 ([#2060](https://github.com/rancher/rke2/pull/2060))
* The ingress-nginx helm chart has been upgraded to version 4.0.3. ([#1942](https://github.com/rancher/rke2/pull/1942))  
  This resolves CVE-2021-25742.
* Servers will no longer occasionally create duplicate static pods during upgrades. ([#1968](https://github.com/rancher/rke2/pull/1968))
* Servers will no longer join etcd clusters until the new member is more prepared to do so. ([#1991](https://github.com/rancher/rke2/pull/1991))
* Flannel's vxlan backend now generates its own MAC addresses, preventing systemd 242+ from changing them unexpectedly. ([#2009](https://github.com/rancher/rke2/pull/2009))
* Cluster member addresses are now updated when resetting/restoring etcd via `--cluster-reset`. ([#2031](https://github.com/rancher/rke2/pull/2031))
* The `rke2 etcd-snapshot` subcommand now honors config file settings. ([#2031](https://github.com/rancher/rke2/pull/2031))

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.12](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12012) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.11-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.1](https://github.com/opencontainers/runc/releases/tag/v1.0.1) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v4.0.3](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.3) |
| Helm-controller | [v0.10.6](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.6) |

## Known Issues
* [#2309](https://github.com/rancher/rke2/issues/2309) - Custom Cluster CIDRs are not honored when using the Canal CNI Plugin. If you specify a `--cluster-cidr` other than 10.42.0.0/16, you should apply the following manifest to your cluster:

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

* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.11+rke2r1
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
# Release v1.20.11+rke2r2
<!-- v1.20.11+rke2r2 -->
This release updates containerd to v1.4.11+k3s1 to address CVE-2021-41103 / GHSA-c2h3-6mxw-7mvq.
<!--
This release updates Kubernetes to v1.20.11, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12010).
-->

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since [v1.20.11+rke2r1](https://github.com/rancher/rke2/releases/tag/v1.20.11%2Brke2r1)

* Bump containerd to v1.4.11 for CVE fix [(#1912)](https://github.com/rancher/rke2/pull/1912)
* Add Permit Port Sharing Flag to Scheduler and Controller Manager (#1841) [(#1850)](https://github.com/rancher/rke2/pull/1850)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12011) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.11-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.1](https://github.com/opencontainers/runc/releases/tag/v1.0.1) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.10.6](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.6) |

## Known Issues
* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.11+rke2r1
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
# Release v1.20.11+rke2r1
<!-- v1.20.11+rke2r1 -->
This release updates Kubernetes to v1.20.11, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12010).

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since [v1.20.10+rke2r1](https://github.com/rancher/rke2/releases/tag/v1.20.10%2Brke2r1)

* Upgrade Kubernetes to v1.20.11 [(#1810)](https://github.com/rancher/rke2/issues/1810)
* Switched upstream k3s branch from master to engine-1.21 [(#1711)](https://github.com/rancher/rke2/issues/1711)
* Resolved an issue where apiaddresses in etcd were overwritten by pod ips scheduled to server nodes [(#1736)](https://github.com/rancher/rke2/issues/1736)
* Resolved an issue where apiserver cert is missing hostname SAN entries [(#1741)](https://github.com/rancher/rke2/issues/1741)
* Resolved an issue where air-gapped image rewrites failed if path began with "docker.io" [(#1785)](https://github.com/rancher/rke2/issues/1785)
* Resolved an issue where the "etcd-expose-metrics" setting caused the etcd livenessProbe to fail [(#1796)](https://github.com/rancher/rke2/issues/1796)


## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12011) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.9-k3s1) |
| Runc | [v1.0.1](https://github.com/opencontainers/runc/releases/tag/v1.0.1) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.10.6](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.6) |

## Known Issues
* [#1074](https://github.com/rancher/rke2/issues/1074#issuecomment-850670271) - Control-plane components may fail to start with "bind: address already in use" message. This will be resolved in a future release.
* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.11+rke2r1
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
# Release v1.20.10+rke2r1
<!-- v1.20.10+rke2r1 -->
This release updates Kubernetes to v1.20.10, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1209).

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since [v1.20.9+rke2r2](https://github.com/rancher/rke2/releases/tag/v1.20.9%2Brke2r2)

* Upgrade Kubernetes to v1.20.10 [(#1547)](https://github.com/rancher/rke2/issues/1547)
* Resolved an issue where restoration fails on etcd only nodes due to invalid state of load balancers [(#1658)](https://github.com/rancher/rke2/issues/1658)
* Resolved an issue with URL pruning when an etcd member would join the cluster [(#1668)](https://github.com/rancher/rke2/issues/1668)
* Resolved an issue to have RKE2 use the FQDN if cloud provider is set to AWS [(#1635)](https://github.com/rancher/rke2/pull/1635)
* Resolved an issue where S3 snapshots weren't showing in the Rancher UI [(#1579)](https://github.com/rancher/rke2/issues/1579)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12010) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.8-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.9.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.9.3) |

## Known Issues
* [#1074](https://github.com/rancher/rke2/issues/1074#issuecomment-850670271) - Control-plane components may fail to start with "bind: address already in use" message. This will be resolved in a future release.
* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.10+rke2r1
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
# Release v1.20.9+rke2r2
<!-- v1.20.9+rke2r2 -->
This release resolves issue [#1530](https://github.com/rancher/rke2/issues/1530) by building Kubernetes with the correct Go version.

**Important Note**

If your server (control-plane) nodes were not started with the `--token` CLI flag or config file key, a randomized token was generated during initial cluster startup. This key is used both for joining new nodes to the cluster, and for encrypting cluster bootstrap data within the datastore. Ensure that you retain a copy of this token, as is required when restoring from backup.

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/rke2/server/token
```

## Changes since [v1.20.9+rke2r1](https://github.com/rancher/rke2/releases/tag/v1.20.9%2Brke2r1)
* Custom Resource validation no longer fails with `Invalid value: "null"` when empty strings are provided as field values. [#1530](https://github.com/rancher/rke2/issues/1530)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1208) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.8-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.9.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.9.2) |

## Known Issues
* [#1074](https://github.com/rancher/rke2/issues/1074#issuecomment-850670271) - Control-plane components may fail to start with "bind: address already in use" message. This will be resolved in a future release.
* [#1447](https://github.com/rancher/rke2/issues/1447) - When restoring RKE2 from backup to a new node, you should ensure that all pods are stopped following the initial restore:
```bash
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=v1.20.9+rke2r2
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
# Release v1.20.8+rke2r1
<!-- v1.20.8+rke2r1 -->
This release updates Kubernetes to v1.20.8
For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1207)

## Upgrade Notes
If you installed RKE2 from RPMs (default on RHEL-based distributions), you will need to either re-run the installer, or edit `/etc/yum.repos.d/rancher-rke2.repo` to point at the `latest/1.20` or `stable/1.20` channel (depending on how quickly you would like to receive new releases) in order to update RKE2 via yum.

## Changes since v1.20.7+rke2r2
- Upgrade Kubernetes to v1.20.8
(#1135)
- The built-in vsphere helm chart is now enabled by passing `--cloud-provider-name=rancher-vsphere`, instead of simply `vsphere`. The implementation from the previous release made it impossible to enable the in-tree vsphere cloud provider.
(#1115)
- CIS checks no longer require the `etcd` user be present on agent nodes.
(#1063)
- A message is now written to the logs when etcd snapshots are disabled.
(#1123)
- Cluster bootstrap data (certs, etc) are now more reliably written to the datastore.
(#1117) 
- The kube-proxy helm chart no longer quotes boolean values.
(#1131)
- kubernetes.default.svc is now included in the default SANs on the Kubernetes API serving certificate.
(#1113)
- RBAC resources for the RKE integrated cloud-controller-manager are now uniquely named.
(#1118)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1208) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s2) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.9.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.9.2) |

## Known Issues
- [#786](https://github.com/rancher/rke2/issues/786) - NetworkManager interferes with network related components. If your node has NetworkManager installed and enabled, please referer to [RKE2 Docs](https://docs.rke2.io/known_issues/#networkmanager) for a workaround.
- [#1118](https://github.com/rancher/rke2/issues/1118) - RKE2 integrated cloud-controller-manager RBAC conflicts with out-of-tree Helm charts. RBAC roles have been renamed to no longer conflict, but if you are upgrading from an earlier release and plan on installing an out-of-tree cloud controller you should run the following command to clean up the legacy roles:
    ```bash
    kubectl delete clusterrole,clusterrolebinding cloud-controller-manager
    ```

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.20.7+rke2r2
<!-- v1.20.7+rke2r2 -->
This release resolves a bug ([#1052](https://github.com/rancher/rke2/issues/1052)) with the `--cluster-reset` flag which causes a goroutine panic when attempting to reset the etcd cluster membership. It is required to upgrade to this version of RKE2 if you intend to leverage etcd cluster reset or etcd restore functionality.

## Upgrade Notes
If you installed RKE2 from RPMs (default on RHEL-based distributions), you will need to either re-run the installer, or edit `/etc/yum.repos.d/rancher-rke2.repo` to point at the `latest/1.20` or `stable/1.20` channel (depending on how quickly you would like to receive new releases) in order to update RKE2 via yum.

## Changes since v1.20.7+rke2r1
- `rke2 server --cluster-reset` now functions properly. ([#1052](https://github.com/rancher/rke2/issues/1052))
- The calico and cilium CNI images have been updated to address vulnerabilities in the base image. ([#1042](https://github.com/rancher/rke2/issues/1042))
- RKE2's Pod Security Policy (PSP) bootstrap code no longer updates the kube-system namespace's annotations when PSPs have not changed. ([#1056](https://github.com/rancher/rke2/issues/1056))  
    This resolves issues with OPA Gatekeeper deployments that enforce an admission controller webhook on namespace writes.

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1207) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s2) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.9.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.9.2) |

## Known Issues
- [#1063](https://github.com/rancher/rke2/issues/1063) - CIS Profile checks require `etcd` user to be present on agents. As a workaround, ensure that the `etcd` user exists on all nodes on which you will use the `--profile` flag, even ones that you do not plan to enable etcd on. This will be fixed in a subsequent patch release.
- [#786](https://github.com/rancher/rke2/issues/786) - NetworkManager interferes with network related components. If your node has NetworkManager installed and enabled, please refer to the [RKE2 Docs](https://docs.rke2.io/known_issues/#networkmanager) for a workaround.

These will be addressed in an upcoming release.

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.20.7+rke2r1
<!-- v1.20.7+rke2r1 -->

# Notice
**This release is affected by a bug ([#1052](https://github.com/rancher/rke2/issues/1052)) with the `--cluster-reset` flag which causes a goroutine panic when attempting to reset the etcd cluster membership. It is required to upgrade to v1.20.7+rke2r2 if you intend to leverage etcd cluster reset or etcd restore functionality.**

This release updates Kubernetes to v1.20.7
For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1206).

## Upgrade Notes
If you installed RKE2 from RPMs (default on RHEL-based distributions), you will need to either re-run the installer, or edit `/etc/yum.repos.d/rancher-rke2.repo` to point at the `latest/1.20` or `stable/1.20` channel (depending on how quickly you would like to receive new releases) in order to update RKE2 via yum.

## Changes since v1.20.6+rke2r1
- Upgrade Kubernetes to v1.20.7 ([#951](https://github.com/rancher/rke2/issues/951))
- Upgrade containerd to v1.4.4-k3s2 ([#1031](https://github.com/rancher/rke2/pull/1031))
- Fixes ([CVE-2021-30465](https://github.com/opencontainers/runc/security/advisories/GHSA-c3xm-pvg7-gh7r)) runc 1.0.0-rc94 and earlier are vulnerable to a symlink exchange attack ([#980](https://github.com/rancher/rke2/issues/980)).
- Add support for `--cni=canal|cilium`. ([#997](https://github.com/rancher/rke2/pull/997))
- Add support for `--cloud-provider=vsphere`. ([#997](https://github.com/rancher/rke2/pull/997))
- Add support for passing through cluster configuration to HelmChart manifests. ([#997](https://github.com/rancher/rke2/pull/997))
- Make `--system-default-registry` a server flag that is propagated to agents. ([#997](https://github.com/rancher/rke2/pull/997))
- Fix for installations on networks lacking DNS for nodes ([#1028](https://github.com/rancher/rke2/issues/1028))

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1207) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s2) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.9.2](https://github.com/k3s-io/helm-controller/releases/tag/v0.9.2) |

## Known Issues
- [#692](https://github.com/rancher/rke2/issues/692) - RKE does not write audit logs, regardless of the audit policy in place.
- [#786](https://github.com/rancher/rke2/issues/786) - NetworkManager interferes with network related components. If your node has NetworkManager installed and enabled, please refere to [Rke2 Docs](https://docs.rke2.io/known_issues/#networkmanager) for a workaround.

These will be addressed in an upcoming release.

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.20.6+rke2r1
<!-- v1.20.6+rke2r1 -->
This release updates Kubernetes to v1.20.6
For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1205).  If you are coming from v1.19 or earlier, it is recommended that you read the [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#urgent-upgrade-notes).

## Upgrade Notes
If you installed RKE2 from RPMs (default on RHEL-based distributions), you will need to either re-run the installer, or edit `/etc/yum.repos.d/rancher-rke2.repo` to point at the `latest/1.20` or `stable/1.20` channel (depending on how quickly you would like to receive new releases) in order to update RKE2 via yum.

## Changes since v1.20.5+rke2r1
- Upgrade Kubernetes to v1.20.6 ([#843](https://github.com/rancher/rke2/issues/843))
- Mount host ssldirs into the controller-manager pod ([#832](https://github.com/rancher/rke2/pull/832))
- Add etcd snapshot to S3 functionality ([#848](https://github.com/rancher/rke2/pull/848))
- Update documentation with detailed remediation for control 5.1.5 within the CIS 1.5 hardening guide ([#551](https://github.com/rancher/rke2/pull/551))
- Private registry functionality enhancements ([#865](https://github.com/rancher/rke2/pull/865))
- Bug fix for disable etcd flag ([#867](https://github.com/rancher/rke2/pull/867))
- Rewrite image references instead of URLs ([#904](https://github.com/rancher/rke2/pull/904))

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1206) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s1) |
| Runc | [v1.0.0-rc93](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc93) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.8.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.4) |

## Known Issues
- [#692](https://github.com/rancher/rke2/issues/692) - RKE does not write audit logs, regardless of the audit policy in place.
- [#786](https://github.com/rancher/rke2/issues/786) - NetworkManager interferes with network related components. If your node has NetworkManager installed and enabled, please refere to [Rke2 Docs](https://docs.rke2.io/known_issues/#networkmanager) for a workaround.

These will be addressed in an upcoming release.

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
# Release v1.20.5+rke2r1
<!-- v1.20.5+rke2r1 -->
This release updates Kubernetes to v1.20.5
For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1204).  If you are coming from v1.19 or earlier, it is recommended that you read the [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#urgent-upgrade-notes).

## Upgrade Notes
If you installed RKE2 from RPMs (default on RHEL-based distributions), you will need to either re-run the installer, or edit `/etc/yum.repos.d/rancher-rke2.repo` to point at the `latest/1.20` or `stable/1.20` channel (depending on how quickly you would like to receive new releases) in order to update RKE2 via yum.

## Changes since v1.20.4+rke2r1
- **[Upgrade Kubernetes to v1.20.5](https://github.com/rancher/rke2/issues/721)**
- Upgrade to containerd v1.4.4-k3s1 ([#804](https://github.com/rancher/rke2/pull/804)) See the [containerd security advisory](https://github.com/containerd/containerd/security/advisories/GHSA-6g2q-w5j3-fwh4) for more information.

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1205) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s1) |
| Runc | [v1.0.0-rc93](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc93) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.8.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.4) |

## Known Issues
-  [#786](https://github.com/rancher/rke2/issues/786) - NetworkManager interferes with network related components. If your node has NetworkManager installed and enabled, please refere to [Rke2 Docs](https://docs.rke2.io/known_issues/#networkmanager) for a workaround.

These will be addressed in an upcoming release.

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.

-----
# Release v1.20.4+rke2r1
<!-- v1.20.4+rke2r1 -->
This release is RKE2's first in the v1.20 line. This release updates Kubernetes to v1.20.4
For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1190).  If you are coming from v1.19 or earlier, it is recommended that you read the [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#urgent-upgrade-notes).

## Upgrade Notes
If you installed RKE2 from RPMs (default on RHEL-based distributions), you will need to either re-run the installer, or edit `/etc/yum.repos.d/rancher-rke2.repo` to point at the `latest/1.20` or `stable/1.20` channel (depending on how quickly you would like to receive new releases) in order to update RKE2 via yum.

## Changes since v1.19.8+rke2r1
- Upgrade Kubernetes to v1.20.4 (#740)
- Packaged components will now come back immediately when they are removed from the --disable list. Previously, they would not come back until RKE2 was upgraded. (#729)
- Arguments passed to Kubernetes components via the --kube-*-arg flags (--kube-apiserver-arg, --kube-scheduler-arg, etc) now override the RKE2 defaults. (#724)
- Airgap tarballs can now be used alongside the --system-default-registry flag. Images loaded from tarballs will appear to come from the default registry. (#683)
- RKE2 honors registries.yaml settings for mirroring, authentication, and TLS configuration when loading core images, including the runtime bootstrap image. (#710)
- The RKE2 agent's client load-balancer now binds to static ports, instead of randomly selecting ports on startup. This resolves an issue that would cause the kube-proxy pod to lose its connection to the apiserver when RKE2 was restarted. (#573)
- RKE2 supports loading images from compressed tarballs; the rke2-images tarball artifacts no longer need to be decompressed after downloading. (#755)
- RKE2 release artifacts now include a rke2-image tarball compressed with zstandard. Zstandard produces archives that are significantly smaller, and faster to decompress. (#755)
- RKE2 now installs to /opt/rke2 on hosts where /usr/local is readonly or a dedicated mount point. (#737 / #742)

## Packaged Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1204) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.3-k3s3](https://github.com/k3s-io/containerd/releases/tag/v1.4.3-k3s3) |
| Runc | [v1.0.0-rc93](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc93) |
| CNI Plugins | [v0.8.7](https://github.com/containernetworking/plugins/releases/tag/v0.8.7) |
| Flannel | [v0.13.0-rancher1](https://github.com/k3s-io/flannel/releases/tag/v0.13.0-rancher1) |
| Calico | [v3.13.3](https://docs.projectcalico.org/archive/v3.13/release-notes/#v3133) |
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| CoreDNS | [v1.6.9](https://github.com/coredns/coredns/releases/tag/v1.6.9) |
| Ingress-Nginx | [v1.36.3](https://github.com/kubernetes/ingress-nginx/releases) |
| Helm-controller | [v0.8.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.4) |

## Known Issues
- #692 - RKE does not write audit logs, regardless of the audit policy in place.
- #690 - There is a bug in containerd concerning SELinux volume relabelling. This issue may manifest as Rancher not being able to start on RKE2 clusters with SELinux enabled.

These will be addressed in an upcoming release.

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/rke2/issues/new)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://docs.rke2.io) for guidance on how to get started.
-----
