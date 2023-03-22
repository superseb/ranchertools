<!-- v1.20.15+k3s1 -->
This release updates Kubernetes to v1.20.15, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12014).


## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4784) that causes etcd only node to not able to join an existing cluster.

## Changes since v1.20.14+k3s2:

* Updated Kubernetes to v1.20.15 [(#4995)](https://github.com/k3s-io/k3s/pull/4995)
* K3s servers no longer attempt to manage cgroup membership when the (unsupported, hidden) `--disable-agent` flag is used. [(#4927)](https://github.com/k3s-io/k3s/pull/4927)
* Update etcd to v3.4.18-k3s1 [(#4946)](https://github.com/k3s-io/k3s/pull/4946)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12015) |
| Kine | [v0.6.5](https://github.com/k3s-io/kine/releases/tag/v0.6.5) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.18-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.18-k3s1) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.12-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.8) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |
<!-- https://github.com/k3s-io/k3s/compare/v1.20.14+k3s2...v1.20.15+k3s1 -->


## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.14+k3s2 -->
This release fixes an issue with the --agent-token flag that could prevent servers from joining managed etcd clusters when this flag was used.
<!--
This release updates Kubernetes to v1.20.14, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12012).
-->

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4784) that causes etcd only node to not able to join an existing cluster.

## Changes since v1.20.v14+k3s1:
* Fixed an issue that prevented joining additional servers when `--agent-token` is set. ([#4880](https://github.com/k3s-io/k3s/pull/4880))
<!-- https://github.com/k3s-io/k3s/compare/v1.20.14+k3s1...v1.20.14+k3s2 -->

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.14](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12012) |
| Kine | [v0.6.5](https://github.com/k3s-io/kine/releases/tag/v0.6.5) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.12-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.8) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.14+k3s1-->
This release updates Kubernetes to v1.20.14, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12012).


## Known Issues: 
* [#4881](https://github.com/k3s-io/k3s/issues/4881): When using embedded etcd and the initial server is started with --agent-token, and this agent-only token does not match the server --token value, additional servers cannot join the cluster. This will be fixed in a subsequent release.
* [#4784](https://github.com/k3s-io/k3s/issues/4784): When creating a new cluster, etcd-only servers (if any) must be created before control-plane servers.

## Changes since v1.20.13+k3s1:

* Updated Kubernetes to v1.21.8 [#4760](https://github.com/k3s-io/k3s/pull/4760)
* Added certificate rotation functionality [(#4633)](https://github.com/k3s-io/k3s/pull/4633)
* Improved flannel logging  [(#4618)](https://github.com/k3s-io/k3s/pull/4618)
* Added check for HA cluster server configuration [(#4680)](https://github.com/k3s-io/k3s/pull/4680)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.14](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12012) |
| Kine | [v0.6.5](https://github.com/k3s-io/kine/releases/tag/v0.6.5) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.12-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.8) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.13+k3s1-->
This release updates Kubernetes to v1.20.13, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v12012).

## Changes since v1.20.12+k3s1:

* Updated Kubernetes to v1.20.13 and containerd v1.4.12 [(#4352)](https://github.com/k3s-io/k3s/pull/4532)
* Rancher will no longer suggest upgrading the Traefik chart packaged with K3s. [(#4556)](https://github.com/k3s-io/k3s/pull/4556)
* Fix log/reap reexec [(#4377)](https://github.com/k3s-io/k3s/pull/4377)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.13](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12012) |
| Kine | [v0.6.2](https://github.com/k3s-io/kine/releases/tag/v0.6.2) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.12-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.12-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.8) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.12+k3s1-->
This release updates Kubernetes to v1.20.12, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1209).

## Changes since v1.20.11+k3s2:

* Updated Kubernetes to v1.20.12 [(#4351)](https://github.com/k3s-io/k3s/pull/4351)
* Set skip SSL verification for etcd snapshots when skip ssl verify flag is passed [(#4105)](https://github.com/k3s-io/k3s/pull/4105)
* Added `--timeout` option to etcd-snapshot command to allow increasing the time allowed for snapshot uploads to complete [(#4227)](https://github.com/k3s-io/k3s/pull/4227)
* Fixed an issue that caused k3s to not be restarted by systemd when started with the `--log` flag [(#4238)](https://github.com/k3s-io/k3s/pull/4238)
* Updated flannel to v0.14.1 [(#4268)](https://github.com/k3s-io/k3s/pull/4268)
* Updated helm-controller and klipper-helm to time out the `helm_v2 ls --all` that is done to check for deprecated helm chart versions [(#4293)](https://github.com/k3s-io/k3s/pull/4293)
* Updated peer address when running cluster-reset [(#4303)](https://github.com/k3s-io/k3s/pull/4303)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.12](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12012) |
| Kine | [v0.6.2](https://github.com/k3s-io/kine/releases/tag/v0.6.2) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.11-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.14.1](https://github.com/flannel-io/flannel/releases/tag/v0.14.1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.8) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.11+k3s2 -->
This release updates containerd to v1.4.11+k3s1 to address CVE-2021-41103 / GHSA-c2h3-6mxw-7mvq.
<!--
This release updates Kubernetes to v1.20.11, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1209).
-->

## Changes since v1.20.11+k3s1:
* The embedded containerd has been updated to v1.4.11+k3s1 to address CVE-2021-41103 ([#4139](https://github.com/k3s-io/k3s/pull/4139))
* Fixed a regression introduced by #4091 that broke rootless support ([#4132](https://github.com/k3s-io/k3s/pull/4132))
* The K3s docker image now works on cgroup v2 systems, and properly reaps terminated containerd shim processes. ([#4091](https://github.com/k3s-io/k3s/pull/4091))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12011) |
| Kine | [v0.6.2](https://github.com/k3s-io/kine/releases/tag/v0.6.2) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.11-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.11-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.12.0-k3s2](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s2) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.5) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
This release updates Kubernetes to v1.20.11, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1209).

## Changes since v1.20.10+k3s1:
* Upgrade Kubernetes to v1.20.11 ([#4030](https://github.com/k3s-io/k3s/pull/4030))
* Reset load balancer state during etcd restoration ([#3879](https://github.com/k3s-io/k3s/pull/3880))
* Fix condition for adding Kubernetes endpoints ([#3947](https://github.com/k3s-io/k3s/pull/3948))
* Removed experimental from cluster commands ([#4034](https://github.com/k3s-io/k3s/pull/4034))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12011) |
| Kine | [v0.6.2](https://github.com/k3s-io/kine/releases/tag/v0.6.2) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.9-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.12.0-k3s2](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s2) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.5) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.10+k3s1 -->
This release updates Kubernetes to v1.20.10, and fixes a number of minor issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1209).

## Changes since v1.20.9+k3s1:
* Upgrade Kubernetes to v1.20.10 ([#3837](https://github.com/k3s-io/k3s/pull/3837))
* The embedded containerd has been updated to v1.4.9-k3s1 ([#3860](https://github.com/k3s-io/k3s/pull/3860))
* Nodes should no longer get stuck in a deleting state ([#3776](https://github.com/k3s-io/k3s/pull/3776))
* The embedded Helm version has been updated to v3.6.3 ([#3764](https://github.com/k3s-io/k3s/pull/3764))
* Helm install jobs should no longer hang when tiller crashes ([#3849](https://github.com/k3s-io/k3s/pull/3849))
* Servers should no longer fail to join an embedded etcd cluster if their IP address is a substring of an existing node IP address ([#3841](https://github.com/k3s-io/k3s/pull/3841) [@mstarostik](https://github.com/mstarostik))
* Etcd backups stored within a subfolder (prefix) of a S3 bucket are now listed properly ([#3813](https://github.com/k3s-io/k3s/pull/3813))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v12010) |
| Kine | [v0.6.2](https://github.com/k3s-io/kine/releases/tag/v0.6.2) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.9-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.9-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.12.0-k3s2](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s2) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.10.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.10.5) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
<!-- v1.20.9+k3s1 -->
This release updates Kubernetes to v1.20.9

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1208)

:warning: **Important Upgrade Note** :warning:  
If you are using K3s in a HA configuration with an external SQL datastore, and your server (control-plane) nodes were not started with the `--token` CLI flag, you will no longer be able to add additional K3s servers to the cluster without specifying the token. Ensure that you retain a copy of this token, as is required when restoring from backup. Previously, K3s did not enforce the use of a token when using external SQL datastores. 

You may retrieve the token value from any server already joined to the cluster:
```bash
cat /var/lib/rancher/k3s/server/token
```

## Changes since v1.20.8+k3s1:
* Upgrade Kubernetes to v1.20.9 ([#3655](https://github.com/k3s-io/k3s/pull/3655))
* Upgrade coredns to v1.8.3 ([#3541](https://github.com/k3s-io/k3s/pull/3541))
* Upgrade k3s-root to v0.9.1 ([#3666](https://github.com/k3s-io/k3s/pull/3666))
* Upgrade containerd to v1.4.8-k3s1 ([#3683](https://github.com/k3s-io/k3s/pull/3683))  
  Addresses [GHSA-c72p-9xmj-rx3w](https://github.com/containerd/containerd/security/advisories/GHSA-c72p-9xmj-rx3w)
* Bootstrap data is now reliably encrypted with the cluster token ([#3516](https://github.com/k3s-io/k3s/pull/3516))  
  Addresses [GHSA-cxm9-4m6p-24mc](https://github.com/k3s-io/k3s/security/advisories/GHSA-cxm9-4m6p-24mc)
* The K3s cloud controller has been moved into a dedicated executor to improve resilience under high datastore latency ([#3531](https://github.com/k3s-io/k3s/pull/3531))
* The CSR signing controller now uses the correct CA for all signers ([#3599](https://github.com/k3s-io/k3s/pull/3599))
* The in-cluster list of available etcd snapshots is no longer updated when snapshots are disabled ([#3611](https://github.com/k3s-io/k3s/pull/3611))
* `k3s etcd-snapshot delete` now functions more reliably when deleting snapshots from S3 ([#3647](https://github.com/k3s-io/k3s/pull/3647))
* `k3s server --cluster-reset` now functions more reliably in case of quorum loss ([#3650](https://github.com/k3s-io/k3s/pull/3650))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1209) |
| Kine | [v0.6.2](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.8-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.8-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.12.0-k3s2](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s2) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.3](https://github.com/coredns/coredns/releases/tag/v1.8.3) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
<!-- v1.20.8+k3s1 -->
This release updates Kubernetes to v1.20.8

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1207)

## Changes since v1.20.7+k3s1:
* Upgrade Kubernetes to v1.20.8 ([#3477](https://github.com/k3s-io/k3s/pull/3477))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1208) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.4-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.12.0-k3s2](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s2) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.7+k3s1 -->
This release updates Kubernetes to v1.20.7

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1206)

## Changes since v1.20.6+k3s1:
* Upgrade Kubernetes to v1.20.7 ([#3329](https://github.com/k3s-io/k3s/pull/3329))
* Fix for sysctl errors with kernel 5.12.2 or newer ([#3342](https://github.com/k3s-io/k3s/pull/3342))
* Fixes ([CVE-2021-30465](https://github.com/opencontainers/runc/security/advisories/GHSA-c3xm-pvg7-gh7r)) runc 1.0.0-rc94 and earlier are vulnerable to a symlink exchange attack ([#3351](https://github.com/k3s-io/k3s/pull/3351)).

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1207) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s3](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s3) |
| Containerd | [v1.4.4-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s1) |
| Runc | [v1.0.0-rc95](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc95) |
| Flannel | [v0.12.0-k3s2](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s2) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.6+k3s1 -->
This release updates Kubernetes to v1.20.6

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1205)

## Changes since v1.20.5+k3s1:
* Upgrade Kubernetes to v1.20.6 ([#3209](https://github.com/k3s-io/k3s/pull/3209))
* Multiple bug fixes for etcd backup and restore on s3
* Fixes ([CVE-2021-25735](https://github.com/kubernetes/kubernetes/issues/100096)) Validating Admission Webhook does not observe some previous fields. Resolved in upstream [PR](https://github.com/kubernetes/kubernetes/pull/100315).

##Known Issues: 
* Install script does not properly escape shell special characters in arguments ([#3179](https://github.com/k3s-io/k3s/issues/3179))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1206) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s1) |
| Runc | [v1.0.0-rc92](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc92) |
| Flannel | [v0.12.0-k3s1](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.20.5+k3s1 -->
This release updates Kubernetes to v1.20.5

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1204)

## Changes since v1.20.4+k3s1:
* Upgrade Kubernetes to v1.20.5 ([#3094](https://github.com/k3s-io/k3s/pull/3094))
* Upgrade to containerd v1.4.4-k3s1 addressing CVE-2021-21334 in containerd/cri ([#3086](https://github.com/k3s-io/k3s/pull/3086))
  See the [containerd security advisory](https://github.com/containerd/containerd/security/advisories/GHSA-6g2q-w5j3-fwh4) for more information.
* Improved error logging when Network Policy Controller cannot be started ([#3042](https://github.com/k3s-io/k3s/pull/3042))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1205) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.4-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.4-k3s1) |
| Runc | [v1.0.0-rc92](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc92) |
| Flannel | [v0.12.0-k3s1](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
<!-- v1.20.4+k3s1 -->

This release updates Kubernetes to v1.20.4

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1202)

Kubernetes v1.20.4 was released to address packaging issues with the v1.20.3 release; there are no corresponding K3s releases.

## Known Issues
* K3s servers should always be upgraded before agents. Agents upgraded to this release before all servers have been upgraded will fail to start due to the issue described at https://github.com/k3s-io/k3s/issues/2996#issuecomment-788352375

## Changes since v1.20.2+k3s2:
* Upgrade Kubernetes to v1.20.4 (k3s-io/k3s#2960)
* K3s servers now use appropriate HTTP response codes to node join failures caused by incorrect credentials (k3s-io/k3s#2915)
* ServiceLB now adds IP addresses for all nodes running LB pods to the Service ingress IP list  (k3s-io/k3s#2909)
* K3s will now reliably enable CFS quotas when the cpu and cpuacct cgroup controllers are comounted (k3s-io/k3s#2911)
* K3s nodes can now successfully join clusters when the cluster CA certificate is trusted by the OS CA bundle (k3s-io/k3s#2743)
* K3s binary size has been reduced; time to first launch a new version of K3s should be reduced as well (k3s-io/k3s#2905)
* K3s is now compiled with golang 1.15.8, resolving a common source of crashes on 32bit arm systems (k3s-io/k3s#2896)
* Crictl will more reliably locate its config file when run by non-root users (k3s-io/k3s#2894)
* The K3s systemd unit will successfully start with a missing EnvironmentFile (k3s-io/k3s#2886 @AkihiroSuda)
* The K3s Network Policy Controller has been updated, offering improved performance and reliability of network policy enforcement (k3s-io/k3s#2867)
* K3s containerd now supports AppArmor signal mediation (k3s-io/k3s#2877)
* The K3s embedded userspace (k3s-root) has been updated to fix several BusyBox CVEs and allow use of the fuse-overlayfs snapshotter (k3s-io/k3s#2862 k3s-io/k3s#2847)
* K3s now supports cgroupv2 (k3s-io/k3s#2844)
* Several regressions in rootless support have been resolved (k3s-io/k3s#2846)
* Cadvisor statistics are no longer missing pod labels (k3s-io/k3s#2836)
* Embedded etcd's Prometheus metrics can now be exposed beyond localhost (k3s-io/k3s#2750 @yuriydzobak)
* The `node.cloudprovider.kubernetes.io/uninitialized` taint on new nodes is now cleared more reliably (k3s-io/k3s#2843)
* Embedded etc snapshots can now be performed on-demand (k3s-io/k3s#2819)
* K3s no longer validates containerd snapshotter functionality when not using the embedded containerd (k3s-io/k3s#2800 @sonicaj)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1204) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.3-k3s3](https://github.com/k3s-io/containerd/releases/tag/v1.4.3-k3s3) |
| Flannel | [v0.12.0-k3s1](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.19](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.19) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
<!-- v1.20.2+k3s1 -->

This release updates Kubernetes to v1.20.2

Kubernetes v1.20.1 was released to address packaging issues with the v1.20.0 release; there are no corresponding K3s releases.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1201)

## Changes since v1.20.0+k3s2:
* Upgrade Kubernetes to v1.20.2 (k3s-io/k3s#2812)
* Helm-controller has been updated to v0.8.3, resolving issues with node taints, and updating the Helm charts stable repository URL (k3s-io/k3s#2793)
* Managed etcd database subdirectory permissions are corrected on startup (k3s-io/k3s#2784)
* K3s now defaults to the correct data-dir path when k3s is running rootless (k3s-io/k3s#2781)


## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1202) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.3-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.3-k3s1) |
| Flannel | [v0.12.0-k3s1](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.3) |
| Local-path-provisioner | [v0.0.14](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.14) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
This release is the first in the K3s v1.20 line. It upgrades to Kubernetes version [v1.20.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1190). If you are coming from v1.19 or earlier, it is recommended that you read the [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#urgent-upgrade-notes).

Major changes from K3s 1.19 include:
* CoreDNS has been bumped to v1.8.0 (k3s-io/k3s#2726)
* Node passwords are now cleaned up when nodes are deleted from the cluster (k3s-io/k3s#2407)
* The `--data-dir` flag no longer leaves some files in `/var/lib/rancher/k3s` (k3s-io/k3s#2475 k3s-io/k3s#2496)
* Pods for packaged components (CoreDNS, Traefik, Metrics-server, Local-storage) now have critical [Priority Classes](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/#how-to-use-priority-and-preemption), which should prevent them from being evicted under load (k3s-io/k3s#2558 @transhapHigsn)
* Rootless support has been improved (k3s-io/k3s#2586 k3s-io/k3s#2595 @AkihiroSuda)
* `k3s --version` now includes the golang version it was compiled with (k3s-io/k3s#2621)
* Several harmless warnings and errors should no longer be seen in the logs (k3s-io/k3s#2475)

With this release, the following versions are latest and stable. For more information on what this means, review our [release channel documentation](https://rancher.com/docs/k3s/latest/en/upgrades/basic/#release-channels).

| Channel | K3s Version | Quick Install Command |
|---|---|---|
| Latest | v1.20.0+k3s2 | `curl -sfL https://get.k3s.io \| INSTALL_K3S_CHANNEL=latest sh -` |
| Stable | v1.19.5+k3s2 | `curl -sfL https://get.k3s.io \| sh -` |

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.20.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#changelog-since-v1190) |
| Kine | [v0.6.0](https://github.com/k3s-io/kine/releases/tag/v0.6.0) |
| SQLite | [3.33.0](https://sqlite.org/releaselog/3_33_0.html) |
| Etcd | [v3.4.13-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.4.13-k3s1) |
| Containerd | [v1.4.3-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.4.3-k3s1) |
| Flannel | [v0.12.0-k3s1](https://github.com/k3s-io/flannel/releases/tag/v0.12.0-k3s1) | 
| Metrics-server | [v0.3.6](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6) |
| Traefik | [v1.7.19](https://github.com/traefik/traefik/releases/tag/v1.7.19) |
| CoreDNS | [v1.8.0](https://github.com/coredns/coredns/releases/tag/v1.8.0) | 
| Helm-controller | [v0.8.0](https://github.com/k3s-io/helm-controller/releases/tag/v0.8.0) |
| Local-path-provisioner | [v0.0.14](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.14) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
