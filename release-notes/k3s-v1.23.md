<!-- v1.23.17+k3s1 -->
This release updates Kubernetes to v1.23.17, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v12316).

## Changes since v1.23.16+k3s1:

* Add jitter to scheduled snapshots and retry harder on conflicts [(#6784)](https://github.com/k3s-io/k3s/pull/6784)
  * Scheduled etcd snapshots are now offset by a short random delay of up to several seconds. This should prevent multi-server clusters from executing pathological behavior when attempting to simultaneously update the snapshot list ConfigMap. The snapshot controller will also be more persistent in attempting to update the snapshot list.
* Bugfix: do not break cert-manager when pprof is enabled [(#6839)](https://github.com/k3s-io/k3s/pull/6839)
* Fix cronjob example [(#6866)](https://github.com/k3s-io/k3s/pull/6866)
* Consolidate E2E tests [(#6889)](https://github.com/k3s-io/k3s/pull/6889)
* Bump vagrant boxes to fedora37 [(#6910)](https://github.com/k3s-io/k3s/pull/6910)
* Ignore value conflicts when reencrypting secrets [(#6917)](https://github.com/k3s-io/k3s/pull/6917)
* Use default address family when adding kubernetes service address to SAN list [(#6906)](https://github.com/k3s-io/k3s/pull/6906)
  * The apiserver advertised address and IP SAN entry are now set correctly on clusters that use IPv6 as the default IP family.
* Allow ServiceLB to honor `ExternalTrafficPolicy=Local` [(#6909)](https://github.com/k3s-io/k3s/pull/6909)
  * ServiceLB now honors the Service's ExternalTrafficPolicy. When set to Local, the LoadBalancer will only advertise addresses of Nodes with a Pod for the Service, and will not forward traffic to other cluster members.
* Fix issue with servicelb startup failure when validating webhooks block creation [(#6921)](https://github.com/k3s-io/k3s/pull/6921)
  * The embedded cloud controller manager will no longer attempt to unconditionally re-create its namespace and serviceaccount on startup. This resolves an issue that could cause a deadlocked cluster when fail-closed webhooks are in use.
* Backport user-provided CA cert and `kubeadm` bootstrap token support [(#6931)](https://github.com/k3s-io/k3s/pull/6931)
  * K3s now functions properly when the cluster CA certificates are signed by an existing root or intermediate CA. You can find a sample script for generating such certificates before K3s starts in the github repo at [contrib/util/certs.sh](https://github.com/k3s-io/k3s/blob/master/contrib/util/certs.sh).
  * K3s now supports `kubeadm` style join tokens. `k3s token create` now creates join token secrets, optionally with a limited TTL.
  * K3s agents joined with an expired or deleted token stay in the cluster using existing client certificates via the NodeAuthorization admission plugin, unless their Node object is deleted from the cluster.
* Fix access to hostNetwork port on NodeIP when egress-selector-mode=agent [(#6938)](https://github.com/k3s-io/k3s/pull/6938)
  * Fixed an issue that would cause the apiserver egress proxy to attempt to use the agent tunnel to connect to service endpoints even in agent or disabled mode.
* Allow for multiple sets of leader-elected controllers [(#6943)](https://github.com/k3s-io/k3s/pull/6943)
  * Fixed an issue where leader-elected controllers for managed etcd did not run on etcd-only nodes
* Fix etcd and ca-cert rotate issues [(#6956)](https://github.com/k3s-io/k3s/pull/6956)
* Update flannel to v0.21.1 [(#6964)](https://github.com/k3s-io/k3s/pull/6964)
* Fix ServiceLB dual-stack ingress IP listing [(#6989)](https://github.com/k3s-io/k3s/pull/6989)
  * Resolved an issue with ServiceLB that would cause it to advertise node IPv6 addresses, even if the cluster or service was not enabled for dual-stack operation.
* Bump kine to v0.9.9 or newer [(#6991)](https://github.com/k3s-io/k3s/pull/6991)
  * The embedded kine version has been bumped to v0.9.9. Compaction log messages are now omitted at `info` level for increased visibility.
* Update to v1.23.17-k3s1 [(#7005)](https://github.com/k3s-io/k3s/pull/7005)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.17](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12317) |
| Kine | [v0.9.9](https://github.com/k3s-io/kine/releases/tag/v0.9.9) |
| SQLite | [3.39.2](https://sqlite.org/releaselog/3_39_2.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.16-k3s2-1-22](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s2-1-22) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.21.1-k3s1.23](https://github.com/flannel-io/flannel/releases/tag/v0.21.1-k3s1.23) | 
| Metrics-server | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) |
| Traefik | [v2.9.4](https://github.com/traefik/traefik/releases/tag/v2.9.4) |
| CoreDNS | [v1.9.4](https://github.com/coredns/coredns/releases/tag/v1.9.4) | 
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1) |
| Local-path-provisioner | [v0.0.23](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.23) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
<!-- v1.23.16+k3s1 -->
This release updates Kubernetes to v1.23.16, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v12315).

## Changes since v1.23.15+k3s1:

* Backport missing E2E test commits [(#6699)](https://github.com/k3s-io/k3s/pull/6699)
* Pass through default tls-cipher-suites [(#6732)](https://github.com/k3s-io/k3s/pull/6732)
  * The K3s default cipher suites are now explicitly passed in to kube-apiserver, ensuring that all listeners use these values.
* Bump action/download-artifact to v3 [(#6749)](https://github.com/k3s-io/k3s/pull/6749)
* Backport dependabot/updatecli updates [(#6763)](https://github.com/k3s-io/k3s/pull/6763)
* Fix Drone plugins/docker tag for 32 bit arm [(#6766)](https://github.com/k3s-io/k3s/pull/6766)
* Update to v1.23.16+k3s1 [(#6776)](https://github.com/k3s-io/k3s/pull/6776)
* Bump containerd to v1.5.16-k3s2 [(#6810)](https://github.com/k3s-io/k3s/pull/6810)
  * The embedded containerd version has been bumped to v1.5.16-k3s2. This includes a backported fix for [containerd/7843](https://github.com/containerd/containerd/issues/7843) which caused pods to lose their CNI info when containerd was restarted, which in turn caused the kubelet to recreate the pod.

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.16](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12316) |
| Kine | [v0.9.6](https://github.com/k3s-io/kine/releases/tag/v0.9.6) |
| SQLite | [3.39.2](https://sqlite.org/releaselog/3_39_2.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.16-k3s2-1-22](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s2-1-22) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.20.2-k3s1.23](https://github.com/flannel-io/flannel/releases/tag/v0.20.2-k3s1.23) | 
| Metrics-server | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) |
| Traefik | [v2.9.4](https://github.com/traefik/traefik/releases/tag/v2.9.4) |
| CoreDNS | [v1.9.4](https://github.com/coredns/coredns/releases/tag/v1.9.4) | 
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1) |
| Local-path-provisioner | [v0.0.23](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.23) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)
-----
<!-- v1.23.15+k3s1 -->
This release updates Kubernetes to v1.23.15, and fixes a number of issues.

**Breaking Change:** K3s no longer includes `swanctl` and `charon` binaries. If you are using the ipsec flannel backend, please ensure that the strongswan `swanctl` and `charon` packages are installed on your node before upgrading K3s to this release.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v12314).

## Changes since v1.23.14+k3s1:

* Remove stuff which belongs in the windows executor implementation [(#6503)](https://github.com/k3s-io/k3s/pull/6503)
* Fix log for flannelExternalIP use case [(#6541)](https://github.com/k3s-io/k3s/pull/6541)
* Github CI Updates [(#6536)](https://github.com/k3s-io/k3s/pull/6536)
* Switch from Google Buckets to AWS S3 Buckets [(#6571)](https://github.com/k3s-io/k3s/pull/6571)
* Change secrets-encryption flag to GA [(#6592)](https://github.com/k3s-io/k3s/pull/6592)
* Update flannel to v0.20.2 [(#6590)](https://github.com/k3s-io/k3s/pull/6590)
* Backports for 2022-12 [(#6602)](https://github.com/k3s-io/k3s/pull/6602)
  * Added new prefer-bundled-bin flag which force K3s to use its bundle binaries over that of the host tools
  * The rootless `port-driver`, `cidr`, `mtu`, `enable-ipv6`, and `disable-host-loopback` settings can now be configured via environment variables.
  * The embedded Load-Balancer controller image has been bumped to klipper-lb:v0.4.0, which includes support for the [LoadBalancerSourceRanges](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/#:~:text=loadBalancerSourceRanges) field.
  * The embedded Helm controller image has been bumped to klipper-helm:v0.7.4-build20221121
  * The embedded cloud-controller-manager's metrics listener on port 10258 is now disabled when the `--disable-cloud-controller` flag is set.
  * Deployments for K3s packaged components now have consistent upgrade strategy and revisionHistoryLimit settings, and will not override scaling decisions by hardcoding the replica count.
  * The packaged metrics-server has been bumped to v0.6.2
  * The embedded k3s-root version has been bumped to v0.12.0, based on buildroot 2022.08.1.
  * The embedded swanctl and charon binaries have been removed. If you are using the ipsec flannel backend, please ensure that the strongswan `swanctl` and `charon` packages are installed on your node before upgrading k3s.
* Update node12->node16 based GH actions [(#6594)](https://github.com/k3s-io/k3s/pull/6594)
* Update to v1.23.15-k3s1 [(#6624)](https://github.com/k3s-io/k3s/pull/6624)
* Bump containerd to v1.5.16-k3s1-v1-22 [(#6628)](https://github.com/k3s-io/k3s/pull/6628)
  * The embedded containerd version has been bumped to v1.5.16
* Preload iptable_filter/ip6table_filter [(#6648)](https://github.com/k3s-io/k3s/pull/6648)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.15](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12315) |
| Kine | [v0.9.6](https://github.com/k3s-io/kine/releases/tag/v0.9.6) |
| SQLite | [3.39.2](https://sqlite.org/releaselog/3_39_2.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.16-k3s1-1-22](https://github.com/k3s-io/containerd/releases/tag/v1.5.16-k3s1-1-22) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.20.2-k3s1.23](https://github.com/flannel-io/flannel/releases/tag/v0.20.2-k3s1.23) | 
| Metrics-server | [v0.6.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2) |
| Traefik | [v2.9.4](https://github.com/traefik/traefik/releases/tag/v2.9.4) |
| CoreDNS | [v1.9.4](https://github.com/coredns/coredns/releases/tag/v1.9.4) | 
| Helm-controller | [v0.13.1](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.1) |
| Local-path-provisioner | [v0.0.23](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.23) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.23.14+k3s1 -->
This release updates Kubernetes to v1.23.14, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v12313).

## Changes since v1.23.13+k3s1:

* Add the gateway parameter in netplan [(#6343)](https://github.com/k3s-io/k3s/pull/6343)
* Add a netpol test for podSelector & ingress type [(#6349)](https://github.com/k3s-io/k3s/pull/6349)
* Upgrade kube-router to v1.5.1 [(#6357)](https://github.com/k3s-io/k3s/pull/6357)
* Add test for node-external-ip config parameter [(#6364)](https://github.com/k3s-io/k3s/pull/6364)
* Bump install tests OS images [(#6381)](https://github.com/k3s-io/k3s/pull/6381)
* Update Flannel to v0.20.1 [(#6419)](https://github.com/k3s-io/k3s/pull/6419)
* Backports for 2022-11 
 * The packaged traefik helm chart has been bumped to v19.0.0, enabling ingressclass support by default.
 * The packaged local-path-provisioner has been bumped to v0.0.23 
 * The packaged coredns has been bumped to v1.9.4
 * Fix incorrect defer usage
 * The bundled traefik has been updated to v2.9.4 /  helm chart v18.3.0
 * Use debugger-friendly compile settings if debug is set
 * Add test for node-external-ip config parameter
 * Convert containerd config.toml.tmpl linux template to v2 syntax
 * Replace fedora-coreos with fedora 36 for install tests
 * Fixed an issue that would prevent the deploy controller from handling manifests that include resource types that are no longer supported by the apiserver.
 * The embedded helm controller has been bumped to v0.13.0
 * The bundled traefik helm chart has been updated to v18.0.0
 * Add hardened cluster and upgrade tests
 * Bump kine to v0.9.6 / sqlite3 v3.39.2 ([cve-2022-35737](https://nvd.nist.gov/vuln/detail/cve-2022-35737))
 * Bumped dynamiclistener library to v0.3.5 [(#6412)](https://github.com/k3s-io/k3s/pull/6412)
* Add some helping logs to avoid wrong configs [(#6433)](https://github.com/k3s-io/k3s/pull/6433)
* Change the priority of address types depending on flannel-external-ip [(#6435)](https://github.com/k3s-io/k3s/pull/6435)
* log kube-router version when starting netpol controller [(#6438)](https://github.com/k3s-io/k3s/pull/6438)
* K3s now indicates specifically which cluster-level configuration flags are out of sync when critical configuration differs between server nodes. [(#6447)](https://github.com/k3s-io/k3s/pull/6447)
* Pull traefik helm chart directly from GH [(#6470)](https://github.com/k3s-io/k3s/pull/6470)
* Update to v1.23.14 [(#6480)](https://github.com/k3s-io/k3s/pull/6480)
* The packaged traefik helm chart has been bumped to 19.0.4 [(#6496)](https://github.com/k3s-io/k3s/pull/6496)
* Move traefik chart repo again [(#6510)](https://github.com/k3s-io/k3s/pull/6510)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.14](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12314) |
| Kine | [v0.9.6](https://github.com/k3s-io/kine/releases/tag/v0.9.6) |
| SQLite | [3.39.2](https://sqlite.org/releaselog/3_39_2.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.20.1-k3s1.23](https://github.com/flannel-io/flannel/releases/tag/v0.20.1-k3s1.23) | 
| Metrics-server | [v0.6.1](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.1) |
| Traefik | [v2.9.4](https://github.com/traefik/traefik/releases/tag/v2.9.4) |
| CoreDNS | [v1.9.4](https://github.com/coredns/coredns/releases/tag/v1.9.4) | 
| Helm-controller | [v0.13.0](https://github.com/k3s-io/helm-controller/releases/tag/v0.13.0) |
| Local-path-provisioner | [v0.0.23](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.23) |

## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)

-----
<!-- v1.23.13+k3s1 -->
This release updates Kubernetes to v1.23.13, and fixes a number of issues.

The K3s [CIS Hardening Guide](https://docs.k3s.io/security/hardening-guide) has been updated to include configuration changes required to support embedding ServiceLB in the cloud controller manager. If you have followed the hardening guide, please update your policies and RBAC in accordingly.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v12312).

## Changes since v1.23.12+k3s1:

* Add flannel-external-ip when there is a k3s node-external-ip [(#6191)](https://github.com/k3s-io/k3s/pull/6191)
* Backports for 2022-10 [(#6228)](https://github.com/k3s-io/k3s/pull/6228)
  * The embedded metrics-server version has been bumped to v0.6.1
  * The ServiceLB (klipper-lb) service controller is now integrated into the K3s stub cloud controller manager.
  * Events recorded to the cluster by embedded controllers are now properly formatted in the service logs.
  * Fixed an issue with the apiserver network proxy that caused `kubectl exec` to occasionally fail with `error dialing backend: EOF`
  * Fixed an issue with the apiserver network proxy that caused `kubectl exec` and `kubectl logs` to fail when a custom kubelet port was used, and the custom port was blocked by firewall or security group rules.
  * The embedded Traefik version has been bumped to v2.9.1 / chart 12.0.0
* Replace deprecated ioutil package [(#6236)](https://github.com/k3s-io/k3s/pull/6236)
* Fix dualStack test [(#6251)](https://github.com/k3s-io/k3s/pull/6251)
* Update to v1.23.13-k3s1 [(#6271)](https://github.com/k3s-io/k3s/pull/6271)
* Add ServiceAccount for svclb pods [(#6277)](https://github.com/k3s-io/k3s/pull/6277)
* Return ProviderID in URI format [(#6288)](https://github.com/k3s-io/k3s/pull/6288)
* Corrected CCM RBAC to allow for removal of legacy service finalizer during upgrades. [(#6308)](https://github.com/k3s-io/k3s/pull/6308)
* Added a new --flannel-external-ip flag. [(#6323)](https://github.com/k3s-io/k3s/pull/6323)
  * When enabled, Flannel traffic will now use the nodes external IPs, instead of internal.
  * This is meant for use with distributed clusters that are not all on the same local network.

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.13](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12313) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.1.4](https://github.com/opencontainers/runc/releases/tag/v1.1.4) |
| Flannel | [v0.19.2](https://github.com/flannel-io/flannel/releases/tag/v0.19.2) |
| Metrics-server | [v0.6.1](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.1) |
| Traefik | [v2.9.1](https://github.com/traefik/traefik/releases/tag/v2.9.1) |
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
<!-- v1.23.12+k3s1 -->
This release updates Kubernetes to v1.23.12, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v12310).

## Changes since v1.23.10+k3s1:

* Bulk Backport of Testing Changes [(#6086)](https://github.com/k3s-io/k3s/pull/6086)
* Update Flannel to v0.19.2 to fix older iptables issue [(#6091)](https://github.com/k3s-io/k3s/pull/6091)
* The bundled version of runc has been bumped to v1.1.4 [(#6073)](https://github.com/k3s-io/k3s/pull/6073)
* Add validation check to confirm correct golang version for Kubernetes [(#6114)](https://github.com/k3s-io/k3s/pull/6114)
* Update to v1.23.11 [(#6144)](https://github.com/k3s-io/k3s/pull/6144)
* Update to v1.23.12 [(#6166)](https://github.com/k3s-io/k3s/pull/6166)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.12](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12312) |
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
<!-- v1.23.10+k3s1 -->
This release updates Kubernetes to v1.23.10, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1239).

## Changes since v1.23.9+k3s1:

* Fix secrets reencryption for 8K+ secrets [(#5939)](https://github.com/k3s-io/k3s/pull/5939)
* The etcd error on incorrect peer urls now correctly includes the expected https and 2380 port. [(#5949)](https://github.com/k3s-io/k3s/pull/5949)
* Bumped minio-go to v7.0.33. This adds support for IMDSv2 credentials.
* When set, the agent-token value is now written to `$datadir/server/agent-token`, in the same manner as the default (server) token is written to `$datadir/server/token`
* Updated dynamiclistener to fix a regression that prevented certificate renewal from working properly.
* The configured service CIDR is now passed to the Kubernetes controller-manager via the `--service-cluster-ip-range` flag. Previously this value was only passed to the apiserver.
* Fixed a regression that caused systemd cgroup driver autoconfiguration to fail on server nodes.
* The initial health-check time for the etcd datastore has been raised from 10 to 30 seconds.
* Bumped rootlesskit to v1.0.1 [(#5951)](https://github.com/k3s-io/k3s/pull/5951)
* Added dualstack IP auto detection [(#5955)](https://github.com/k3s-io/k3s/pull/5955)
* Updated flannel to v0.19.1 [(#5966)](https://github.com/k3s-io/k3s/pull/5966)
* Remove codespell from Drone, add to GH Actions [(#6011)](https://github.com/k3s-io/k3s/pull/6011)
* Update to v1.23.10 [(#6013)](https://github.com/k3s-io/k3s/pull/6013)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.10](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v12310) |
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
<!-- v1.23.9+k3s1 -->
This release updates Kubernetes to v1.23.9, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1238).

## Changes since v1.23.8+k3s2:
* Fixed an issue that would cause etcd restore to fail when restoring a snapshot made with secrets encryption enabled if the --secrets-encryption command was not included in the config file or restore command. [(#5819)](https://github.com/k3s-io/k3s/pull/5819)
* Fix deletion of svclb DaemonSet when Service is deleted
* Fixed a regression that caused ServiceLB DaemonSets to remain present after their corresponding Services were deleted.
    Manual cleanup of orphaned `svclb-*` DaemonSets from the `kube-system` namespace may be necessary if any LoadBalancer Services were deleted while running an affected release. [(#5826)](https://github.com/k3s-io/k3s/pull/5826)
* Backport runc and remotedialer version bumps
* Updated rancher/remotedialer to address a potential memory leak.
* The embedded runc binary has been bumped to v1.1.3 [(#5827)](https://github.com/k3s-io/k3s/pull/5827)
* Address issues with etcd snapshots
* Scheduled etcd snapshots are now compressed when snapshot compression is enabled.
* The default etcd snapshot timeout has been raised to 5 minutes.
    Only one scheduled etcd snapshot will run at a time. If another snapshot would occur while the previous snapshot is still in progress, an error will be logged and the second scheduled snapshot will be skipped.
* S3 objects for etcd snapshots are now labeled with the correct content-type when compression is not enabled. [(#5842)](https://github.com/k3s-io/k3s/pull/5842)
* Update to v1.23.9 [(#5871)](https://github.com/k3s-io/k3s/pull/5871)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.9](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1239) |
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
<!-- v1.23.8+k3s2 -->
This fixes several issues in the v1.23.8+k3s1 and prior releases.

## Changes since v1.23.8+k3s1:

* Fixed an issue that prevented `kubectl logs` and other functionality that requires a connection to the agent from working correctly when the server's `--bind-address` flag was used, or when k3s is used behind a http proxy. ([#5797](https://github.com/k3s-io/k3s/pull/5797))
* K3s will no longer log panics after upgrading directly from much older kubernetes releases, or when deploying services with `type: externalname`. ([#5797](https://github.com/k3s-io/k3s/pull/5797))
* Bumped kine to v0.9.3 ([#5797](https://github.com/k3s-io/k3s/pull/5797))
* Fixed an issue that prevented newer versions of k3s from joining clusters that do not have egress-selector-mode support. ([#5791](https://github.com/k3s-io/k3s/pull/5791))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1238) |
| Kine | [v0.9.3](https://github.com/k3s-io/kine/releases/tag/v0.9.3) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
| Flannel | [v0.18.1](https://github.com/flannel-io/flannel/releases/tag/v0.18.1) | 
| Metrics-server | [v0.5.2](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.5.2) |
| Traefik | [v2.6.2](https://github.com/traefik/traefik/releases/tag/v2.6.2) |
| CoreDNS | [v1.9.1](https://github.com/coredns/coredns/releases/tag/v1.9.1) | 
| Helm-controller | [v0.12.3](https://github.com/k3s-io/helm-controller/releases/tag/v0.12.3) |
| Local-path-provisioner | [v0.0.21](https://github.com/rancher/local-path-provisioner/releases/tag/v0.0.21) |

## Known Issues

- [#5823](https://github.com/k3s-io/k3s/issues/5823) - When using ServiceLB, deleting Services with `type: LoadBalancer` will leave orphan `svclb-` DaemonSets. This will be fixed in a subsequent release.


## Helpful Links
As always, we welcome and appreciate feedback from our community of users. Please feel free to:
- [Open issues here](https://github.com/rancher/k3s/issues/new/choose)
- [Join our Slack channel](https://slack.rancher.io/)
- [Check out our documentation](https://rancher.com/docs/k3s/latest/en/) for guidance on how to get started or to dive deep into K3s.
- [Read how you can contribute here](https://github.com/rancher/k3s/blob/master/CONTRIBUTING.md)


-----
<!-- v1.23.8+k3s1 -->
This release updates Kubernetes to v1.23.8, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1237).

## Changes since v1.23.7+k3s1:

* Remove kube-ipvs0 interface when cleaning up [(#5680)](https://github.com/k3s-io/k3s/pull/5680)
* Add FlannelConfCNI flag [(#5682)](https://github.com/k3s-io/k3s/pull/5682)
* Integration and E2E test improvements [(#5686)](https://github.com/k3s-io/k3s/pull/5686)
* add support for pprof server [(#5690)](https://github.com/k3s-io/k3s/pull/5690)
* Disable urfave markdown/man docs generation [(#5700)](https://github.com/k3s-io/k3s/pull/5700)
* The embedded etcd snapshot controller will no longer fail to process snapshot files containing characters that are invalid for use in ConfigMap keys. [(#5703)](https://github.com/k3s-io/k3s/pull/5703)
* Environment variables prefixed with `CONTAINERD_` now take priority over other existing variables, when passed through to containerd. [(#5709)](https://github.com/k3s-io/k3s/pull/5709)
* The embedded etcd instance no longer accepts connections from other nodes while resetting or restoring. [(#5694)](https://github.com/k3s-io/k3s/pull/5694)
* Delay service readiness until after startuphooks have finished [(#5723)](https://github.com/k3s-io/k3s/pull/5723)
* Flannel version update to 0.18.1 and added the ability to configure additional options for wireguard backend [(#5721)](https://github.com/k3s-io/k3s/pull/5721)
* Pods created by ServiceLB are now all placed in the `kube-system` namespace, instead of in the same namespace as the Service. This allows for [enforcing Pod Security Standards](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels/) in user namespaces without breaking ServiceLB. [(#5730)](https://github.com/k3s-io/k3s/pull/5730)
* The embedded Helm controller now properly updates Chart deployments when HelmChartConfig resources are updated or deleted. [(#5734)](https://github.com/k3s-io/k3s/pull/5734)
* Update to v1.23.8-k3s1 [(#5751)](https://github.com/k3s-io/k3s/pull/5751)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.8](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1238) |
| Kine | [v0.9.1](https://github.com/k3s-io/kine/releases/tag/v0.9.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.13-k3s1](https://github.com/k3s-io/containerd/releases/tag/v1.5.13-k3s1) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
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
<!-- v1.23.7+k3s1 -->
This release updates Kubernetes to v1.23.7, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1236).

## Changes since v1.23.6+k3s1:

* Add CNI Plugins and Flannel version to build scripts
* CNI plugins binaries now output the correct versions when queried on the command line
* CNI plugins have been bumped to v1.1.1 [(#5464)](https://github.com/k3s-io/k3s/pull/5464)
* K3s now uses the systemd cgroup driver instead of cgroupfs when running under systemd 244 or later. [(#5462)](https://github.com/k3s-io/k3s/pull/5462)
* K3s supervisor status errors are now wrapped in Kubernetes API error types, for improved compatibility with Kubernetes client libraries. [(#5519)](https://github.com/k3s-io/k3s/pull/5519)
* K3s now supports [NATS JetStream](https://docs.nats.io/nats-concepts/jetstream) as a datastore backend [(#5207)](https://github.com/k3s-io/k3s/pull/5207)
* agent(netpol): Explicitly enable IPv4 when necessary [(#5470)](https://github.com/k3s-io/k3s/pull/5470)
* Use ListWatch helpers instead of bare List/Watch [(#5487)](https://github.com/k3s-io/k3s/pull/5487)
* Users can now install auto-completion using the k3s completion command [(#5461)](https://github.com/k3s-io/k3s/pull/5461)
* The embedded kubelet now waits for the apiserver to become available before starting. [(#5518)](https://github.com/k3s-io/k3s/pull/5518)
* The K3s supervisor now implements a [KEP-1281](https://github.com/kubernetes/enhancements/tree/master/keps/sig-api-machinery/1281-network-proxy) compliant apiserver network proxy. [(#5382)](https://github.com/k3s-io/k3s/pull/5382)
* Check if user has a correct cluster-cidr and service-cidr config [(#5492)](https://github.com/k3s-io/k3s/pull/5492)
* When generating a replacement resolv.conf due to potentially unsuitable nameservers in the host resolv.conf, k3s now logs a warning, and stores the autogenerated configuration file in a more durable location. [(#5531)](https://github.com/k3s-io/k3s/pull/5531)
* Fix dual-stack and ipv6 support in traefik ingress [(#5535)](https://github.com/k3s-io/k3s/pull/5535)
* Mark v1.23.6+k3s1 stable [(#5529)](https://github.com/k3s-io/k3s/pull/5529)
* Objects will be removed from Kubernetes when they are removed from manifest files. [(#5594)](https://github.com/k3s-io/k3s/pull/5594)
* The integrated apiserver network proxy's operational mode can now be set with `--egress-selector-mode`. [(#5603)](https://github.com/k3s-io/k3s/pull/5603)
* Update Kubernetes to v1.23.7-k3s1 [(#5614)](https://github.com/k3s-io/k3s/pull/5614)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.7](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1237) |
| Kine | [v0.9.1](https://github.com/k3s-io/kine/releases/tag/v0.9.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.11-k3s2) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
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
<!-- v1.23.6+k3s1 -->
This release updates Kubernetes to v1.23.6, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1235).

## Changes since v1.23.5+k3s1:

* Fixed etcd URL in case of IPv6 address [(#5325)](https://github.com/k3s-io/k3s/pull/5325)
* The flannel configuration passed to `--flannel-conf` may now use the flannel backend type "wireguard". [(#5377)](https://github.com/k3s-io/k3s/pull/5377)
* netpol: Add dual-stack support [(#5387)](https://github.com/k3s-io/k3s/pull/5387)
* When using clusters with a mix of etcd-only/control-plane-only nodes, agents may now also join etcd-only servers [(#5367)](https://github.com/k3s-io/k3s/pull/5367)
* Fixed an issue that caused k3s to crash on startup when converting a node from agent to server. K3s will no longer panic on startup if the legacy node password file exists but does not contain any valid password entries. [(#5392)](https://github.com/k3s-io/k3s/pull/5392)
* K3s will no longer crash on startup if the scheduled cron expression triggered a snapshot before the internal controllers are fully initialized. [(#5383)](https://github.com/k3s-io/k3s/pull/5383)
* Add wireguard native flannel backend [(#5391)](https://github.com/k3s-io/k3s/pull/5391)
* Managed etcd controllers no longer run on clusters not using managed etcd. [(#5388)](https://github.com/k3s-io/k3s/pull/5388)
* Update helm-controller version [(#5398)](https://github.com/k3s-io/k3s/pull/5398)
* Add certificate rotation integration tests [(#5393)](https://github.com/k3s-io/k3s/pull/5393)
* fix: non-idiomatic returning of boolean expression [(#5343)](https://github.com/k3s-io/k3s/pull/5343)
* update trivy to 0.25.3 [(#5401)](https://github.com/k3s-io/k3s/pull/5401)
* Fixed flannel backend helper text [(#5422)](https://github.com/k3s-io/k3s/pull/5422)
* fix typo in Dockerfile [(#5370)](https://github.com/k3s-io/k3s/pull/5370)
* golang-ci has been upgraded to 1.45.2 [(#5403)](https://github.com/k3s-io/k3s/pull/5403)
* Added default endpoint for IPv6 [(#5420)](https://github.com/k3s-io/k3s/pull/5420)
* Bump Reencryption Test timeout, improve comments [(#5431)](https://github.com/k3s-io/k3s/pull/5431)
* update sonobuoy to 0.56.4 [(#5419)](https://github.com/k3s-io/k3s/pull/5419)
* Added support for repeated extra arguments [(#5373)](https://github.com/k3s-io/k3s/pull/5373)
* E2E: Added option to config hardened k3s [(#5415)](https://github.com/k3s-io/k3s/pull/5415)
* The embedded containerd version has been bumped to v1.5.11-k3s1 [(#5432)](https://github.com/k3s-io/k3s/pull/5432)
* Fix issue with RKE2 server hanging on startup when listing apiserver addresses [(#5437)](https://github.com/k3s-io/k3s/pull/5437)
* The embedded etcd version has been bumped to v3.5.3-k3s1 [(#5429)](https://github.com/k3s-io/k3s/pull/5429)
* Add s390x arch support for k3s [(#5018)](https://github.com/k3s-io/k3s/pull/5018)
* E2E Validation Improvements [(#5444)](https://github.com/k3s-io/k3s/pull/5444)
* Fix wrong default ipv6 cidr [(#5467)](https://github.com/k3s-io/k3s/pull/5467)
* Update Kubernetes to v1.23.6 [(#5477)](https://github.com/k3s-io/k3s/pull/5477)
* Fix issue with long-running apiserver endpoints watch [(#5478)](https://github.com/k3s-io/k3s/pull/5478)
* Secrets Encryption: Add RetryOnConflict around updating nodes [(#5495)](https://github.com/k3s-io/k3s/pull/5495)
* Bump containerd for selinux fix [(#5507)](https://github.com/k3s-io/k3s/pull/5507)
* Fix issue with datastore corruption on cluster-reset [(#5515)](https://github.com/k3s-io/k3s/pull/5515)
    * The embedded etcd has been bumped to v3.5.4-k3s1
    * Etcd is now shut down cleanly when performing a --cluster-reset 

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1236) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.4-k3s1](https://github.com/k3s-io/etcd/releases/tag/v3.5.4-k3s1) |
| Containerd | [v1.5.11-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.11-k3s2) |
| Runc | [v1.0.3](https://github.com/opencontainers/runc/releases/tag/v1.0.3) |
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
<!-- v1.23.5+k3s1 -->
This release updates Kubernetes to v1.23.5, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1234).

## Changes since v1.23.4+k3s1:

* Add partial support for IPv6 only mode [(#4450)](https://github.com/k3s-io/k3s/pull/4450)
* Integration tests: move to a global test lock [(#5155)](https://github.com/k3s-io/k3s/pull/5155)
* Fixed a bug that prevented users from using k3s secrets-encryption rotation after upgrading from older K3s versions. [(#5140)](https://github.com/k3s-io/k3s/pull/5140)
* Add ability to specify etcd snapshot list output format [(#5132)](https://github.com/k3s-io/k3s/pull/5132)
* Add `--json` flag for `k3s secrets-encrypt status` [(#5127)](https://github.com/k3s-io/k3s/pull/5127)
* Bump up github.com/containerd/stargz-snapshotter (v0.11.0) [(#5032)](https://github.com/k3s-io/k3s/pull/5032)
* Server nodes with only etcd/control-plane/etcd+control-plane roles can now be added to the cluster in any order, as long as the first node has the etcd role. [(#5143)](https://github.com/k3s-io/k3s/pull/5143)
* Add http/2 support to API server [(#5149)](https://github.com/k3s-io/k3s/pull/5149)
* E2E secrets encryption test [(#5144)](https://github.com/k3s-io/k3s/pull/5144)
* Any alarms present on the embedded etcd datastore are now reported and cleared at startup. This should allow for graceful recovery after exceeding and subsequently raising the etcd quota size. [(#5158)](https://github.com/k3s-io/k3s/pull/5158)
* When using the unsupported `--disable-agent` flag, kube-scheduler will now be started when a node is available. [(#5125)](https://github.com/k3s-io/k3s/pull/5125)
* E2E Add external DB options to ValidateCluster test [(#5157)](https://github.com/k3s-io/k3s/pull/5157)
* [master] changing package to k3s-io [(#4846)](https://github.com/k3s-io/k3s/pull/4846)
* The embedded containerd has been bumped to v1.5.10-k3s1 [(#5201)](https://github.com/k3s-io/k3s/pull/5201)
* The embedded ServiceLB LoadBalancer controller now supports mixed-protocol Services, and will clean up daemonsets when the Service type changes. [(#5205)](https://github.com/k3s-io/k3s/pull/5205)
* Flannel 0.17 [(#5215)](https://github.com/k3s-io/k3s/pull/5215)
* `k3s secrets-encrypt prepare` can now be used on control-plane only nodes [(#5222)](https://github.com/k3s-io/k3s/pull/5222)
* fix function arg call [(#5234)](https://github.com/k3s-io/k3s/pull/5234)
* Added ipv6 only support with flannel [(#5238)](https://github.com/k3s-io/k3s/pull/5238)
* Testing directory and documentation rework. [(#5256)](https://github.com/k3s-io/k3s/pull/5256)
* Fixed a regression present in 1.23 that prevented the embedded kubectl binary from parsing common CLI flags, such as `-v=0 to set verbosity` [(#5270)](https://github.com/k3s-io/k3s/pull/5270)
* The embedded Helm controller can now cease management of existing HelmChart releases, supports setting a failure policy for  install/update operations, and allows trusting custom CA certs for remote chart repositories. [(#5263)](https://github.com/k3s-io/k3s/pull/5263)
* E2E Split Server Test [(#5286)](https://github.com/k3s-io/k3s/pull/5286)
* Replace CentOS 8 with Rocky Linux 8 for install testing [(#5279)](https://github.com/k3s-io/k3s/pull/5279)
* Secondary etcd-only nodes will now successfully bootstrap containerd and the kubelet before a control-plane node has joined the cluster. [(#5300)](https://github.com/k3s-io/k3s/pull/5300)
* Refactor automation using terraform [(#5268)](https://github.com/k3s-io/k3s/pull/5268)
* Update Kubernetes to v1.23.5-k3s1 [(#5271)](https://github.com/k3s-io/k3s/pull/5271)
* The packaged coredns version has been bumped to v1.9.1 [(#5308)](https://github.com/k3s-io/k3s/pull/5308)
* Defragment etcd datastore before clearing alarms; don't delete temp etcd db while reconciling
 * The embedded etcd database is now defragmented on startup.
 * Fixed an issue that could cause restart of managed etcd nodes to occasionally fail while reconciling bootstrap data. [(#5336)](https://github.com/k3s-io/k3s/pull/5336)
* [master] Wrap containerd.New [(#5361)](https://github.com/k3s-io/k3s/pull/5361)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1235) |
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
This release updates Kubernetes to v1.23.4, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1233).

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the
 cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster d
oes not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since v1.23.3+k3s1:

* Updated to V1.23.4 k3s1 and updated traefik to v2.6.1 [(#5135)](https://github.com/k3s-io/k3s/pull/5135)
* Added `--server` flag to `k3s secrets-encrypt` subcommand to enable access non-local and non-default k3s servers. [(#5016)](https://github.com/k3s-io/k3s/pull/5016)
* Fixed to Drone CI Stability [(#4897)](https://github.com/k3s-io/k3s/pull/4897)
* Updated to flannel v0.16.2 [(#5035)](https://github.com/k3s-io/k3s/pull/5035)
* Signed CSRs for legacy-unknown with the server CA [(#5057)](https://github.com/k3s-io/k3s/pull/5057)
* K3s kubectl now no longer outputs a [WARN] log when using the `--kubeconfig` flag [(#5064)](https://github.com/k3s-io/k3s/pull/5064)
* Used kube-router as a library [(#5079)](https://github.com/k3s-io/k3s/pull/5079)
* Updated CentOS 8 smoke vm's with vault repositories [(#5092)](https://github.com/k3s-io/k3s/pull/5092)
* Fixed cluster validation and add upgrade cluster test [(#5020)](https://github.com/k3s-io/k3s/pull/5020)
* Removed all iptables rules when destroying k3s cluster [(#5059)](https://github.com/k3s-io/k3s/pull/5059)
* Added k3s etcd restoration test [(#5014)](https://github.com/k3s-io/k3s/pull/5014)
* Migrated Ginkgo testing framework to V2, consolidate integration tests [(#5097)](https://github.com/k3s-io/k3s/pull/5097)
* E2E Test Improvements [(#5102)](https://github.com/k3s-io/k3s/pull/5102)
* Fixed annoying netpol heartbeat missing log [(#5106)](https://github.com/k3s-io/k3s/pull/5106)
* Fixed a regression that prevented `--disable` from removing previously installed components. [(#5113)](https://github.com/k3s-io/k3s/pull/5113)

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1234) |
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
<!-- v1.23.3+k3s1 -->
This release updates Kubernetes to v1.23.3, and fixes a small number of issues. Upstream Kubernetes identified [an issue](https://github.com/kubernetes/kubernetes/issues/107690) with v1.23.x around custom resources. As such, v1.23.3 is being released sooner than expected. 


For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1232).

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#urgent-upgrade-notes).  

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since v1.23.2+k3s1:
* Update to v1.23.3 [(#5027)](https://github.com/k3s-io/k3s/pull/5027)
* Move containerd wait into exported function [(#5021)](https://github.com/k3s-io/k3s/pull/5021)
* Add Rocket.Chat to list of adopters [(#5017)](https://github.com/k3s-io/k3s/pull/5017)
<!-- https://github.com/k3s-io/k3s/compare/v1.23.2+k3s1...v1.23.3+k3s1 -->

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1233) |
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
<!-- v1.23.2+k3s1 -->
NOTE: Upstream Kubernetes has identified [an issue](https://github.com/kubernetes/kubernetes/issues/107690) with v1.23.x around custom resources. As such, v1.23.3 is being released sooner than expected. 

This release updates Kubernetes to v1.23.2, and fixes a number of issues.

For more details on what's new, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1231).

As this release includes a number of significant changes from previous versions, we will not make v1.23 available via the [stable release channel](https://rancher.com/docs/k3s/latest/en/upgrades/basic/#release-channels) until v1.23.2+k3s1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#urgent-upgrade-notes).  

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since v1.23.1+k3s2:
* Update to v1.23.2 [(#4997)](https://github.com/k3s-io/k3s/pull/4997)
* Enable debug logging on all k3s subcommands with debug flag [(#4921)](https://github.com/k3s-io/k3s/pull/4921)
* Adds the ability to compress etcd snapshots [(#4866)](https://github.com/k3s-io/k3s/pull/4866)
* Add IPv6 NAT [(#4952)](https://github.com/k3s-io/k3s/pull/4952)
* K3s servers no longer attempt to manage cgroup membership when the (unsupported, hidden) `--disable-agent` flag is used. [(#4923)](https://github.com/k3s-io/k3s/pull/4923)
* Bump etcd and containerd to track upstream [(#4871)](https://github.com/k3s-io/k3s/pull/4871)
  * Update etcd to v3.5.1-k3s1
  * Update containerd to v1.5.9-k3s1
* Remove ip6table rules when cleaning up k3s [(#4973)](https://github.com/k3s-io/k3s/pull/4973)
* Update metrics-server to 0.5.2 [(#4867)](https://github.com/k3s-io/k3s/pull/4867)
* Update packaged components [(#4963)](https://github.com/k3s-io/k3s/pull/4963)
  * Update local-path-provisioner to v0.0.21
  * Update local-path-provisioner busybox helper to 1.34.1
  * Update coredns to 1.8.6
  * Update traefik to 2.5.6
  * Update pause to 3.6
* Add new upgradecluster E2E test [(#4900)](https://github.com/k3s-io/k3s/pull/4900)
<!-- https://github.com/k3s-io/k3s/compare/v1.23.1+k3s2...v1.23.2+k3s1 -->

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1232) |
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
<!-- v1.23.1+k3s2 -->
This release fixes several issues, including an issue with the --agent-token flag that could prevent servers from joining managed etcd clusters when this flag was used.
<!--
This release is K3s's first in the v1.23 line. It updates Kubernetes to [v1.23.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1220)

As this release includes a number of significant changes from previous versions, we will not make v1.23 available via the [stable release channel](https://rancher.com/docs/k3s/latest/en/upgrades/basic/#release-channels) until v1.23.2+k3s1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#urgent-upgrade-notes).  
-->

## Known Issues: 
* There is [an issue](https://github.com/k3s-io/k3s/issues/4023) that may cause unexpected behavior when removing servers running embedded etcd from the cluster. When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.

## Changes since K3s v1.23.1+k3s1:
* Fixed an issue that prevented cluster-reset restore from working on some nodes in a multi-node etcd cluster. ([#4915](https://github.com/k3s-io/k3s/pull/4915))
* Update building documentation for macos ([#4850](https://github.com/k3s-io/k3s/pull/4850))
<!-- Fix handling of agent-token fallback to token ([#4889](https://github.com/k3s-io/k3s/pull/4889)) -->
* Fixed an issue that prevented joining additional servers when `--agent-token` is set. ([#4876](https://github.com/k3s-io/k3s/pull/4876))
* Fix a typo: advertise-up -> advertise-ip ([#4827](https://github.com/k3s-io/k3s/pull/4827))
* Integration tests utilities improvements ([#4832](https://github.com/k3s-io/k3s/pull/4832))
* Fix make generate to use dapper ([#4861](https://github.com/k3s-io/k3s/pull/4861))
* Fix small windows lint issues ([#4849](https://github.com/k3s-io/k3s/pull/4849))
* Update channel.yaml for 1.23 ([#4833](https://github.com/k3s-io/k3s/pull/4833))
* Export default parser ([#4826](https://github.com/k3s-io/k3s/pull/4826))
* Require integration test to be run as sudo/root ([#4824](https://github.com/k3s-io/k3s/pull/4824))
* Fix cgroup smoke test ([#4823](https://github.com/k3s-io/k3s/pull/4823))
<!-- https://github.com/k3s-io/k3s/compare/v1.23.1+k3s1...v1.23.1+k3s2 -->

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1231) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s2) |
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
<!-- v1.23.1+k3s1 -->
This release is K3s's first in the v1.23 line. It updates Kubernetes to [v1.23.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#changelog-since-v1220)

As this release includes a number of significant changes from previous versions, we will not make v1.23 available via the [stable release channel](https://rancher.com/docs/k3s/latest/en/upgrades/basic/#release-channels) until v1.23.2+k3s1 or later.

Before upgrading from earlier releases, be sure to read the Kubernetes [Urgent Upgrade Notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#urgent-upgrade-notes).  

## Known Issues: 
* [#4881](https://github.com/k3s-io/k3s/issues/4881): When using embedded etcd and the initial server is started with --agent-token, and this agent-only token does not match the server --token value, additional servers cannot join the cluster. This will be fixed in a subsequent release.
* [#4023](https://github.com/k3s-io/k3s/issues/4023): When removing servers with etcd from the cluster, ensure that the k3s service is stopped before using `kubectl delete` to remove the node from the Kubernetes and etcd cluster. You should do this one node at a time to ensure that your cluster does not lose quorum. Failure to follow this process may result in K3s on the deleted node crashing, restarting, and rejoining the cluster.
* [#4784](https://github.com/k3s-io/k3s/issues/4784): When creating a new cluster, etcd-only servers (if any) must be created before control-plane servers.

## Changes since K3s v1.22.2-rc2+k3s1 (when the **release-1.22** branch was forked from **master**)
* Update kubernetes to v1.23 ([#4623](https://github.com/k3s-io/k3s/pull/4623))
* Bump stable to v1.22.5+k3s1 ([#4821](https://github.com/k3s-io/k3s/pull/4821))
* Backout accidental package renaming ([#4817](https://github.com/k3s-io/k3s/pull/4817))
* Fix panic checking name of uninitialized etcd member ([#4813](https://github.com/k3s-io/k3s/pull/4813))
* Fix multiple ci issues blocking 1.23 release ([#4801](https://github.com/k3s-io/k3s/pull/4801))
* Update bootstrap logic to output all changed files on disk ([#4800](https://github.com/k3s-io/k3s/pull/4800))
* Remove the vendor directory ([#4791](https://github.com/k3s-io/k3s/pull/4791))
* Move flannel logs to logrus ([#4796](https://github.com/k3s-io/k3s/pull/4796))
* Close agentready channel only in k3s ([#4792](https://github.com/k3s-io/k3s/pull/4792))
* K3s no longer leaks etcd client grpc connections ([#4745](https://github.com/k3s-io/k3s/pull/4745))
* Remove disables, skips and disablekubeproxy from the comparing configs ([#4781](https://github.com/k3s-io/k3s/pull/4781))
* Add initial skeleton adopters.md to better track large use cases ([#4764](https://github.com/k3s-io/k3s/pull/4764))
* The embedded containerd binary is no longer part of the k3s multicall bundle. ([#4757](https://github.com/k3s-io/k3s/pull/4757))
* The embedded userspace binaries have been updated to k3s-root v0.10.1. ([#4758](https://github.com/k3s-io/k3s/pull/4758))
* Fix cold boot and reconcilation on secondary servers ([#4747](https://github.com/k3s-io/k3s/pull/4747))
* Docs: adrs: dual-stack in network policy agent ([#4729](https://github.com/k3s-io/k3s/pull/4729))
* Fix snapshot restoration on fresh nodes ([#4737](https://github.com/k3s-io/k3s/pull/4737))
* Resolve bootstrap migration edge case ([#4730](https://github.com/k3s-io/k3s/pull/4730))
* Add in docs/adr to ensure we capture decisions properly  ([#4707](https://github.com/k3s-io/k3s/pull/4707))
* Resolve issue preventing successful restore of etcd snapshot due to change in bootstrapping logic. ([#4704](https://github.com/k3s-io/k3s/pull/4704))
* Update wharfie usage in windows code path ([#4709](https://github.com/k3s-io/k3s/pull/4709))
* Add validation to certificate rotation ([#4692](https://github.com/k3s-io/k3s/pull/4692))
* Runc has been bumped to v1.0.3, resolving a hugetlb error message frequently seen on raspberry pi. ([#4693](https://github.com/k3s-io/k3s/pull/4693))
* Add `skip_airgap` enviroment variable for make ([#4688](https://github.com/k3s-io/k3s/pull/4688))
* Include node-external-ip in serving-kubelet.crt sans ([#4620](https://github.com/k3s-io/k3s/pull/4620))
* A cli subcommand to control secrets encryption. supports key rotation and enabled/disable of secrets encryption. ([#4372](https://github.com/k3s-io/k3s/pull/4372))
* Verify new control plane nodes joining the cluster share the same config as cluster members ([#4581](https://github.com/k3s-io/k3s/pull/4581))
* Bump wharfie to v0.5.1 ([#4575](https://github.com/k3s-io/k3s/pull/4575))
* K3s will now ensure that the write-ahead log for the embedded sqlite datastore does not grow excessively large. ([#4569](https://github.com/k3s-io/k3s/pull/4569))
* Update dynamiclistener to v0.3.1 ([#4568](https://github.com/k3s-io/k3s/pull/4568))
* Nighlty automation vagrant rework ([#4574](https://github.com/k3s-io/k3s/pull/4574))
* Bump stable to v1.21.7+k3s1 ([#4636](https://github.com/k3s-io/k3s/pull/4636))
* Add cert rotation command ([#4495](https://github.com/k3s-io/k3s/pull/4495))
* Update maintainers list ([#4622](https://github.com/k3s-io/k3s/pull/4622))
* Etcd snapshotting has been enhanced to provide better feedback ([#4453](https://github.com/k3s-io/k3s/pull/4453))
* Rancher will no longer suggest upgrading the traefik chart packaged with k3s. ([#4557](https://github.com/k3s-io/k3s/pull/4557))
* Improve flannel code and logging ([#4550](https://github.com/k3s-io/k3s/pull/4550))
* Bump golang to 1.16.10 and containerd to v1.5.8 ([#4538](https://github.com/k3s-io/k3s/pull/4538))
* Bump kubernetes to v1.22.4 ([#4536](https://github.com/k3s-io/k3s/pull/4536))
* Fix regression with cluster reset ([#4521](https://github.com/k3s-io/k3s/pull/4521))
* Fixed an issue where config.yaml arguments with an equal sign would be skipped by server. ([#4505](https://github.com/k3s-io/k3s/pull/4505))
* Unknown flags in config are now silently skipped by k3s server and etcd-snapshot ([#4491](https://github.com/k3s-io/k3s/pull/4491))
* Tests/vagrant: refactor vagrant smoke tests ([#4484](https://github.com/k3s-io/k3s/pull/4484))
* K3s now supports `--etcd-arg` to specify additional etcd arguments for running etcd ([#4463](https://github.com/k3s-io/k3s/pull/4463))
* Allow optional customizations to coredns via `coredns-custom` configmap ([#4397](https://github.com/k3s-io/k3s/pull/4397))
* Fix to allow etcd-snapshot to use config file with flags that are only used with k3s server. ([#4464](https://github.com/k3s-io/k3s/pull/4464))
* Increase agent's apiserver ready timeout ([#4454](https://github.com/k3s-io/k3s/pull/4454))
* Rancher will no longer suggest upgrading the traefik chart packaged with k3s. ([#4324](https://github.com/k3s-io/k3s/pull/4324))
* Allow svclb pod to enable ipv6 forwarding ([#4437](https://github.com/k3s-io/k3s/pull/4437))
* Update bootstrap logic ([#4438](https://github.com/k3s-io/k3s/pull/4438))
* Corrected skip check for dualstack on ci ([#4427](https://github.com/k3s-io/k3s/pull/4427))
* Improved microos support for k3s-uninstall.sh ([#4403](https://github.com/k3s-io/k3s/pull/4403))
* Values saved in "config.yaml" can now be used with the etcd-snapshot subcommands ([#4383](https://github.com/k3s-io/k3s/pull/4383))
* Replace gzip with pigz for faster builds ([#4411](https://github.com/k3s-io/k3s/pull/4411))
* Remove unit tests from drone ci ([#4424](https://github.com/k3s-io/k3s/pull/4424))
* Updating to new signals package in wrangler ([#4399](https://github.com/k3s-io/k3s/pull/4399))
* Install.sh: fix path detection for sle-micro ([#4398](https://github.com/k3s-io/k3s/pull/4398))
* Containerd: v1.5.7-k3s2 ([#4387](https://github.com/k3s-io/k3s/pull/4387))
* Bump klipper-lb image for arm fix ([#4385](https://github.com/k3s-io/k3s/pull/4385))
* Update k3s ci to run all integration tests ([#4358](https://github.com/k3s-io/k3s/pull/4358))
* Enable epics action to automatically check off child issues in an epic ([#4353](https://github.com/k3s-io/k3s/pull/4353))
* Refactor: use plain channel send or receive ([#4370](https://github.com/k3s-io/k3s/pull/4370))
* Fix log/reap reexec ([#4373](https://github.com/k3s-io/k3s/pull/4373))
* The btrfs snapshotter is now builtin to the k3s binary and ready for action ([#4316](https://github.com/k3s-io/k3s/pull/4316))
* Resolved an issue that would occasionally cause k3s to take more than a minute to schedule initial pods on the first server in a cluster. ([#4345](https://github.com/k3s-io/k3s/pull/4345))
* Initial support for sle micro with selinux via https://get.k3s.io ([#4331](https://github.com/k3s-io/k3s/pull/4331))
* Update to v1.22.3 ([#4354](https://github.com/k3s-io/k3s/pull/4354))
* K3s integration test fixes ([#4341](https://github.com/k3s-io/k3s/pull/4341))
* Update peer address when running cluster-reset ([#4307](https://github.com/k3s-io/k3s/pull/4307))
* Reset buffer back to beginning after use ([#4279](https://github.com/k3s-io/k3s/pull/4279))
* Bump klipper-helm version ([#4290](https://github.com/k3s-io/k3s/pull/4290))
* Values saved in "config.yaml" can now be used with the etcd-snapshot command ([#4280](https://github.com/k3s-io/k3s/pull/4280))
* Install.sh: capture quoted environment variables ([#4275](https://github.com/k3s-io/k3s/pull/4275))
* Update to the newest flannel (v0.15.1) ([#4258](https://github.com/k3s-io/k3s/pull/4258))
* K3s should now reliably exit when core kubernetes components (apiserver, controller-manager, etc) experience fatal errors. ([#4240](https://github.com/k3s-io/k3s/pull/4240))
* Set duration to second ([#4231](https://github.com/k3s-io/k3s/pull/4231))
* Add the ability to pass in a timeout value for s3 operations used with etcd snapshots. ([#4207](https://github.com/k3s-io/k3s/pull/4207))
* Copy old bootstrap buffer data for use during migration ([#4215](https://github.com/k3s-io/k3s/pull/4215))
* Fix race condition in cloud provider ([#4218](https://github.com/k3s-io/k3s/pull/4218))
* K3s now waits until etcd is actually able to start before joining a new members to the embedded etcd clusters. ([#4194](https://github.com/k3s-io/k3s/pull/4194))
* Maintainers: add manuel and michal ([#4193](https://github.com/k3s-io/k3s/pull/4193))
* Display cluster tls error only in debug mode ([#4124](https://github.com/k3s-io/k3s/pull/4124))
* Fixed an issue that caused k3s to not be restarted by systemd when started with the `--log` flag. ([#4190](https://github.com/k3s-io/k3s/pull/4190))
* Improve error message when using a "k10" prefixed token ([#4180](https://github.com/k3s-io/k3s/pull/4180))
* Add ability to reconcile bootstrap data between datastore and disk ([#3398](https://github.com/k3s-io/k3s/pull/3398))
* Move fossa out of dapper ([#4158](https://github.com/k3s-io/k3s/pull/4158))
* New aliases for k3s etcd-snapshot s3 commands to match the flags used with k3s server. ([#4161](https://github.com/k3s-io/k3s/pull/4161))
* Dual-stack support in servicelb controller ([#4114](https://github.com/k3s-io/k3s/pull/4114))
* Update stable to v1.21.5+k3s2 ([#4153](https://github.com/k3s-io/k3s/pull/4153))
* Add topologyspreadconstraints to support scaling of coredns ([#4133](https://github.com/k3s-io/k3s/pull/4133))
* The embedded containerd has been updated to v1.5.7+k3s1 to address cve-2021-41103 ([#4136](https://github.com/k3s-io/k3s/pull/4136))
* Fixed a regression introduced by #4086 that broke rootless support ([#4127](https://github.com/k3s-io/k3s/pull/4127))
* Skip tests that violate version skew policy ([#4122](https://github.com/k3s-io/k3s/pull/4122))
* The k3s systemd unit will no longer hang starting when the `--log` flag is used to redirect output ([#4115](https://github.com/k3s-io/k3s/pull/4115))
* The k3s docker image now works on cgroup v2 systems, and properly reaps terminated containerd shim processes. ([#4086](https://github.com/k3s-io/k3s/pull/4086))
* Set transport to skip verify if se skip flag passed ([#4102](https://github.com/k3s-io/k3s/pull/4102))
* Bump stable to v1.21.5+k3s1 ([#4068](https://github.com/k3s-io/k3s/pull/4068))
* Enable the inheritance of sysctl network settings for ipv6 ([#4098](https://github.com/k3s-io/k3s/pull/4098))
* Adding fossa anaylze/test drone step ([#4045](https://github.com/k3s-io/k3s/pull/4045))
* Rootless support now requires delegated cgroup v2 support. ([#4065](https://github.com/k3s-io/k3s/pull/4065))

## Embedded Component Versions
| Component | Version |
|---|---|
| Kubernetes | [v1.23.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#v1231) |
| Kine | [v0.8.1](https://github.com/k3s-io/kine/releases/tag/v0.8.1) |
| SQLite | [3.36.0](https://sqlite.org/releaselog/3_36_0.html) |
| Etcd | [v3.5.0-k3s2](https://github.com/k3s-io/etcd/releases/tag/v3.5.0-k3s2) |
| Containerd | [v1.5.8-k3s2](https://github.com/k3s-io/containerd/releases/tag/v1.5.8-k3s2) |
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
