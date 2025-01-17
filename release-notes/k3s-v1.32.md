| k3s version| Kubernetes | Kine | SQLite | Etcd | Containerd | Runc | Flannel | Metrics-server | Traefik | CoreDNS | Helm-controller | Local-path-provisioner  |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | -----  |
| v1.32.0+k3s1 | [v1.32.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md#v1320) | [v0.13.5](https://github.com/k3s-io/kine/releases/tag/v0.13.5) | [3.46.1](https://sqlite.org/releaselog/3_46_1.html) | [v3.5.16-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.16-k3s1) | [v1.7.23-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.23-k3s2) | [v1.2.1-k3s1](https://github.com/opencontainers/runc/releases/tag/v1.2.1-k3s1) | [v0.25.7](https://github.com/flannel-io/flannel/releases/tag/v0.25.7) | [v0.7.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.2) | [v2.11.10](https://github.com/traefik/traefik/releases/tag/v2.11.10) | [v1.12.0](https://github.com/coredns/coredns/releases/tag/v1.12.0) | [v0.16.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.16.5) | [v0.0.30](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.30)  |



| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| [v1.32.0+k3s1](k3s-v1.32.md#release-v1320k3s1) | Jan 10 2025 | 01/10/25 | 2025-01-10 | Dec 11 2024 | 12/11/24 | 2024-12-11 | 30 days |



# Release v1.32.0+k3s1
<!-- v1.32.0+k3s1 -->

This release is K3S's first in the v1.32 line. This release updates Kubernetes to v1.32.0.

Kubernetes 1.32 moves the `AuthorizeNodeWithSelectors` feature gate to Beta and on by default. See [KEP-4601](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/4601-authorize-with-selectors/README.md) for more information.

This feature-gate breaks some of the RBAC that previous releases of K3s relied upon. The January releases of K3s v1.29, v1.30, and v1.31 will contain backported fixes. Until then, you must set `--kube-apiserver-arg=feature-gates=AuthorizeNodeWithSelectors=false` on server nodes, if you want to mix K3s v1.32 nodes with nodes of other versions (within the limits of what is supported by the [Kubernetes Version Skew Policy](https://kubernetes.io/releases/version-skew-policy/)).

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md#changelog-since-v1310).

## Changes since v1.31.4+k3s1:

* Fix rotateca validation failures when not touching default self-signed CAs [(#10710)](https://github.com/k3s-io/k3s/pull/10710)
* Bump runc to v1.1.13 [(#10737)](https://github.com/k3s-io/k3s/pull/10737)
* Update stable channel to v1.30.4+k3s1 [(#10739)](https://github.com/k3s-io/k3s/pull/10739)
* Fix deploy latest commit on E2E tests [(#10725)](https://github.com/k3s-io/k3s/pull/10725)
* Remove secrets encryption controller [(#10612)](https://github.com/k3s-io/k3s/pull/10612)
* Update kubernetes to v1.31.0-k3s3 [(#10764)](https://github.com/k3s-io/k3s/pull/10764)
* Bump traefik to v2.11.8 [(#10779)](https://github.com/k3s-io/k3s/pull/10779)
* Update coredns to 1.11.3 and metrics-server to 0.7.2 [(#10760)](https://github.com/k3s-io/k3s/pull/10760)
* Add trivy scanning to PR reports [(#10758)](https://github.com/k3s-io/k3s/pull/10758)
* Cover edge case when on new minor release for E2E upgrade test [(#10781)](https://github.com/k3s-io/k3s/pull/10781)
* Bump aquasecurity/trivy-action from 0.20.0 to 0.24.0 [(#10795)](https://github.com/k3s-io/k3s/pull/10795)
* Update CNI plugins version [(#10798)](https://github.com/k3s-io/k3s/pull/10798)
* Bump Sonobuoy version [(#10792)](https://github.com/k3s-io/k3s/pull/10792)
* Fix /trivy action running against target branch instead of PR branch [(#10824)](https://github.com/k3s-io/k3s/pull/10824)
* Launch private registry with init [(#10822)](https://github.com/k3s-io/k3s/pull/10822)
* Add channel for v1.31 [(#10826)](https://github.com/k3s-io/k3s/pull/10826)
* Bump containerd to v1.7.21, runc to v1.1.14 [(#10805)](https://github.com/k3s-io/k3s/pull/10805)
* Bump helm-controller for skip-verify/plain-http and updated tolerations [(#10832)](https://github.com/k3s-io/k3s/pull/10832)
* Tag PR image build as latest before scanning [(#10825)](https://github.com/k3s-io/k3s/pull/10825)
* Only clean up containerd hosts dirs managed by k3s [(#10823)](https://github.com/k3s-io/k3s/pull/10823)
* Remove otelgrpc pinned dependency [(#10799)](https://github.com/k3s-io/k3s/pull/10799)
* Add node-internal-dns/node-external-dns address pass-through support [(#10852)](https://github.com/k3s-io/k3s/pull/10852)
* Give good report if no CVEs found in trivy [(#10853)](https://github.com/k3s-io/k3s/pull/10853)
* Fix hosts.toml header var [(#10870)](https://github.com/k3s-io/k3s/pull/10870)
* Bump Trivy version [(#10863)](https://github.com/k3s-io/k3s/pull/10863)
* Add int test for flannel-ipv6masq [(#10440)](https://github.com/k3s-io/k3s/pull/10440)
* Bump Trivy version [(#10899)](https://github.com/k3s-io/k3s/pull/10899)
* Update Kubernetes to v1.31.1-k3s3 [(#10911)](https://github.com/k3s-io/k3s/pull/10911)
* Add MariaDB to CI [(#10724)](https://github.com/k3s-io/k3s/pull/10724)
* Update stable channel tov1.30.5+k3s1 [(#10921)](https://github.com/k3s-io/k3s/pull/10921)
* Use static CNI bin dir [(#10868)](https://github.com/k3s-io/k3s/pull/10868)
  * K3s now uses a stable directory for CNI binaries, which simplifies the installation of additional CNI plugins.
* Breakup trivy scan and check comment author [(#10935)](https://github.com/k3s-io/k3s/pull/10935)
* Fix getMembershipForUserInOrg call [(#10937)](https://github.com/k3s-io/k3s/pull/10937)
* Check k3s-io organization membership not team membership for trivy scans [(#10940)](https://github.com/k3s-io/k3s/pull/10940)
* Bump kine to v0.13.0 [(#10932)](https://github.com/k3s-io/k3s/pull/10932)
  * Kine has been bumped to v0.13.0. This release includes changes that should enhance performance when using postgres as an external DB. The updated schema will be automatically used for new databases; to migrate to the new schema on existing databases, K3s can be started with the `KINE_SCHEMA_MIGRATION=2` environment variable set.
* Fix trivy report download [(#10943)](https://github.com/k3s-io/k3s/pull/10943)
* Trivy workflow: Specify GH_REPO env to use gh cli [(#10949)](https://github.com/k3s-io/k3s/pull/10949)
* Bump Trivy version [(#10924)](https://github.com/k3s-io/k3s/pull/10924)
* Bump traefik to chart 27.0.2 [(#10939)](https://github.com/k3s-io/k3s/pull/10939)
* Pass Rancher's VEX report to Trivy to remove known false-positives CVEs [(#10956)](https://github.com/k3s-io/k3s/pull/10956)
* Fix trivy vex line [(#10970)](https://github.com/k3s-io/k3s/pull/10970)
* Add user path to runtimes search [(#10953)](https://github.com/k3s-io/k3s/pull/10953)
  * Runtimes detection will now use $PATH
* Bump to new wharfie version [(#10971)](https://github.com/k3s-io/k3s/pull/10971)
* Update README.md [(#10523)](https://github.com/k3s-io/k3s/pull/10523)
* Remove trailing whitespace [(#9362)](https://github.com/k3s-io/k3s/pull/9362)
* Bump kine to v0.13.2 [(#10978)](https://github.com/k3s-io/k3s/pull/10978)
* Allow configuration of Rootlesskit's CopyUpDirs through an environment variable [(#10386)](https://github.com/k3s-io/k3s/pull/10386)
  * Add new environment variable "K3S_ROOTLESS_COPYUPDIRS" to add folders to the Rootlesskit configuration.
* Fix race condition when multiple nodes reconcile S3 snapshots [(#10979)](https://github.com/k3s-io/k3s/pull/10979)
* Bump Trivy version [(#10996)](https://github.com/k3s-io/k3s/pull/10996)
* Add ca-cert rotation integration test, and fix ca-cert rotation [(#11013)](https://github.com/k3s-io/k3s/pull/11013)
* Add e2e test which verifies traffic policies and firewall in services [(#10972)](https://github.com/k3s-io/k3s/pull/10972)
* Update tcpproxy for import path change [(#11029)](https://github.com/k3s-io/k3s/pull/11029)
* Bump Local Path Provisioner version [(#10862)](https://github.com/k3s-io/k3s/pull/10862)
* Bump local-path-provisioner to v0.0.30 [(#11049)](https://github.com/k3s-io/k3s/pull/11049)
* Bump helm-controller and klipper-helm [(#11060)](https://github.com/k3s-io/k3s/pull/11060)
* Bump containerd to v1.7.22 [(#11067)](https://github.com/k3s-io/k3s/pull/11067)
* Simplify svclb daemonset [(#10954)](https://github.com/k3s-io/k3s/pull/10954)
  * Stop using klipper-lb as the image for svclb. Replace it with a simple busybox which just sleeps
* Add the nvidia runtime cdi [(#11065)](https://github.com/k3s-io/k3s/pull/11065)
  * Add nvidia cdi runtime to the list of supported and discoverable runtimes
* Bump Trivy version [(#11103)](https://github.com/k3s-io/k3s/pull/11103)
* Rollback GHA to Ubuntu 22.04 [(#11111)](https://github.com/k3s-io/k3s/pull/11111)
* Revert "Make svclb as simple as possible" [(#11109)](https://github.com/k3s-io/k3s/pull/11109)
* Fix Github Actions for Ubuntu-24.04 [(#11112)](https://github.com/k3s-io/k3s/pull/11112)
* Bump aquasecurity/trivy-action from 0.24.0 to 0.27.0 [(#11105)](https://github.com/k3s-io/k3s/pull/11105)
* Check the last 10 commits for upgrade E2E test [(#11086)](https://github.com/k3s-io/k3s/pull/11086)
* Bump aquasecurity/trivy-action from 0.27.0 to 0.28.0 [(#11138)](https://github.com/k3s-io/k3s/pull/11138)
* Fixes "file exists" error from CNI bins when upgrading k3s [(#11123)](https://github.com/k3s-io/k3s/pull/11123)
* Reduce the number of GH api request for E2E nightly [(#11148)](https://github.com/k3s-io/k3s/pull/11148)
* Update Kubernetes to v1.31.2-k3s1 and Go 1.22.8 [(#11163)](https://github.com/k3s-io/k3s/pull/11163)
* Update stable channel to v1.30.6+k3s1 [(#11186)](https://github.com/k3s-io/k3s/pull/11186)
* Fix timeout when defragmenting etcd on startup [(#11164)](https://github.com/k3s-io/k3s/pull/11164)
* Capture all fedora atomic variants in install script [(#11170)](https://github.com/k3s-io/k3s/pull/11170)
  * Allow easier installation of k3s on all variants of fedora atomic that use rpm-ostree
* Typo fixes in contributing.md [(#11201)](https://github.com/k3s-io/k3s/pull/11201)
* Bump Trivy version [(#11206)](https://github.com/k3s-io/k3s/pull/11206)
* Pin vagrant to older version to avoid known issue 13527 [(#11226)](https://github.com/k3s-io/k3s/pull/11226)
* Set kine EmulatedETCDVersion from embedded etcd version [(#11221)](https://github.com/k3s-io/k3s/pull/11221)
* Add nonroot-devices flag to agent CLI [(#11200)](https://github.com/k3s-io/k3s/pull/11200)
  * `Device_ownership_from_security_context` can now be enabled in the containerd CRI config by setting the `--nonroot-devices` flag or config key.
* Bump runc to v1.2 [(#10896)](https://github.com/k3s-io/k3s/pull/10896)
* Update flannel and base cni plugins version [(#11188)](https://github.com/k3s-io/k3s/pull/11188)
* Bump github.com/golang-jwt/jwt/v4 from 4.5.0 to 4.5.1 [(#11236)](https://github.com/k3s-io/k3s/pull/11236)
* Fix MustFindString returning override flags on external CLI commands [(#11237)](https://github.com/k3s-io/k3s/pull/11237)
* Bump containerd to v1.7.23-k3s1 to fix registry rewrite token scopes [(#11238)](https://github.com/k3s-io/k3s/pull/11238)
* Fix the "Standalone"-mode of oidc-login in the wrapped kubectl library [(#11266)](https://github.com/k3s-io/k3s/pull/11266)
  * Fixes 'no Auth Provider found for name "oidc"' when using oidc-login in standalone mode.
* Bump K3s-root version to v0.14.1 [(#11282)](https://github.com/k3s-io/k3s/pull/11282)
* Bump kine [(#11277)](https://github.com/k3s-io/k3s/pull/11277)
* Bump kine for mysql connection close fix [(#11305)](https://github.com/k3s-io/k3s/pull/11305)
* Fix handling of wrapped subcommands when run with a path [(#11306)](https://github.com/k3s-io/k3s/pull/11306)
* Fix updatecli config for klipper and helm-controller [(#11290)](https://github.com/k3s-io/k3s/pull/11290)
* Fix issue with loadbalancer failover to default server [(#11319)](https://github.com/k3s-io/k3s/pull/11319)
* Update `localstorage_int_test.go` reference [(#11339)](https://github.com/k3s-io/k3s/pull/11339)
  * Update `localstorage_int_test.go` reference in `tests/integration/README.md`
* Add  to the output command to be consistent with the product command [(#11345)](https://github.com/k3s-io/k3s/pull/11345)
* Allow install script to print error on failed binary download [(#11335)](https://github.com/k3s-io/k3s/pull/11335)
* Remove the go toolchain line [(#11358)](https://github.com/k3s-io/k3s/pull/11358)
* Add ubuntu 24.04 apt command for e2e test [(#11361)](https://github.com/k3s-io/k3s/pull/11361)
* Bump Trivy version [(#11360)](https://github.com/k3s-io/k3s/pull/11360)
* Bump aquasecurity/trivy-action from 0.28.0 to 0.29.0 [(#11364)](https://github.com/k3s-io/k3s/pull/11364)
* Convert legacy docker tests from bash to golang [(#11357)](https://github.com/k3s-io/k3s/pull/11357)
* Update Kubernetes to v1.31.3-k3s1 [(#11373)](https://github.com/k3s-io/k3s/pull/11373)
* Fix Branch Name logic for Dependabot and UpdateCLI pushes to k3s-io [(#11376)](https://github.com/k3s-io/k3s/pull/11376)
* Fix INSTALL_K3S_PR support [(#11383)](https://github.com/k3s-io/k3s/pull/11383)
* Fix etcd backup/restore test and add guardrail for etcd-snapshot [(#11314)](https://github.com/k3s-io/k3s/pull/11314)
* Bump containerd to -k3s2 to fix rewrites [(#11401)](https://github.com/k3s-io/k3s/pull/11401)
* Fix opensuse-leap install test [(#11379)](https://github.com/k3s-io/k3s/pull/11379)
* Fix secrets-encrypt reencrypt timeout error [(#11385)](https://github.com/k3s-io/k3s/pull/11385)
* Rework loadbalancer server selection logic [(#11329)](https://github.com/k3s-io/k3s/pull/11329)
* Remove experimental from embedded-registry flag [(#11443)](https://github.com/k3s-io/k3s/pull/11443)
* Update stable channel to v1.31.3+k3s1 [(#11436)](https://github.com/k3s-io/k3s/pull/11436)
* Fix agent tunnel address with dedicated supervisor port [(#11427)](https://github.com/k3s-io/k3s/pull/11427)
* Update coredns to 1.12.0 [(#11387)](https://github.com/k3s-io/k3s/pull/11387)
* Bump Trivy version [(#11430)](https://github.com/k3s-io/k3s/pull/11430)
* Update to v1.31.4-k3s1 and Go 1.22.9 [(#11463)](https://github.com/k3s-io/k3s/pull/11463)
* Bump alpine from 3.20 to 3.21 in /conformance [(#11433)](https://github.com/k3s-io/k3s/pull/11433)
* Fix docker check warnings [(#11474)](https://github.com/k3s-io/k3s/pull/11474)
* Update stable channel to v1.31.4+k3s1 [(#11483)](https://github.com/k3s-io/k3s/pull/11483)
* V1.32.0+k3s1 [(#11478)](https://github.com/k3s-io/k3s/pull/11478)
* Switch to using kubelet config file for all supported flags [(#10433)](https://github.com/k3s-io/k3s/pull/10433)
* Load kernel modules for nft in agent setup [(#11527)](https://github.com/k3s-io/k3s/pull/11527)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.32.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md#v1320) |
| Kine | [v0.13.5](https://github.com/k3s-io/kine/releases/tag/v0.13.5) |
| SQLite | [3.46.1](https://sqlite.org/releaselog/3_46_1.html) |
| Etcd | [v3.5.16-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.16-k3s1) |
| Containerd | [v1.7.23-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.7.23-k3s2) |
| Runc | [v1.2.1-k3s1](https://github.com/opencontainers/runc/releases/tag/v1.2.1-k3s1) |
| Flannel | [v0.25.7](https://github.com/flannel-io/flannel/releases/tag/v0.25.7) | 
| Metrics-server | [v0.7.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.2) |
| Traefik | [v2.11.10](https://github.com/traefik/traefik/releases/tag/v2.11.10) |
| CoreDNS | [v1.12.0](https://github.com/coredns/coredns/releases/tag/v1.12.0) | 
| Helm-controller | [v0.16.5](https://github.com/k3s-io/helm-controller/releases/tag/v0.16.5) |
| Local-path-provisioner | [v0.0.30](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.30) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
