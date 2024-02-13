| k3s version| Kubernetes | Kine | SQLite | Etcd | Containerd | Runc | Flannel | Metrics-server | Traefik | CoreDNS | Helm-controller | Local-path-provisioner  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.29.1+k3s2 | [v1.29.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#v1291) | [v0.11.0](https://github.com/k3s-io/kine/releases/tag/v0.11.0) | [3.42.0](https://sqlite.org/releaselog/3_42_0.html) | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) | [v1.7.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.11-k3s2) | [v1.1.12-k3s1](https://github.com/opencontainers/runc/releases/tag/v1.1.12-k3s1) | [v0.24.0](https://github.com/flannel-io/flannel/releases/tag/v0.24.0) | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) | [v2.10.5](https://github.com/traefik/traefik/releases/tag/v2.10.5) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [v0.15.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.8) | [v0.0.24](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.24)  |
| v1.29.0+k3s1 | [v1.29.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#v1290) | [v0.11.0](https://github.com/k3s-io/kine/releases/tag/v0.11.0) | [3.42.0](https://sqlite.org/releaselog/3_42_0.html) | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) | [v1.7.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.11-k3s2) | [v1.1.10](https://github.com/opencontainers/runc/releases/tag/v1.1.10) | [v0.24.0](https://github.com/flannel-io/flannel/releases/tag/v0.24.0) | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) | [v2.10.5](https://github.com/traefik/traefik/releases/tag/v2.10.5) | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | [v0.15.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.4) | [v0.0.24](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.24)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.29.1+k3s2](k3s-v1.29.md#release-v1291k3s2) | Feb 06 2024 | 02/06/24 | 2024-02-06 | Jan 17 2024 | 01/17/24 | 2024-01-17 | 20 days |
| [v1.29.0+k3s1](k3s-v1.29.md#release-v1290k3s1) | Dec 22 2023 | 12/22/23 | 2023-12-22 | Dec 13 2023 | 12/13/23 | 2023-12-13 | 9 days |



# Release v1.29.1+k3s2
<!-- v1.29.1+k3s2 -->

This release updates Kubernetes to v1.29.1, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#changelog-since-v1290).

**Important Notes**

Addresses the runc CVE: [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626) by updating runc to v1.1.12.

## Changes since v1.29.0+k3s1:

* Bump Sonobuoy version [(#8910)](https://github.com/k3s-io/k3s/pull/8910)
* Bump actions/setup-go from 4 to 5 [(#9036)](https://github.com/k3s-io/k3s/pull/9036)
* Chore: Update Code of Conduct to Redirect to CNCF CoC [(#9104)](https://github.com/k3s-io/k3s/pull/9104)
  * NONE
* Update stable channel to v1.28.5+k3s1 and add v1.29 channel [(#9110)](https://github.com/k3s-io/k3s/pull/9110)
* Added support for env *_PROXY variables for agent loadbalancer [(#9070)](https://github.com/k3s-io/k3s/pull/9070)
  * HTTP_PROXY, HTTPS_PROXY and NO_PROXY environment variables are now taken into account by the agent loadbalancer if K3S_AGENT_HTTP_PROXY_ALLOWED env variable is set to true.
  * This however doesn't affect local requests as the function used prevents that: https://pkg.go.dev/net/http#ProxyFromEnvironment.
* Add a retry around updating a secrets-encrypt node annotations [(#9039)](https://github.com/k3s-io/k3s/pull/9039)
* Silence SELinux warning on INSTALL_K3S_SKIP_SELINUX_RPM [(#8703)](https://github.com/k3s-io/k3s/pull/8703)
* Add ServiceLB support for PodHostIPs FeatureGate [(#8917)](https://github.com/k3s-io/k3s/pull/8917)
* Added support for env *_PROXY variables for agent loadbalancer [(#9118)](https://github.com/k3s-io/k3s/pull/9118)
* Redirect error stream to null when checking nm-cloud systemd unit [(#8815)](https://github.com/k3s-io/k3s/pull/8815)
  * Remove confusing "nm-cloud-setup.service: No such file or directory" journalctl log
* Dockerfile.dapper: set $HOME properly [(#9090)](https://github.com/k3s-io/k3s/pull/9090)
* Add system-agent-installer-k3s step to GA release instructions [(#9153)](https://github.com/k3s-io/k3s/pull/9153)
* Fix install script checksum [(#9159)](https://github.com/k3s-io/k3s/pull/9159)
* Fix the OTHER etcd snapshot s3 log message that prints the wrong variable [(#8944)](https://github.com/k3s-io/k3s/pull/8944)
* Handle logging flags when parsing kube-proxy args [(#8916)](https://github.com/k3s-io/k3s/pull/8916)
* Fix nil map in full snapshot configmap reconcile [(#9049)](https://github.com/k3s-io/k3s/pull/9049)
* Add support for containerd cri registry config_path [(#8973)](https://github.com/k3s-io/k3s/pull/8973)
* Add more paths to crun runtime detection [(#9086)](https://github.com/k3s-io/k3s/pull/9086)
* Add runtime checking of golang version [(#9054)](https://github.com/k3s-io/k3s/pull/9054)
* Fix OS PRETTY_NAME on tagged releases [(#9062)](https://github.com/k3s-io/k3s/pull/9062)
* Print error when downloading file error inside install script [(#6874)](https://github.com/k3s-io/k3s/pull/6874)
* Wait for cloud-provider taint to be gone before starting the netpol controller [(#9076)](https://github.com/k3s-io/k3s/pull/9076)
* Bump Trivy version [(#8812)](https://github.com/k3s-io/k3s/pull/8812)
* Use `ipFamilyPolicy: RequireDualStack` for dual-stack kube-dns [(#8984)](https://github.com/k3s-io/k3s/pull/8984)
* Handle etcd status condition when node is not ready and disable etcd [(#9084)](https://github.com/k3s-io/k3s/pull/9084)
* Update s3 e2e test [(#9025)](https://github.com/k3s-io/k3s/pull/9025)
* Add e2e startup test for rootless k3s [(#8383)](https://github.com/k3s-io/k3s/pull/8383)
* Add spegel distributed registry mirror [(#8977)](https://github.com/k3s-io/k3s/pull/8977)
* Bump quic-go for CVE-2023-49295 [(#9208)](https://github.com/k3s-io/k3s/pull/9208)
* Enable network policy controller metrics [(#9195)](https://github.com/k3s-io/k3s/pull/9195)
  * Kube-router network policy controller metrics are now exposed via the default node metrics endpoint
* Fix nonexistent dependency repositories [(#9213)](https://github.com/k3s-io/k3s/pull/9213)
* Move proxy dialer out of init() and fix crash when using `K3S_AGENT_HTTP_PROXY_ALLOWED=true` [(#9219)](https://github.com/k3s-io/k3s/pull/9219)
* Error getting node in setEtcdStatusCondition [(#9210)](https://github.com/k3s-io/k3s/pull/9210)
* Update to v1.29.1 and Go 1.21.6 [(#9259)](https://github.com/k3s-io/k3s/pull/9259)
* New stale action [(#9278)](https://github.com/k3s-io/k3s/pull/9278)
* Fix handling of bare hostname or IP as endpoint address in registries.yaml [(#9323)](https://github.com/k3s-io/k3s/pull/9323)
* Bump runc to v1.1.12 and helm-controller to v0.15.7 [(#9332)](https://github.com/k3s-io/k3s/pull/9332)
* Bump helm-controller to fix issue with ChartContent [(#9345)](https://github.com/k3s-io/k3s/pull/9345)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.29.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#v1291) |
| Kine | [v0.11.0](https://github.com/k3s-io/kine/releases/tag/v0.11.0) |
| SQLite | [3.42.0](https://sqlite.org/releaselog/3_42_0.html) |
| Etcd | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) |
| Containerd | [v1.7.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.11-k3s2) |
| Runc | [v1.1.12-k3s1](https://github.com/opencontainers/runc/releases/tag/v1.1.12-k3s1) |
| Flannel | [v0.24.0](https://github.com/flannel-io/flannel/releases/tag/v0.24.0) | 
| Metrics-server | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) |
| Traefik | [v2.10.5](https://github.com/traefik/traefik/releases/tag/v2.10.5) |
| CoreDNS | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | 
| Helm-controller | [v0.15.8](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.8) |
| Local-path-provisioner | [v0.0.24](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.24) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
# Release v1.29.0+k3s1
<!-- v1.29.0+k3s1 -->

This release is K3S's first in the v1.29 line. This release updates Kubernetes to v1.29.0.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#urgent-upgrade-notes).

⚠️ IMPORTANT: This release removes the expiremental `rotate-keys` subcommand due to changes in Kubernetes upstream for [KMSv2](https://github.com/kubernetes/kubernetes/issues/117728), the subcommand should be added back in future releases.

⚠️ IMPORTANT: This release also removes the `multi-cluster-cidr` flag, since the support for this alpha feature has been removed completely from [Kubernetes upstream](https://groups.google.com/g/kubernetes-sig-network/c/nts1xEZ--gQ/m/2aTOUNFFAAAJ), this flag should be removed from the configuration before upgrade.


## Changes since v1.28.4+k3s2:

* Fix overlapping address range [(#8913)](https://github.com/k3s-io/k3s/pull/8913)
* Modify CONTRIBUTING.md guide [(#8954)](https://github.com/k3s-io/k3s/pull/8954)
* Nov 2023 stable channel update [(#9022)](https://github.com/k3s-io/k3s/pull/9022)
* Default runtime and runtime classes for wasm/nvidia/crun [(#8936)](https://github.com/k3s-io/k3s/pull/8936)
  * Added runtime classes for wasm/nvidia/crun
  * Added default runtime flag for containerd
* Bump containerd/runc to v1.7.10-k3s1/v1.1.10 [(#8962)](https://github.com/k3s-io/k3s/pull/8962)
* Allow setting default-runtime on servers [(#9027)](https://github.com/k3s-io/k3s/pull/9027)
* Bump containerd to v1.7.11 [(#9040)](https://github.com/k3s-io/k3s/pull/9040)
* Remove GA feature-gates [(#8970)](https://github.com/k3s-io/k3s/pull/8970)
* Only publish to code_cov on merged E2E builds [(#9051)](https://github.com/k3s-io/k3s/pull/9051)
* Update Kubernetes to v1.29.0+k3s1 [(#9052)](https://github.com/k3s-io/k3s/pull/9052)
* Update flannel to v0.24.0 and remove multiclustercidr flag [(#9075)](https://github.com/k3s-io/k3s/pull/9075)
* Remove rotate-keys subcommand [(#9079)](https://github.com/k3s-io/k3s/pull/9079)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.29.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#v1290) |
| Kine | [v0.11.0](https://github.com/k3s-io/kine/releases/tag/v0.11.0) |
| SQLite | [3.42.0](https://sqlite.org/releaselog/3_42_0.html) |
| Etcd | [v3.5.9-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.9-k3s1) |
| Containerd | [v1.7.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.11-k3s2) |
| Runc | [v1.1.10](https://github.com/opencontainers/runc/releases/tag/v1.1.10) |
| Flannel | [v0.24.0](https://github.com/flannel-io/flannel/releases/tag/v0.24.0) | 
| Metrics-server | [v0.6.3](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3) |
| Traefik | [v2.10.5](https://github.com/traefik/traefik/releases/tag/v2.10.5) |
| CoreDNS | [v1.10.1](https://github.com/coredns/coredns/releases/tag/v1.10.1) | 
| Helm-controller | [v0.15.4](https://github.com/k3s-io/helm-controller/releases/tag/v0.15.4) |
| Local-path-provisioner | [v0.0.24](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.24) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
