| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.6.11](rancher-v2.6.md#release-v2611) | Mar 08 2023 | 03/08/23 | 2023-03-08 |
| [v2.6.10](rancher-v2.6.md#release-v2610) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v2.6.9](rancher-v2.6.md#release-v269) | Oct 18 2022 | 10/18/22 | 2022-10-18 |
| [v2.6.8](rancher-v2.6.md#release-v268) | Aug 30 2022 | 08/30/22 | 2022-08-30 |
| [v2.6.7](rancher-v2.6.md#release-v267) | Aug 19 2022 | 08/19/22 | 2022-08-19 |
| [v2.6.6](rancher-v2.6.md#release-v266) | Jun 30 2022 | 06/30/22 | 2022-06-30 |
| [v2.6.5](rancher-v2.6.md#release-v265) | May 12 2022 | 05/12/22 | 2022-05-12 |
| [v2.6.4](rancher-v2.6.md#release-v264) | Mar 31 2022 | 03/31/22 | 2022-03-31 |
| [v2.6.3-patch2](rancher-v2.6.md#release-v263-patch2) | Mar 16 2022 | 03/16/22 | 2022-03-16 |
| [v2.6.3-patch1](rancher-v2.6.md#release-v263-patch1) | Jan 28 2022 | 01/28/22 | 2022-01-28 |
| [v2.6.3](rancher-v2.6.md#release-v263) | Dec 21 2021 | 12/21/21 | 2021-12-21 |
| [v2.6.2](rancher-v2.6.md#release-v262) | Oct 20 2021 | 10/20/21 | 2021-10-20 |
| [v2.6.1](rancher-v2.6.md#release-v261) | Oct 11 2021 | 10/11/21 | 2021-10-11 |
| [v2.6.0](rancher-v2.6.md#release-v260) | Aug 31 2021 | 08/31/21 | 2021-08-31 |



# Release v2.6.11

# Features and Enhancements

### New in Rancher

- The `startupProbe` value along with its `failureThreshold` and `periodSeconds` sub-values are now exposed in the Rancher chart. They are off by default. Setting `startupProbe` value will use defaults for `failureThreshold` and `periodSeconds`, 1 and 30 respectively if they are not set. See [#38177](https://github.com/rancher/rancher/issues/38177).

# Major Bug Fixes

- Fixed an issue where high CPU usage is observed on RKE1 v1.24.x clusters. See [#40596](https://github.com/rancher/rancher/issues/40596).
- Fixed an issue in RKE1 clusters on Kubernetes v1.24 where cAdvisor `container` labels and metric series would break Monitoring V2 dashboards. See [#40601](https://github.com/rancher/rancher/issues/40601).
- Fixed an issue where provisioning new RKE1 clusters with a password-protected private registry may fail. See [#40457](https://github.com/rancher/rancher/issues/40457).
- Fixed an issue where downstream RKE2 clusters do not reach an `Active` state after performing a migration. See [#40300](https://github.com/rancher/rancher/issues/40300).
- Fixed an issue where encryption keys may fail to rotate when there are a large number of secrets. See [#40202](https://github.com/rancher/rancher/issues/40202).
- Fixed an issue where provisioning clusters with `--node-name` set to a value that doesn't match the default hostname assigned would fail with a `node not found` error. See [#37634](https://github.com/rancher/rancher/issues/37634).
- Fixed an issue where upgrading Monitoring from 100.1.3+up19.0.3 to 100.2.0+up40.1.2 results in alert webhooks failing to send. See [#40566](https://github.com/rancher/rancher/issues/40566).
- Fixed an issue where performing authentication with an LDAP server that uses a version of TLS lower than 1.2 would fail with an unsupported TLS protocol error on Rancher v2.6.9 or greater. See [#40671](https://github.com/rancher/rancher/issues/40671).
- Fixed an issue where groups were not being evaluated when determining a user's permission to Manage Cluster Members and Project Members. Users who do not want to upgrade their Rancher version can update the rancher-webhook version only by setting the environment variable `CATTLE_MIN_WEBHOOK_VERSION=v0.2.9` and then restarting the rancher-pods. See [#195](https://github.com/rancher/webhook/pull/195).
- Fixed a bug which caused new cache entries to be created if a user received new permissions (even if those new permissions did not allow the user to perform any new actions). This caused memory usage to steadily grow, particularly on events which created large amounts of new permissions (such as cluster provisioning). See [#40148](https://github.com/rancher/rancher/issues/40148).

# Rancher Behavior Changes

- Previously, using Project Monitoring V2 required setting `helmProjectOperator.helmController.enabled: false` since earlier versions of RKE2 and K3s's Helm Controller operated on a cluster-wide level and didn't respect the `managedBy` annotation. This annotation is now respected by recent versions of RKE2 and K3s, so the default Helm Controller can be turned back on. See [#39904](https://github.com/rancher/rancher/issues/39904) for affected versions.
- After upgrading Monitoring to 100.2.0+up40.1.2, alerts are not sent. This is the result of an upstream change to avoid collisions with AlertManagerConfig objects. See the [upstream PR](https://github.com/prometheus-operator/prometheus-operator/pull/4626) for details and [#40358](https://github.com/rancher/rancher/issues/40358#issuecomment-1426394330) for the configuration changes required to send alerts.
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40379](https://github.com/rancher/rancher/pull/40379).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. Rancher recommends admins to add Directory.Read.All permissions of type Application. If you configure a different set of permissions, Rancher may not be able to perform some of the actions within Azure AD, if the permissions are insufficient, so you may encounter errors. See [#38770](https://github.com/rancher/rancher/issues/38770).
- Fixed an issue for RKE1 clusters with the AWS cloud provider around `hostname-override`. Rancher now always sets `hostname-override` for kubelet to fix `node not found` issues for custom clusters. It is now also required to enable `useInstanceHostnameMetadata` in `cluster.yml` to set `hostname-override` from ec2 instance metadata for kube-proxy. Please review [RKE behavior changes](https://github.com/rancher/rancher/issues/37634#issuecomment-1458916717) for more details.

# Known Issues

- CIS scans on K3s clusters take a long time to complete. This issue is seen on nodes due to an OS issue/kernel bug that is corrupting the IP checksum on VXLAN packets when offload is enabled due to an upstream [Flannel bug](https://github.com/flannel-io/flannel/issues/1279). As a workaround, execute `sudo ethtool -K flannel.1 tx-checksum-ip-generic off` on all nodes before running the scan. See [#39839](https://github.com/rancher/rancher/issues/39839).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
  - When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Library and Helm3-Library Catalogs:**
  - Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **Local Cluster:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Upgrading the Rancher UI:**
  - After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet:**
  - For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
  - Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and Saving Clusters:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS Cluster:**
  - There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System Components:**
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **GKE and AKS Clusters:**
  - Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **Rolling Back Rancher:**
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC:**
  - Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs. Kube Nodes:**
  - In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook:**
  - In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Memory Limit for Legacy Monitoring:**
  - The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Memory Limit for Monitoring:**
  - The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Snapshot

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.11

### Tools
- CLI - [v2.6.11](https://github.com/rancher/cli/releases/tag/v2.6.11)
- RKE - [v1.3.19](https://github.com/rancher/rke/releases/tag/v1.3.19)

### Kubernetes Versions
- v1.24.10 (Default)
- v1.23.16
- v1.22.17
- v1.21.14
- v1.20.15

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	Used to enable the ability to provision RKE2 clusters. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Rancher Features

- RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.6/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring v1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - In v2.6.5, v1.21.x of RKE2 will remain experimental and [unsupported](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) for RKE2 Windows. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **K3s:**
    - The K3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1. This will be fixed in an upcoming release. See [#39284](https://github.com/rancher/rancher/issues/39284).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
  - **Oracle:**
    - Kubernetes 1.24 clusters fail to reach an `Active` state using Oracle Linux 8.4. See [#38214](https://github.com/rancher/rancher/issues/38214).
- **Harvester:**
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Istio 1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - Upon upgrade to Rancher v2.6.8, the UI consistently throws `Websocket Disconnected` errors. Note that alerts have been hidden behind a toggle by default so that systems remain usable. See [#6960](https://github.com/rancher/dashboard/issues/6960).
  - When navigating to the Continuous Delivery page from the Cluster Management page or Home page, the namespace filter is missing from the top-right corner. As a workaround, navigate to the Continuous Delivery page from the Cluster Explorer page to have access to the namespace filter. See [#7213](https://github.com/rancher/dashboard/issues/7213).
  - Kubernetes versions 1.24.x are incorrectly marked as “experimental” when provisioning AKS clusters (1.24.x versions are fully supported for AKS clusters). See [#7217](https://github.com/rancher/dashboard/issues/7217).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.6.10

**Rancher v2.6.10 is a security release to address the following issues:**

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> In Rancher v2.6.4, the cluster-api module has been upgraded from v0.4.4 to v1.0.2 in which the apiVersion of CAPI CRDs are upgraded from `cluster.x-k8s.io/v1alpha4` to `cluster.x-k8s.io/v1beta1`. This has the effect of causing rollbacks from Rancher v2.6.4 to any previous version of Rancher v2.6.x to fail because the previous version the CRDs needed to roll back are no longer available in v1beta1. To avoid this, the Rancher resource cleanup script should be run **before** the restore or rollback is attempted. This script can be found in the [rancherlabs/support-tools repo](https://github.com/rancherlabs/support-tools/tree/master/rancher-cleanup) and the usage of the script can be found in [the backup-restore operator docs](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/). In addition, when users roll back Rancher on the same cluster using the Rancher Backup and Restore app in 2.6.4+, the [updated steps to create the Restore Custom Resource](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/#create-the-restore-custom-resource) must be followed. See also [#36803](https://github.com/rancher/rancher/issues/36803) for more details.

# Security Fixes for Rancher Vulnerabilities

This release addresses **05 security issues** found in Rancher:

- Improved authorization logic checks around project role template binding (PRTB) and `-promoted` roles to protect against possible privilege escalation. For more information, see [CVE-2022-43759](https://github.com/rancher/rancher/security/advisories/GHSA-7m72-mh5r-6j3r).

- Fixed an issue in Rancher's Git package that could potentially lead to command injection. For more information, see [CVE-2022-43758](https://github.com/rancher/rancher/security/advisories/GHSA-34p5-jp77-fcrc).

- Fixed an issue where sensitive fields and credentials like secret tokens, encryption keys, and SSH keys were stored as plaintext on Kubernetes objects. This is a follow-up security fix to address the fields missed in [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f). For more information, see [CVE-2022-43757](https://github.com/rancher/rancher/security/advisories/GHSA-cq4p-vp5q-4522).

- Improved the generation process of Rancher's `cattle-token` to make the token random. Before, `cattle-token` did not use any random value in its composition, which caused the token to be always predictable. For more information, see [CVE-2022-43755](https://github.com/rancher/rancher/security/advisories/GHSA-8c69-r38j-rpfj).

- Fixed an authorization logic flaw that allowed an authenticated user on any downstream cluster to (1) open a shell pod in the Rancher local cluster and (2) have limited kubectl access to the local cluster. For more information, see [CVE-2022-21953](https://github.com/rancher/rancher/security/advisories/GHSA-g25r-gvq3-wrq7).

Additionally, the following security related updates were performed in this release to address security issues:

- Fixed a validation check issue where Rancher generated tokens are not revoked after modifications are made to a configured authentication provider. This issue is only applicable if external authentication providers were configured in Rancher. For more information, see security advisory [GHSA-c45c-39f6-6gw9](https://github.com/rancher/rancher/security/advisories/GHSA-c45c-39f6-6gw9).

- Updated the version of Rancher's Fleet chart to `100.2.0+up0.5.1` to address two security issues in [`rancher/wrangler`](https://github.com/rancher/wrangler) dependency:

  - The high severity [CVE-2022-31249](https://github.com/rancher/wrangler/security/advisories/GHSA-qrg7-hfx7-95c5) that could lead to a command injection vulnerability in Rancher's Continuous Delivery feature through Fleet's GitJob pod.

  - The medium severity [CVE-2022-43756](https://github.com/rancher/wrangler/security/advisories/GHSA-8fcj-gf77-47mg) that could cause a denial of service (DoS) attack in Fleet's GitJob pod.

- Updated the version of [`crewjam/saml`](https://github.com/crewjam/saml) SAML library to address the critical severity [CVE-2022-41912](https://github.com/crewjam/saml/security/advisories/GHSA-j2jp-wvqg-wc2g).

- Updated the base image version of Rancher `rancher/rancher` and Rancher Agent `rancher/rancher-agent` images from SUSE's SLE BCI Base 15 SP3 to 15 SP4 [`registry.suse.com/bci/bci-base:15.4`](https://registry.suse.com/bci/bci-base-15sp4/index.html) due to 15 SP3 reaching its end-of-life (EOL).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

# Major Bug Fixes

- Fixed issue where handlers would infinitely loop if a user had no tokens, or the user only had tokens that did not have their ExtraByProvider field set. See [#39401](https://github.com/rancher/rancher/issues/39401).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **TLS:**
  - Beginning with Rancher 2.6.9, Rancher was built using go version 1.19. As part of this upgrade, Rancher's clients will only communicate with servers running tls version 1.2 or higher. This includes auth servers like ldap. We plan on introducing a future version of the 2.6 release line which allows ldap servers using tls versions 1.0 to communicate with rancher.
- **Authentication:**
  - For Azure AD, Rancher now doesn't create or update the cached secret with the Azure AD access token if a new token does not have the necessary permissions. Rancher also prevents admins from updating the endpoints for Microsoft Graph if a new token lacks permissions. Note that these behaviors will be changed in the future as part of [#38770](https://github.com/rancher/rancher/issues/38770). See [#38754](https://github.com/rancher/rancher/issues/38754).
- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
  - When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Library and Helm3-Library Catalogs:**
  - Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **Local Cluster:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Upgrading the Rancher UI:**
  - After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet:**
  - For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
  - Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and Saving Clusters:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS Cluster:**
  - There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System Components:**
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **GKE and AKS Clusters:**
  - Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **Rolling Back Rancher:**
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC:**
  - Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs. Kube Nodes:**
  - In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook:**
  - In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Memory Limit for Legacy Monitoring:**
  - The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Memory Limit for Monitoring:**
  - The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Snapshot

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.10

### Tools
- CLI - [v2.6.9](https://github.com/rancher/cli/releases/tag/v2.6.9)
- RKE - [v1.3.18](https://github.com/rancher/rke/releases/tag/v1.3.18)

### Kubernetes Versions
- v1.24.9 (Default)
- v1.23.15
- v1.22.17
- v1.21.14
- v1.20.15

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	Used to enable the ability to provision RKE2 clusters. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Rancher Features

- RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.6/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring v1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Provisioning new RKE1 clusters with a password-protected private registry may fail. See [#40321](https://github.com/rancher/rancher/issues/40321#issuecomment-1407095199) for a workaround and more information on the issue.
    - In RKE1 clusters on Kubernetes v1.24, cadvisor `container` labels and metric series break Monitoring V2 dashboards. See [#38934](https://github.com/rancher/rancher/issues/38934#issuecomment-1294585708) for a workaround and more details on the issue.
    - High CPU usage is observed on RKE1 v1.24.x clusters. Cluster could be a fresh installation or upgraded to v1.24.x. See [#38816]( https://github.com/rancher/rancher/issues/38816).
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - Encryption keys may fail to rotate when there are a large number (> 2000) of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - In v2.6.5, v1.21.x of RKE2 will remain experimental and [unsupported](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) for RKE2 Windows. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **K3s:**
    - The K3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1. This will be fixed in an upcoming release. See [#39284](https://github.com/rancher/rancher/issues/39284).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
  - **Oracle:**
    - Kubernetes 1.24 clusters fail to reach an `Active` state using Oracle Linux 8.4. See [#38214](https://github.com/rancher/rancher/issues/38214).
- **Harvester:**
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Istio 1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - Upon upgrade to Rancher v2.6.8, the UI consistently throws `Websocket Disconnected` errors. Note that alerts have been hidden behind a toggle by default so that systems remain usable. See [#6960](https://github.com/rancher/dashboard/issues/6960).
  - When navigating to the Continuous Delivery page from the Cluster Management page or Home page, the namespace filter is missing from the top-right corner. As a workaround, navigate to the Continuous Delivery page from the Cluster Explorer page to have access to the namespace filter. See [#7213](https://github.com/rancher/dashboard/issues/7213).
  - Kubernetes versions 1.24.x are incorrectly marked as “experimental” when provisioning AKS clusters (1.24.x versions are fully supported for AKS clusters). See [#7217](https://github.com/rancher/dashboard/issues/7217).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.6.9

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> In Rancher v2.6.4, the cluster-api module has been upgraded from v0.4.4 to v1.0.2 in which the apiVersion of CAPI CRDs are upgraded from `cluster.x-k8s.io/v1alpha4` to `cluster.x-k8s.io/v1beta1`. This has the effect of causing rollbacks from Rancher v2.6.4 to any previous version of Rancher v2.6.x to fail because the previous version the CRDs needed to roll back are no longer available in v1beta1. To avoid this, the Rancher resource cleanup script should be run **before** the restore or rollback is attempted. This script can be found in the [rancherlabs/support-tools repo](https://github.com/rancherlabs/support-tools/tree/master/rancher-cleanup) and the usage of the script can be found in [the backup-restore operator docs](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/). In addition, when users roll back Rancher on the same cluster using the Rancher Backup and Restore app in 2.6.4+, the [updated steps to create the Restore Custom Resource](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/#create-the-restore-custom-resource) must be followed. See also [#36803](https://github.com/rancher/rancher/issues/36803) for more details.

# Major Bug Fixes

- Fixed an issue which caused version 1.0.0 of the CSP Adapter to incorrectly count nodes. Users should only use version 1.0.1 or higher of the adapter to ensure that node counts are accurate. See [#38712](https://github.com/rancher/rancher/issues/38712).
- Fixed an issue where role templates with circular references (e.g., role template 1 inherits role template 2 which inherits role template 1) could result in high CPU usage and crashes. Requests to create new role templates with such a structure (or edit existing role templates to have such a structure) should not fail, and Rancher should no longer have excessively high CPU cycles when attempting to process such existing roles. Note that this will not remove existing custom roles which have circular references; therefore, it is recommended that users review existing role templates to ensure that they do not have circular references (such role templates will not function as desired). See [#38419](https://github.com/rancher/rancher/issues/38419).
- Fixed an issue in which user attributes were not being refreshed correctly and sometimes became empty which caused impersonation rules to be incorrect. See [#36096](https://github.com/rancher/rancher/issues/36096).
- Fixed an issue where user-defined EKS security groups were configured as the only node group security groups rather than being appended to the cluster default security group. See [#38014](https://github.com/rancher/rancher/issues/38014).
- Fixed issue in which OPA Gatekeeper became stuck when uninstalled. See [#37029](https://github.com/rancher/rancher/issues/37029).
- Users running RHEL/CentOS 7 may install or upgrade using K3s/RKE2 v1.24.4 and up. See [#5912](https://github.com/k3s-io/k3s/issues/5912).
- RKE v1.3.10-v1.3.13 in Rancher v2.6.7-v2.6.8 no longer removes user addons during an upgrade before redeploying them, which would cause issues with RKE1 cluster upgrades if user addons template has `cattle-*` or other system namespaces. See [#38876](https://github.com/rancher/rancher/issues/38876).
- Fixed an issue in which after installing any chart through the Rancher UI, the `proxy` container of the `helm-operation` pod was not terminated, and it would become `NotReady`. See [#38873](https://github.com/rancher/rancher/issues/38873).
- Resolved an issue in which Kubernetes API events were not recorded when the log level was set to 3. See [#38323](https://github.com/rancher/rancher/issues/38323).
- Admins can now reconfigure (edit) a new Azure AD setup as well as a setup with updated endpoints for the Microsoft Graph without errors. See [#38753](https://github.com/rancher/rancher/issues/38753).
- A bug has been fixed that resulted in certain clusters being rendered unavailable after upgrade. This was due to improper migration of certain cluster fields to secrets. The known cluster types this affected were legacy AKS, GKE, and EKS clusters but may have affected other types of clusters as well. See [#38699](https://github.com/rancher/rancher/issues/38699).
- RKE2 and K3s custom clusters now provision as expected when using a proxy. See [#39068](https://github.com/rancher/rancher/issues/39068).
- Fixed an issue in which the Rancher UI produced the wrong CLI command when joining a node to a cluster with a taint in AWS. See [#6827](https://github.com/rancher/dashboard/issues/6827).
- In the Rancher UI, yellow icons have been added to indicate which clusters need to be updated. See [#6580](https://github.com/rancher/dashboard/issues/6580).

# Rancher Behavior Changes

- For Azure AD, Rancher now doesn't create or update the cached secret with the Azure AD access token if a new token does not have the necessary permissions. Rancher also prevents admins from updating the endpoints for Microsoft Graph if a new token lacks permissions. Note that this will be removed in v2.6.10 in favor of a different approach of handling token permissions. See [#38754](https://github.com/rancher/rancher/issues/38754).
- Beginning with Rancher 2.6.9, Rancher was built using go version 1.19. As part of this upgrade, Rancher's clients will only communicate with servers running tls version 1.2 or higher. This includes auth servers like ldap. We plan on introducing a future version of the 2.6 release line which allows ldap servers using tls versions 1.0 to communicate with rancher.

# Known Issues

### Rancher UI

- Upon upgrade to Rancher v2.6.8, the UI consistently throws `Websocket Disconnected` errors. Note that alerts have been hidden behind a toggle by default so that systems remain usable. See [#6960](https://github.com/rancher/dashboard/issues/6960).
- When navigating to the Continuous Delivery page from the Cluster Management page or Home page, the namespace filter is missing from the top-right corner. As a workaround, navigate to the Continuous Delivery page from the Cluster Explorer page to have access to the namespace filter. See [#7213](https://github.com/rancher/dashboard/issues/7213).
- Kubernetes versions 1.24.x are incorrectly marked as “experimental” when provisioning AKS clusters (1.24.x versions are fully supported for AKS clusters). See [#7217](https://github.com/rancher/dashboard/issues/7217).

### Harvester

- When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).

### K3s

- The K3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1. This will be fixed in an upcoming release. See [#39284](https://github.com/rancher/rancher/issues/39284).

### RKE 

- High CPU usage is observed on RKE1 v1.24.x clusters. Cluster could be a fresh installation or upgraded to v1.24.x. See [#38816]( https://github.com/rancher/rancher/issues/38816).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
  - When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Library and Helm3-Library Catalogs:**
  - Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **Local Cluster:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Upgrading the Rancher UI:**
  - After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet:**
  - For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
  - Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and Saving Clusters:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS Cluster:**
  - There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System Components:**
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **GKE and AKS Clusters:**
  - Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **Rolling Back Rancher:**
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC:**
  - Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs. Kube Nodes:**
  - In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook:**
  - In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Memory Limit for Legacy Monitoring:**
  - The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Memory Limit for Monitoring:**
  - The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Snapshot

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.9

### Tools
- CLI - [v2.6.9](https://github.com/rancher/cli/releases/tag/v2.6.9)
- RKE - [v1.3.15](https://github.com/rancher/rke/releases/tag/v1.3.15)

### Kubernetes Versions
- v1.24.4 (Default)
- v1.23.10
- v1.22.13
- v1.21.14
- v1.20.15

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	Used to enable the ability to provision RKE2 clusters. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Rancher Features

- RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.6/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring v1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - Encryption keys may fail to rotate when there are a large number (> 2000) of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - In v2.6.5, v1.21.x of RKE2 will remain experimental and [unsupported](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) for RKE2 Windows. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
  - **Oracle:**
    - Kubernetes 1.24 clusters fail to reach an `Active` state using Oracle Linux 8.4. See [#38214](https://github.com/rancher/rancher/issues/38214).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Istio 1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).

-----
# Release v2.6.8

**Rancher v2.6.8 is a mirror release of [v2.6.7](https://github.com/rancher/rancher/releases/tag/v2.6.7) to address the following issues:**

#### Major Bug Fixes

- Fleet bundle pruning was too aggressive when GitJobs had multiple paths. This situation can lead to data loss. Note that this data loss only affects applications deployed through Fleet, including Longhorn. This has been fixed. Update to v2.6.8 or later to prevent potential data loss. See [#933](https://github.com/rancher/fleet/pull/933) for more details on the fix.
- Fixed an issue in which custom branding, color, and theme in Rancher Manager v2.6.7 was not correctly applied in the UI. See [#6704](https://github.com/rancher/dashboard/issues/6704) for more details.

#### Known Issue in RKE

- RKE v1.3.10-v1.3.13 in Rancher v2.6.7-v2.6.8 removes user addons during an upgrade before redeploying them. This causes issues with RKE1 cluster upgrades if user addons template has `cattle-*` or other system namespaces. See [#38749](https://github.com/rancher/rancher/issues/38749) for more details.
- High CPU usage is observed on RKE1 v1.24.x clusters. Cluster could be a fresh installation or upgraded to v1.24.x. See [#38816]( https://github.com/rancher/rancher/issues/38816).

#### Known Issue in GKE

- Provisioning K8s 1.23+ GKE clusters with the default option of "Container-Optimized OS with Docker" for "Image Type" fails due to GKE no longer supporting Docker-based images per [GKE documentation](https://cloud.google.com/kubernetes-engine/docs/deprecations/docker-containerd#timeline_and_milestones). Please use containerd-based images instead. See [#38743](https://github.com/rancher/rancher/issues/38743).


<br/>

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> In Rancher v2.6.4, the cluster-api module has been upgraded from v0.4.4 to v1.0.2 in which the apiVersion of CAPI CRDs are upgraded from `cluster.x-k8s.io/v1alpha4` to `cluster.x-k8s.io/v1beta1`. This has the effect of causing rollbacks from Rancher v2.6.4 to any previous version of Rancher v2.6.x to fail because the previous version the CRDs needed to roll back are no longer available in v1beta1. To avoid this, the Rancher resource cleanup script should be run **before** the restore or rollback is attempted. This script can be found in the [rancherlabs/support-tools repo](https://github.com/rancherlabs/support-tools/tree/master/rancher-cleanup) and the usage of the script can be found in [the backup-restore operator docs](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/). In addition, when users roll back Rancher on the same cluster using the Rancher Backup and Restore app in 2.6.4+, the [updated steps to create the Restore Custom Resource](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/#create-the-restore-custom-resource) must be followed. See also [#36803](https://github.com/rancher/rancher/issues/36803) for more details.

# Security Fixes for Rancher Vulnerabilities

This release addresses three **critical severity** security issues found in Rancher:

- Fixed an issue where sensitive fields like passwords, API keys, and Rancher's service account token were stored as plaintext on Kubernetes objects. Any user with read access to those objects in the Kubernetes API could retrieve the plaintext version of those sensitive data. For more information, see [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f).

- Improved the sanitization (removal) of credentials from cluster template answers. Failure to sanitize data can lead to plaintext storage and exposure of credentials, passwords, and API tokens. For more information, see [CVE-2021-36783](https://github.com/rancher/rancher/security/advisories/GHSA-8w87-58w6-hfv8).

- Fixed an authorization logic flaw that allowed privilege escalation in downstream clusters through cluster role template binding (CRTB) and project role template binding (PRTB). For more information, see [CVE-2022-31247](https://github.com/rancher/rancher/security/advisories/GHSA-6x34-89p7-95wg).

For more details, see the [Security Advisories page](https://github.com/rancher/rancher/security/advisories).

# Features and Enhancements

### Azure Active Directory API Migration

Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.6/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

- **Limitations**
  - Attempts to log in will fail after rolling back a Docker install of Rancher if the following conditions have occurred:
    - Azure AD is enabled.
    - Before the rollback, admins committed to the Azure AD configuration update.

    This is because the Azure AD endpoints will not be rolled back if the rollback is not performed via the backup-restore operator. If you want to roll back Rancher to use the old Azure AD Graph API without using the backup-restore operator, follow this [workaround](https://github.com/rancher/rancher/issues/38025#issuecomment-1213208087) to edit the AzureAD authconfig resource stored in the local cluster's database. The old Azure AD Graph API endpoints will not be rolled back on a Rancher rollback. See [#38025](https://github.com/rancher/rancher/issues/38025).
- **Other**
  - Multi-factor authentication (MFA) now works with the Azure AD auth provider. Some Rancher setups might have had MFA enabled in Azure from before, but Rancher wasn't working with it correctly. Be aware that on upgrade, if MFA is enabled for the Azure app, Rancher will require additional verification. See [#38028](https://github.com/rancher/rancher/pull/38028).
  - Before starting the migration process or enabling Azure AD for the first time in v2.6.7+, ensure that you add the Azure app registration's permissions of type **Application** and **NOT Delegated** for Microsoft Graph. Otherwise, you may not be able to login to Azure AD. This issue will persist even after you disable/re-enable Azure AD and will require an hour wait, or manual deletion of a cache value to resolve.

### Integration with Cloud Marketplaces

Rancher v2.6.7 introduces an integration allowing users to easily purchase support through the AWS marketplace for installation hosted on AWS/EKS. You must be running Rancher v2.6.7 or higher and have set up Rancher and it's local cluster according to the [prerequisites](https://rancher.com/docs/rancher/v2.6/en/installation/cloud-marketplace/aws/prerequisites).

For details about the integration, refer to the [Rancher documentation](https://rancher.com/docs/rancher/v2.6/en/installation/cloud-marketplace/aws/) and [#37495](https://github.com/rancher/rancher/issues/37495).

Note: If users are using the csp-adapter and the [rancher backup-restore operator](https://github.com/rancher/backup-restore-operator), they will need to upgrade the backup-restore operator to the latest version (v2.1.3) in order to ensure that the applications work together.

### New in Rancher

- Support for Kubernetes v1.24 added.
- Support has ended for Kubernetes v1.18 and v1.19.
- Increased entropy of CSRF (cross-site request forgery) token. See [#14](https://github.com/rancher/apiserver/pull/14) and [#414](https://github.com/rancher/norman/pull/414)
- Starting in v2.6.0, whenever a user requests a kubeconfig file, Rancher creates a newly-generated token instead of retrieving the old one. The token TTL is not configurable on these tokens, causing token cleanup to be a manual process. We've now added a new setting to allow users to change the TTL on kubeconfig tokens called `kubeconfig-default-token-TTL-minutes`. This setting has a default value of 0 to retain default behavior between Rancher versions. Rancher recommends that admins change this setting from its default to prevent unbound token creation. Note that this setting only applies to tokens generated for kubeconfigs when `kubeconfig-generate-tokens` is true, which is the default. When `kubeconfig-generate-tokens` is false, `kubeconfig-token-ttl-minutes` will be used for token TTL. This behavior is the same as previous versions of Rancher. The `kubeconfig-token-ttl-minutes` setting is now deprecated in favor of using `kubeconfig-default-token-TTL-minutes` in the future. See [#37705](https://github.com/rancher/rancher/issues/37705).
- The Rancher chart now exposes the `ingress.ingressClassName` value, which allows setting the name of the ingress controller to be used with Rancher's Ingress resource. This is relevant for Rancher clusters created with a provider other than RKE, since RKE automatically sets nginx as the ingress class name. By default, the value is an empty string because Rancher does not make assumptions about the type of ingress controller that runs in Rancher (nginx, Traefik, etc.). See [#37971](https://github.com/rancher/rancher/issues/37971).
- **Behavior Changes**
  - The Kubernetes team has observed an increase in memory usage with Kubernetes v1.24. See [the upstream changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.24.md#feature-1) for details.
  - All Kubernetes 1.24 clusters will have cri-dockerd enabled by default which includes new and upgraded clusters. Users can apply the `io.cattle.cluster.cridockerd.enable` annotation on a cluster, and the annotation will override the default behavior. If the annotation is set to false and `enable_cri_dockerd` is set to true, the annotation will override the field/flag behavior and `enable_cri_dockerd` will be updated to false. Clusters will not provision correctly if cri-dockerd is disabled; this is expected unless a proper Docker runtime is provided. See [#38160](https://github.com/rancher/rancher/issues/38160).

### New in RKE1

- Resolved an issue for RKE clusters that prevented specifying more than one private registry in the YAML configuration. See [#37658](https://github.com/rancher/rancher/issues/37658).
- **Windows**
  - **Important**: RKE1 Support for Windows will stop on September 1st 2022 due to upstream changes. See [this article](https://www.suse.com/support/kb/doc/?id=000020684&mkt_tok=OTM3LURDSC0yNjEAAAGFmb5AA1pbloC-PZ0mHbB9sQ3Lwqcq1iax_88DXONtcnsgG5veDwnoueEmqqNdyuAdyVjjWi582ug_dSvYQto) for more details.
  - A warning message has been added to inform users that Windows support is being deprecated for RKE1. See [#5995](https://github.com/rancher/dashboard/issues/5995).

### New in RKE2

- New encryption key rotation feature added. See [the docs](https://rancher.com/docs/rancher/v2.6/en/cluster-admin/encryption-key-rotation/) and [#35436](https://github.com/rancher/rancher/issues/35436).
- **Windows**
  - HostProcess containers are now supported in Kubernetes v1.24.1 and up. See [#69](https://github.com/rancher/windows/issues/69).
- **Behavior Changes**
  - After an upgrade to Rancher v2.6.7, RKE2 provisioned clusters will briefly go into an `Updating` state with the message `waiting for plan to be applied`. This behavior is expected and has no adverse effects. See [#38353](https://github.com/rancher/rancher/issues/38353).
- **Known Issues**
  - Encryption keys may fail to rotate when there are a large number (> 2000) of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
  - Users running RHEL/CentOS 7 should not install or upgrade to K3s/RKE2 v1.24.2 or v1.24.3 but should instead wait for K3s/RKE2 v1.24.4 to do so. See [#5912](https://github.com/k3s-io/k3s/issues/5912).
  - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [38646](https://github.com/rancher/rancher/issues/38646).
  
### New in the Rancher UI

- Removed monitoring dashboard "Rancher Internal State (Controllers)". Most functionality from this dashboard has been replaced and can be found in the dashboard "Rancher Performance Debugging". See [#37274](https://github.com/rancher/rancher/issues/37274).
- `ProjectHelmCharts` has been added as a selectable resource from the `helm.cattle.io` API group when creating a new project/namespace role. See [#5747](https://github.com/rancher/dashboard/issues/5747).
- Added a Diagnostics page to allow users to gather data from their systems to append to any issues filed for Rancher. The Diagnostics page is accessible via the About page. See [#6544](https://github.com/rancher/dashboard/issues/6544).
- The Deployment creation screen has been improved and a new Pod creation view has been added. See [#5734](https://github.com/rancher/dashboard/issues/5734).
- When viewing the details of a GitRepo through Fleet, users can now get a graphical representation of the bundle deployments that came from that GitRepo. See [#4680](https://github.com/rancher/dashboard/issues/4680).
- **Behavior Changes**
  - Project owners and project members will no longer be able to see namespaces outside of the project(s) they have access to. This is to prevent a bad user experience, where some users could see namespaces that they could not use.
  - Project owners and project members will now be required to delete namespaces within a project when deleting the project. This is to prevent a situation where they would essentially be creating orphaned namespaces, which they would lose access to when they delete the project.

# Major Bug Fixes

- User Preferences set by a drop-down component will now be applied correctly. Previously, updating a user preference in this manner would cause adverse effects such as the inability to view logs or the setting not taking effect. See [#5984](https://github.com/rancher/dashboard/issues/5984).
- Prior to `v2.6.7`, if S3 or other kinds of credentials were added to a cluster after it was already created, the reference to the secret containing the credentials was lost because the cluster status cannot be updated through the API. The references are now moved to the cluster Spec so that they can be updated after creation. To repair a cluster after a upgrade to `v2.6.7`, edit the cluster and change the etcd snapshot configuration back to local and save it, then edit again to configure S3 snapshots again. See [#38215](https://github.com/rancher/rancher/issues/38215).
- Certificates with a CN exceeding 64 characters will not cause an error. See [#37766](https://github.com/rancher/rancher/issues/37766).
- If the creation of the impersonation ClusterRoleBinding is interfered with or interrupted, users can now access the downstream cluster without experiencing unauthorized errors. See [#37733](https://github.com/rancher/rancher/issues/37733).
- Resolved an issue where users that existed since Rancher v2.6.2 or earlier may start experiencing authorization errors upon upgrade to Rancher v2.6.5 when using kubectl with a downloaded kubeconfig for a downstream cluster. See [#37894](https://github.com/rancher/rancher/issues/37894).
- Users with the role 'Cluster Owners' who are not also 'Admins' are now able to manage snapshots on RKE2 clusters. See [#37630](https://github.com/rancher/rancher/issues/37630).
- A bug was found that overloaded the downstream Kubernetes API server when the Cluster Explorer dashboard is left open to a page for a downstream cluster for over 30 minutes and would start rapidly opening and closing watch requests perpetually. See [#37627](https://github.com/rancher/rancher/issues/37627).
- Rancher server now generates a new token every time a kubeconfig is requested via the CLI. This token is then cached by the CLI on the local system and will not cause previously created tokens to become invalid. See [#37245](https://github.com/rancher/rancher/issues/37245).
- Windows installation scripts are now successfully retrieved in proxied RKE2 downstream clusters. See [#36574](https://github.com/rancher/rancher/issues/36574).
- The `istiod-istio-system` ValidatingWebhookConfiguration has been removed to allow Istio 1.11.x and higher to be installed in air-gapped environments. See [#35742](https://github.com/rancher/rancher/issues/35742).
- Most API responses now set response headers to include `Cache-Control: no-store` which directs intermediate caches not to cache the response. Previously, some intermediate caches between the Rancher server and clients, including cluster agents, were configured to cache responses for the purpose of scalability and improved response time. In some cases this led to stale data getting inadvertently cached which would disrupt deployment of downstream clusters. See [#35199](https://github.com/rancher/rancher/issues/35199).
- Project resource quotas are now correctly removed when deleted through the UI. See [#35688](https://github.com/rancher/rancher/issues/35688).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
  - When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Library and Helm3-Library Catalogs:**
  - Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **Local Cluster:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Upgrading the Rancher UI:**
  - After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet:**
  - For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
  - Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and Saving Clusters:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS Cluster:**
  - There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System Components:**
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **GKE and AKS Clusters:**
  - Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **Rolling Back Rancher:**
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC:**
  - Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs. Kube Nodes:**
  - In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook:**
  - In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Memory Limit for Legacy Monitoring:**
  - The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Memory Limit for Monitoring:**
  - The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Snapshot

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.8

### Tools
- CLI - [v2.6.7](https://github.com/rancher/cli/releases/tag/v2.6.7)
- RKE - [v1.3.13](https://github.com/rancher/rke/releases/tag/v1.3.13)

### Kubernetes Versions
- v1.24.2 (Default)
- v1.23.8
- v1.22.11
- v1.21.14
- v1.20.15

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	Used to enable the ability to provision RKE2 clusters. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

- RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring v1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE1 - Windows:**
    - OPA Gatekeeper gets stuck when uninstalled. See [#37029](https://github.com/rancher/rancher/issues/37029).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - OPA Gatekeeper gets stuck when uninstalled. See [#37029](https://github.com/rancher/rancher/issues/37029).
    - In v2.6.5, v1.21.x of RKE2 will remain experimental and [unsupported](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) for RKE2 Windows. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
  - **Oracle:**
    - Kubernetes 1.24 clusters fail to reach an `Active` state using Oracle Linux 8.4. See [#38214](https://github.com/rancher/rancher/issues/38214).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Istio 1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.6.7

**WARNING: Version 2.6.7 introduced a bug that can cause data loss. If you are running v2.6.7, it is highly recommended to update to v2.6.8 or later.**

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> In Rancher v2.6.4, the cluster-api module has been upgraded from v0.4.4 to v1.0.2 in which the apiVersion of CAPI CRDs are upgraded from `cluster.x-k8s.io/v1alpha4` to `cluster.x-k8s.io/v1beta1`. This has the effect of causing rollbacks from Rancher v2.6.4 to any previous version of Rancher v2.6.x to fail because the previous version the CRDs needed to roll back are no longer available in v1beta1. To avoid this, the Rancher resource cleanup script should be run **before** the restore or rollback is attempted. This script can be found in the [rancherlabs/support-tools repo](https://github.com/rancherlabs/support-tools/tree/master/rancher-cleanup) and the usage of the script can be found in [the backup-restore operator docs](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/). In addition, when users roll back Rancher on the same cluster using the Rancher Backup and Restore app in 2.6.4+, the [updated steps to create the Restore Custom Resource](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/#create-the-restore-custom-resource) must be followed. See also [#36803](https://github.com/rancher/rancher/issues/36803) for more details.

# Security Fixes for Rancher Vulnerabilities

This release addresses three **critical severity** security issues found in Rancher:

- Fixed an issue where sensitive fields like passwords, API keys, and Rancher's service account token were stored as plaintext on Kubernetes objects. Any user with read access to those objects in the Kubernetes API could retrieve the plaintext version of those sensitive data. For more information, see [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f).

- Improved the sanitization (removal) of credentials from cluster template answers. Failure to sanitize data can lead to plaintext storage and exposure of credentials, passwords, and API tokens. For more information, see [CVE-2021-36783](https://github.com/rancher/rancher/security/advisories/GHSA-8w87-58w6-hfv8).

- Fixed an authorization logic flaw that allowed privilege escalation in downstream clusters through cluster role template binding (CRTB) and project role template binding (PRTB). For more information, see [CVE-2022-31247](https://github.com/rancher/rancher/security/advisories/GHSA-6x34-89p7-95wg).

For more details, see the [Security Advisories page](https://github.com/rancher/rancher/security/advisories).

# Features and Enhancements

### Azure Active Directory API Migration

Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.6/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

- **Limitations**
  - Attempts to log in will fail after rolling back a Docker install of Rancher if the following conditions have occurred:
    - Azure AD is enabled.
    - Before the rollback, admins committed to the Azure AD configuration update.

    This is because the Azure AD endpoints will not be rolled back if the rollback is not performed via the backup-restore operator. If you want to roll back Rancher to use the old Azure AD Graph API without using the backup-restore operator, follow this [workaround](https://github.com/rancher/rancher/issues/38025#issuecomment-1213208087) to edit the AzureAD authconfig resource stored in the local cluster's database. The old Azure AD Graph API endpoints will not be rolled back on a Rancher rollback. See [#38025](https://github.com/rancher/rancher/issues/38025).
- **Other**
  - Multi-factor authentication (MFA) now works with the Azure AD auth provider. Some Rancher setups might have had MFA enabled in Azure from before, but Rancher wasn't working with it correctly. Be aware that on upgrade, if MFA is enabled for the Azure app, Rancher will require additional verification. See [#38028](https://github.com/rancher/rancher/pull/38028).
  - Before starting the migration process or enabling Azure AD for the first time in v2.6.7+, ensure that you add the Azure app registration's permissions of type **Application** and **NOT Delegated** for Microsoft Graph. Otherwise, you may not be able to login to Azure AD. This issue will persist even after you disable/re-enable Azure AD and will require an hour wait, or manual deletion of a cache value to resolve.

### Integration with Cloud Marketplaces

Rancher v2.6.7 introduces an integration allowing users to easily purchase support through the AWS marketplace for installation hosted on AWS/EKS. You must be running Rancher v2.6.7 or higher and have set up Rancher and it's local cluster according to the [prerequisites](https://rancher.com/docs/rancher/v2.6/en/installation/cloud-marketplace/aws/prerequisites).

For details about the integration, refer to the [Rancher documentation](https://rancher.com/docs/rancher/v2.6/en/installation/cloud-marketplace/aws/) and [#37495](https://github.com/rancher/rancher/issues/37495).

Note: If users are using the csp-adapter and the [rancher backup-restore operator](https://github.com/rancher/backup-restore-operator), they will need to upgrade the backup-restore operator to the latest version (v2.1.3) in order to ensure that the applications work together.

### New in Rancher

- Support for Kubernetes v1.24 added.
- Support has ended for Kubernetes v1.18 and v1.19.
- Increased entropy of CSRF (cross-site request forgery) token. See [#14](https://github.com/rancher/apiserver/pull/14) and [#414](https://github.com/rancher/norman/pull/414)
- Starting in v2.6.0, whenever a user requests a kubeconfig file, Rancher creates a newly-generated token instead of retrieving the old one. The token TTL is not configurable on these tokens, causing token cleanup to be a manual process. We've now added a new setting to allow users to change the TTL on kubeconfig tokens called `kubeconfig-default-token-TTL-minutes`. This setting has a default value of 0 to retain default behavior between Rancher versions. Rancher recommends that admins change this setting from its default to prevent unbound token creation. Note that this setting only applies to tokens generated for kubeconfigs when `kubeconfig-generate-tokens` is true, which is the default. When `kubeconfig-generate-tokens` is false, `kubeconfig-token-ttl-minutes` will be used for token TTL. This behavior is the same as previous versions of Rancher. The `kubeconfig-token-ttl-minutes` setting is now deprecated in favor of using `kubeconfig-default-token-TTL-minutes` in the future. See [#37705](https://github.com/rancher/rancher/issues/37705).
- The Rancher chart now exposes the `ingress.ingressClassName` value, which allows setting the name of the ingress controller to be used with Rancher's Ingress resource. This is relevant for Rancher clusters created with a provider other than RKE, since RKE automatically sets nginx as the ingress class name. By default, the value is an empty string because Rancher does not make assumptions about the type of ingress controller that runs in Rancher (nginx, Traefik, etc.). See [#37971](https://github.com/rancher/rancher/issues/37971).
- **Behavior Changes**
  - The Kubernetes team has observed an increase in memory usage with Kubernetes v1.24. See [the upstream changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.24.md#feature-1) for details.
  - All Kubernetes 1.24 clusters will have cri-dockerd enabled by default which includes new and upgraded clusters. Users can apply the `io.cattle.cluster.cridockerd.enable` annotation on a cluster, and the annotation will override the default behavior. If the annotation is set to false and `enable_cri_dockerd` is set to true, the annotation will override the field/flag behavior and `enable_cri_dockerd` will be updated to false. Clusters will not provision correctly if cri-dockerd is disabled; this is expected unless a proper Docker runtime is provided. See [#38160](https://github.com/rancher/rancher/issues/38160).

### New in RKE1

- Resolved an issue for RKE clusters that prevented specifying more than one private registry in the YAML configuration. See [#37658](https://github.com/rancher/rancher/issues/37658).
- **Windows**
  - **Important**: RKE1 Support for Windows will stop on September 1st 2022 due to upstream changes. See [this article](https://www.suse.com/support/kb/doc/?id=000020684&mkt_tok=OTM3LURDSC0yNjEAAAGFmb5AA1pbloC-PZ0mHbB9sQ3Lwqcq1iax_88DXONtcnsgG5veDwnoueEmqqNdyuAdyVjjWi582ug_dSvYQto) for more details.
  - A warning message has been added to inform users that Windows support is being deprecated for RKE1. See [#5995](https://github.com/rancher/dashboard/issues/5995).

### New in RKE2

- New encryption key rotation feature added. See [the docs](https://rancher.com/docs/rancher/v2.6/en/cluster-admin/encryption-key-rotation/) and [#35436](https://github.com/rancher/rancher/issues/35436).
- **Windows**
  - HostProcess containers are now supported in Kubernetes v1.24.1 and up. See [#69](https://github.com/rancher/windows/issues/69).
- **Behavior Changes**
  - After an upgrade to Rancher v2.6.7, RKE2 provisioned clusters will briefly go into an `Updating` state with the message `waiting for plan to be applied`. This behavior is expected and has no adverse effects. See [#38353](https://github.com/rancher/rancher/issues/38353).
- **Known Issues**
  - Encryption keys may fail to rotate when there are a large number (> 2000) of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
  - Users running RHEL/CentOS 7 should not install or upgrade to K3s/RKE2 v1.24.2 or v1.24.3 but should instead wait for K3s/RKE2 v1.24.4 to do so. See [#5912](https://github.com/k3s-io/k3s/issues/5912).
  - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [38646](https://github.com/rancher/rancher/issues/38646).
  
### New in the Rancher UI

- Removed monitoring dashboard "Rancher Internal State (Controllers)". Most functionality from this dashboard has been replaced and can be found in the dashboard "Rancher Performance Debugging". See [#37274](https://github.com/rancher/rancher/issues/37274).
- `ProjectHelmCharts` has been added as a selectable resource from the `helm.cattle.io` API group when creating a new project/namespace role. See [#5747](https://github.com/rancher/dashboard/issues/5747).
- Added a Diagnostics page to allow users to gather data from their systems to append to any issues filed for Rancher. The Diagnostics page is accessible via the About page. See [#6544](https://github.com/rancher/dashboard/issues/6544).
- The Deployment creation screen has been improved and a new Pod creation view has been added. See [#5734](https://github.com/rancher/dashboard/issues/5734).
- When viewing the details of a GitRepo through Fleet, users can now get a graphical representation of the bundle deployments that came from that GitRepo. See [#4680](https://github.com/rancher/dashboard/issues/4680).
- **Behavior Changes**
  - Project owners and project members will no longer be able to see namespaces outside of the project(s) they have access to. This is to prevent a bad user experience, where some users could see namespaces that they could not use.
  - Project owners and project members will now be required to delete namespaces within a project when deleting the project. This is to prevent a situation where they would essentially be creating orphaned namespaces, which they would lose access to when they delete the project.

# Major Bug Fixes

- User Preferences set by a drop-down component will now be applied correctly. Previously, updating a user preference in this manner would cause adverse effects such as the inability to view logs or the setting not taking effect. See [#5984](https://github.com/rancher/dashboard/issues/5984).
- Prior to `v2.6.7`, if S3 or other kinds of credentials were added to a cluster after it was already created, the reference to the secret containing the credentials was lost because the cluster status cannot be updated through the API. The references are now moved to the cluster Spec so that they can be updated after creation. To repair a cluster after a upgrade to `v2.6.7`, edit the cluster and change the etcd snapshot configuration back to local and save it, then edit again to configure S3 snapshots again. See [#38215](https://github.com/rancher/rancher/issues/38215).
- Certificates with a CN exceeding 64 characters will not cause an error. See [#37766](https://github.com/rancher/rancher/issues/37766).
- If the creation of the impersonation ClusterRoleBinding is interfered with or interrupted, users can now access the downstream cluster without experiencing unauthorized errors. See [#37733](https://github.com/rancher/rancher/issues/37733).
- Resolved an issue where users that existed since Rancher v2.6.2 or earlier may start experiencing authorization errors upon upgrade to Rancher v2.6.5 when using kubectl with a downloaded kubeconfig for a downstream cluster. See [#37894](https://github.com/rancher/rancher/issues/37894).
- Users with the role 'Cluster Owners' who are not also 'Admins' are now able to manage snapshots on RKE2 clusters. See [#37630](https://github.com/rancher/rancher/issues/37630).
- A bug was found that overloaded the downstream Kubernetes API server when the Cluster Explorer dashboard is left open to a page for a downstream cluster for over 30 minutes and would start rapidly opening and closing watch requests perpetually. See [#37627](https://github.com/rancher/rancher/issues/37627).
- Rancher server now generates a new token every time a kubeconfig is requested via the CLI. This token is then cached by the CLI on the local system and will not cause previously created tokens to become invalid. See [#37245](https://github.com/rancher/rancher/issues/37245).
- Windows installation scripts are now successfully retrieved in proxied RKE2 downstream clusters. See [#36574](https://github.com/rancher/rancher/issues/36574).
- The `istiod-istio-system` ValidatingWebhookConfiguration has been removed to allow Istio 1.11.x and higher to be installed in air-gapped environments. See [#35742](https://github.com/rancher/rancher/issues/35742).
- Most API responses now set response headers to include `Cache-Control: no-store` which directs intermediate caches not to cache the response. Previously, some intermediate caches between the Rancher server and clients, including cluster agents, were configured to cache responses for the purpose of scalability and improved response time. In some cases this led to stale data getting inadvertently cached which would disrupt deployment of downstream clusters. See [#35199](https://github.com/rancher/rancher/issues/35199).
- Project resource quotas are now correctly removed when deleted through the UI. See [#35688](https://github.com/rancher/rancher/issues/35688).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
  - When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Library and Helm3-Library Catalogs:**
  - Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **Local Cluster:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Upgrading the Rancher UI:**
  - After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet:**
  - For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
  - Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and Saving Clusters:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS Cluster:**
  - There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System Components:**
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **GKE and AKS Clusters:**
  - Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **Rolling Back Rancher:**
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC:**
  - Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs. Kube Nodes:**
  - In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook:**
  - In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Memory Limit for Legacy Monitoring:**
  - The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Memory Limit for Monitoring:**
  - The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.7

### Tools
- CLI - [v2.6.7](https://github.com/rancher/cli/releases/tag/v2.6.7)
- RKE - [v1.3.13](https://github.com/rancher/rke/releases/tag/v1.3.13)

### Kubernetes Versions
- v1.24.2 (Default)
- v1.23.8
- v1.22.11
- v1.21.14
- v1.20.15

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	Used to enable the ability to provision RKE2 clusters. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

- RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring v1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - RKE v1.3.10-v1.3.13 in Rancher v2.6.7-v2.6.8 removes user addons during an upgrade before redeploying them. This causes issues with RKE1 cluster upgrades if user addons template has `cattle-*` or other system namespaces. See [#38749](https://github.com/rancher/rancher/issues/38749) for more details.
  - **RKE1 - Windows:**
    - OPA Gatekeeper gets stuck when uninstalled. See [#37029](https://github.com/rancher/rancher/issues/37029).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - OPA Gatekeeper gets stuck when uninstalled. See [#37029](https://github.com/rancher/rancher/issues/37029).
    - In v2.6.5, v1.21.x of RKE2 will remain experimental and [unsupported](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) for RKE2 Windows. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
    - Provisioning K8s 1.23+ GKE clusters with the default option of "Container-Optimized OS with Docker" for "Image Type" fails due to GKE no longer supporting Docker-based images per [GKE documentation](https://cloud.google.com/kubernetes-engine/docs/deprecations/docker-containerd#timeline_and_milestones). Please use containerd-based images instead. See [#38743](https://github.com/rancher/rancher/issues/38743).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
  - **Oracle:**
    - Kubernetes 1.24 clusters fail to reach an `Active` state using Oracle Linux 8.4. See [#38214](https://github.com/rancher/rancher/issues/38214).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Istio 1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
**Rancher v2.6.6 is a mirror release of [v2.6.5](https://github.com/rancher/rancher/releases/tag/v2.6.5) with one change to address the following issue:**

- A major performance issue was occurring when Rancher was attempting to control large volumes of traffic from downstream clusters. This mechanism was not handling disconnects properly and would result in indefinite locks. See [#37250](https://github.com/rancher/rancher/issues/37250).
-----
# Release v2.6.5


**Note: Rancher 2.6.5 contains a bug which causes downstream clusters to become unavailable via most methods. A temporary workaround is to restart the Rancher pods. [#37250](https://github.com/rancher/rancher/issues/37250)**

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> In Rancher v2.6.4, the cluster-api module has been upgraded from v0.4.4 to v1.0.2 in which the apiVersion of CAPI CRDs are upgraded from `cluster.x-k8s.io/v1alpha4` to `cluster.x-k8s.io/v1beta1`. This has the effect of causing rollbacks from Rancher v2.6.4 to any previous version of Rancher v2.6.x to fail because the previous version the CRDs needed to roll back are no longer available in v1beta1. To avoid this, the Rancher resource cleanup script should be run **before** the restore or rollback is attempted. This script can be found in the [rancherlabs/support-tools repo](https://github.com/rancherlabs/support-tools/tree/master/rancher-cleanup) and the usage of the script can be found in [the backup-restore operator docs](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/). In addition, when users roll back Rancher on the same cluster using the Rancher Backup and Restore app in 2.6.4+, the [updated steps to create the Restore Custom Resource](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/#create-the-restore-custom-resource) must be followed. See also [#36803](https://github.com/rancher/rancher/issues/36803) for more details.

# Features and Enhancements

### New Integration with Rancher: NeuVector Security Platform

Rancher 2.6.5 introduces [NeuVector](https://open-docs.neuvector.com/), the first open-source container-centric security platform, as a new integration. NeuVector can be enabled through a Helm chart that may be installed either through **Apps & Marketplace** or through the **Cluster Tools** button in Cluster Explorer in the UI. Once NeuVector is enabled, users can deploy and manage NeuVector clusters within Rancher. See the [Neuvector documentation](https://open-docs.neuvector.com/deploying/rancher) for more information on deploying and managing NeuVector through Rancher. Refer also to the [Rancher documentation](https://rancher.com/docs/rancher/v2.6/en/neuvector-integration) for more.
- **Features**
  - Provides real-time compliance, visibility, and protection for critical apps and data.
  - Supports scanning of SUSE Linux operating systems and SUSE Rancher Kubernetes distributions (RKE1 and RKE2).
  - Features built-in navigation to deploy the NeuVector console using single sign-on (SSO).
- **Installation Details**
  - The integration with Rancher works with NeuVector 5.0.0 or higher only at this time.
  - NeuVector container images are available for installation from the Rancher Apps & Marketplace.
  - NeuVector deployment will deploy containers into the `cattle-neuvector-system` namespace.
  - NeuVector installation is supported on hardened clusters, SELinux clusters, and on clusters in an air-gapped environment.
- **Installation Recommendations**
  - When NeuVector is installed through the Rancher chart, users can log in through Rancher to log in directly to the NeuVector console. It is highly recommended to log into NeuVector directly and modify the default admin password.
  - The NeuVector vulnerability scanner image is released daily, to include the latest security advisory update. In addition, the scanner image is mirrored into the Rancher registry at `rancher/mirrored-neuvector-scanner` daily. It is recommended that you mirror the scanner image into your private registry, if needed, based on your schedule.  
- **Support Limitations**
  - Only admins and cluster owners are currently supported.
  - Fleet multi-cluster deployment is not supported.
  - NeuVector is not supported on clusters with Windows nodes.
- **Other Limitations**
  - Previous deployments from Rancher, such as from our Partners chart repository or the primary NeuVector Helm chart, must be completely removed in order to update to the new integrated feature chart. See [#37447](https://github.com/rancher/rancher/issues/37447).
  - When NeuVector is deployed in an air-gapped Rancher setup, the NeuVector `rancher/mirrored-neuvector-scanner` and `rancher/mirrored-neuvector-updater` containers will not be regularly updated by default. They will only contain the database of CVEs at the time the images are pulled into your own private registry. Updating these images in your private registry on a regular cadence will ensure your vulnerability database stays up to date. 
  - Container runtime is not auto-detected for different cluster types when installing the NeuVector chart. To work around this, you can specify the runtime manually. See [#37481](https://github.com/rancher/rancher/issues/37481).
  - Sometimes when the controllers are not ready, the NeuVector UI is not accessible from the Rancher UI. During this time, controllers will try to restart, and it takes a few minutes for the controllers to be active. See [#37400](https://github.com/rancher/rancher/issues/37400).  

### New in Project Monitoring v2

Project Monitoring v2, also known as Prometheus Federator, is now available and supported. 

- Monitoring v2 is now at parity with Monitoring v1. Please note that Monitoring v1 was deprecated in Rancher v2.5 and will be removed in an upcoming release. 
- Project Monitoring v2 introduces a custom resource called ProjectHelmCharts. This custom resource solves a problem where, if you are a project owner, you may not have permission to install/upgrade real Helm charts, but you may still need to configure monitoring across the namespaces in your project. With this, you may now create Project Monitors to enable monitoring in projects.
- Users can deploy Monitoring v2 through Rancher's Apps & Marketplace.
- **Limitations**
  - When enabling Prometheus Federator on an RKE2 cluster, the embedded Helm controller in Prometheus Federator should be disabled in favor of using the Helm controller embedded into RKE2 that is responsible for managing the state of internal Kubernetes components (since the RKE2 embedded Helm controller has a global scope in implementing HelmChart resources in the cluster). This can be provided on installing the chart by setting `helmProjectOperator.helmController.enabled=false` and is exposed as an option on the chart installation page's UI on Apps & Marketplace. See [#37694](https://github.com/rancher/rancher/issues/37694).
  - At this time, there are no migration instructions from Monitoring v2 to Project Monitoring v2. The existing instructions for migrating from Monitoring v1 to Monitoring v2 will be updated in an upcoming release.

### New in RKE2 Provisioning

RKE2 provisioning is now GA for Kubernetes v1.22 and up.

- New S3 snapshot and restore feature added. See [#34417](https://github.com/rancher/rancher/issues/34417).
- **RKE2 Windows Clusters**
  - RKE2 provisioning is now available for vSphere node driver in Windows on RKE2, RKE2 custom clusters, and Project Network Isolation (PNI) for Calico. See [#15](https://github.com/rancher/vsphere-charts/issues/15) and [#13](https://github.com/rancher/vsphere-charts/issues/13).
- **Support Limitations** 
  - There is currently no support for Encryption Key Rotation functionality. See [#35436](https://github.com/rancher/rancher/issues/35436#issuecomment-1109111044).

### New in Rancher

- Rancher on IBM Z is now in tech preview.

### New in the Rancher UI

- **Rancher Dashboard**
  - Ability to scale workload up and down from the Workload detail page has been added. See [#5114](https://github.com/rancher/dashboard/issues/5114).
- **NeuVector**
  - A new sidebar and button were added to allow users to connect to the NeuVector UI in Rancher. See [#5019](https://github.com/rancher/dashboard/issues/5019). 
  - NeuVector link has been added to the Rancher UI. See [#5556](https://github.com/rancher/dashboard/issues/5556).
- **RKE2**
  - Users may provision an RKE2 cluster using the Oracle node driver plugin. See [#3263](https://github.com/rancher/dashboard/issues/3263).   
  - Support for OCI credentials is now available for RKE2 clusters. See [#3600](https://github.com/rancher/dashboard/issues/3600).
- **Known Issues**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).  
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See Dashboard [#5336](https://github.com/rancher/dashboard/issues/5336).

### New in RKE1 and RKE2

- **RKE2 Windows**
  - The `system-agent` uninstall script now has Linux and Windows feature parity. See [#171](https://github.com/rancher/windows/issues/171).
- **RKE1 Windows**
  - Note that on September 1, 2022, RKE1 Windows will be end-of-life (EOL). For more information, see [#179](https://github.com/rancher/windows/issues/179).  
- **Behavior Changes in RKE2 Clusters**
  - Custom clusters in RKE2 and K3s will get to an active state before adding worker nodes. This is a behavior change from RKE1, which depends on worker nodes to schedule CoreDNS. See [#37017](https://github.com/rancher/rancher/issues/37017).
  - `cluster state` changes to `Provisioning` when a worker node is deleted in an RKE2 cluster, which is expected behavior. In RKE1, the cluster state remains `Active` when a snapshot is triggered or a worker node is deleted. See [#36689](https://github.com/rancher/rancher/issues/36689).
  - `cluster state` changes to `Provisioning` or `Updating` when a snapshot is taken in an RKE2 cluster, which is expected behavior. In RKE1, Rancher is responsible for taking the snapshots. See [#36504](https://github.com/rancher/rancher/issues/36504).
- **Known Issues**
  - RKE2 cluster provisioning fails when using the RHEL 8.5 golden public AWS AMI from Rancher. See [#36731](https://github.com/rancher/rancher/issues/36731). To work around this issue, please see [this note](https://github.com/rancher/rancher/issues/36731#issuecomment-1058230553).
  - RKE2 snapshots display different sizes and are working as expected. See [#36713](https://github.com/rancher/rancher/issues/36713).
  - The RKE2 cluster name cannot exceed 63 characters. In addition, removing such clusters from Rancher because they fail to provision causes Rancher server to crash. See [#37544](https://github.com/rancher/rancher/issues/37544).
  - OPA Gatekeeper gets stuck when uninstalling on Windows clusters. Note that this applies to both RKE1 and RKE2 clusters. See [#37029](https://github.com/rancher/rancher/issues/37029). A fix is scheduled for 2.6.6.
  - Any RKE2 Windows cluster created prior to v2.6.5 through the provisioning v2 framework cannot be upgraded using v2.6.5. Only RKE2 Windows clusters provisioned on v2.6.5+ can be upgraded. See [#76](https://github.com/rancher/windows/issues/76).
  - The Windows agent for RKE2 Windows nodes does not support auto-upgrades at this time. This functionality is planned for v2.6.6. See [#181](https://github.com/rancher/windows/issues/181).
  - Windows worker nodes in RKE2 clusters that require the use of a proxy for downstream nodes will not successfully provision. This issue exists only in the system-agent implementation for RKE2 Windows, as it is unable to use a proxy when attempting to pull images while applying a plan. See [#37688](https://github.com/rancher/rancher/issues/37688).
  - The Calico CNI will not run on SLE Micro without additional configuration as the filesystem is read-only, and Calico tries to create a flexVolume with a path at `/usr/libexec`. Note that this affects v1.23.6+rke2r2 and v1.22.9+rke2r2 as well as earlier RKE2 versions, but this may be fixed in newer versions that can be added to Rancher via a KDM update. To view the workaround and this issue, refer to [#2886](https://github.com/rancher/rke2/issues/2886#issue-1231809448).
  - When Rancher is air-gapped, Windows worker nodes in RKE2 clusters will not be able to successfully provision. This issue occurs when a custom CA certificate is required when making calls in Go on Windows when a restconfig needs to be built, and it requires a custom CA certificate, which is part of the system-agent installation flow for RKE2 Windows. See [#37695](https://github.com/rancher/rancher/issues/37695).
  - Hardening guide template for RKE2 currently only supports CNI Canal. See [#154](https://github.com/rancher/cis-operator/issues/154).

# Major Bug Fixes 

- RKE2 node driver cluster provisions successfully in both Kubernetes v1.22.x and v1.23.x. See [#36939](https://github.com/rancher/rancher/issues/36939).
- On the Cluster Management page, snapshot-related actions such as create/restore and `rotate certificate` are now available for a standard user in RKE1. See Dashboard [#5011](https://github.com/rancher/dashboard/issues/5011).
- Cluster usage metrics have been removed from the Rancher homepage cluster list. Users may still check usage per cluster by using the cluster dashboard. See [#5430](https://github.com/rancher/dashboard/issues/5430).
- When performing a backup/restore using Helm, the command will now work as expected if Let's Encrypt is used. See [#37060](https://github.com/rancher/rancher/issues/37060).
- If you set restricted PSP as default to cluster and create a new namespace with an unrestricted PSP, the pod/deployment creation in the new project no longer fails. See [#37443](https://github.com/rancher/rancher/issues/37443).
- A warning message is now present as expected to state that the monitoring and logging apps must be upgraded to deploy on newly added Windows nodes. See [#5530](https://github.com/rancher/dashboard/issues/5530). 
- After installing Monitoring v2, the rancher-monitoring-crd now successfully installs. See [#35744](https://github.com/rancher/rancher/issues/35744). 
- API audit logging was fixed to log to either the sidecar or the hostPath, but not both. See [#26192](https://github.com/rancher/rancher/issues/26192).
 
# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
  - When using Kubernetes v1.21 with Windows Server 20H2 Standard Core, the patch "2019-08 Servicing Stack Update for Windows Server" must be installed on the node. See [#72](https://github.com/rancher/windows/issues/72).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**  
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:** 
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
  - When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Library and Helm3-Library Catalogs:** 
  - Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **Local Cluster:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Upgrading the Rancher UI:** 
  - After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet:**
  - For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
  - Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and Saving Clusters:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS Cluster:**
  - There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System Components:** 
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **GKE and AKS Clusters:** 
  - Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **Rolling Back Rancher:** 
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC:** 
  - Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Azure Cloud Provider for RKE2:** 
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs. Kube Nodes:** 
  - In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook:** 
  - In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Memory Limit for Legacy Monitoring:** 
  - The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Memory Limit for Monitoring:** 
  - The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.5

### Tools
- CLI - [v2.6.5](https://github.com/rancher/cli/releases/tag/v2.6.5)
- RKE - [v1.3.11](https://github.com/rancher/rke/releases/tag/v1.3.11)

### Kubernetes Versions
- v1.23.6 (Default)
- v1.22.9
- v1.21.12
- v1.20.15
- v1.19.16
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	Used to enable the ability to provision RKE2 clusters. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

- RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring v1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using a RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - In v2.6.5, v1.21.x of RKE2 will remain experimental and [unsupported](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) for RKE2 Windows. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - CSI Proxy for Windows will not work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Istio 1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - A `failed calling webhook "validation.istio.io"` error will occur in air gapped environments if the `istiod-istio-system` `ValidatingWebhookConfiguration` exists, and you attempt a fresh install of Istio 1.11.x and higher. To work around this issue, run the command `kubectl delete validatingwebhookconfiguration istiod-istio-system` and attempt your install again. See [#35742](https://github.com/rancher/rancher/issues/35742#issuecomment-994801502).
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).

-----
# Release v2.6.4

**Note: Rancher 2.6.4 contains a bug which causes downstream clusters to become unavailable via most methods. A temporary workaround is to restart the Rancher pods. [#37250](https://github.com/rancher/rancher/issues/37250)**

--- 

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> In Rancher v2.6.4, the cluster-api module has been upgraded from v0.4.4 to v1.0.2 in which the apiVersion of CAPI CRDs are upgraded from `cluster.x-k8s.io/v1alpha4` to `cluster.x-k8s.io/v1beta1`. This has the effect of causing rollbacks from Rancher v2.6.4 to any previous version of Rancher v2.6.x to fail because the previous version the CRDs needed to roll back are no longer available in v1beta1. To avoid this, the Rancher resource cleanup script should be run **before** the restore or rollback is attempted. This script can be found in the [rancherlabs/support-tools repo](https://github.com/rancherlabs/support-tools/tree/master/rancher-cleanup) and the usage of the script can be found in [the backup-restore operator docs](https://rancher.com/docs/rancher/v2.6/en/backups/restoring-rancher/). See also [#36803](https://github.com/rancher/rancher/issues/36803) for more details.

# Features and Enhancements

### New in Rancher

- Kubernetes v1.22 is no longer experimental and is now supported. Kubernetes v1.23 is experimental.
- Kubernetes v1.22 and v1.23 are available as Kubernetes version options when provisioning clusters as well as upgrading imported RKE2/k3s clusters.
- Rancher on IBM Z is now in tech preview.

### New in Cert-Manager
- Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x will reach end-of-life on March 30, 2022. To read more, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#4-install-cert-manager).
- When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
- There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
- For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
- For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).

### New in RKE2 - Tech Preview

- UI Enhancements in RKE2 Cluster Provisioning 
  - The UI now provides an option to rotate certificates for RKE2 provisioned clusters, including an option to rotate certificates for an individual component. See Dashboard [#4485](https://github.com/rancher/dashboard/issues/4485).
  - S3 configuration support has been re-enabled for RKE2 snapshots; this is required for RKE2 provisioning parity with RKE1. See Dashboard [#4551](https://github.com/rancher/dashboard/issues/4551).
  - When restoring RKE2 cluster etcd snapshots, more restore options are available. See Dashboard [#4539](https://github.com/rancher/dashboard/issues/4539).
  - “Auto Replace” option support enabled for RKE2 machine pools. See Dashboard [#4449](https://github.com/rancher/dashboard/issues/4449).
  - Ability to scale down individual nodes for RKE2-provisioned clusters added. See Dashboard [#4446](https://github.com/rancher/dashboard/issues/4446).
  - Enhanced RKE2 cluster provisioning on Linode. See Dashboard [#3262](https://github.com/rancher/dashboard/issues/3262).
  - Added user-configurable OS field for vSphere machine pools. See Dashboard [#4859](https://github.com/rancher/dashboard/issues/4859).
  - "Drain Before Delete" support for RKE2 machine pools has been added. Note that when editing nodes and enabling the "Drain Before Delete" option, the existing control plane nodes and worker nodes are deleted and new nodes are created. It should be noted that for etcd nodes, the same behavior does not apply. See [#35274](https://github.com/rancher/rancher/issues/35274) and Dashboard [#4448](https://github.com/rancher/dashboard/issues/4448).
  - Health checks were added to support self-healing RKE2 machine pools. See [#35275](https://github.com/rancher/rancher/issues/35275).
- Bug Fixes
  - RKE2 clusters can now be provisioned using the AWS cloud provider with Kubernetes v1.22. See [#35618](https://github.com/rancher/rancher/issues/35618).
  - Clusters can be created from an RKE2 template as non-admin user. [#34844](https://github.com/rancher/rancher/issues/34844).
-	Known Issues in Windows
    - Experimental Support for RKE2 Provisioning tech preview for Windows will only work on v1.22 and up of RKE2. End users should not use v1.21.x of RKE2 for any RKE2 cluster that will have Windows worker nodes. This is due to an [upstream Calico bug](https://github.com/rancher/windows/issues/131#issuecomment-1007792897) that was not backported to the minor version of Calico (3.19.x) that is present in v1.21.x of RKE2. See [#131](https://github.com/rancher/windows/issues/131).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed.
    - CSI Proxy for Windows will not work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
-	Other Known Issues
    - RKE2 node driver cluster gets stuck in provisioning state after an upgrade to v2.6.4 and rollback to v2.6.3. See [#36859](https://github.com/rancher/rancher/issues/36859).
    - RKE2 node driver cluster has its nodes redeployed when upgrading Rancher from v2.6.3 to v2.6.4. See [#36627](https://github.com/rancher/rancher/issues/36627).
    - RKE2 node driver cluster gets stuck in provisioning state in Kubernetes v1.23.x. See [#36939](https://github.com/rancher/rancher/issues/36939).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cillium as the CNI and activate project network isolation. See [documentation](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275)
    - `cluster state` changes to `Provisioning` when a worker node is deleted in an RKE2 cluster. See [#36689](https://github.com/rancher/rancher/issues/36689).
    - `cluster state` changes to `Provisioning` when a snapshot is taken in an RKE2 cluster. See [#36504](https://github.com/rancher/rancher/issues/36504).

### UI Enhancements in Fleet

- Added a Bundles tab to the GitRepo detail view. See Dashboard [#4794](https://github.com/rancher/dashboard/issues/4794).
- Added a Detail view for the Fleet Bundle resource. See Dashboard [#4793](https://github.com/rancher/dashboard/issues/4793).
- Fleet controller logs are now viewable on cluster dashboard. See Dashboard [#3668](https://github.com/rancher/dashboard/issues/3668).
- In the Continuous Delivery dashboard, badge colors have been updated to feature counts that convey health status information. See Dashboard [#5232](https://github.com/rancher/dashboard/issues/5232).
- On the Git Repos detail page, error notifications were added to the Conditions tab. See Dashboard [#5218](https://github.com/rancher/dashboard/issues/5218).
- Added a new dashboard view to Fleet at the top of the navigation list; this is the default page that the user will land on. See Dashboard [#5048](https://github.com/rancher/dashboard/issues/5048).
- In the Git Repos detail page, a warning icon now displays when the GitRepo does not apply to any clusters. See Dashboard [#4929](https://github.com/rancher/dashboard/issues/4929).

### Other UI Enhancements

- Nvidia GPU Reservation can be edited on the workloads page. See Dashboard [#5005](https://github.com/rancher/dashboard/issues/5005).
- The UI now uses a nested structure to determine whether to display global or cluster-scoped resources in the role creation forms, and which API group should be auto-populated when a resource is selected. See Dashboard [#4888](https://github.com/rancher/dashboard/issues/4888).
- An edit and detail UI has been added for NetworkPolicies. See Dashboard [#4729](https://github.com/rancher/dashboard/issues/4729).
- On the namespace detail page, a new tab was added that shows the workloads. See Dashboard [#5115](https://github.com/rancher/dashboard/issues/5115).
- In Apps and Marketplace, existing charts have been updated with annotations such that users will better understand what occurs in their mixed Linux/Windows workload cluster if they deploy a chart. See Dashboard [#5137](https://github.com/rancher/dashboard/issues/5137).
- If a custom consent banner is enabled, after logging into Rancher, a user must now accept or deny consent. By default, consent is required to use Rancher, but can be configured to be optional. See Dashboard [#4719](https://github.com/rancher/dashboard/issues/4719).
- Improvements added to the Rollback Diff view: ability to switch between the side-by-side and inline diff and the ability to collapse (or hide) the fields that are non-standard. See Dashboard [#4636](https://github.com/rancher/dashboard/issues/4636).
- Users can now create a ConfigMap at the project scope. See Dashboard [#4571](https://github.com/rancher/dashboard/issues/4571).

### Security Enhancements

- New `restricted-noroot` PSP created to prevent pods from running as a privileged user. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/pod-security-policies/), [#35191](https://github.com/rancher/rancher/issues/35191) and security advisory [GHSA-hwm2-4ph6-w6m5](https://github.com/rancher/rancher/security/advisories/GHSA-hwm2-4ph6-w6m5).
- CIS Hardening Guide updated for Rancher 2.6. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/security/hardening-guides/) and [#35735](https://github.com/rancher/rancher/issues/35735).

### Other New Features

- Users can now provision node driver clusters from an air gapped cluster configured to use a proxy for outbound connections. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/other-installation-methods/behind-proxy/) and [#28411](https://github.com/rancher/rancher/issues/28411).
- The "rancher/install-docker" script now supports the Linux distributions `SLES / OpenSUSE / RHEL / Rocky Linux` for the Docker versions `20.10.8 / 20.10.9 / 20.10.10`. See [#34615](https://github.com/rancher/rancher/issues/34615).
- Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).

### Behavior Changes

- If you provide your own security group for an EC2 instance, Rancher will not modify it; therefore, you must set the security group to [allow the necessary ports for Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/ports/#rancher-aws-ec2-security-group) to provision the instance. See [documentation](https://rancher.com/docs/rancher/v2.6/en/cluster-provisioning/rke-clusters/node-pools/ec2/ec2-node-template-config/#security-group) and [#3832](https://github.com/rancher/docs/issues/3832).

# Major Bug Fixes
### UI
- Fixed an issue in which restricted admins couldn't create git repos from the continuous delivery menu. See Dashboard [#4909](https://github.com/rancher/dashboard/issues/4909).
- Cluster Dashboard resource gauges now show correct max values. See Dashboard [#2892](https://github.com/rancher/dashboard/issues/2892).
- Can now add or edit cluster labels via the UI. See Dashboard [#3086](https://github.com/rancher/dashboard/issues/3086).
- Added support for cluster icons for drivers that are not built in. See Dashboard [#3124](https://github.com/rancher/dashboard/issues/3124).
- Editing deployment image names via "Edit Config" no longer results in failure. See Dashboard [#3827](https://github.com/rancher/dashboard/issues/3827).
- Templates are now listing from vSphere content library as expected. See Dashboard [#4302](https://github.com/rancher/dashboard/issues/4302).
- "Restore snapshot" action is now available in Cluster management page. See Dashboard [#4606](https://github.com/rancher/dashboard/issues/4606).
- Rollback option on workload works as expected. See Dashboard [#4664](https://github.com/rancher/dashboard/issues/4664).
- Group list now sorts alphabetically when attempting to add role grant for SAML group. See Dashboard [#4685](https://github.com/rancher/dashboard/issues/4685).
- Namespace resource settings for quota override now display in UI. See Dashboard [#4704](https://github.com/rancher/dashboard/issues/4704).
- Fixed an issue in which there were differences in behavior of conditional logic in questions.yaml between older Cluster Manager Apps and the Cluster Explorer in Apps & Marketplace. See Dashboard [#4706](https://github.com/rancher/dashboard/issues/4706).
- UI now shows network-attachment-definitions correctly. See Dashboard [#4748](https://github.com/rancher/dashboard/issues/4748).
- Added form field for `ssl_verify` and `ssl_version` when enabling an HTTPS flow. See Dashboard [#4753](https://github.com/rancher/dashboard/issues/4753).
- Fixed issue in which advanced selector settings for GitRepo get lost when editing. See Dashboard [#4788](https://github.com/rancher/dashboard/issues/4788).
- UI change of replicas are now enabled. See Dashboard [#4828](https://github.com/rancher/dashboard/issues/4828).
- Form elements are now displayed as expected in Continuous Delivery Git Repo create/edit form. See Dashboard [#4830](https://github.com/rancher/dashboard/issues/4830).
- Added back pod selection checkboxes and delete button to workload views in Cluster Explorer. See Dashboard [#4831](https://github.com/rancher/dashboard/issues/4831).
- Removed Rancher OS AMI link from EC2 provisioning UI. See Dashboard [#4833](https://github.com/rancher/dashboard/issues/4833).
- Restricted admins can now see Assign Global Roles button in Users & Authentication -> Groups. See Dashboard [#4834](https://github.com/rancher/dashboard/issues/4834).
- Project/Cluster Member with Project Monitoring role granted on System Project able to view workload /node metrics tab in Explorer UI. See Dashboard [#4835](https://github.com/rancher/dashboard/issues/4835).
- Init containers are now visible in the Cluster Explorer UI. See Dashboard [#4840](https://github.com/rancher/dashboard/issues/4840).
- Users may create a cronjob in Rancher UI as expected. See Dashboard [#4842](https://github.com/rancher/dashboard/issues/4842).
- API Key Expired date displays correctly now at first login as standard user. See Dashboard [#4863](https://github.com/rancher/dashboard/issues/4863).
- Secrets can be used as Environment Variables in Deployments. See Dashboard [#4866](https://github.com/rancher/dashboard/issues/4866).
- Dashboard now shows the API endpoint URL in the API Keys page. See Dashboard [#4869](https://github.com/rancher/dashboard/issues/4869).
- Unnecessary "%" that was displayed in Maximum Worker Nodes Unavailable screen has been removed. See Dashboard [#4870](https://github.com/rancher/dashboard/issues/4870).
- Events table in cluster dashboard has been replaced with monitoring alerts table. See Dashboard [#4911](https://github.com/rancher/dashboard/issues/4911).
- Kubernetes Job now displays in Rancher UI when job is created from CronJob with kubectl 1.19+ version. See Dashboard [#4963](https://github.com/rancher/dashboard/issues/4963).
- Resolved Rancher error when browsing clusters and refreshing the page. See Dashboard [#4967](https://github.com/rancher/dashboard/issues/4967).
- New User Default Role Toggle now functions as expected in Rancher UI. See Dashboard [#4992](https://github.com/rancher/dashboard/issues/4992).
- Fixed login error `Cannot read properties of null (reading 'startsWith') Home`. See Dashboard [#5004](https://github.com/rancher/dashboard/issues/5004).
- Users can now change default role via UI after configuring ADFS authentication. See Dashboard [#5066](https://github.com/rancher/dashboard/issues/5066).
- Namespace view now provides detail for the summary pills. See Dashboard [#5074](https://github.com/rancher/dashboard/issues/5074).
- Dropdown added so that viewing previous container logs is easier. See Dashboard [#5075](https://github.com/rancher/dashboard/issues/5075).
- Helm UI now displays logs of a deployment. See Dashboard [#5079](https://github.com/rancher/dashboard/issues/5079).
- Component Status pills now show on cluster dashboard view. See Dashboard [#5085](https://github.com/rancher/dashboard/issues/5085).
- Fixed an issue in which config map view was inconsistent for binary data. See Dashboard [#5311](https://github.com/rancher/dashboard/issues/5311).
### Rancher
- Fixed error in which standard users received an error when creating a cluster from the `Edit as YAML` and `Edit as a Form` buttons. See [#35868](https://github.com/rancher/rancher/issues/35868).
- If the `rancher-node` security group is used, the existing security group is not modified, as expected. See [#24337](https://github.com/rancher/rancher/issues/24337).
- For namespaces created inside projects via `kubectl`, when a resource limit exceeds the remaining amount in the project, Rancher no longer assigns an all-restrictive quota limit. Instead, a zero limit is set for the exceeding resource only. See [#35647](https://github.com/rancher/rancher/issues/35647).
- When deploying a cluster on v1.22, monitoring installation works as expected. See [#35571](https://github.com/rancher/rancher/issues/35571).
- Fixed an issue in which Calico probes failed on Windows nodes. See [#36910](https://github.com/rancher/rancher/issues/36910).
- Enabling `Cluster Monitoring` through the API or the UI will now set the same memory limits. See [#25103](https://github.com/rancher/rancher/issues/25103).
- When creating a RKE cluster with the Rancher CLI, the values from a config file are now applied. See [#25416](https://github.com/rancher/rancher/issues/25416).
- The `Container Default Resource Limits` are now applied when a new namespace is created in a project via `kubectl` (bypassing the UI). See [#27750](https://github.com/rancher/rancher/issues/27750).
- Fixed issue in which deploying clusters using the Azure node driver caused `Pod Predicate NodeAffinity failed error` on `default-http-backend` pod. See [#29882](https://github.com/rancher/rancher/issues/29882).
- Hairpin rules are now added when using IPVS with a cloud provider enabled. See [#30363](https://github.com/rancher/rancher/issues/30363).
- Cluster namespaces no longer remain after deleting a cluster. See [#31546](https://github.com/rancher/rancher/issues/31546).
- Upgrading Kubernetes version on downstream clusters no longer causes a memory consumption increase. See [#31640](https://github.com/rancher/rancher/issues/31640).
- Configuring Keycloak (SAML) authentication no longer fails with decoding error `Unknown error: SAML: cannot initialize saml SP, cannot decode IDP Metadata content from the config`. See [#33709](https://github.com/rancher/rancher/issues/33709).
- Fixed issue in which intermittent health check failure caused unreachable downstream clusters. See [#34819](https://github.com/rancher/rancher/issues/34819).
- Backups taking longer than 5 minutes will no longer cause Rancher to start a new backup and delete the one that is currently running, generating a backup loop. See [#34890](https://github.com/rancher/rancher/issues/34890).
- K3s Docker image should now be used in the Dockerfile instead of downloading the K3s binary. See [#35101](https://github.com/rancher/rancher/issues/35101).
- When Logging v1 and v2 are both installed, the v1 `fluentd` pods no longer get stuck with the `crashlooping` error. See [#35125](https://github.com/rancher/rancher/issues/35125).
- Syslog output can now be sent through UDP in Logging v2. See [#35197](https://github.com/rancher/rancher/issues/35197).
- The `cattle-node-cleanup` job will be deleted as expected after it times out. See [#35334](https://github.com/rancher/rancher/issues/35334).
- If a new namespace does not fit the Project quota limits, a `zero quota` limit will be created only for the new namespace's resources. See [#35647](https://github.com/rancher/rancher/issues/35647).
- When upgrading a RKE cluster, the status is seen as active even though the add-ons are still being updated. See [#35750](https://github.com/rancher/rancher/issues/35750).
- `rancher-webhook` certificate renewal workaround updated. See [#35860](https://github.com/rancher/rancher/issues/35860).
- Default value for `ingressNginx.serviceMonitor.interval` is set to `30s` in the `rancher-monitoring` charts. See [#36070](https://github.com/rancher/rancher/issues/36070).
- Importing KEv2 clusters with the Rancher client have their config correctly rewritten. See [#36128](https://github.com/rancher/rancher/issues/36128).
- The `rancher-monitoring` ports for `node-exporter` and `push-proxy-clients` are no longer opened on the host. See [#36140](https://github.com/rancher/rancher/issues/36140).
- DNS redirect iptables rules are now correctly created by `istio-cni`. See [#36159](https://github.com/rancher/rancher/issues/36159).
- When using Fleet to apply the configuration, it will only apply the final configMap entry. See [#36242](https://github.com/rancher/rancher/issues/36242).
- When creating a cluster, RKE cluster will no longer panic if `rotate_encryption_key` is enabled and `secrets_encryption_config` disabled. See [#36333](https://github.com/rancher/rancher/issues/36333).
- Actions can now be performed by a cluster member, `Download KubeConfig` and `Take Snapshot`, are correctly being shown as available on RKE1 clusters in a Rancher setup. See [#35828](https://github.com/rancher/rancher/issues/35828).
### Security
- Role bindings are now cleaned up from deleted users. See [#36550](https://github.com/rancher/rancher/pull/36550).
- Fixed error when syncing handler restrictedAdmin RBAC cluster. See [#36650](https://github.com/rancher/rancher/pull/36650).
- Fixed error when syncing handler `grb-cluster-sync: RoleBinding.rbac.authorization.k8s.io`. See [#36650](https://github.com/rancher/rancher/pull/36650).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
  - When using Kubernetes v1.21 with Windows Server 20H2 Standard Core, the patch "2019-08 Servicing Stack Update for Windows Server" must be installed on the node. See [#72](https://github.com/rancher/windows/issues/72).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Legacy features are gated behind a feature flag.** Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
- **Users must manually remove legacy services.** When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Charts from library and helm3-library catalogs can no longer be launched.** Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Users must log in again.** After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet is now always enabled.** For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
- **The Fleet agent in the local cluster now lives in `cattle-fleet-local-system`.** Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and saving clusters can result in cluster reconciliation.** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **The EKS cluster refresh interval setting changed.** There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System components will restart.** Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **New GKE and AKS clusters will use Rancher's new lifecycle management features.** Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **New steps for rolling back Rancher.** The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC differences around Manage Nodes for RKE2 clusters.** Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **New procedure to set up Azure cloud provider for RKE2.** For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs Kube Nodes.** In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook chart no longer supported in v1.22.** In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Increased memory limit for Legacy Monitoring.** The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Increased memory limit for Monitoring.** The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.4

### Tools
- CLI - [v2.6.4](https://github.com/rancher/cli/releases/tag/v2.6.4)
- RKE - [v1.3.8](https://github.com/rancher/rke/releases/tag/v1.3.8)

### Kubernetes Versions
- v1.23.4 (Experimental)
- v1.22.7 (Default)
- v1.21.10
- v1.20.15
- v1.19.16
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	We have introduced the ability to provision RKE2 clusters as tech preview. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).


### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring V1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - On the Cluster Management page, snapshot-related actions such as create/restore and `rotate certificate` are not available for a standard user in RKE1. See Dashboard [#5011](https://github.com/rancher/dashboard/issues/5011).
    - Dual stack is [not supported](https://kubernetes.io/docs/setup/production-environment/windows/intro-windows-in-kubernetes/#ipv6-networking) for RKE1 Windows clusters, specifically v1.23.4 with dual stack networking becoming [GA in upstream Kubernetes](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). See Windows [#165](https://github.com/rancher/windows/issues/165).
    - Due to a bug in rancher-machine which ignores the use of NO_PROXY when running inside of a Rancher jail, certain air-gapped Rancher environments may face issues with provisioning an RKE node driver cluster if Rancher should not use the proxy to communicate with the downstream cluster. It is recommended that End-users with environments matching these conditions do not upgrade to 2.6.4. See [#37295](https://github.com/rancher/rancher/issues/37295).
  - **RKE2 - Tech Preview:** There are several known issues as this feature is in tech preview, but here are some major issues to consider before using RKE2.
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using a RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
  - **RKE2 - Windows:**
    - Windows clusters do not yet support Rancher Apps & Marketplace. See [#34405](https://github.com/rancher/rancher/issues/34405).
    - Windows clusters do not yet support upgrading RKE2 versions. See Windows [#76](https://github.com/rancher/windows/issues/76).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - In an HA Rancher server on Kubernetes v1.20, ingresses on AWS EC2 node driver clusters do not go through and result in a `failed calling webhook` error. Please refer to the [workaround](https://github.com/rancher/rancher/issues/35754#issuecomment-995566492). See [#35754](https://github.com/rancher/rancher/issues/35754).
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
- **Infrastructures:**
  - **vSphere:**
    - The vSphere CSI Driver does not support Kubernetes v1.22 due to unsupported v1beta1 CRD APIs. Support will be added in a later release, but in the meantime users with the `CSIMigrationvSphere` feature enabled should not upgrade to Kubernetes v1.22. See [#33848](https://github.com/rancher/rancher/issues/33848).
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
    - When performing a backup/restore using Helm, the command will fail if Let's Encrypt is used. See [#37060](https://github.com/rancher/rancher/issues/37060).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring fails to upgrade when CRD is in a failed state. To work around this issue, use Helm to install the `rancher-monitoring` chart into the cluster directly, rather than using the Rancher UI. In order to set nodeSelector or tolerations to the `rancher-monitoring-crd` chart, you need to install the `rancher-monitoring-crd` and `rancher-monitoring` chart by using the Helm command via command line. Rancher UI will add support soon. See [#35744](https://github.com/rancher/rancher/issues/35744).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - A `failed calling webhook "validation.istio.io"` error will occur in air gapped environments if the `istiod-istio-system` `ValidatingWebhookConfiguration` exists, and you attempt a fresh install of Istio 1.11.x and higher. To work around this issue, run the command `kubectl delete validatingwebhookconfiguration istiod-istio-system` and attempt your install again. See [#35742](https://github.com/rancher/rancher/issues/35742#issuecomment-994801502).
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Login to Rancher using Active Directory with TLS:** 
  - Upon an upgrade to v2.6.0, authenticating via Rancher against an Active Directory server using TLS can fail if the certificates on the AD server do not support SAN attributes. This is a check enabled by default in Go v1.15. See [#34325](https://github.com/rancher/rancher/issues/34325).
  - The error received is "Error creating SSL connection: LDAP Result Code 200 "Network Error": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0"
  - To resolve this, the certificates on the AD server should be updated or replaced with new ones that support the SAN attribute. Alternatively this error can be ignored by setting `GODEBUG=x509ignoreCN=0` as an environment variable to Rancher server container.
- **Rancher UI:**
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See Dashboard [#5336](https://github.com/rancher/dashboard/issues/5336).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----

-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Upgrading to Rancher v2.6.3-patch1:**
- For Helm, use the following command. Take note of the additional `rancherImageTag` parameter and be sure to change `namespace` and `hostname` as needed for your configuration:

    helm upgrade rancher rancher-latest/rancher \
      --namespace cattle-system \
      --set hostname=rancher.my.org \
      --set rancherImageTag=v2.6.3-patch1

- For Docker, use the standard upgrade command:

    docker run -d --privileged --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:v2.6.3-patch1


**Rancher v2.6.3-patch1 addresses additional issues including, but not limited to:**

- On upgrade, any namespaces created with resource quotas should either be deleted or edited again (which will correct the invalid resource quotas). Failure to do so will result in resource quotas failing to apply to all other namespaces in the same project. See [#4804](https://github.com/rancher/dashboard/issues/4804).
- Fixed an issue where a broken websocket connection would redirect users to the login page when accessing the Cluster Explorer. See [#32934](https://github.com/rancher/rancher/issues/32934).
- Cluster health checks no longer fail from random downstream clusters becoming unreachable. See [#36191](https://github.com/rancher/rancher/issues/36191).
- Downstream clusters are no longer missing from Docker installations of Rancher after upgrading when volumes are bound. See [#36178](https://github.com/rancher/rancher/issues/36178).
- New and existing rancher-webhook deployments will automatically renew their TLS certificates when the expiration date is 30 days or less. See [#36177](https://github.com/rancher/rancher/issues/36177).
# Features and Enhancements

### New Experimental Features

Kubernetes v1.22 is being introduced in Rancher v2.6.3 as an experimental feature. As such, Rancher doesn't support provisioning 1.22 clusters or having Rancher run on 1.22 clusters at this time. Support will become available at a later time.

### New in Harvester

- Harvester v1.0.0 is GA and is only supported by Rancher v2.6.3.
- Harvester v0.3.0 is not supported by Rancher v2.6.3. You must delete your Harvester v0.3.0 cluster from Rancher before upgrading Rancher.
- Virtualization Management
  - Importing a Harvester cluster no longer needs the manual `kubectl` command. Refer [here](https://docs.harvesterhci.io/v1.0/rancher/virtualization-management/) for details.
- RKE1
  - Rancher provisioned RKE1 clusters now support installing Harvester Cloud Provider Chart and CSI Driver Chart.  No more manual configuration is needed.
  - Additional UI enhancement has been added to the RKE1 Load Balancer page to support the Harvester Load Balancer configuration. No more manual annotation is needed.
  - Refer to the [documentation](https://docs.harvesterhci.io/v1.0/rancher/cloud-provider/) for more details.
- RKE2
  - Rancher provisioned RKE2 clusters will have Harvester Load Balancer and CSI driver installed automatically.
  - Additional UI enhancement has been added to the RKE2 Load Balancer page to support the Harvester Load Balancer configuration.
  - Refer to the [documentation](https://docs.harvesterhci.io/v1.0/rancher/cloud-provider/) for more details.

### UI Enhancements

- Scaling up or down of a workload is now enabled in the Rancher UI. See [#4328](https://github.com/rancher/dashboard/issues/4328).
- The scale and health status of a workload is now visible in workload view. See [#4329](https://github.com/rancher/dashboard/issues/4329).
- Added ability to pause orchestration for workloads. See [#4331](https://github.com/rancher/dashboard/issues/4331).
- Added dashboards for workload metrics into the Rancher UI. See [#1879](https://github.com/rancher/dashboard/issues/1879).
- Support added to Azure node driver to use images from Apps & Marketplace. See [#33518](https://github.com/rancher/rancher/issues/33518).
- UI page load times improved. See [#34721](https://github.com/rancher/rancher/issues/34721).

### Security Enhancements

- By default, only passwords with at least 12 characters are accepted per new password policy in Rancher. See [#34851](https://github.com/rancher/rancher/pull/34851).
- Starting with v1.22, RKE1 no longer rewrites SELinux labels on container volume mounts. Please see the [security docs](https://rancher.com/docs/rancher/v2.6/en/security/selinux/) for information on how to install the rancher-selinux RPM to ensure SELinux policies are configured. See [#2541](https://github.com/rancher/rke/pull/2541) for reference.

### Other New Features

- Authorized Cluster Endpoint can now be enabled on downstream imported RKE2/K3s clusters. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/cluster-provisioning/registered-clusters/#authorized-cluster-endpoint-support-for-rke2-and-k3s-clusters) and [#35161](https://github.com/rancher/rancher/issues/35161) for details.
- The Rancher Monitoring chart has been upgraded to match the upstream `kube-prometheus-stack` version 19.0.3. See [#34577](https://github.com/rancher/rancher/issues/34577).

# Major Bug Fixes

- Fixed issue in which RKE1 and RKE2 Clusters were becoming stuck in Removing state. See [#35180](https://github.com/rancher/rancher/issues/35180).
- Rancher-related namespaces are now removed after cluster agents are removed on imported provider clusters. See [#34990](https://github.com/rancher/rancher/issues/34990).
- Fixed issue in which cluster failed to communicate with API server after etcd role node is removed. See [#34488](https://github.com/rancher/rancher/issues/34488).
- Downstream clusters behind a proxy are now supported when RKE2 cluster is upgraded. See [#32633](https://github.com/rancher/rancher/issues/32633).
- The API Server has been updated to fix slow consumers causing deadlocks. See [#34906](https://github.com/rancher/rancher/pull/34906).
- When in installed apps under Apps & Marketplace in a cluster, navigating to workloads after selecting namespace works. See [#4428](https://github.com/rancher/dashboard/issues/4428).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
  - When using Kubernetes v1.21 with Windows Server 20H2 Standard Core, the patch "2019-08 Servicing Stack Update for Windows Server" must be installed on the node. See [#72](https://github.com/rancher/windows/issues/72).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Legacy features are gated behind a feature flag.** Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
- **Users must manually remove legacy services.** When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Charts from library and helm3-library catalogs can no longer be launched.** Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Users must log in again.** After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet is now always enabled.** For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
- **The Fleet agent in the local cluster now lives in `cattle-fleet-local-system`.** Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and saving clusters can result in cluster reconciliation.** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **The EKS cluster refresh interval setting changed.** There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System components will restart.** Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **New GKE and AKS clusters will use Rancher's new lifecycle management features.** Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **New steps for rolling back Rancher.** The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC differences around Manage Nodes for RKE2 clusters.** Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **New procedure to set up Azure cloud provider for RKE2.** For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs Kube Nodes.** In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook chart no longer supported in v1.22.** In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Requirements for Docker installs.**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Increased memory limit for Legacy Monitoring.** The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Increased memory limit for Monitoring.** The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.3

### Tools
- CLI - [v2.6.0](https://github.com/rancher/cli/releases/tag/v2.6.0)
- RKE - [v1.3.3](https://github.com/rancher/rke/releases/tag/v1.3.3)

### Kubernetes Versions
- v1.22.4 (Experimental)
- v1.21.7 (Default)
- v1.20.13
- v1.19.16
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	We have introduced the ability to provision RKE2 clusters as tech preview. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` for new installs, `true` for upgrades | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring V1

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - Actions that can’t be performed by a cluster member, `Download KubeConfig` and `Take Snapshot`, are being shown as available on RKE1 clusters in a Rancher setup. See [#35828](https://github.com/rancher/rancher/issues/35828).
  - **RKE2 - Tech Preview:** There are several known issues as this feature is in tech preview, but here are some major issues to consider before using RKE2.
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - Windows clusters do not yet support Rancher Apps & Marketplace. See [#34405](https://github.com/rancher/rancher/issues/34405).
    - Windows clusters do not yet support upgrading RKE2 versions. See Windows [#76](https://github.com/rancher/windows/issues/76).
    - Rancher v2.6.3 cannot deploy RKE2 Windows clusters with versions 1.21.6+rke2r1 and below due to system agent updates. Note that RKE2 clusters with v1.21.7rc2 and higher are compatible with Rancher v2.6.3. See [#122](https://github.com/rancher/windows/issues/122).
    - When provisioning using a RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 clusters are not able to be provisioned using the AWS cloud provider in Kubernetes v1.22. Note that RKE2 clusters in v1.21 function as expected. See [#35618](https://github.com/rancher/rancher/issues/35618).
    - Standard users will not be able to create a cluster after clicking the `Edit as YAML` button. They will receive an error even if attempting to then `Edit as a Form`. To work around this issue, start over and create the cluster without clicking the `Edit as YAML` button. See [#35868](https://github.com/rancher/rancher/issues/35868).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - In an HA Rancher server on Kubernetes v1.20, ingresses on AWS EC2 node driver clusters do not go through and result in a `failed calling webhook` error. Please refer to the [workaround](https://github.com/rancher/rancher/issues/35754#issuecomment-995566492) and [#35754](https://github.com/rancher/rancher/issues/35754).
- **Infrastructures:**
  - **vSphere:**
    - The vSphere CSI Driver does not support Kubernetes v1.22 due to unsupported v1beta1 CRD APIs. Support will be added in a later release, but in the meantime users with the `CSIMigrationvSphere` feature enabled should not
    upgrade to Kubernetes v1.22. See [#33848](https://github.com/rancher/rancher/issues/33848).
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring fails to upgrade when CRD is in a failed state. To work around this issue, use Helm to install the `rancher-monitoring` chart into the cluster directly, rather than using the Rancher UI. In order to set nodeSelector or tolerations to the `rancher-monitoring-crd` chart, you need to install the `rancher-monitoring-crd` and `rancher-monitoring` chart by using the Helm command via command line. Rancher UI will add support soon. See [#35744](https://github.com/rancher/rancher/issues/35744).
    - When deploying a cluster on v1.22, the pod `rancher-monitoring-admission-patch` fails and times out, which causes the Monitoring install to fail. To deploy the rancher-monitoring chart successfully in RKE1/RKE2 1.22.x, please see [workaround](https://github.com/rancher/rancher/issues/35571#issuecomment-991140220). See also [#35571](https://github.com/rancher/rancher/issues/35571).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - In Istio v1.10.4, Kubernetes IP service is set to default IP, which does not work for all environments. To work around this issue, install Istio version 100.1.0+up1.11.4 in the downstream cluster, and installation will complete successfully. Note that the new install will not include the Kiali CRD. See [#35339](https://github.com/rancher/rancher/issues/35339).
    - Istio 100.1.0+up1.11.4 no longer installs the Kiali CRD because it was removed from the upstream Helm chart starting in Kiali version 1.36. If you have upgraded from a previous version of rancher-istio installed to 100.1.0+up1.11.4, you will need to manually delete the `rancher-kiali-server-crd` found on the installed apps page, since it is no longer in use after the upgrade completes. See [#35686](https://github.com/rancher/rancher/issues/35686) for more information.
    - A `failed calling webhook "validation.istio.io"` error will occur in air-gapped environments if the `istiod-istio-system` `ValidatingWebhookConfiguration` exists, and you attempt a fresh install of Istio 1.11.x and higher. To work around this issue, run the command `kubectl delete validatingwebhookconfiguration istiod-istio-system` and attempt your install again. See [#35742](https://github.com/rancher/rancher/issues/35742#issuecomment-994801502).
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker installs:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
- **Login to Rancher using ActiveDirectory with TLS:** See [#34325](https://github.com/rancher/rancher/issues/34325).
  - Upon an upgrade to v2.6.0, authenticating via Rancher against an ActiveDirectory server using TLS can fail if the certificates on the AD server do not support SAN attributes. This is a check enabled by default in Golang v1.15.
  - The error received is "Error creating ssl connection: LDAP Result Code 200 "Network Error": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0"
  - To resolve this, the certificates on the AD server should be updated or replaced with new ones that support the SAN attribute. Alternatively this error can be ignored by setting "GODEBUG=x509ignoreCN=0" as an environment variable to Rancher server container.
- **Rancher UI:**
  - After clicking on the header of an expanded navigation group, the navigation group remains unchanged. See [#4368](https://github.com/rancher/dashboard/issues/4368).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> **Warning:** If single-node Docker installation with [persistent data](https://rancher.com/docs/rancher/v2.6/en/installation/other-installation-methods/single-node-docker/advanced/#persistent-data) is used, upgrading to Rancher 2.6.3 wipes all data. Refer [here](https://github.com/rancher/rancher/issues/35955#issuecomment-1000641550) to work around this issue.

# Features and Enhancements

### New Experimental Features

Kubernetes v1.22 is being introduced in Rancher v2.6.3 as an experimental feature. As such, Rancher doesn't support provisioning 1.22 clusters or having Rancher run on 1.22 clusters at this time. Support will become available at a later time.

### New in Harvester

- Harvester v1.0.0 is GA and is only supported by Rancher v2.6.3.
- Harvester v0.3.0 is not supported by Rancher v2.6.3. You must delete your Harvester v0.3.0 cluster from Rancher before upgrading Rancher.
- Virtualization Management
  - Importing a Harvester cluster no longer needs the manual `kubectl` command. Refer [here](https://docs.harvesterhci.io/v1.0/rancher/virtualization-management/) for details.
- RKE1
  - Rancher provisioned RKE1 clusters now support installing Harvester Cloud Provider Chart and CSI Driver Chart.  No more manual configuration is needed.
  - Additional UI enhancement has been added to the RKE1 Load Balancer page to support the Harvester Load Balancer configuration. No more manual annotation is needed.
  - Refer to the [documentation](https://docs.harvesterhci.io/v1.0/rancher/cloud-provider/) for more details. 
- RKE2
  - Rancher provisioned RKE2 clusters will have Harvester Load Balancer and CSI driver installed automatically.
  - Additional UI enhancement has been added to the RKE2 Load Balancer page to support the Harvester Load Balancer configuration.
  - Refer to the [documentation](https://docs.harvesterhci.io/v1.0/rancher/cloud-provider/) for more details. 

### UI Enhancements

- Scaling up or down of a workload is now enabled in the Rancher UI. See [#4328](https://github.com/rancher/dashboard/issues/4328).
- The scale and health status of a workload is now visible in workload view. See [#4329](https://github.com/rancher/dashboard/issues/4329).
- Added ability to pause orchestration for workloads. See [#4331](https://github.com/rancher/dashboard/issues/4331).
- Added dashboards for workload metrics into the Rancher UI. See [#1879](https://github.com/rancher/dashboard/issues/1879).
- Support added to Azure node driver to use images from Apps & Marketplace. See [#33518](https://github.com/rancher/rancher/issues/33518).

### Security Enhancements

- By default, only passwords with at least 12 characters are accepted per new password policy in Rancher. See [#34851](https://github.com/rancher/rancher/pull/34851).
- Starting with v1.22, RKE1 no longer rewrites SELinux labels on container volume mounts. Please see the [security docs](https://rancher.com/docs/rancher/v2.6/en/security/selinux/) for information on how to install the rancher-selinux RPM to ensure SELinux policies are configured. See [#2541](https://github.com/rancher/rke/pull/2541) for reference.

### Other New Features

- Authorized Cluster Endpoint can now be enabled on downstream imported RKE2/K3s clusters. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/cluster-provisioning/registered-clusters/#authorized-cluster-endpoint-support-for-rke2-and-k3s-clusters) and [#35161](https://github.com/rancher/rancher/issues/35161) for details.
- The Rancher Monitoring chart has been upgraded to match the upstream `kube-prometheus-stack` version 19.0.3. See [#34577](https://github.com/rancher/rancher/issues/34577).

# Major Bug Fixes

- Fixed issue in which RKE1 and RKE2 Clusters were becoming stuck in Removing state. See [#35180](https://github.com/rancher/rancher/issues/35180).
- Rancher-related namespaces are now removed after cluster agents are removed on imported provider clusters. See [#34990](https://github.com/rancher/rancher/issues/34990).
- Fixed issue in which cluster failed to communicate with API server after etcd role node is removed. See [#34488](https://github.com/rancher/rancher/issues/34488).
- Downstream clusters behind a proxy are now supported when RKE2 cluster is upgraded. See [#32633](https://github.com/rancher/rancher/issues/32633).
- The API Server has been updated to fix slow consumers causing deadlocks. See [#34906](https://github.com/rancher/rancher/pull/34906).
- When in installed apps under Apps & Marketplace in a cluster, navigating to workloads after selecting namespace works. See [#4428](https://github.com/rancher/dashboard/issues/4428). 
- Installation and upgrade of Istio chart (version 100.1.0+up1.11.4) now works as expected. See [#35686](https://github.com/rancher/rancher/issues/35686).
- Fixed an issue in Istio v1.10.4 where Kubernetes IP service is set to default IP, which did not work for all environments. Users many install Istio version 100.1.0+up1.11.4 in the downstream cluster, and installation will complete successfully (note that the new install will not include the Kiali CRD). See [#35339](https://github.com/rancher/rancher/issues/35339).
 
# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows. 

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:** 
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
  - When using Kubernetes v1.21 with Windows Server 20H2 Standard Core, the patch "2019-08 Servicing Stack Update for Windows Server" must be installed on the node. See [#72](https://github.com/rancher/windows/issues/72).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- **Legacy features are gated behind a feature flag.** Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
- **Users must manually remove legacy services.** When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **Charts from library and helm3-library catalogs can no longer be launched.** Users will no longer be able to launch charts from the library and helm3-library catalogs, which are available through the legacy apps and multi-cluster-apps pages. Any existing legacy app that was deployed from a previous Rancher version will continue to be able to edit its currently deployed chart. Note that the Longhorn app will still be available from the library for new installs but will be removed in the next Rancher version. All users are recommended to deploy Longhorn from the Apps & Marketplace section of the Rancher UI instead of through the Legacy Apps pages.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Users must log in again.** After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet is now always enabled.** For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
- **The Fleet agent in the local cluster now lives in `cattle-fleet-local-system`.** Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and saving clusters can result in cluster reconciliation.** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **The EKS cluster refresh interval setting changed.** There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System components will restart.** Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **New GKE and AKS clusters will use Rancher's new lifecycle management features.** Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **New steps for rolling back Rancher.** The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC differences around Manage Nodes for RKE2 clusters.** Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **New procedure to set up Azure cloud provider for RKE2.** For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs Kube Nodes.** In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Rancher's External IP Webhook chart no longer supported in v1.22.** In v1.22, upstream Kubernetes has enabled the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips) to reject usage of external IPs. As such, the `rancher-external-ip-webhook` chart that was created as a workaround is no longer needed, and support for it is now capped to Kubernetes v1.21 and below. See [#33893](https://github.com/rancher/rancher/issues/33893).
- **Requirements for Docker installs.**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Increased memory limit for Legacy Monitoring.** The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Increased memory limit for Monitoring.** The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.3

### Tools
- CLI - [v2.6.0](https://github.com/rancher/cli/releases/tag/v2.6.0)
- RKE - [v1.3.3](https://github.com/rancher/rke/releases/tag/v1.3.3)

### Kubernetes Versions
- v1.22.4 (Experimental)
- v1.21.7 (Default)
- v1.20.13
- v1.19.16
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Feature flags introduced in 2.6.0 and the Harvester feature flag introduced in 2.6.1 are listed below for reference:

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	We have introduced the ability to provision RKE2 clusters as tech preview. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-matrix/) for questions.

The following legacy features are no longer supported on Kubernetes v1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

The following legacy feature is no longer supported past Kubernetes v1.21+ clusters:

* Monitoring V1 

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - Actions that can’t be performed by a cluster member, `Download KubeConfig` and `Take Snapshot`, are being shown as available on RKE1 clusters in a Rancher setup. See [#35828](https://github.com/rancher/rancher/issues/35828).
  - **RKE2 - Tech Preview:** There are several known issues as this feature is in tech preview, but here are some major issues to consider before using RKE2.
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - Windows clusters do not yet support Rancher Apps & Marketplace. See [#34405](https://github.com/rancher/rancher/issues/34405).
    - Windows clusters do not yet support upgrading RKE2 versions. See Windows [#76](https://github.com/rancher/windows/issues/76).
    - Rancher v2.6.3 cannot deploy RKE2 Windows clusters with versions 1.21.6+rke2r1 and below due to system agent updates. Note that RKE2 clusters with v1.21.7rc2 and higher are compatible with Rancher v2.6.3. See [#122](https://github.com/rancher/windows/issues/122). 
    - When provisioning using a RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#3689](https://github.com/rancher/dashboard/issues/3689).
    - RKE2 clusters are not able to be provisioned using the AWS cloud provider in Kubernetes v1.22. Note that RKE2 clusters in v1.21 function as expected. See [#35618](https://github.com/rancher/rancher/issues/35618).
    - Standard users will not be able to create a cluster after clicking the `Edit as YAML` button. They will receive an error even if attempting to then `Edit as a Form`. To work around this issue, start over and create the cluster without clicking the `Edit as YAML` button. See [#35868](https://github.com/rancher/rancher/issues/35868).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - In an HA Rancher server on Kubernetes v1.20, ingresses on AWS EC2 node driver clusters do not go through and result in a `failed calling webhook` error. Please refer to the [workaround](https://github.com/rancher/rancher/issues/35754#issuecomment-995566492) and [#35754](https://github.com/rancher/rancher/issues/35754).
- **Infrastructures:**
  - **vSphere:**  
    - The vSphere CSI Driver does not support Kubernetes v1.22 due to unsupported v1beta1 CRD APIs. Support will be added in a later release, but in the meantime users with the `CSIMigrationvSphere` feature enabled should not
    upgrade to Kubernetes v1.22. See [#33848](https://github.com/rancher/rancher/issues/33848).
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22 cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://rancher.com/docs/rancher/v2.6/en/backups/migrating-rancher/#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring fails to upgrade when CRD is in a failed state. To work around this issue, use Helm to install the `rancher-monitoring` chart into the cluster directly, rather than using the Rancher UI. In order to set nodeSelector or tolerations to the `rancher-monitoring-crd` chart, you need to install the `rancher-monitoring-crd` and `rancher-monitoring` chart by using the Helm command via command line. Rancher UI will add support soon. See [#35744](https://github.com/rancher/rancher/issues/35744).
    - When deploying a cluster on v1.22, the pod `rancher-monitoring-admission-patch` fails and times out, which causes the Monitoring install to fail. To deploy the rancher-monitoring chart successfully in RKE1/RKE2 1.22.x, please see [workaround](https://github.com/rancher/rancher/issues/35571#issuecomment-991140220). See also [#35571](https://github.com/rancher/rancher/issues/35571).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - A `failed calling webhook "validation.istio.io"` error will occur in air-gapped environments if the `istiod-istio-system` `ValidatingWebhookConfiguration` exists, and you attempt a fresh install of Istio 1.11.x and higher. To work around this issue, run the command `kubectl delete validatingwebhookconfiguration istiod-istio-system` and attempt your install again. See [#35742](https://github.com/rancher/rancher/issues/35742#issuecomment-994801502).
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes v1.21. To work around this issue, disable the `BoundServiceAccountTokenVolume` feature in Kubernetes v1.21 and above. Note that this workaround will be deprecated in Kubernetes v1.22. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring which is compatible with Kubernetes v1.15 clusters. If you are running Kubernetes v1.15 clusters in an air gapped environment, and you want to either install Legacy Monitoring or upgrade Legacy Monitoring to the latest that is offered by Rancher for Kubernetes v1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
    - Legacy Monitoring does not support Kubernetes v1.22 due to the `feature-gates` flag no longer being supported. See [#35574](https://github.com/rancher/rancher/issues/35574).
    - After performing an upgrade to Rancher v2.6.3 from v2.6.2, the Legacy Monitoring custom metric endpoint stops working. To work around this issue, delete the service that is being targeted by the servicemonitor and allow it to be recreated; this will reload the pods that need to be targeted on a service sync. See [#35790](https://github.com/rancher/rancher/issues/35790).
- **Docker installs:** UI issues may occur due to a longer startup time.  
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
- **Login to Rancher using ActiveDirectory with TLS:** See [#34325](https://github.com/rancher/rancher/issues/34325).
  - Upon an upgrade to v2.6.0, authenticating via Rancher against an ActiveDirectory server using TLS can fail if the certificates on the AD server do not support SAN attributes. This is a check enabled by default in Golang v1.15.
  - The error received is "Error creating ssl connection: LDAP Result Code 200 "Network Error": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0"
  - To resolve this, the certificates on the AD server should be updated or replaced with new ones that support the SAN attribute. Alternatively this error can be ignored by setting "GODEBUG=x509ignoreCN=0" as an environment variable to Rancher server container.
- **Rancher UI:**
  - After clicking on the header of an expanded navigation group, the navigation group remains unchanged. See [#4368](https://github.com/rancher/dashboard/issues/4368). 
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192). 
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.6.2 is a mirror release of [v2.6.1](https://github.com/rancher/rancher/releases/tag/v2.6.1) to address three issues:**
- Cluster Dashboard now loads after the Cluster menu item is clicked while on a sub-level view. See #4358.
- Resolved panic seen after deleting imported cluster. See [#35160](https://github.com/rancher/rancher/issues/35160).
- The Istio chart has been updated to resolve a DNS issue when installing with releaseMirror mode enabled. See #30842.

# Features and Enhancements

### Tech Preview - Harvester Integration with Rancher

Rancher 2.6.1 introduces [Harvester v0.3.0](https://docs.harvesterhci.io/v0.3/) as a new integration. This integration only works with Harvester version 0.3.0 or higher. A feature flag, enabled by default, provides access to the integration. When enabled, users can manage Harvester clusters within Rancher. See [#33605](https://github.com/rancher/rancher/issues/33605). 

- Import multiple Harvester clusters for multi-cluster/multi-site management.
- Use Rancher RBAC and enterprise authentication to log into Harvester clusters.
- Use Rancher Projects in Harvester so teams can keep their VMs separate and organized.
- Provision Kubernetes clusters on Harvester. You can use Harvester's built-in CSI driver and load balancer for your Kubernetes workloads (cloud provider). To set up the cloud provider with Harvester, refer [here](https://docs.harvesterhci.io/v0.3-dev/rancher/cloud-provider/#load-balancer-request-parameters). See [#4208](https://github.com/rancher/dashboard/issues/4208).

### Security Enhancements

- RKE and RKE2 include new versions of Kubernetes that address an issue where symlink exchanges could allow host filesystem access. See [CVE-2021-25741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25741).
- Role revisions are properly tracked for ClusterRoles associated to RoleBinding resources. This allows returning up-to-date schemas for users and not evaluating a user's access from stale access states. See [#34732](https://github.com/rancher/rancher/issues/34732).

### Fleet

- Fleet can now manage clusters running other instances of Fleet. This enables Rancher to manage Harvester clusters, other Rancher instances, or stand alone Fleet. Becasue of this change, it is possible two Fleet agents are in a cluster. See [#34716](https://github.com/rancher/rancher/issues/34716).

# Major Bug Fixes

- AKS clusters now display applicable upgrade versions only. See [#34161](https://github.com/rancher/rancher/issues/34161).
- The AKS provisioner now correctly handles simultaneous Kubernetes version upgrades and node pool additions. See [#33426](https://github.com/rancher/rancher/issues/33426).
- Fixed conflict errors for the impersonation cluster role causing requests to occasionally fail with an `unable to create impersonator account: error setting up impersonation for user u-xxxxx` error. See [#34671](https://github.com/rancher/rancher/issues/34671)
- The Istio chart now allows upgrades of Istio in an air gapped environment. Upgrading will be limited to versions available at time of build. See [#30842](https://github.com/rancher/rancher/issues/30842).
- The side navigation no longer shows an incorrect top-level "Istio" menu item after upgrading from Rancher v2.5.x with v1 Istio enabled. See [#4072](https://github.com/rancher/dashboard/issues/4072).
- Resource deletion has been updated to address multiple cases. See [#34761](https://github.com/rancher/rancher/pull/34761).
  - Nodes are correctly removed from the infrastructure provider when the cluster is deleted in Rancher. See [#34542](https://github.com/rancher/rancher/issues/34542).
  - Nodes from a misconfigured node pool no longer remain in the cluster after being deleted. See [#34713](https://github.com/rancher/rancher/issues/34713).
  - The deleted status of clusters are now synchronized across pages in Rancher. See [#33774](https://github.com/rancher/rancher/issues/33774).
- Fixed an issue where Fleet would infinitely create cluster management secrets when no system namespace exists. See [#34776](https://github.com/rancher/rancher/issues/34776).
- Migrating clusters to a different `FleetWorkspace` no longer results in the management cluster being deleted. See [#34744](https://github.com/rancher/rancher/issues/34744).
- The external IP address is now properly retrieved for Windows nodes in a custom RKE2 cluster. See Windows [#91](https://github.com/rancher/windows/issues/91).
- The API Server has been updated to fix slow consumers causing deadlocks. See [#34906](https://github.com/rancher/rancher/pull/34906).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
- The namespace where the local Fleet agent runs has been changed to cattle-fleet-local-system. This change does not impact GitOps workflows. 

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:** 
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
  - When using Kubernetes v1.21 with Windows Server 20H2 Standard Core, the patch "2019-08 Servicing Stack Update for Windows Server" must be installed on the node. See [#72](https://github.com/rancher/windows/issues/72).
- **CNI requirements:**
  - For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. [#33685](https://github.com/rancher/rancher/issues/33685)

### Rancher Behavior Changes

- **Legacy features are gated behind a feature flag.** Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
- **Users must manually remove legacy services.** When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Users must log in again.** After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet is now always enabled.** For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
- **The Fleet agent in the local cluster now lives in `cattle-fleet-local-system`.** Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and saving clusters can result in cluster reconciliation.** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **The EKS cluster refresh interval setting changed.** There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System components will restart.** Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **New GKE and AKS clusters will use Rancher's new lifecycle management features.** Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **New steps for rolling back Rancher.** The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC differences around Manage Nodes for RKE2 clusters.** Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **New procedure to set up Azure cloud provider for RKE2.** For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs Kube Nodes.** In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Requirements for Docker installs.**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Increased memory limit for Legacy Monitoring.** The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Increased memory limit for Monitoring.** The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.1

### Tools
- CLI - [v2.4.13](https://github.com/rancher/cli/releases/tag/v2.4.13)
- RKE - [v1.3.1](https://github.com/rancher/rke/releases/tag/v1.3.1)

### Kubernetes Versions
- v1.21.5
- v1.20.11
- v1.19.15
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0 many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Please review the new Harvester feature flag introduced into 2.6.1 and its default status. Additional feature flags introduced in 2.6.0 are shown also for reference.

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	We have introduced the ability to provision RKE2 clusters as tech preview. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-maintenance-terms/) for questions.

The following legacy features are no longer supported on Kubernetes 1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2 - Tech Preview**: There are several known issues as this feature is in tech preview, but here are some major issues to consider before using RKE2.
    - There are issues around removing etcd nodes from a cluster. See [#34488](https://github.com/rancher/rancher/issues/34488).
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - Proxy behind individual downstream clusters is not working. See [#32633](https://github.com/rancher/rancher/issues/32633).
    - Windows clusters do not yet support Rancher Apps & Marketplace. See [#34405](https://github.com/rancher/rancher/issues/34405).
    - Windows clusters do not yet support upgrading RKE2 versions. See Windows [#76](https://github.com/rancher/windows/issues/76).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561)
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
  - **GKE**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
- **Harvester - Tech Preview:**
  - Harvester v0.3.0 doesn't support air gap environment installation. See [#34908](https://github.com/rancher/rancher/issues/34908).
  - Harvester v0.3.0 doesn't support upgrade from v0.2.0 nor upgrade to future v1.0.0.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the resourceSet rancher-resource-set will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.10.4 will be available with the Rancher Istio Helm chart v100.0.0+up1.10.4. A previous version of Istio, 1.10.2, included a security fix for CVE-2021-34824. See [#32795](https://github.com/rancher/rancher/issues/32795).
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes 1.21. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
- **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).
- **Login to Rancher using ActiveDirectory with TLS:** See [#34325](https://github.com/rancher/rancher/issues/34325).
  - Upon an upgrade to v2.6.0, authenticating via Rancher against an ActiveDirectory server using TLS can fail if the certificates on the AD server do not support SAN attributes. This is a check enabled by default in Golang 1.15.
  - The error received is "Error creating ssl connection: LDAP Result Code 200 "Network Error": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0"
  - To resolve this, the certificates on the AD server should be updated or replaced with new ones that support the SAN attribute. Alternatively this error can be ignored by setting "GODEBUG=x509ignoreCN=0" as an environment variable to Rancher server container.
- **Rancher UI:**
  - When in installed apps under Apps & Marketplace in a cluster, navigating to workloads after selecting namespace does not work. The workaround is to select all namespaces first and then click on workloads. See [#4428](https://github.com/rancher/dashboard/issues/4428). 
  - After clicking on the header of an expanded navigation group, the navigation group remains unchanged. See [#4368](https://github.com/rancher/dashboard/issues/4368).
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Features and Enhancements

### Tech Preview - Harvester Integration with Rancher

Rancher 2.6.1 introduces [Harvester v0.3.0](https://docs.harvesterhci.io/v0.3/) as a new integration. This integration only works with Harvester version 0.3.0 or higher. A feature flag, enabled by default, provides access to the integration. When enabled, users can manage Harvester clusters within Rancher. See [#33605](https://github.com/rancher/rancher/issues/33605). 

- Import multiple Harvester clusters for multi-cluster/multi-site management.
- Use Rancher RBAC and enterprise authentication to log into Harvester clusters.
- Use Rancher Projects in Harvester so teams can keep their VMs separate and organized.
- Provision Kubernetes clusters on Harvester. You can use Harvester's built-in CSI driver and load balancer for your Kubernetes workloads (cloud provider). To set up the cloud provider with Harvester, refer [here](https://docs.harvesterhci.io/v0.3-dev/rancher/cloud-provider/#load-balancer-request-parameters). See [#4208](https://github.com/rancher/dashboard/issues/4208).

### Security Enhancements

- RKE and RKE2 include new versions of Kubernetes that address an issue where symlink exchanges could allow host filesystem access. See [CVE-2021-25741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25741).
- Role revisions are properly tracked for ClusterRoles associated to RoleBinding resources. This allows returning up-to-date schemas for users and not evaluating a user's access from stale access states. See [#34732](https://github.com/rancher/rancher/issues/34732).

### Fleet

- Fleet can now manage clusters running other instances of Fleet. This enables Rancher to manage Harvester clusters, other Rancher instances, or stand alone Fleet. Becasue of this change, it is possible two Fleet agents are in a cluster. See [#34716](https://github.com/rancher/rancher/issues/34716).

# Major Bug Fixes

- AKS clusters now display applicable upgrade versions only. See [#34161](https://github.com/rancher/rancher/issues/34161).
- The AKS provisioner now correctly handles simultaneous Kubernetes version upgrades and node pool additions. See [#33426](https://github.com/rancher/rancher/issues/33426).
- Fixed conflict errors for the impersonation cluster role causing requests to occasionally fail with an `unable to create impersonator account: error setting up impersonation for user u-xxxxx` error. See [#34671](https://github.com/rancher/rancher/issues/34671)
- The Istio chart now allows upgrades of Istio in an air gapped environment. Upgrading will be limited to versions available at time of build. See [#30842](https://github.com/rancher/rancher/issues/30842).
- The side navigation no longer shows an incorrect top-level "Istio" menu item after upgrading from Rancher v2.5.x with v1 Istio enabled. See [#4072](https://github.com/rancher/dashboard/issues/4072).
- Resource deletion has been updated to address multiple cases. See [#34761](https://github.com/rancher/rancher/pull/34761).
  - Nodes are correctly removed from the infrastructure provider when the cluster is deleted in Rancher. See [#34542](https://github.com/rancher/rancher/issues/34542).
  - Nodes from a misconfigured node pool no longer remain in the cluster after being deleted. See [#34713](https://github.com/rancher/rancher/issues/34713).
  - The deleted status of clusters are now synchronized across pages in Rancher. See [#33774](https://github.com/rancher/rancher/issues/33774).
- Fixed an issue where Fleet would infinitely create cluster management secrets when no system namespace exists. See [#34776](https://github.com/rancher/rancher/issues/34776).
- Migrating clusters to a different `FleetWorkspace` no longer results in the management cluster being deleted. See [#34744](https://github.com/rancher/rancher/issues/34744).
- The external IP address is now properly retrieved for Windows nodes in a custom RKE2 cluster. See Windows [#91](https://github.com/rancher/windows/issues/91).
- The API Server has been updated to fix slow consumers causing deadlocks. See [#34906](https://github.com/rancher/rancher/pull/34906).
- New ports can now be added in the Rancher 2.6 UI to a Deployment that was created initially without any ports using the legacy UI. See [#4159](https://github.com/rancher/dashboard/issues/4159).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
- The namespace where the local Fleet agent runs has been changed to cattle-fleet-local-system. This change does not impact GitOps workflows. 

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:** 
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
  - When using Kubernetes v1.21 with Windows Server 20H2 Standard Core, the patch "2019-08 Servicing Stack Update for Windows Server" must be installed on the node. See [#72](https://github.com/rancher/windows/issues/72).
- **CNI requirements:**
  - For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. [#33685](https://github.com/rancher/rancher/issues/33685)

### Rancher Behavior Changes

- **Legacy features are gated behind a feature flag.** Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
- **Users must manually remove legacy services.** When workloads created using the legacy UI are deleted, the corresponding services are not automatically deleted. Users will need to manually remove these services. A message will be displayed notifying the user to manually delete the associated services when such a workload is deleted.  See [#34639](https://github.com/rancher/rancher/issues/34639).
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Users must log in again.** After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet is now always enabled.** For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
- **The Fleet agent in the local cluster now lives in `cattle-fleet-local-system`.** Starting with Rancher v2.6.1, Fleet allows for two agents in the local cluster for scenarios where "Fleet is managing Fleet". The _true_ local agent runs in the new `cattle-fleet-local-system` namespace. The agent downstream from another Fleet management cluster runs in `cattle-fleet-system`, similar to the agent _pure_ downstream clusters. See [#34716](https://github.com/rancher/rancher/issues/34716) and [#531](https://github.com/rancher/fleet/issues/531).
- **Editing and saving clusters can result in cluster reconciliation.** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **The EKS cluster refresh interval setting changed.** There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System components will restart.** Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **New GKE and AKS clusters will use Rancher's new lifecycle management features.** Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **New steps for rolling back Rancher.** The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC differences around Manage Nodes for RKE2 clusters.** Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **New procedure to set up Azure cloud provider for RKE2.** For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation]({{<baseurl>}}//rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
- **Machines vs Kube Nodes.** In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Requirements for Docker installs.**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Increased memory limit for Legacy Monitoring.** The default value of the Prometheus memory limit in the legacy Rancher UI is now 2000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).
- **Increased memory limit for Monitoring.** The default value of the Prometheus memory limit in the new Rancher UI is now 3000Mi to prevent the pod from restarting due to a OOMKill. See [#34850](https://github.com/rancher/rancher/issues/34850).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.1

### Tools
- CLI - [v2.4.13](https://github.com/rancher/cli/releases/tag/v2.4.13)
- RKE - [v1.3.1](https://github.com/rancher/rke/releases/tag/v1.3.1)

### Kubernetes Versions
- v1.21.5
- v1.20.11
- v1.19.15
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0 many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Please review the new Harvester feature flag introduced into 2.6.1 and its default status. Additional feature flags introduced in 2.6.0 are shown also for reference.

Feature Flag | Default Value | Description
---|---|---
`harvester` | `true` | Used to manage access to the Harvester list page where users can navigate directly to Harvester host clusters and have the ability to import them.
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	We have introduced the ability to provision RKE2 clusters as tech preview. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-maintenance-terms/) for questions.

The following legacy features are no longer supported on Kubernetes 1.21+ clusters:

* Logging
* CIS Scans
* Istio 1.5
* Pipelines

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2 - Tech Preview**: There are several known issues as this feature is in tech preview, but here are some major issues to consider before using RKE2.
    - There are issues around removing etcd nodes from a cluster. See [#34488](https://github.com/rancher/rancher/issues/34488).
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - Proxy behind individual downstream clusters is not working. See [#32633](https://github.com/rancher/rancher/issues/32633).
    - Windows clusters do not yet support Rancher Apps & Marketplace. See [#34405](https://github.com/rancher/rancher/issues/34405).
    - Windows clusters do not yet support upgrading RKE2 versions. See Windows [#76](https://github.com/rancher/windows/issues/76).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561)
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
  - **GKE**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
- **Harvester - Tech Preview:**
  - Harvester v0.3.0 doesn't support air gap environment installation. See [#34908](https://github.com/rancher/rancher/issues/34908).
  - Harvester v0.3.0 doesn't support upgrade from v0.2.0 nor upgrade to future v1.0.0.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the resourceSet rancher-resource-set will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.10.4 will be available with the Rancher Istio Helm chart v100.0.0+up1.10.4. A previous version of Istio, 1.10.2, included a security fix for CVE-2021-34824. See [#32795](https://github.com/rancher/rancher/issues/32795).
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes 1.21. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
- **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).
- **Login to Rancher using ActiveDirectory with TLS:** See [#34325](https://github.com/rancher/rancher/issues/34325).
  - Upon an upgrade to v2.6.0, authenticating via Rancher against an ActiveDirectory server using TLS can fail if the certificates on the AD server do not support SAN attributes. This is a check enabled by default in Golang 1.15.
  - The error received is "Error creating ssl connection: LDAP Result Code 200 "Network Error": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0"
  - To resolve this, the certificates on the AD server should be updated or replaced with new ones that support the SAN attribute. Alternatively this error can be ignored by setting "GODEBUG=x509ignoreCN=0" as an environment variable to Rancher server container.
- **Rancher UI:** 
  - After clicking on the header of an expanded navigation group, the navigation group remains unchanged. See [#4368](https://github.com/rancher/dashboard/issues/4368).  
  - Clicking on a menu item has no effect while user is on a sub-level view. See [#4358](https://github.com/rancher/dashboard/issues/4358).
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.6

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Features and Enhancements

### Redesigned Rancher User Experience

Rancher 2.6 has a new refreshed look and feel in the UI making it easy to use for beginner and advanced Kubernetes users.  

- **New cluster explorer navigation**: The Rancher UI view for a Kubernetes cluster has been enhanced for both new and advanced users. Users now see a collapsed subset of the most-used Kubernetes resources expressed in simple terms. All Kubernetes resources can be managed through the explorer and quickly found through the resource search functionality. Cluster admins can now administer projects from the cluster detail view. Cluster tools like logging and monitoring are now aggregated under a new easy-to-discover **Cluster Tools.** The cluster detail page is now enhanced with cluster and pod live metrics dashboards when monitoring is deployed through the Cluster Tools. See [#2578](https://github.com/rancher/dashboard/issues/2578)
- **New home page**: The default landing page provides a quick overview of the Rancher installation. Users can see what is new in the current release, find support, quickly launch into a cluster, or provision their first cluster. See [#2511](https://github.com/rancher/dashboard/issues/2511).
- **New global navigation**: The primary navigation menu has been redesigned and simplified to make it easier for users and admins to quickly switch between clusters and top-level apps. See [#2499](https://github.com/rancher/dashboard/issues/2499).
- **New cluster manager navigation**: The new cluster management page lists all of a user's clusters and has been enhanced with a new left-hand navigation menu to manage clusters, credentials, pod security policy templates and node drivers from a single place. See [#2849](https://github.com/rancher/dashboard/issues/2849).

Because the Cluster Manager and Cluster Explorer from Rancher v2.5 have been consolidated into a unified experience, those terms have been replaced in these release notes with "the global view" and "the cluster detail page."

### Enhanced Branding and Customization Options

A new brand management page has been added to allow customizations to the Rancher UI in a single place:

- Admins can now customize the logo image, display name, and primary color displayed throughout the Rancher UI.
- Admins can specify a link to direct users to a custom support page.
- Admins can disable displaying Rancher community support links on the new home page.
- Cluster navigation customizations:
  - Users can now add top-level links in the left navigation of the cluster detail page.
  - Users can create groups of links that point to external and services within the cluster.

For details, see the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/branding/) and [#2835](https://github.com/rancher/dashboard/issues/2835).

### Enhancements for Hosted Kubernetes Clusters

- **AKS provisioning enhancements:** AKS provisioning has been enhanced to support the full lifecycle management of the cluster. Users can now provision private AKS endpoints, multiple node pools, and leverage Rancher cloud credentials for authentication. Existing AKS clusters provisioned with other tools like the Azure Portal can now be registered into Rancher to allow management of Kubernetes upgrades and configuration going forward. Node pools can be configured with AKS to automatically enable autoscaling. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/cluster-admin/editing-clusters/aks-config-reference/#changes-in-rancher-v2-6).
  - **Note for AKS Clusters with RBAC Disabled:** It is possible to create an AKS cluster in the Azure portal that has RBAC disabled. Since Rancher relies heavily on RBAC, a warning message is displayed when registering and viewing an AKS cluster in Rancher that has RBAC disabled. See [#27670](https://github.com/rancher/rancher/issues/27670).
- **GKE provisioning enhancements:** GKE provisioning builds on the updates in Rancher 2.5 that support full lifecycle management of GKE clusters. The GKE enhancements allow users to leverage shared VPCs and multiple node pools within Google Cloud Platform. GKE node pools can be also be configured to support the native autoscaling capabilities.
  - **Ability to support network tags:** When provisioning node pools in GKE clusters, users can add [network tags](https://cloud.google.com/vpc/docs/add-remove-network-tags) to make firewall rules and routes between subnets.
  - **Ability to support Project Network Isolation for registered GKE clusters**: Admins and project owners can now leverage project network isolation to restrict network access between projects on imported/registered GKE clusters.
- **Deploying on hardened clusters:** Support has been added for deploying EKS, AKS, and GKE clusters when the Rancher Management server cluster has been CIS hardened. See [#29066](https://github.com/rancher/rancher/issues/29066).

### Security Enhancements

- **Username and Identity Provider (IdP) name added to Rancher and Kubernetes audit logs**: Admins can now view Rancher usernames and IdP (e.g., Active Directory and Github) usernames in the Kubernetes audit logs and the Rancher API audit logs, when interacting with the cluster through Rancher UI. Downstream cluster admins no longer have to map the u-********* name back to a user in the Rancher local cluster manually. This allows admins to track a user's activity by using the IDP username throughout the system including login and failed login attempts. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/troubleshooting/userid-tracking-in-audit-logs/) and [#31166](https://github.com/rancher/rancher/issues/31166)
- **Rancher server container based on SLE BCI image**: The base image for Rancher server has been moved to SLE BCI. See [#33127](https://github.com/rancher/rancher/issues/33127).
- **Rancher API token hashing**: A new opt-in feature flag has been added to enable one-way hashing of Rancher tokens. Enabling this flag is one-way and non-reversible and should be vetted in dev/test environments before enabling in production. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/api/api-tokens) and issues [#31214](https://github.com/rancher/rancher/issues/31214) and [#25723](https://github.com/rancher/rancher/pull/25723).
- **Randomly generated bootstrap password**: A random bootstrap password is always generated for the user when Rancher is started for the first time, unless the users sets `bootstrapPassword` in the Helm chart values or `CATTLE_BOOTSTRAP_PASSWORD` on the Docker container. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/bootstrap-password) and [#121](https://github.com/rancher/rancher/pull/32749).
- **Sanitized audit log data:** Audit logs level 2+ no longer output sensitive data (Passwords) in plain text. See [#33338](https://github.com/rancher/rancher/pull/33338).
- **Restricted admin permissions:** Permissions for a user with a "Restricted Admin" role have been fixed so that the user is able to perform the following operations, even though they have restricted access to the local cluster:
  - Deploy AKS/GKE/EKS clusters

### Tech Preview - RKE2 Cluster Provisioning

Rancher 2.6 introduces a new provisioning framework built on top of Cluster API for provisioning RKE2 clusters from the Rancher UI/API.

- **Out of the box node driver support**: RKE2 provisioning can create VMs on the major cloud providers leveraging cloud credentials. New in RKE2 provisioning with Rancher node drivers is the ability to SSH into the node directly from the Rancher UI. See [#32516](https://github.com/rancher/rancher/issues/32516). 
  - AWS. See [#32367](https://github.com/rancher/rancher/issues/32367).
  - Azure. See [#32368](https://github.com/rancher/rancher/issues/32368).
  - vSphere. See [#32370](https://github.com/rancher/rancher/issues/32370).
  - Digital Ocean. See [#32366](https://github.com/rancher/rancher/issues/32366).
  - Linode. See [#32371](https://github.com/rancher/rancher/issues/32371).
- **Additional CNI options**: RKE2 brings with it new supported CNI options. Rancher's project network isolation feature can be used with CNIs that support Kubernetes network policies. See [#32378](https://github.com/rancher/rancher/issues/32378).
  - Calico support. See [#32380](https://github.com/rancher/rancher/issues/32380).
  - Cilium support. See [#32381](https://github.com/rancher/rancher/issues/32381).
  - Multus support. See [#32382](https://github.com/rancher/rancher/issues/32382).
  - Canal support. See [#32379](https://github.com/rancher/rancher/issues/32379).
- **Support for Authorized Cluster Endpoint**: Cluster admins can configure Rancher's Authorized Cluster Endpoint locally in RKE2 clusters to allow direct access to the cluster without passing through the Rancher Management server proxy. See [#32388](https://github.com/rancher/rancher/issues/32388).


### Tech Preview - RKE2 Windows Node support

- **RKE2 Cluster provisioning supports Windows nodes:** Users can now provision custom RKE2 clusters with Windows nodes using a single command on pre-provisioned VMs or bare metal nodes. See [#1240](https://github.com/rancher/rke2/issues/1240).
- **Calico CNI support for Windows nodes:** Windows nodes support Calico CNI as the default network plugin. See [#49](https://github.com/rancher/windows/issues/49) and [#1529](https://github.com/rancher/rke2/issues/1529).
- **Known Issues:**:
  - Air gap support is not currently supported for Windows Containers on Rancher on RKE2.
  - Setting an external IP is currently not an option for Windows Containers.
- **Documentation for RKE2 Windows Cluster Provisioning:**
  - [Windows RKE2 Quickstart Guide](https://docs.rke2.io/install/quickstart/#windows-agent-worker-node-installation)
  - [Experimental RKE2 Windows Airgap Support](https://docs.rke2.io/install/windows_airgap/)
  - [Windows Agent Configuration Reference](https://docs.rke2.io/install/install_options/windows_agent_config/). See [#1276](https://github.com/rancher/rke2/issues/1276).
  - [Windows Uninstall Script for RKE2](https://docs.rke2.io/install/windows_uninstall/). See [#1487](https://github.com/rancher/rke2/issues/1487).

### Tech Preview - Cluster Templates and Example RKE2 Cluster Template

Cluster templates allow an admin to define a base cluster configuration for users to consume when provisioning clusters. Cluster templates in the new provisioning framework are built as Helm charts and added to Rancher through the catalog.

Unlike RKE templates, which are for enforcing Kubernetes configuration, cluster templates include more of the cluster definition options and do not affect the cluster after it is initially provisioned. Cluster templates can define node pools, cloud credentials, cluster members, and installation of Rancher tools like monitoring. We provide an example cluster template for RKE2 that can be used to provision a Kubernetes cluster with the following constraints:

  - Multiple node pools for etcd/control plane and workers
  - An admin provided cloud credential
  - Allow users to enable the authorized cluster endpoint and specify cluster configuration options
  - Install Rancher V2 Monitoring
  - Assign cluster members

We provide an example cluster template for an RKE2 cluster [here.](https://github.com/rancher/cluster-template-examples#rke2-cluster-template) To customize the template, you will need to fork the repository, add the Helm chart to a Rancher catalog, and install the template through the catalog. Rancher then provisions the Kubernetes cluster, and the cluster can be managed through Rancher in the same way as any other Rancher-launched Kubernetes cluster.

See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/cluster-templates) and [#30099](https://github.com/rancher/rancher/issues/30099).

More cluster template examples will be added to the [cluster template repository](https://github.com/rancher/cluster-template-examples) in the future.

## Enhancements for RKE Clusters

- **Added RKE External Dockershim Support**: As of Kubernetes 1.20, the in-tree Dockershim was deprecated and is scheduled for removal in Kubernetes 1.22. The Dockershim is the CRI compliant layer between the Kubelet and the Docker daemon. RKE clusters now support the external Dockershim to continue leveraging Docker as the CRI runtime. We now implement the upstream open source community Dockershim announced by Mirantis and Docker to ensure RKE clusters can continue to leverage Docker. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/) and [#31943](https://github.com/rancher/rancher/issues/31943).
- **Added Kubernetes 1.21**: We've added support for Kubernetes 1.21 clusters for RKE.
- **NGINX Ingress default backend no longer a separate deployment**: The default backend for the NGINX Ingress controller is now self-contained. Previously, the default backend was deployed as a pod and service. See [#30356](https://github.com/rancher/rancher/issues/30356).
- **Windows RKE Prefix Path Support:** Add support for Windows RKE prefix path with the ability to parse multiple styles of paths and separators. See [#32268](https://github.com/rancher/rancher/issues/32268).
- **Dual-stack Support:** Starting with Kubernetes v1.21, it is possible to configure dual-stack clusters in combination with the Calico network provider. See [#33107](https://github.com/rancher/rancher/issues/33107).
- **hostPort for NGINX Ingress:** The NGINX Ingress Controller version deployed with Kubernetes v1.21 and higher will be configured using hostPort instead of using hostNetwork. The NGINX Ingress Controller runs a validating admission webhook server which would be exposed externally when using hostNetwork. To avoid exposing it externally, the NGINX Ingress Controller runs in hostPort for port 80 and port 443, and the validating admission webhook server uses a ClusterIP which is only reachable from inside the cluster. See [#33792](https://github.com/rancher/rancher/issues/33792).
- **ECR repository private registry configuration support**: Added support to configure ECR repository as a private registry. See [#28693](https://github.com/rancher/rancher/issues/28693).

### Rancher Logging Enhancements

- Added support for configuring `fluentd` and `fluent-bit` buffer sizes. See [#28401](https://github.com/rancher/rancher/issues/28401).
- Added support for more `fluentd` options: `bufferStorageVolume`, `nodeSelector`, `tolerations` (specific to `fluentd`), and `replicas`. See [#31807](https://github.com/rancher/rancher/issues/31807).
- Added support for Windows RKE prefix path with the ability to handle multiple kinds of pathing styles and separators. See [#32268](https://github.com/rancher/rancher/issues/32268).
- K3s logs are now aggregated through journald and are more refined. See [#32993](https://github.com/rancher/rancher/issues/32993).
- The number of fluentd replicas is now configurable. See [#33373](https://github.com/rancher/rancher/issues/33373).
- Upgraded the Banzai logging operator to version 3.10.0. See [#32748](https://github.com/rancher/rancher/issues/32748).
- Added timestamps to RKE2 control plane logs. See [#32917](https://github.com/rancher/rancher/issues/32917).

### Continuous Delivery Enhancements

- **Extended support for Fleet values:** Add `valuesFrom` feature for `ConfigMaps` and `Secrets` to provide `values.yaml` for Fleet. See [#384](https://github.com/rancher/fleet/issues/384).
- **Ability to support bundle dependencies:** Support bundle dependency. See [#392](https://github.com/rancher/fleet/issues/392).
- **Updated namespaces to avoid potential Fleet naming conflicts:** Move Fleet to `cattle-fleet-system` from `fleet-system` to avoid collisions with other apps named `fleet`. See [#395](https://github.com/rancher/fleet/issues/395).
- **New Fleet GitOps feature flag:** Rancher v2.6's new cluster provisioning system leverages Fleet's bundle deployment capabilities in order to manage clusters at scale. Therefore, in Rancher v2.6, Fleet can no longer be disabled. If Fleet was disabled in Rancher v2.5.x, it will become enabled if Rancher is upgraded to v2.6.x. A new feature flag was added to Rancher to disable the GitOps CD portion for end users within Rancher. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/feature-flags/continuous-delivery), [#32688](https://github.com/rancher/rancher/issues/32688) and [#32808](https://github.com/rancher/rancher/issues/32808).
- **Miscellaneous fixes for Provisioning V2:** various edge cases were mitigated and performance inconsistencies were fixed in preparation for Provisioning V2.

### Other Enhancements

- **Support for Keycloak with OIDC**: A new Keycloak auth provider has been added to support OIDC. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/authentication/keycloak-oidc/) and [#30280](https://github.com/rancher/rancher/issues/30280).
- **Catalog performance enhancement:** Catalogs will be greatly reduced in size, depending on their contents. See [#32938](https://github.com/rancher/rancher/issues/32938).

# Major Bug Fixes

- Fix workload environment variables interpolation order by deprecating our custom `environment` and `environmentFrom` types in favor of Kubernetes `env` and `envFrom` native types. See [#16148](https://github.com/rancher/rancher/issues/16148).
- EKS, AKS, and GKE provisioners now correctly use any additional CAs passed to Rancher, if provided. See [#31846](https://github.com/rancher/rancher/issues/31846).
- The GKE cluster provisioner now handles differences in supported Kubernetes versions across regions. See [#33524](https://github.com/rancher/rancher/issues/33524).
- The GKE cluster provisioner was updated to handle changes to how the provider configures public and private clusters. See [#33241](https://github.com/rancher/rancher/issues/33241).
- The EKS cluster provisioner now correctly adds labels to clusters without causing the cluster to be in a perpetual updating state. See [#33302](https://github.com/rancher/rancher/issues/33302).
- Global DNS app gets uninstalled/removed immediately after install due to OwnerReferences cleanup enforced in Kubernetes v1.20. Instead of relying on the ownerReference for deletion of the app after GlobalDNSProvider is removed, fix is added to handle the delete event in the controller to remove the app. See [#31638](https://github.com/rancher/rancher/issues/31638).
- Project Network Isolation ingress NetworkPolicy resources now get configured correctly when using Calico CNI with IPIP or VXLAN routing. See [#33979](https://github.com/rancher/rancher/issues/33979).
- The Multi-cluster management feature flag can now only be disabled when starting Rancher. Previously, disabling the flag through the UI would result in a `404 page not found` error. See [#32721](https://github.com/rancher/rancher/issues/32721).
- Users can now use the `answersSetString` field to ensure values are passed as a string as expected by the app being configured. See [#26088](https://github.com/rancher/rancher/issues/26088).
- The health status of the Controller Mananger and Scheduler on the dashboard will show as `Not Applicable` on clusters where the componentstatus is not available. See [#11496](https://github.com/rancher/rancher/issues/11496).
- Custom encryption configuration is no longer required to be case sensitive. See [#31385](https://github.com/rancher/rancher/issues/31385)
- The `rancher.cattle.io` MutatingWebhookConfiguration object is now deleted when Rancher is uninstalled, which would otherwise cause failures reinstalling Rancher on the same cluster. See [#33988](https://github.com/rancher/rancher/issues/33988)

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:** The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.18+ before installing Rancher 2.6+.
- **CNI requirements:**
  - For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. See [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. [#33685](https://github.com/rancher/rancher/issues/33685)

### Rancher Behavior Changes

- **Legacy features are gated behind a feature flag.** Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to enable the flag on install or through the UI.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.6/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see [the documentation.](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster)
- **Users must log in again.** After upgrading to `v2.6+`, users will be automatically logged out of the old Rancher UI and must log in again to access Rancher and the new UI. See [#34004](https://github.com/rancher/rancher/issues/34004).
- **Fleet is now always enabled.** For users upgrading from `v2.5.x` to `v2.6.x`, note that Fleet will be enabled by default as it is required for operation in `v2.6+`. This will occur even if Fleet was disabled in `v2.5.x`. During the upgrade process, users will observe restarts of the `rancher` pods, which is expected. See [#31044](https://github.com/rancher/rancher/issues/31044) and [#32688](https://github.com/rancher/rancher/issues/32688).
- **Editing and saving clusters can result in cluster reconciliation.** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **The EKS cluster refresh interval setting changed.** There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **System components will restart.** Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
- **New GKE and AKS clusters will use Rancher's new lifecycle management features.** Existing GKE and AKS clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
- **New steps for rolling back Rancher.** The process to roll back Rancher has been updated for versions v2.5.0 and above. New steps require scaling Rancher down to 0 replica before restoring the backup. Please refer to the [documentation](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/rollbacks/) for the new instructions.
- **RBAC differences around Manage Nodes for RKE2 clusters** Due to the change of the provisioning framework, the `Manage Nodes` role will no longer be able to scale up/down machine pools. The user would need the ability to edit the cluster to manage the machine pools [#34474](https://github.com/rancher/rancher/issues/34474).
- **Machines vs Kube Nodes.** In previous versions, Rancher only displayed Nodes, but with v2.6, there are the concepts of `machines` and `kube nodes`. Kube nodes are the Kubernetes node objects and are only accessible if the Kubernetes API server is running and the cluster is active. Machines are the cluster's machine object which defines what the cluster *should* be running.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.6/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.6.0

### Tools
- CLI - [v2.4.12](https://github.com/rancher/cli/releases/tag/v2.4.12)
- RKE - [v1.3.0](https://github.com/rancher/rke/releases/tag/v1.3.0)

### Kubernetes Versions
- v1.21.x (Default)
- v1.20.10
- v1.19.14
- v1.18.20

### Rancher Helm Chart Versions

Starting in 2.6.0 many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Feature Flags
Please review the new feature flags introduced into 2.6.0 and their default status.

Feature Flag | Default Value | Description
---|---|---
`fleet`| `true` | The previous `fleet` feature flag is now required to be enabled as the fleet capabilities are leveraged within the new provisioning framework. If you had this feature flag disabled in earlier versions, upon upgrading to Rancher, the flag will automatically be enabled.
`gitops` | `true` | If you want to hide the "Continuous Delivery" feature from your users, then please use the newly introduced `gitops` feature flag, which hides the ability to leverage Continuous Delivery.
`rke2` | `true` | 	We have introduced the ability to provision RKE2 clusters as tech preview. By default, this feature flag is enabled, which allows users to attempt to provision these type of clusters.
`legacy` | `false` for new installs, `true` for upgrades | There are a set of features from previous versions that are slowly being phased out of Rancher for newer iterations of the feature. This is a mix of deprecated features as well as features that will eventually be moved to newer variations in Rancher. By default, this feature flag is disabled for new installations. If you are upgrading from a previous version, this feature flag would be enabled.
`token-hashing` | `false` | Used to enable new token-hashing feature. Once enabled, existing tokens will be hashed and all new tokens will be hashed automatically using the SHA256 algorithm. Once a token is hashed it cannot be undone. Once this feature flag is enabled it cannot be disabled.

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Legacy Features

Legacy features are features hidden behind the `legacy` feature flag, which are various features/functionality of Rancher that was available in previous releases. These are features that Rancher doesn't intend for new users to consume, but if you have been using past versions of Rancher, you'll still want to use this functionality.

When you first start 2.6, there is a card in the Home page that outlines the location of where these features are now located.

The deprecated features from v2.5 are now behind the `legacy` feature flag. Please review our [deprecation policy](https://rancher.com/support-maintenance-terms/) for questions.

The following legacy features are no longer supported on Kubernetes 1.21+ clusters:

* Logging (Legacy)
* CIS Scans (Legacy)
* Istio 1.5
* Pipelines

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2 - Tech Preview**: There are several known issues as this feature is in tech preview, but here are some major issues to consider before using RKE2.
    - Sometimes the nodes may not be cleaned up in the infrastructure provider when deleting clusters or nodes. Please be sure to review the actual nodes after cleaning up a cluster. See [#34542](https://github.com/rancher/rancher/issues/34542).
    - There are issues around removing etcd nodes from a cluster. See [#34488](https://github.com/rancher/rancher/issues/34488).
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - Proxy behind individual downstream clusters is not working. See [#32633](https://github.com/rancher/rancher/issues/32633).
    - Cloud providers are not working for Azure clusters. See [#34367](https://github.com/rancher/rancher/issues/34367).
    - Windows Container support on Windows Server Standard Edition requires the 09-2021 cumulative update from Microsoft. Windows Server Datacenter Edition is unaffected. See [#72](https://github.com/rancher/windows/issues/72).
    - Windows clusters do not yet support Rancher Apps & Marketplace. See [#34405](https://github.com/rancher/rancher/issues/34405).
    - Windows clusters do not yet support upgrading RKE2 versions. See Windows [#76](https://github.com/rancher/windows/issues/76).
  - **AKS:**
    - When upgrading the Kubernetes version in an AKS cluster, do not add a node pool at the same time. These actions must be done separately. See [#33426](https://github.com/rancher/rancher/issues/33426).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561)
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - When upgrading an AKS cluster Kubernetes minor versions cannot be skipped. All upgrades must be performed sequentially by major version number. See [#34161](https://github.com/rancher/rancher/issues/34161)
  - **GKE**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the resourceSet rancher-resource-set will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.10.4 will be available with the Rancher Istio Helm chart v100.0.0+up1.10.4. A previous version of Istio, 1.10.2, included a security fix for CVE-2021-34824. See [#32795](https://github.com/rancher/rancher/issues/32795).
    - Istio 1.9 support ends on August 18th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
    - The Kiali dashboard bundled with 100.0.0+up1.10.2 errors on a page refresh. Instead of refreshing the page when needed, simply access Kiali using the dashboard link again. Everything else works in Kiali as expected, including the graph auto-fresh. See [#33739](https://github.com/rancher/rancher/issues/33739).
    - When v1 Istio is installed in a cluster, the side navigation will incorrectly show a top-level 'Istio' menu item. This should be ignored for v1 Istio and users should instead use the Istio functionality under the 'Legacy' top-level menu item (this requires the legacy feature flag to be enabled). See [#4072](https://github.com/rancher/dashboard/issues/4072).
  - **Legacy Monitoring:**
    - The Grafana instance inside Cluster Manager's Monitoring is not compatible with Kubernetes 1.21. See [#33465](https://github.com/rancher/rancher/issues/33465).
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
    - When deploying any downstream cluster, Rancher logs errors that seem to be related to Monitoring even when Monitoring is not installed onto either cluster; specifically, Rancher logs that it `failed on subscribe` to the Prometheus CRs in the cluster because it is unable to get the resource `prometheus.meta.k8s.io`. These logs appear in a similar fashion for other Prometheus CRs (namely Alertmanager, ServiceMonitors, and PrometheusRules), but do not seem to cause any other major impact in functionality. See [#32978](https://github.com/rancher/rancher/issues/32978).
- **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).
- **Login to Rancher using ActiveDirectory with TLS:** See [#34325](https://github.com/rancher/rancher/issues/34325).
  - Upon an upgrade to v2.6.0, authenticating via Rancher against an ActiveDirectory server using TLS can fail if the certificates on the AD server do not support SAN attributes. This is a check enabled by default in Golang 1.15.
  - The error received is "Error creating ssl connection: LDAP Result Code 200 "Network Error": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0"
  - To resolve this, the certificates on the AD server should be updated or replaced with new ones that support the SAN attribute. Alternatively this error can be ignored by setting "GODEBUG=x509ignoreCN=0" as an environment variable to Rancher server container.
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a port to a Deployment that was created initially without any ports using the legacy UI, users may encounter a `services <NAME> already exists` error. To work around this issue, the legacy UI should be used to make updates to the configuration of Deployments created using the legacy UI. See [#4159](https://github.com/rancher/dashboard/issues/4159).
- **Rancher UI:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
-----
