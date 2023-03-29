| k3s version| Kubernetes | Kine | SQLite | Etcd | Containerd | Runc | Flannel | Metrics-server | Traefik | CoreDNS | Helm-controller | Local-path-provisioner  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.22.17+k3s1  |
| v1.22.16+k3s1  |
| v1.22.15+k3s1  |
| v1.22.13+k3s1  |
| v1.22.12+k3s1  |
| v1.22.11+k3s2  |
| v1.22.11+k3s1  |
| v1.22.10+k3s1  |
| v1.22.9+k3s1  |
| v1.22.8+k3s1  |
| v1.22.7+k3s1  |
| v1.22.6+k3s1  |
| v1.22.5+k3s2  |
| v1.22.5+k3s1  |
| v1.22.4+k3s1  |
| v1.22.3+k3s1  |
| v1.22.2+k3s2  |
| v1.22.2+k3s1  |



| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.22.17+k3s1](k3s-v1.22.md#release-v12217k3s1) | Dec 21 2022 | 12/21/22 | 2022-12-21 |
| [v1.22.16+k3s1](k3s-v1.22.md#release-v12216k3s1) | Nov 18 2022 | 11/18/22 | 2022-11-18 |
| [v1.22.15+k3s1](k3s-v1.22.md#release-v12215k3s1) | Sep 28 2022 | 09/28/22 | 2022-09-28 |
| [v1.22.13+k3s1](k3s-v1.22.md#release-v12213k3s1) | Aug 25 2022 | 08/25/22 | 2022-08-25 |
| [v1.22.12+k3s1](k3s-v1.22.md#release-v12212k3s1) | Jul 19 2022 | 07/19/22 | 2022-07-19 |
| [v1.22.11+k3s2](k3s-v1.22.md#release-v12211k3s2) | Jul 06 2022 | 07/06/22 | 2022-07-06 |
| [v1.22.11+k3s1](k3s-v1.22.md#release-v12211k3s1) | Jun 27 2022 | 06/27/22 | 2022-06-27 |
| [v1.22.10+k3s1](k3s-v1.22.md#release-v12210k3s1) | Jun 11 2022 | 06/11/22 | 2022-06-11 |
| [v1.22.9+k3s1](k3s-v1.22.md#release-v1229k3s1) | Apr 28 2022 | 04/28/22 | 2022-04-28 |
| [v1.22.8+k3s1](k3s-v1.22.md#release-v1228k3s1) | Mar 31 2022 | 03/31/22 | 2022-03-31 |
| [v1.22.7+k3s1](k3s-v1.22.md#release-v1227k3s1) | Feb 24 2022 | 02/24/22 | 2022-02-24 |
| [v1.22.6+k3s1](k3s-v1.22.md#release-v1226k3s1) | Jan 25 2022 | 01/25/22 | 2022-01-25 |
| [v1.22.5+k3s2](k3s-v1.22.md#release-v1225k3s2) | Jan 14 2022 | 01/14/22 | 2022-01-14 |
| [v1.22.5+k3s1](k3s-v1.22.md#release-v1225k3s1) | Dec 18 2021 | 12/18/21 | 2021-12-18 |
| [v1.22.4+k3s1](k3s-v1.22.md#release-v1224k3s1) | Nov 29 2021 | 11/29/21 | 2021-11-29 |
| [v1.22.3+k3s1](k3s-v1.22.md#release-v1223k3s1) | Nov 04 2021 | 11/04/21 | 2021-11-04 |
| [v1.22.2+k3s2](k3s-v1.22.md#release-v1222k3s2) | Oct 05 2021 | 10/05/21 | 2021-10-05 |
| [v1.22.2+k3s1](k3s-v1.22.md#release-v1222k3s1) | Sep 23 2021 | 09/23/21 | 2021-09-23 |



# Release v1.22.17+k3s1
<!-- v1.22.17+k3s1 -->
This release updates Kubernetes to v1.22.17, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v12216).

## Changes since v1.22.16+k3s1:

* Update to v1.22.17-k3s1 [(#6625)](https://github.com/k3s-io/k3s/pull/6625)
* Bump containerd to v1.5.16-k3s1-1-22 [(#6629)](https://github.com/k3s-io/k3s/pull/6629)
  * The embedded containerd version has been bumped to v1.5.16

## Embedded Component Versions
| Component              | Version                                                                                             |
|------------------------|-----------------------------------------------------------------------------------------------------|
| Kubernetes             | [v1.22.17](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12217) |
| Kine                   | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3)                                        |
| SQLite                 | [3.36.0](https://sqlite.org/releaselog/3_36_0.html)                                                 |
| Etcd                   | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1)                              |
| Containerd             | [v1.6.9](https://github.com/k3s-io/containerd/releases/tag/v1.6.9)                                  |
| Runc                   | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4)                                |
| Flannel                | [v0.19.2](https://github.com/flannel-io/flannel/releases/tag/v0.19.2)                               |
| Metrics-server         | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2)                     |
| Traefik                | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2)                                    |
| CoreDNS                | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1)                                    |
| Helm-controller        | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3)                           |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21)                   |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
# Release v1.22.16+k3s1
<!-- v1.22.16+k3s1 -->
This release updates Kubernetes to v1.22.16, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v12215).

## Changes since v1.22.15+k3s1:

* Pull traefik helm chart directly from GH [(#6471)](https://github.com/k3s-io/k3s/pull/6471)
* Update to v1.22.16 [(#6481)](https://github.com/k3s-io/k3s/pull/6481)
* Move traefik chart repo again [(#6511)](https://github.com/k3s-io/k3s/pull/6511)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.16](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12216) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.19.2](https://github.com/flannel-io/flannel/releases/tag/v0.19.2) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
# Release v1.22.15+k3s1
<!-- v1.22.15+k3s1 -->
This release updates Kubernetes to v1.22.15, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v12213).

## Changes since v1.22.13+k3s1:

* Update Flannel to v0.19.2 to fix older iptables issue [(#6094)](https://github.com/k3s-io/k3s/pull/6094)
* The bundled version of runc has been bumped to v1.1.4 [(#6074)](https://github.com/k3s-io/k3s/pull/6074)
* Add validation check to confirm correct golang version for Kubernetes [(#6115)](https://github.com/k3s-io/k3s/pull/6115)
* Update to v1.22.14 [(#6145)](https://github.com/k3s-io/k3s/pull/6145)
* Update to v1.22.15 [(#6167)](https://github.com/k3s-io/k3s/pull/6167)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12215) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.19.2](https://github.com/flannel-io/flannel/releases/tag/v0.19.2) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
# Release v1.22.13+k3s1
<!-- v1.22.13+k3s1 -->
This release updates Kubernetes to v1.22.13, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v12212).

## Changes since v1.22.12+k3s1:

* Fix secrets reencryption for 8K+ secrets [(#5938)](https://github.com/k3s-io/k3s/pull/5938)
* The etcd error on incorrect peer urls now correctly includes the expected https and 2380 port. [(#5950)](https://github.com/k3s-io/k3s/pull/5950)
* Bumped minio-go to v7.0.33. This adds support for IMDSv2 credentials.
* When set, the agent-token value is now written to `$datadir/server/agent-token`, in the same manner as the default (server) token is written to `$datadir/server/token`
* Updated dynamiclistener to fix a regression that prevented certificate renewal from working properly.
* The configured service CIDR is now passed to the Kubernetes controller-manager via the `--service-cluster-ip-range` flag. Previously this value was only passed to the apiserver.
* Fixed a regression that caused systemd cgroup driver autoconfiguration to fail on server nodes.
* The initial health-check time for the etcd datastore has been raised from 10 to 30 seconds.
* Bumped rootlesskit to v1.0.1 [(#5952)](https://github.com/k3s-io/k3s/pull/5952)
* Added dualstack IP auto detection [(#5959)](https://github.com/k3s-io/k3s/pull/5959)
* Updated flannel to v0.19.1 [(#5968)](https://github.com/k3s-io/k3s/pull/5968)
* Remove codespell from Drone, add to GH Actions [(#6010)](https://github.com/k3s-io/k3s/pull/6010)
* Update to v1.22.13 [(#6012)](https://github.com/k3s-io/k3s/pull/6012)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.13](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12213) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.1.3](https://github.com/opencontainers/runc/releases/tag/v1.1.3) |
| Flannel | [v0.19.1](https://github.com/flannel-io/flannel/releases/tag/v0.19.1) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
# Release v1.22.12+k3s1
<!-- v1.22.12+k3s1 -->
This release updates Kubernetes to v1.22.12, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v12211).

## Changes since v1.22.11+k3s2:
* Fixed an issue that would cause etcd restore to fail when restoring a snapshot made with secrets encryption enabled if the --secrets-encryption command was not included in the config file or restore command. [(#5820)](https://github.com/k3s-io/k3s/pull/5820)
* Backport runc and remotedialer version bumps
* Updated rancher/remotedialer to address a potential memory leak.
* The embedded runc binary has been bumped to v1.1.3 [(#5828)](https://github.com/k3s-io/k3s/pull/5828)
* Address issues with etcd snapshots
* Scheduled etcd snapshots are now compressed when snapshot compression is enabled.
* The default etcd snapshot timeout has been raised to 5 minutes.
    Only one scheduled etcd snapshot will run at a time. If another snapshot would occur while the previous snapshot is still in progress, an error will be logged and the second scheduled snapshot will be skipped.
* S3 objects for etcd snapshots are now labeled with the correct content-type when compression is not enabled. [(#5843)](https://github.com/k3s-io/k3s/pull/5843)
* Update to v1.22.12 [(#5872)](https://github.com/k3s-io/k3s/pull/5872)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.12](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12212) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.1.3](https://github.com/opencontainers/runc/releases/tag/v1.1.3) |
| Flannel | [v0.18.1](https://github.com/flannel-io/flannel/releases/tag/v0.18.1) |
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) |
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
# Release v1.22.11+k3s2
<!-- v1.22.11+k3s2 -->
This fixes several issues in the v1.22.11+k3s1 and prior releases.

## Changes since v1.22.11+k3s1:

* Fixed an issue that prevented `kubectl logs` and other functionality that requires a connection to the agent from working correctly when the server's `--bind-address` flag was used, or when k3s is used behind a http proxy. ([#5798](https://github.com/k3s-io/k3s/pull/5798))
* K3s will no longer log panics after upgrading directly from much older kubernetes releases, or when deploying services with `type: externalname`. ([#5798](https://github.com/k3s-io/k3s/pull/5798))
* Bumped kine to v0.9.3 ([#5798](https://github.com/k3s-io/k3s/pull/5798))
* Fixed an issue that prevented newer versions of k3s from joining clusters that do not have egress-selector-mode support. ([#5792](https://github.com/k3s-io/k3s/pull/5792))
* Remove k3s-io fork of containerd/continuity ([#5776](https://github.com/k3s-io/k3s/pull/5776))
* Remove go-powershell dead dependency ([#5779](https://github.com/k3s-io/k3s/pull/5779))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12211) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.0.0](https://github.com/opencontainers/runc/releases/tag/v1.0.0) |
| Flannel | [v0.18.1](https://github.com/flannel-io/flannel/releases/tag/v0.18.1) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
# Release v1.22.11+k3s1
<!-- v1.22.11+k3s1 -->
This release updates Kubernetes to v1.22.11, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v12210).

## Changes since v1.22.10+k3s1:

* Remove kube-ipvs0 interface when cleaning up [(#5679)](https://github.com/k3s-io/k3s/pull/5679)
* Add FlannelConfCNI flag [(#5684)](https://github.com/k3s-io/k3s/pull/5684)
* add support for pprof server [(#5691)](https://github.com/k3s-io/k3s/pull/5691)
* Integration and E2E test improvements [(#5685)](https://github.com/k3s-io/k3s/pull/5685)
* Disable urfave markdown/man docs generation [(#5701)](https://github.com/k3s-io/k3s/pull/5701)
* The embedded etcd snapshot controller will no longer fail to process snapshot files containing characters that are invalid for use in ConfigMap keys. [(#5704)](https://github.com/k3s-io/k3s/pull/5704)
* Environment variables prefixed with `CONTAINERD_` now take priority over other existing variables, when passed through to containerd. [(#5710)](https://github.com/k3s-io/k3s/pull/5710)
* Delay service readiness until after startuphooks have finished [(#5724)](https://github.com/k3s-io/k3s/pull/5724)
* The embedded etcd instance no longer accepts connections from other nodes while resetting or restoring. [(#5540)](https://github.com/k3s-io/k3s/pull/5540)
* Flannel version update to 0.18.1 and added the ability to configure additional options for wireguard backend [(#5722)](https://github.com/k3s-io/k3s/pull/5722)
* The embedded Helm controller now properly updates Chart deployments when HelmChartConfig resources are updated or deleted. [(#5735)](https://github.com/k3s-io/k3s/pull/5735)
* Update to v1.22.11-k3s1 [(#5752)](https://github.com/k3s-io/k3s/pull/5752)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12211) |
| Kine | [v0.9.1](https://github.com/k3s-io/kine/releases/tag/v0.9.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.0.0](https://github.com/opencontainers/runc/releases/tag/v1.0.0) |
| Flannel | [v0.18.1](https://github.com/flannel-io/flannel/releases/tag/v0.18.1) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
# Release v1.22.10+k3s1
<!-- v1.22.10+k3s1 -->
This release updates Kubernetes to v1.22.10, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1229).

## Changes since v1.22.9+k3s1:

* Add "ipFamilyPolicy: PreferDualStack" to have dual-stack ingress support [(#5537)](https://github.com/k3s-io/k3s/pull/5537)
* Add systemd cgroup controller support  [(#5555)](https://github.com/k3s-io/k3s/pull/5555)
* Changing package to k3s-io [(#5585)](https://github.com/k3s-io/k3s/pull/5585)
* Backport bugfixes and enhancements from master
* The embedded ServiceLB LoadBalancer controller now supports mixed-protocol Services, and will clean up daemonsets when the Service type changes.
* CNI plugins binaries now output the correct versions when queried on the command line
* CNI plugins have been bumped to v1.1.1
* K3s now uses the systemd cgroup driver instead of cgroupfs when running under systemd 244 or later.
* K3s supervisor status errors are now wrapped in Kubernetes API error types, for improved compatibility with Kubernetes client libraries.
* K3s now supports [NATS JetStream](https://docs.nats.io/nats-concepts/jetstream) as a datastore backend
* The embedded kubelet now waits for the apiserver to become available before starting.
* The K3s supervisor now implements a [KEP-1281](https://github.com/kubernetes/enhancements/tree/master/keps/sig-api-machinery/1281-network-proxy) compliant apiserver network proxy.
* The integrated apiserver network proxy's operational mode can now be set with `--egress-selector-mode`.
* When generating a replacement resolv.conf due to potentially unsuitable nameservers in the host resolv.conf, k3s now logs a warning, and stores the autogenerated configuration file in a more durable location.
* Objects will be removed from Kubernetes when they are removed from manifest files. [(#5586)](https://github.com/k3s-io/k3s/pull/5586)
* Users can now install auto-completion using the k3s completion command [(#5592)](https://github.com/k3s-io/k3s/pull/5592)
* Update Kubernetes to v1.22.10-k3s1 [(#5612)](https://github.com/k3s-io/k3s/pull/5612)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v12210) |
| Kine | [v0.9.1](https://github.com/k3s-io/kine/releases/tag/v0.9.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.11-k3s2) |
| Runc | [v1.0.0](https://github.com/opencontainers/runc/releases/tag/v1.0.0) |
| Flannel | [v0.17.0](https://github.com/flannel-io/flannel/releases/tag/v0.17.0) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.1) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
# Release v1.22.9+k3s1
<!-- v1.22.9+k3s1 -->
This release updates Kubernetes to v1.22.9, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1228).

## Changes since v1.22.8+k3s1:

* Fix ipv6 url [(#5385)](https://github.com/k3s-io/k3s/pull/5385)
* Update helm-controller version [(#5399)](https://github.com/k3s-io/k3s/pull/5399)
* Wireguard native flannel support [(#5409)](https://github.com/k3s-io/k3s/pull/5409)
* update trivy to 0.25.3 [(#5426)](https://github.com/k3s-io/k3s/pull/5426)
* The embedded containerd version has been bumped to v1.5.11-k3s1 [(#5433)](https://github.com/k3s-io/k3s/pull/5433)
* The embedded etcd version has been bumped to v3.5.3-k3s1 [(#5430)](https://github.com/k3s-io/k3s/pull/5430)
* When using clusters with a mix of etcd-only/control-plane-only nodes, agents may now also join etcd-only servers [(#5438)](https://github.com/k3s-io/k3s/pull/5438)
* netpol: Add dual-stack support [(#5416)](https://github.com/k3s-io/k3s/pull/5416)
* Add s390x arch support for k3s [(#5447)](https://github.com/k3s-io/k3s/pull/5447)
* Fix default ipv6 cidr [(#5469)](https://github.com/k3s-io/k3s/pull/5469)
* Update Kubernetes to v1.22.9 [(#5474)](https://github.com/k3s-io/k3s/pull/5474)
* Fix issue with long-running apiserver endpoints watch [(#5479)](https://github.com/k3s-io/k3s/pull/5479)
* Secrets Encryption: Add RetryOnConflict around updating nodes [(#5498)](https://github.com/k3s-io/k3s/pull/5498)
* Bump containerd for selinux fix [(#5508)](https://github.com/k3s-io/k3s/pull/5508)
* Added default endpoint for IPv6 [(#5510)](https://github.com/k3s-io/k3s/pull/5510)
* Fix issue with datastore corruption on cluster-reset [(#5517)](https://github.com/k3s-io/k3s/pull/5517)
    * The embedded etcd has been bumped to v3.5.4-k3s1
    * Etcd is now shut down cleanly when performing a --cluster-reset 

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1229) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.0.0](https://github.com/k3s-io/containerd/releases/tag/v1.0.0) |
| Runc | [v1.0.0](https://github.com/opencontainers/runc/releases/tag/v1.0.0) |
| Flannel | [v0.17.0](https://github.com/flannel-io/flannel/releases/tag/v0.17.0) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.1) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
# Release v1.22.8+k3s1
<!-- v1.22.8+k3s1 -->
This release updates Kubernetes to v1.22.8, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1227).

## Changes since v1.22.7+k3s1:

* Add ability to specify etcd snapshot list output format (#5132) [(#5179)](https://github.com/k3s-io/k3s/pull/5179)
* Fixed a bug that prevented users from using k3s secrets-encryption rotation after upgrading from older K3s versions. [(#5169)](https://github.com/k3s-io/k3s/pull/5169)
* Add `--json` flag for `k3s secrets-encrypt status` [(#5198)](https://github.com/k3s-io/k3s/pull/5198)
* `k3s secrets-encrypt prepare` can now be used on control-plane only nodes [(#5228)](https://github.com/k3s-io/k3s/pull/5228)
* Fix function arg call (#5234) [(#5236)](https://github.com/k3s-io/k3s/pull/5236)
* Add net util funcs [(#5245)](https://github.com/k3s-io/k3s/pull/5245)
* Release 1.22 fix 700 [(#5246)](https://github.com/k3s-io/k3s/pull/5246)
* IPv6 only [(#5260)](https://github.com/k3s-io/k3s/pull/5260)
* The embedded containerd has been bumped to v1.5.10-k3s1 [(#5231)](https://github.com/k3s-io/k3s/pull/5231)
* Backport cleanups and bugfixes from master  [(#5251)](https://github.com/k3s-io/k3s/pull/5251)
   * When using the unsupported `--disable-agent` flag, kube-scheduler will now be started when a node is available.
   * Server nodes with only etcd/control-plane/etcd+control-plane roles can now be added to the cluster in any order, as long as the first node has the etcd role.
   * Any alarms present on the embedded etcd datastore are now reported and cleared at startup. This should allow for graceful recovery after exceeding and subsequently raising the etcd quota size.
* The embedded Helm controller can now cease management of existing HelmChart releases, supports setting a failure policy for  install/update operations, and allows trusting custom CA certs for remote chart repositories. [(#5280)](https://github.com/k3s-io/k3s/pull/5280)
* Secondary etcd-only nodes will now successfully bootstrap containerd and the kubelet before a control-plane node has joined the cluster. [(#5302)](https://github.com/k3s-io/k3s/pull/5302)
* Update Kubernetes to v1.22.8-k3s1 [(#5272)](https://github.com/k3s-io/k3s/pull/5272)
* The packaged coredns version has been bumped to v1.9.1 [(#5309)](https://github.com/k3s-io/k3s/pull/5309)
* Defragment etcd datastore before clearing alarms; don't delete temp etcd db while reconciling
 * The embedded etcd database is now defragmented on startup.
 * Fixed an issue that could cause restart of managed etcd nodes to occasionally fail while reconciling bootstrap data. [(#5340)](https://github.com/k3s-io/k3s/pull/5340)
* Wrap containerd.New [(#5362)](https://github.com/k3s-io/k3s/pull/5362)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1228) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1) |
| Containerd | [v1.5.10-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.10-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| Flannel | [v0.17.0](https://github.com/flannel-io/flannel/releases/tag/v0.17.0) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.1](https://github.com/traefik/traefik/releases/tag/v2.6.1) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Known Issues
- The etcd maintainers have recommended against the use of etcd 3.5.0-3.5.2 for new production workloads, due to a recently discovered bug that may cause data loss when etcd is killed under high load. [Please see this link for more details.](https://forums.rancher.com/t/rancher-kubernetes-distributions-and-etcd-3-5-updates/37485)

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
# Release v1.22.7+k3s1
<!-- v1.22.7+k3s1 -->
This release updates Kubernetes to v1.22.7, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1226).

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since v1.22.6+k3s1:

* Upgraded to V1.22.7 k3s1 and updated traefik to v2.6.1 [(#5136)](https://github.com/k3s-io/k3s/pull/5136)
* Moved containerd wait into exported function [(#5022)](https://github.com/k3s-io/k3s/pull/5022)
* Added new upgradecluster E2E test [(#5015)](https://github.com/k3s-io/k3s/pull/5015)
* Added `--server flag` to `k3s secrets-encrypt` [(#5053)](https://github.com/k3s-io/k3s/pull/5053)
* Used kube-router as a library [(#5087)](https://github.com/k3s-io/k3s/pull/5087)
* Fixes to Drone CI Stability [(#5090)](https://github.com/k3s-io/k3s/pull/5090)
* K3s kubectl now no longer outputs a [WARN] log when using the `--kubeconfig` flag [(#5075)](https://github.com/k3s-io/k3s/pull/5075)
* Updated flannel version and removed the iptables rules from ipmasq flannel [(#5062)](https://github.com/k3s-io/k3s/pull/5062)
* Added k3s etcd restoration integration test  [(#5096)](https://github.com/k3s-io/k3s/pull/5096)
* Enabled smoke tests [(#5100)](https://github.com/k3s-io/k3s/pull/5100)
* Fixed annoying netpol heartbeat missing log [(#5108)](https://github.com/k3s-io/k3s/pull/5108)
* Fixed a regression that prevented `--disable` from removing previously installed components. [(#5116)](https://github.com/k3s-io/k3s/pull/5116)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1227) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1) |
| Containerd | [v1.5.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.9-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| Flannel | [v0.16.3](https://github.com/flannel-io/flannel/releases/tag/v0.16.3) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.1](https://github.com/traefik/traefik/releases/tag/v2.6.1) |
| CoreDNS | [v1.8.6](https://github.com/coredns/coredns/releases/tag/v1.8.6) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
# Release v1.22.6+k3s1
<!-- v1.22.6+k3s1 -->
This release updates Kubernetes to v1.22.6, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1225).


## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since v1.22.5+k3s2:

* Update to v1.22.6 [(#4996)](https://github.com/k3s-io/k3s/pull/4996)
* Enable debug logging on all k3s subcommands with debug flag [(#4931)](https://github.com/k3s-io/k3s/pull/4931)
* K3s servers no longer attempt to manage cgroup membership when the (unsupported, hidden) `--disable-agent` flag is used. [(#4924)](https://github.com/k3s-io/k3s/pull/4924)
* Bump etcd and containerd to track upstream [(#4934)](https://github.com/k3s-io/k3s/pull/4934)
  * Update etcd to v3.5.1-k3s1
  * Update containerd to v1.5.9-k3s1
* Remove ip6table rules when cleaning up k3s [(#4977)](https://github.com/k3s-io/k3s/pull/4977)
* Add IPv6 NAT [(#4983)](https://github.com/k3s-io/k3s/pull/4983)
* Adds the ability to compress etcd snapshots (#4866) [(#4960)](https://github.com/k3s-io/k3s/pull/4960)
* Update packaged components [(#4964)](https://github.com/k3s-io/k3s/pull/4964)
  * Update local-path-provisioner to v0.0.21
  * Update local-path-provisioner busybox helper to 1.34.1
  * Update metrics-server to 0.5.2
  * Update coredns to 1.8.6
  * Update traefik to 2.5.6
  * Update pause to 3.6

<!-- https://github.com/k3s-io/k3s/compare/v1.22.5+k3s1...v1.22.6+k3s1 -->

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1226) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.1-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.1-k3s1) |
| Containerd | [v1.5.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.9-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| Flannel | [v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.5.6](https://github.com/traefik/traefik/releases/tag/v2.5.6) |
| CoreDNS | [v1.8.6](https://github.com/coredns/coredns/releases/tag/v1.8.6) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
# Release v1.22.5+k3s2
<!-- v1.22.5+k3s2 -->
This release fixes several issues, including an issue with the --agent-token flag that could prevent servers from joining managed etcd clusters when this flag was used.
<!--
This release updates Kubernetes to v1.22.5, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1223).
-->

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since v1.22.5+k3s1:
* Fixed an issue that prevented cluster-reset restore from working on some nodes in a multi-node etcd cluster. ([#4916](https://github.com/k3s-io/k3s/pull/4916))
<!-- [release-1.22] fix handling of agent-token fallback to token ([#4894](https://github.com/k3s-io/k3s/pull/4894)) -->
* Fixed an issue that prevented joining additional servers when `--agent-token` is set. ([#4877](https://github.com/k3s-io/k3s/pull/4877))
* Feature: add coredns customization options ([#4860](https://github.com/k3s-io/k3s/pull/4860))
* Require integration test to be run as sudo/root ([#4830](https://github.com/k3s-io/k3s/pull/4830))
* Add tests to use vagrantfile (#4722) ([#4829](https://github.com/k3s-io/k3s/pull/4829))
* Remove vendor dir ([#4843](https://github.com/k3s-io/k3s/pull/4843))
* Fix cgroup smoke test ([#4831](https://github.com/k3s-io/k3s/pull/4831))
* Backport multiple ci fixes from master ([#4816](https://github.com/k3s-io/k3s/pull/4816))
* Fix panic checking name of uninitialized etcd member ([#4812](https://github.com/k3s-io/k3s/pull/4812))
* Update bootstrap logic to output all changed files on disk (#4800) ([#4809](https://github.com/k3s-io/k3s/pull/4809))
* Close agentready channel only in k3s ([#4793](https://github.com/k3s-io/k3s/pull/4793))
<!-- https://github.com/k3s-io/k3s/compare/v1.22.5+k3s1...v1.22.5+k3s2 -->

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1224) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| Flannel | [v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1) | 
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| Traefik | [v2.5.0](https://github.com/traefik/traefik/releases/tag/v2.5.0) |
| CoreDNS | [v1.8.4](https://github.com/coredns/coredns/releases/tag/v1.8.4) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.20](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.20) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
# Release v1.22.5+k3s1
<!-- v1.22.5+k3s1 -->
This release updates Kubernetes to v1.22.5, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1223).

## Known Issues: 
* [#4881](https://github.com/k3s-io/k3s/issues/4881): When using embedded etcd and the initial server is started with --agent-token, and this agent-only token does not match the server --token value, additional servers cannot join the cluster. This will be fixed in a subsequent release.
* [#4023](https://github.com/k3s-io/k3s/issues/4023): When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.
* [#4784](https://github.com/k3s-io/k3s/issues/4784): When creating a new cluster, etcd-only servers must be created before control-plane servers.

## Changes since v1.22.4+k3s1:

* Updated Kubernetes to v1.22.5 and containerd v1.5.8 [(#4767)](https://github.com/k3s-io/k3s/pull/4767)
* Added secrets encryption key rotation functionaility [(#4654)](https://github.com/k3s-io/k3s/pull/4654)
* Enhancements to ETCD snapshot functionailty [(#4605)](https://github.com/k3s-io/k3s/pull/4605)
* Added certificate rotation functionality [(#4635)](https://github.com/k3s-io/k3s/pull/4635)
* Improved cleanup for etcd unit test [(#4608)](https://github.com/k3s-io/k3s/pull/4608)
* Improved flannel logging  [(#4614)](https://github.com/k3s-io/k3s/pull/4614)
* Added check for HA cluster server configuration [(#4678)](https://github.com/k3s-io/k3s/pull/4678)
* Resolved server restore bootstrap [(#4715)](https://github.com/k3s-io/k3s/pull/4715)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1224) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| Flannel | [v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1) | 
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| Traefik | [v2.5.0](https://github.com/traefik/traefik/releases/tag/v2.5.0) |
| CoreDNS | [v1.8.4](https://github.com/coredns/coredns/releases/tag/v1.8.4) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.20](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.20) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
# Release v1.22.4+k3s1
<!-- v1.22.4+k3s1 -->
This release updates Kubernetes to v1.22.4, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1223).

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.


## Changes since v1.22.3+k3s1:

* Updated Kubernetes to v1.22.4 and containerd v1.5.8 [(#4530)](https://github.com/k3s-io/k3s/pull/4530)
* Rancher will no longer suggest upgrading the Traefik chart packaged with K3s. [(#4558)](https://github.com/k3s-io/k3s/pull/4558)
* Fix regression with cluster reset [(#4523)](https://github.com/k3s-io/k3s/pull/4523)
* tests/vagrant [(#4499)](https://github.com/k3s-io/k3s/pull/4499)
* Allow svclb pod to enable ipv6 forwarding [(#4518)](https://github.com/k3s-io/k3s/pull/4518)
* Fixed an issue where config.yaml arguments with an equal sign would be skipped by server. [(#4507)](https://github.com/k3s-io/k3s/pull/4507)
* Unknown flags in config are now silently skipped by k3s server and etcd-snapshot [(#4492)](https://github.com/k3s-io/k3s/pull/4492)
* K3s now supports `--etcd-arg` to specify additional etcd arguments for running etcd [(#4469)](https://github.com/k3s-io/k3s/pull/4469)
* Flags in config.yaml can now be used by etcd-snapshot [(#4475)](https://github.com/k3s-io/k3s/pull/4475)
* Increase agent's apiserver ready timeout [(#4455)](https://github.com/k3s-io/k3s/pull/4455)
* Rancher will no longer suggest upgrading the Traefik chart packaged with K3s. [(#4325)](https://github.com/k3s-io/k3s/pull/4325)
* Add ability to reconcile bootstrap data between datastore and disk [(#4448)](https://github.com/k3s-io/k3s/pull/4448)
* Improve error message when using a "K10" prefixed token [(#4430)](https://github.com/k3s-io/k3s/pull/4430)
* Updated to new signals package in wrangler [(#4422)](https://github.com/k3s-io/k3s/pull/4422)
* Bump klipper-lb image for arm fix [(#4386)](https://github.com/k3s-io/k3s/pull/4386)
* Fix log/reap reexec [(#4374)](https://github.com/k3s-io/k3s/pull/4374)
* Resolved an issue that would occasionally cause K3s to take more than a minute to schedule initial pods on the first server in a cluster. [(#4361)](https://github.com/k3s-io/k3s/pull/4361)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1224) |
| Kine | [v0.8.0](https://github.com/k3s-io/kine/releases/tag/v0.8.0) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s1) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| Flannel | [v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1) | 
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| Traefik | [v2.5.0](https://github.com/traefik/traefik/releases/tag/v2.5.0) |
| CoreDNS | [v1.8.4](https://github.com/coredns/coredns/releases/tag/v1.8.4) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.20](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.20) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
# Release v1.22.3+k3s1
<!-- v1.22.3+k3s1 -->
This release updates Kubernetes to v1.22.3, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1222).

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.
* There is [an issue](https://github.com/k3s-io/k3s/issues/4400) that affects k3s when deploying on dual-stack mode on hosts with a kernel version older than 5.1, the IPv6 external-ip exposed by the service LB does not work correctly.

## Changes since v1.22.2+k3s2:

* Updated Kubernetes to v1.22.3 [(#4348)](https://github.com/k3s-io/k3s/pull/4348)
* Added dual-stack support LB controller [(#4160)](https://github.com/k3s-io/k3s/pull/4160)
* New aliases for k3s etcd-snapshot s3 commands to match the flags used with k3s server [(#4170)](https://github.com/k3s-io/k3s/pull/4170) [(#4282)](https://github.com/k3s-io/k3s/pull/4282)
* Set skip SSL verification for etcd snapshots if skip ssl verify flag is passed [(#4103)](https://github.com/k3s-io/k3s/pull/4103)
* Display cluster tls error only in debug mode [(#4200)](https://github.com/k3s-io/k3s/pull/4200)
* Ensured that node address labels are set before initializing the node with the integrated cloud provider [(#4222)](https://github.com/k3s-io/k3s/pull/4222)
* Added `--timeout` option to etcd-snapshot command to allow increasing the time allowed for snapshot uploads to complete [(#4230)](https://github.com/k3s-io/k3s/pull/4230)
* K3s should now reliably exit when core Kubernetes components (apiserver, controller-manager, etc) experience fatal errors [(#4241)](https://github.com/k3s-io/k3s/pull/4241)
* K3s now waits until etcd is actually able to start before joining a new members to the embedded etcd clusters [(#4245)](https://github.com/k3s-io/k3s/pull/4245)
* Fixed an issue that caused k3s to not be restarted by systemd when started with the `--log` flag [(#4235)](https://github.com/k3s-io/k3s/pull/4235)
* Updated flannel to v0.15.1 [(#4265)](https://github.com/k3s-io/k3s/pull/4265)
* Updated helm-controller and klipper-helm to time out the `helm_v2 ls --all` that is done to check for deprecated helm chart versions [(#4291)](https://github.com/k3s-io/k3s/pull/4291)
* Fixed a problem in etcd cluster-reset by updating the peer addresses [(#4305)](https://github.com/k3s-io/k3s/pull/4305)
* When using the integrated cloud provider, ensure that the scheduler doesn't start before at least one node in the cluster has been initialized [(#4361)](https://github.com/k3s-io/k3s/pull/4361)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1223) |
| Kine | [v0.8.0](https://github.com/k3s-io/kine/releases/tag/v0.8.0) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.7-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s2) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| Flannel | [v0.15.1](https://github.com/flannel-io/flannel/releases/tag/v0.15.1) | 
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| Traefik | [v2.5.0](https://github.com/traefik/traefik/releases/tag/v2.5.0) |
| CoreDNS | [v1.8.4](https://github.com/coredns/coredns/releases/tag/v1.8.4) | 
| Helm-controller | [v0.11.7](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.7) |
| Local-path-provisioner | [v0.0.20](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.20) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
# Release v1.22.2+k3s2
<!-- v1.22.2+k3s2 -->
This release updates containerd to v1.5.7+k3s1 to address CVE-2021-41103 / GHSA-c2h3-6mxw-7mvq.
<!--
This release is K3s's first in the v1.22 line. It updates Kubernetes to [v1.22.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1210)
-->

As v1.22 releases include a number of significant changes from previous versions, we will not make v1.22 available via the [stable release channel](https://rancher.com/docs/k3s/latest/en/upgrades/basic/#release-channels) until v1.22.3+k3s1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#urgent-upgrade-notes). Special attention should be paid to the [removal of several beta Kubernetes APIs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#removal-of-several-beta-kubernetes-apis), as this is a breaking change for users with `apiextensions.k8s.io/v1beta1 CustomResourceDefinition` or `networking.k8s.io/v1beta1 Ingress` resources in their manifests.

## Changes since K3s v1.22.2-k3s1
* The embedded containerd has been updated to v1.5.7+k3s1 to address CVE-2021-41103 ([#4137](https://github.com/k3s-io/k3s/pull/4137))
* Enable the inheritance of settings for ipv6 ([#4101](https://github.com/k3s-io/k3s/pull/4101))
* Fixed a regression introduced by #4088 that broke rootless support ([#4129](https://github.com/k3s-io/k3s/pull/4129))
* The K3s docker image now works on cgroup v2 systems, and properly reaps terminated containerd shim processes. ([#4088](https://github.com/k3s-io/k3s/pull/4088))

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior
when removing servers running embedded etcd from the cluster. When removing servers with etcd from the
cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node
from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your
cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node
crashing, restarting, and rejoining the cluster.

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1222) |
| Kine | [v0.8.0](https://github.com/k3s-io/kine/releases/tag/v0.8.0) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.7-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.7-k3s1) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| Flannel | [v0.14.0@fca1560c91cc](https://github.com/flannel-io/flannel/compare/v0.14.0...fca1560c91cc) | 
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| Traefik | [v2.5.0](https://github.com/traefik/traefik/releases/tag/v2.5.0) |
| CoreDNS | [v1.8.4](https://github.com/coredns/coredns/releases/tag/v1.8.4) | 
| Helm-controller | [v0.11.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.5) |
| Local-path-provisioner | [v0.0.20](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.20) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
# Release v1.22.2+k3s1
<!-- v1.22.2+k3s1 -->
This release is K3s's first in the v1.22 line. It updates Kubernetes to [v1.22.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#changelog-since-v1210)

As this release includes a number of significant changes from previous versions, we will not make v1.22 available via the [stable release channel](https://rancher.com/docs/k3s/latest/en/upgrades/basic/#release-channels) until v1.22.3+k3s1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#urgent-upgrade-notes).  
Special attention should be paid to the [removal of several beta Kubernetes APIs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#removal-of-several-beta-kubernetes-apis), as this is a breaking change for users with `apiextensions.k8s.io/v1beta1 CustomResourceDefinition` or `networking.k8s.io/v1beta1 Ingress` resources in their manifests.

## Changes since K3s v1.21.1-k3s1 (when the **release-1.21** branch was forked from **master**)
* servicelb pods no longer mount the kube-system default service account token ([#4041](https://github.com/k3s-io/k3s/pull/4041))
* Make sure there are no duplicate node names in etcd member list ([#4025](https://github.com/k3s-io/k3s/pull/4025))
* The JobTrackingWithFinalizers alpha feature-gate is now enabled by default ([#4038](https://github.com/k3s-io/k3s/pull/4038))
* Fix cgroup v1 regression in check-config.sh ([#4039](https://github.com/k3s-io/k3s/pull/4039))
* Update Kubernetes to v1.22.2-k3s1 ([#4037](https://github.com/k3s-io/k3s/pull/4037))
* Removed experimental tag from k3s server cluster commands ([#4024](https://github.com/k3s-io/k3s/pull/4024))
* Nvidia container runtimes are now discovered automatically ([#3890](https://github.com/k3s-io/k3s/pull/3890))
* Fix premature etcd shutdown when joining an existing cluster ([#4018](https://github.com/k3s-io/k3s/pull/4018))
* install.sh now passes through environment variables prefixed with "CONTAINERD_" ([#4009](https://github.com/k3s-io/k3s/pull/4009))
* Use existing name for etcd controller ([#4014](https://github.com/k3s-io/k3s/pull/4014))
* Add dual-stack support on flannel ([#3906](https://github.com/k3s-io/k3s/pull/3906))
* The embedded Helm controller now ensures that deprecated or removed Kubernetes api versions are handled properly during upgrades. ([#4012](https://github.com/k3s-io/k3s/pull/4012))
* Set controller authorization-kubeconfig and authentication-kubeconfig ([#4007](https://github.com/k3s-io/k3s/pull/4007))
* Handle cgroup v1/2/hybrid in check-config.sh more explicitly/accurately ([#3230](https://github.com/k3s-io/k3s/pull/3230))
* Add `etcd-member-management` controller to K3s ([#4001](https://github.com/k3s-io/k3s/pull/4001))
* Wait for apiserver readyz instead of healthz ([#3993](https://github.com/k3s-io/k3s/pull/3993))
* install.sh now handles non-RHEL RPM-based distros properly ([#3992](https://github.com/k3s-io/k3s/pull/3992))
* Exposing etcd metrics on the host IP no longer disables the localhost metrics listener ([#3985](https://github.com/k3s-io/k3s/pull/3985))
* Failures within core Kubernetes components are now handled more gracefully, and will not trigger a full thread dump that obscures the actual error. ([#3975](https://github.com/k3s-io/k3s/pull/3975))
* K3s will no longer attempt to disable the SupportPodPidsLimit FeatureGate on nodes without PIDS cgroup support. PIDS cgroup support is mandatory as of Kubernetes 1.20. ([#3978](https://github.com/k3s-io/k3s/pull/3978))
* Migrate sqlite data to etcd when initializing the cluster ([#3231](https://github.com/k3s-io/k3s/pull/3231))
* Allow option to disable s3 over https when using etcd-snapshot ([#3968](https://github.com/k3s-io/k3s/pull/3968))
* Ship Stargz Snapshotter ([#2936](https://github.com/k3s-io/k3s/pull/2936))
* The local kube-apiserver that is available on port 6444 on server nodes now includes the node name in the certificate SAN list ([#3957](https://github.com/k3s-io/k3s/pull/3957))
* Added raspberry installation hint ([#2379](https://github.com/k3s-io/k3s/pull/2379))
* Update maintainers to reflect team changes ([#3953](https://github.com/k3s-io/k3s/pull/3953))
* Kine has been updated to v0.8.0, making the `etcd_db_total_size_in_bytes` apiserver metric available to track database size. ([#3940](https://github.com/k3s-io/k3s/pull/3940))
* Small updates to CONTRIBUTING ([#3734](https://github.com/k3s-io/k3s/pull/3734))
* Fix condition for adding kubernetes endpoints ([#3941](https://github.com/k3s-io/k3s/pull/3941))
* install.sh now makes consistent use of os-release vars ([#3918](https://github.com/k3s-io/k3s/pull/3918))
* Addon checksums are now properly updated when successfully applied. ([#3920](https://github.com/k3s-io/k3s/pull/3920))
* Bump cniplugins version to 0.9.1 ([#3925](https://github.com/k3s-io/k3s/pull/3925))
* Add functions to separate ipv4 and ipv6 CIDRs ([#3916](https://github.com/k3s-io/k3s/pull/3916))
* install.sh now informs users of current SELinux support status for SUSE-like distros ([#3088](https://github.com/k3s-io/k3s/pull/3088))
* The containerd runtime V1 (`containerd-shim`) has been removed ([#3903](https://github.com/k3s-io/k3s/pull/3903))
* Bump RootlessKit to v0.14.5 ([#3902](https://github.com/k3s-io/k3s/pull/3902))
* Fix rootless regression in 1.22 (set KubeletInUserNamespace gate) ([#3901](https://github.com/k3s-io/k3s/pull/3901))
* Update Kubernetes to v1.22.0 ([#3565](https://github.com/k3s-io/k3s/pull/3565))
* Reset load balancer state during etcd restore ([#3877](https://github.com/k3s-io/k3s/pull/3877))
* Update Kubernetes to v1.21.4 ([#3839](https://github.com/k3s-io/k3s/pull/3839))
* The embedded containerd has been updated to v1.4.9-k3s1 ([#3858](https://github.com/k3s-io/k3s/pull/3858))
* The embedded Helm controller should no longer hang while checking for Helm v2 releases ([#3847](https://github.com/k3s-io/k3s/pull/3847))
* Fix URL pruning when joining an etcd member ([#3832](https://github.com/k3s-io/k3s/pull/3832))
* Updated the code to use GetNetworkByName and tweaked logic ([#3818](https://github.com/k3s-io/k3s/pull/3818))
* Account for an s3 folder when listing objects ([#3807](https://github.com/k3s-io/k3s/pull/3807))
* Running `etcd snapshot list` or `delete` as a non-root user will no longer create a new empty snapshot dir owned by the current user ([#3783](https://github.com/k3s-io/k3s/pull/3783))
* Rancher-mirrored images used by k3s now include a mirrored- prefix ([#3749](https://github.com/k3s-io/k3s/pull/3749))
* Fix Node stuck at deletion ([#3771](https://github.com/k3s-io/k3s/pull/3771))
* The embedded Helm version has been updated to v3.6.3 ([#3762](https://github.com/k3s-io/k3s/pull/3762))
* install.sh: Use built-in shell functionality instead of awk ([#3738](https://github.com/k3s-io/k3s/pull/3738))
* Images imported from airgap tarballs are now properly lease-locked to prevent garbage collection ([#3755](https://github.com/k3s-io/k3s/pull/3755))
* Fix initial start of etcd only nodes ([#3748](https://github.com/k3s-io/k3s/pull/3748))
* Update rancher/local-path-provisioner to v0.0.20 ([#3746](https://github.com/k3s-io/k3s/pull/3746))
* Sync DisableKubeProxy into control struct ([#3724](https://github.com/k3s-io/k3s/pull/3724))
* Systemd notifications now function properly on etcd-only nodes ([#3732](https://github.com/k3s-io/k3s/pull/3732))
* Fix local-path-provisioner to allow non-root users access to storage volumes ([#3714](https://github.com/k3s-io/k3s/pull/3714))
* Wait until server is ready before configuring kube-proxy ([#3716](https://github.com/k3s-io/k3s/pull/3716))
* When deleting a snapshot, users should now see an info message telling them if the snapshot they tried to remove does not exist. ([#3695](https://github.com/k3s-io/k3s/pull/3695))
* Fix multiple bootstrap keys found ([#3688](https://github.com/k3s-io/k3s/pull/3688))
* Update Kubernetes to v1.21.3 and golang to 1.16.6 ([#3686](https://github.com/k3s-io/k3s/pull/3686))
* The embedded containerd version has been updated to v1.4.8-k3s1 to resolve GHSA-c72p-9xmj-rx3w ([#3682](https://github.com/k3s-io/k3s/pull/3682))
* Custom named etcd snapshots will now be cleanup by etcd-snapshot prune correctly. ([#3649](https://github.com/k3s-io/k3s/pull/3649))
* Bump helm-controller to v0.10.1 ([#3644](https://github.com/k3s-io/k3s/pull/3644))
* Fix a runtime core panic ([#3627](https://github.com/k3s-io/k3s/pull/3627))
* Bump k3s-root to v0.9.1 ([#3626](https://github.com/k3s-io/k3s/pull/3626))
* Prevent snapshot save when snapshots are disabled ([#3475](https://github.com/k3s-io/k3s/pull/3475))
* Update tcpproxy upstream from github.com/google/tcpproxy to inet.af/tcpproxy ([#3483](https://github.com/k3s-io/k3s/pull/3483))
* Update packaged runc binary version to v1.0.0 ([#3602](https://github.com/k3s-io/k3s/pull/3602))
* Update the error message encountered when running `k3s etcd-snapshot` where K3s cannot find an initialized etcd database to be more informative. ([#3568](https://github.com/k3s-io/k3s/pull/3568))
* Update embedded kube-router ([#3557](https://github.com/k3s-io/k3s/pull/3557))
* Set ulimits in docker-compose.yml ([#3393](https://github.com/k3s-io/k3s/pull/3393))
* Update Kubernetes to v1.21.2 ([#3564](https://github.com/k3s-io/k3s/pull/3564))
* Allow passing targeted environment variables to containerd ([#3553](https://github.com/k3s-io/k3s/pull/3553))
* Export cli server flags and etcd restoration functions ([#3527](https://github.com/k3s-io/k3s/pull/3527))
* Bump kine to resolve race condition and unrevisioned delete ([#3545](https://github.com/k3s-io/k3s/pull/3545))
* Changes local storage pods to have 700 permissions ([#3537](https://github.com/k3s-io/k3s/pull/3537))
* Move cloud-controller-manager into an embedded executor ([#3525](https://github.com/k3s-io/k3s/pull/3525))
* Add option to disable the built-in Helm Controller ([#3515](https://github.com/k3s-io/k3s/pull/3515))
* Fix storing bootstrap data with empty token string ([#3422](https://github.com/k3s-io/k3s/pull/3422))
* Fail to start k3s if nm-cloud-setup is enabled ([#3465](https://github.com/k3s-io/k3s/pull/3465))
* Renamed client-cloud-controller crt and key ([#3470](https://github.com/k3s-io/k3s/pull/3470))
* Change containerd image leases from context lifespan to permanent ([#3464](https://github.com/k3s-io/k3s/pull/3464))
* Send systemd notifications for both server and agent ([#3430](https://github.com/k3s-io/k3s/pull/3430))
* Add events to deploy controller ([#3436](https://github.com/k3s-io/k3s/pull/3436))
* Add nodename to UA string for deploy controller ([#3433](https://github.com/k3s-io/k3s/pull/3433))
* Updated iptables version check ([#3425](https://github.com/k3s-io/k3s/pull/3425))
* Add kubernetes.default.svc to serving certs ([#3423](https://github.com/k3s-io/k3s/pull/3423))
* Fixed possible race where bootstrap data might not save ([#3413](https://github.com/k3s-io/k3s/pull/3413))
* Added log message indicating etcd snapshots are disabled ([#3405](https://github.com/k3s-io/k3s/pull/3405))
* The default cloud-controller-manager ClusterRole and ClusterRoleBindings no longer conflict with external cloud providers ([#3388](https://github.com/k3s-io/k3s/pull/3388))
* Move wireguard's privatekey to flannel config directory ([#3385](https://github.com/k3s-io/k3s/pull/3385))
* Bump flannel to v0.14 ([#3376](https://github.com/k3s-io/k3s/pull/3376))
* Bump containerd to v1.4.4-k3s2 ([#3358](https://github.com/k3s-io/k3s/pull/3358))
* Fix shell expansion and file permission issues in install.sh ([#3355](https://github.com/k3s-io/k3s/pull/3355))
* Bump runc to v1.0.0-rc95 ([#3348](https://github.com/k3s-io/k3s/pull/3348))
* Fix bug in etcd snapshot s3 prune ([#3346](https://github.com/k3s-io/k3s/pull/3346))
* add retention default and wire in s3 prune ([#3340](https://github.com/k3s-io/k3s/pull/3340))
* Set nf_conntrack_max for kube-proxy in supervisor agent setup ([#3337](https://github.com/k3s-io/k3s/pull/3337))
* Add support for multiple env files for systemd unit ([#3332](https://github.com/k3s-io/k3s/pull/3332))
* Add etcd snapshot save subcommand ([#3336](https://github.com/k3s-io/k3s/pull/3336))

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster.  
  When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.22.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md#v1222) |
| Kine | [v0.8.0](https://github.com/k3s-io/kine/releases/tag/v0.8.0) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.5-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.5-k3s1) |
| Runc | [v1.0.2](https://github.com/opencontainers/runc/releases/tag/v1.0.2) |
| Flannel | [v0.14.0@fca1560c91cc](https://github.com/flannel-io/flannel/compare/v0.14.0...fca1560c91cc) | 
| Metrics-server | [v0.5.0](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.0) |
| Traefik | [v2.5.0](https://github.com/traefik/traefik/releases/tag/v2.5.0) |
| CoreDNS | [v1.8.4](https://github.com/coredns/coredns/releases/tag/v1.8.4) | 
| Helm-controller | [v0.11.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.11.5) |
| Local-path-provisioner | [v0.0.20](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.20) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
