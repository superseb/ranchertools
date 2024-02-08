| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.6.14](rancher-v2.6.md#release-v2614) | Feb 08 2024 | 02/08/24 | 2024-02-08 |
| [v2.6.13](rancher-v2.6.md#release-v2613) | May 31 2023 | 05/31/23 | 2023-05-31 |
| [v2.6.12](rancher-v2.6.md#release-v2612) | Apr 27 2023 | 04/27/23 | 2023-04-27 |
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



# Release v2.6.14

> It's important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

Rancher v2.6.14 is a security release based on v2.6.13 that addresses the security issues below. For specific information detailing v2.6.13, please consult its [release note](https://github.com/rancher/rancher/releases/tag/v2.6.13).

# Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Fixed an issue where the [Rancher Audit Log](https://ranchermanager.docs.rancher.com/how-to-guides/advanced-user-guides/enable-api-audit-log) was leaking sensitive data. For more information, see [CVE-2023-22649](https://github.com/rancher/rancher/security/advisories/GHSA-xfj7-qf8w-2gcr).
- Updated the versions of Norman and API Server to address CVEs [CVE-2023-32193](https://github.com/rancher/norman/security/advisories/GHSA-r8f4-hv23-6qp6) and [CVE-2023-32192](https://github.com/rancher/apiserver/security/advisories/GHSA-833m-37f7-jq55), respectively, that could lead to an unauthenticated cross-site scripting (XSS) in Rancher's public API.
- Fixed an issue where users with permissions in custom API groups could manage namespaces in the core API group. For more information, see [CVE-2023-32194](https://github.com/rancher/rancher/security/advisories/GHSA-c85r-fwc7-45vc).
- Bumped `runc` to [v1.1.12](https://github.com/opencontainers/runc/releases/tag/v1.1.12) to fix [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626), see related [`runc` security advisory](https://github.com/opencontainers/runc/security/advisories/GHSA-xr7r-f8xq-vfvv).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

# AKS Hosted Cluster Creation No Longer Supported

Rancher versions 2.6.x no longer supports creating AKS hosted clusters as the highest Kubernetes version (1.24.10) provided by Rancher is not supported by AKS anymore. Please upgrade to Rancher 2.7.x or 2.8.x to continue using of AKS hosted clusters.

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

- **Password Re-Use**
  - Rancher no longer allows administrators to reuse the initial bootstrap password when changing the password after a fresh install.
- **Restricted-Admin Privileges & Ownership**
  - Restricted-Admins lost the ability to manage cluster and project members on clusters they didn't create. Rancher now adds Restricted-Admins as cluster-owners on all downstream clusters.
- **App Permission Validation:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. Rancher recommends admins to add `Directory.Read. All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not be able to perform some of the actions within Azure AD, if the permissions are insufficient, so you may encounter errors. See [#38770](https://github.com/rancher/rancher/issues/38770).
- **Disabled Authentication Provider:**
  - Rancher now behaves the same regardless of whether you disable an auth provider through the UI, through deleting the auth config in Terraform, or by manually editing the configuration's `enabled` field to `false` through the Rancher API. Upon disabling the provider, Rancher will clean up resources associated with the auth provider and reset all fields of the corresponding configuration. Locking the auth configuration will prevent both resource cleanup and the configuration reset. See [#40896](https://github.com/rancher/rancher/issues/40896).
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40379](https://github.com/rancher/rancher/pull/40379).
- **Project Monitoring:**
  - Previously, using Project Monitoring V2 required setting `helmProjectOperator.helmController.enabled: false` since earlier versions of RKE2 and K3s's Helm Controller operated on a cluster-wide level and didn't respect the `managedBy` annotation. This annotation is now respected by recent versions of RKE2 and K3s, so the default Helm Controller can be turned back on. See [#39904](https://github.com/rancher/rancher/issues/39904) for affected versions.
  - After upgrading Monitoring to 100.2.0+up40.1.2, SMS and Microsoft Teams alerts are no longer sent, unless you manually update the respective drivers' ConfigMap. This is because of an upstream change to avoid collisions with AlertManagerConfig objects. We've added [instructions](https://ranchermanager.docs.rancher.com/v2.6/reference-guides/monitoring-v2-configuration/receivers) on how to continue to receive alerts. See the [upstream PR](https://github.com/prometheus-operator/prometheus-operator/pull/4626) for details and [#40358](https://github.com/rancher/rancher/issues/40358#issuecomment-1426394330) for how this affects Rancher.
- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x reached end-of-life on March 30, 2022. To read more, see the [documentation](https://ranchermanager.docs.rancher.com/v2.6/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - The `startupProbe` value along with its `failureThreshold` and `periodSeconds` sub-values are now exposed in the Rancher chart. They are off by default. Setting `startupProbe` value will use defaults for `failureThreshold` and `periodSeconds`, 1 and 30 respectively if they are not set. See [#38177](https://github.com/rancher/rancher/issues/38177).
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to [enable](https://ranchermanager.docs.rancher.com/v2.6/pages-for-subheaders/enable-experimental-features) the flag on install or through the UI.
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
- **AWS Cloud Provider for RKE:**
  - Fixed an issue for RKE1 clusters with the AWS cloud provider around `hostname-override`. Rancher now always sets `hostname-override` for kubelet to fix `node not found` issues for custom clusters. It is now also required to enable `useInstanceHostnameMetadata` in `cluster.yml` to set `hostname-override` from ec2 instance metadata for kube-proxy. Please review [RKE behavior changes](https://github.com/rancher/rancher/issues/37634#issuecomment-1458916717) for more details.
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation](https://ranchermanager.docs.rancher.com/v2.6/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/azure) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
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
- rancher/rancher:v2.6.14

### Tools
- CLI - [v2.6.11](https://github.com/rancher/cli/releases/tag/v2.6.11)
- RKE - [v1.3.20](https://github.com/rancher/rke/releases/tag/v1.3.20)

### Kubernetes Versions
- v1.24.13 (Default)
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
    - When you upgrade an RKE2 cluster, and use a Kubernetes version that isn't listed in the current Rancher release, your current Kubernetes version is listed at the top of the *Kubernetes Version* dropdown menu. This can make the version numbers in the list appear out of order. See [#8305](https://github.com/rancher/dashboard/issues/8305).
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
  - **RKE2/K3s**
    - RKE2/K3s clusters may remain in an Updating state until the UI is refreshed when cluster members attempt to take snapshots, scale node pools, or perform other actions. See [#8282](https://github.com/rancher/dashboard/issues/8282).
    - When you create an RKE2/K3s cluster, the cluster enters an Active state immediately after being provisioned, then returns to a Reconciling state, instead of starting in and staying in a Reconciling state. See [#8276](https://github.com/rancher/dashboard/issues/8276).
  - **K3s:**
    - The K3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1. This will be fixed in an upcoming release. See [#39284](https://github.com/rancher/rancher/issues/39284).
  - **AKS:**
    - Rancher versions 2.6.x no longer supports creating AKS hosted clusters as the highest Kubernetes version (1.24.10) provided by Rancher is not supported by AKS anymore. Please upgrade to Rancher 2.7.x or 2.8.x to continue use of AKS hosted clusters.
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.6/en/helm-charts/#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **AWS:**
    - On RHEL8.4 SELinux in AWS AMI, Kubernetes v1.22 fails to provision on AWS. As Rancher will not install RPMs on the nodes, users may work around this issue either by using AMI with this package already installed, or by installing AMI via cloud-init. Users will encounter this issue on upgrade to v1.22 as well. When upgrading to 1.22, users must manually upgrade/install the rancher-selinux package on all the nodes in the cluster, then upgrade the Kubernetes version. See [#36509](https://github.com/rancher/rancher/issues/36509).
  - **EKS**
    - When a standard user edits an EKS cluster configuration, the UI makes a network request to `v3/authconfigs/azuread`. See [#8265](https://github.com/rancher/dashboard/issues/8265).  
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
  - Administrators (users who have a GlobalRoleBinding to the `admin` GlobalRole) may see insufficient permissions in downstream clusters, and constant error messages with the format `[ERROR] error syncing 'local': handler global-admin-cluster-sync: failed to get GlobalRoleBinding for 'globaladmin-user-1234': %!!(MISSING)w(<nil>), requeuing`. In most cases, these issues are strictly cosmetic: no actual permissions have been lost. In cases where the issue isn't cosmetic and permissions really have been lost, users can restore permissions by adding the affected administrator as a `Cluster-Owner` on the affected clusters, or by binding them to `Restricted-Admin`. This fixes the issue for all downstream clusters. This won't stop the error messages from appearing in the logs, but it should restore the expected permissions. Users should upgrade to the latest v2.7.x release, where this issue is not present.
  - If you set up multiple endpoints for accessing a single Rancher instance, then visit the Rancher UI, you might see the URL of an endpoint other than the one that you expected. Although Rancher 2.6.x doesn't support configuring multiple URLs per instance, there are external solutions available, such as network load balancers, which do support this functionality. See [#6620](https://github.com/rancher/dashboard/issues/6620).
  - Upon upgrade to Rancher v2.6.8, the UI consistently throws `Websocket Disconnected` errors. Note that alerts have been hidden behind a toggle by default so that systems remain usable. See [#6960](https://github.com/rancher/dashboard/issues/6960).
  - When navigating to the Continuous Delivery page from the Cluster Management page or Home page, the namespace filter is missing from the top-right corner. As a workaround, navigate to the Continuous Delivery page from the Cluster Explorer page to have access to the namespace filter. See [#7213](https://github.com/rancher/dashboard/issues/7213).
  - Kubernetes versions 1.24.x are incorrectly marked as “experimental” when provisioning AKS clusters (1.24.x versions are fully supported for AKS clusters). See [#7217](https://github.com/rancher/dashboard/issues/7217).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.6.13

> It's important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.6.13 is a security release to address the following issues:**

# Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Fixed an issue where users with `update` privileges on a namespace, could move that namespace into a project they didn't have access to. For more information, see [CVE-2020-10676](https://github.com/rancher/rancher/security/advisories/GHSA-8vhc-hwhc-cpj4).
- Fixed an issue where cross-site (XSS) scripting could allow a malicious user to inject code executed within another user's browser. This would allow an attacker to steal sensitive information, manipulate web content, or perform other malicious activities on behalf of the victim. For more information, see [CVE-2022-43760](https://github.com/rancher/rancher/security/advisories/GHSA-46v3-ggjg-qq3x).
- Fixed an issue that enabled [Standard users](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/manage-role-based-access-control-rbac/global-permissions) or above to elevate their permissions to Administrator in the `local` cluster. For more information, see [CVE-2023-22647](https://github.com/rancher/rancher/security/advisories/GHSA-p976-h52c-26p6).
- Fixed an issue where changing a user's permissions in Azure AD wasn't reflected for users while they were logged in to the Rancher UI. This caused users to retain their previous permissions in Rancher, even if they changed groups on Azure AD. For more information, see [CVE-2023-22648](https://github.com/rancher/rancher/security/advisories/GHSA-vf6j-6739-78m8).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's GitHub repo.

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/)
> - The namespace where the local Fleet agent runs has been changed to `cattle-fleet-local-system`. This change does not impact GitOps workflows.

### Rancher Webhook Now Deployed Downstream

Starting with Rancher v2.6.13, a webhook is now installed in all downstream clusters, to validate and enforce certain boundaries. There is a known issue with behavior during rollbacks, as well as with downstream GKE private clusters; see the [Known Major Issues](#known-major-issues) section of these release notes for advice and instructions. See [#40816](https://github.com/rancher/rancher/issues/40816) and [#41142](https://github.com/rancher/rancher/issues/41142).

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

- **Password Re-Use**
  - Rancher no longer allows administrators to reuse the initial bootstrap password when changing the password after a fresh install.
- **Restricted-Admin Privileges & Ownership**
  - Restricted-Admins lost the ability to manage cluster and project members on clusters they didn't create. Rancher now adds Restricted-Admins as cluster-owners on all downstream clusters.
- **App Permission Validation:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. Rancher recommends admins to add `Directory.Read. All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not be able to perform some of the actions within Azure AD, if the permissions are insufficient, so you may encounter errors. See [#38770](https://github.com/rancher/rancher/issues/38770).
- **Disabled Authentication Provider:**
  - Rancher now behaves the same regardless of whether you disable an auth provider through the UI, through deleting the auth config in Terraform, or by manually editing the configuration's `enabled` field to `false` through the Rancher API. Upon disabling the provider, Rancher will clean up resources associated with the auth provider and reset all fields of the corresponding configuration. Locking the auth configuration will prevent both resource cleanup and the configuration reset. See [#40896](https://github.com/rancher/rancher/issues/40896).
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40379](https://github.com/rancher/rancher/pull/40379).
- **Project Monitoring:**
  - Previously, using Project Monitoring V2 required setting `helmProjectOperator.helmController.enabled: false` since earlier versions of RKE2 and K3s's Helm Controller operated on a cluster-wide level and didn't respect the `managedBy` annotation. This annotation is now respected by recent versions of RKE2 and K3s, so the default Helm Controller can be turned back on. See [#39904](https://github.com/rancher/rancher/issues/39904) for affected versions.
  - After upgrading Monitoring to 100.2.0+up40.1.2, SMS and Microsoft Teams alerts are no longer sent, unless you manually update the respective drivers' ConfigMap. This is because of an upstream change to avoid collisions with AlertManagerConfig objects. We've added [instructions](https://ranchermanager.docs.rancher.com/v2.6/reference-guides/monitoring-v2-configuration/receivers) on how to continue to receive alerts. See the [upstream PR](https://github.com/prometheus-operator/prometheus-operator/pull/4626) for details and [#40358](https://github.com/rancher/rancher/issues/40358#issuecomment-1426394330) for how this affects Rancher.
- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x reached end-of-life on March 30, 2022. To read more, see the [documentation](https://ranchermanager.docs.rancher.com/v2.6/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - The `startupProbe` value along with its `failureThreshold` and `periodSeconds` sub-values are now exposed in the Rancher chart. They are off by default. Setting `startupProbe` value will use defaults for `failureThreshold` and `periodSeconds`, 1 and 30 respectively if they are not set. See [#38177](https://github.com/rancher/rancher/issues/38177).
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to [enable](https://ranchermanager.docs.rancher.com/v2.6/pages-for-subheaders/enable-experimental-features) the flag on install or through the UI.
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
- **AWS Cloud Provider for RKE:**
  - Fixed an issue for RKE1 clusters with the AWS cloud provider around `hostname-override`. Rancher now always sets `hostname-override` for kubelet to fix `node not found` issues for custom clusters. It is now also required to enable `useInstanceHostnameMetadata` in `cluster.yml` to set `hostname-override` from ec2 instance metadata for kube-proxy. Please review [RKE behavior changes](https://github.com/rancher/rancher/issues/37634#issuecomment-1458916717) for more details.
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation](https://ranchermanager.docs.rancher.com/v2.6/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/azure) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
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
- rancher/rancher:v2.6.13

### Tools
- CLI - [v2.6.11](https://github.com/rancher/cli/releases/tag/v2.6.11)
- RKE - [v1.3.20](https://github.com/rancher/rke/releases/tag/v1.3.20)

### Kubernetes Versions
- v1.24.13 (Default)
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

- Starting with Rancher v2.6.13, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
  - If you rollback from a version of Rancher >= v2.6.13 to a version < v2.6.13, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.6.13 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - If you have downstream private GKE clusters, you might experience issues when interacting with the resources that the webhook validates, such as namespaces. This can cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. As a [workaround](https://github.com/rancher/rancher/issues/41142#issuecomment-1505624756), add a firewall setting to allow traffic to the webhook. See [#41142](https://github.com/rancher/rancher/issues/41142). 

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2:**
    - When you upgrade an RKE2 cluster, and use a Kubernetes version that isn't listed in the current Rancher release, your current Kubernetes version is listed at the top of the *Kubernetes Version* dropdown menu. This can make the version numbers in the list appear out of order. See [#8305](https://github.com/rancher/dashboard/issues/8305).
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
  - **RKE2/K3s**
    - RKE2/K3s clusters may remain in an Updating state until the UI is refreshed when cluster members attempt to take snapshots, scale node pools, or perform other actions. See [#8282](https://github.com/rancher/dashboard/issues/8282).
    - When you create an RKE2/K3s cluster, the cluster enters an Active state immediately after being provisioned, then returns to a Reconciling state, instead of starting in and staying in a Reconciling state. See [#8276](https://github.com/rancher/dashboard/issues/8276).
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
  - **EKS**
    - When a standard user edits an EKS cluster configuration, the UI makes a network request to `v3/authconfigs/azuread`. See [#8265](https://github.com/rancher/dashboard/issues/8265).  
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
  - Administrators (users who have a GlobalRoleBinding to the `admin` GlobalRole) may see insufficient permissions in downstream clusters, and constant error messages with the format `[ERROR] error syncing 'local': handler global-admin-cluster-sync: failed to get GlobalRoleBinding for 'globaladmin-user-1234': %!!(MISSING)w(<nil>), requeuing`. In most cases, these issues are strictly cosmetic: no actual permissions have been lost. In cases where the issue isn't cosmetic and permissions really have been lost, users can restore permissions by adding the affected administrator as a `Cluster-Owner` on the affected clusters, or by binding them to `Restricted-Admin`. This fixes the issue for all downstream clusters. This won't stop the error messages from appearing in the logs, but it should restore the expected permissions. Users should upgrade to the latest v2.7.x release, where this issue is not present.
  - If you set up multiple endpoints for accessing a single Rancher instance, then visit the Rancher UI, you might see the URL of an endpoint other than the one that you expected. Although Rancher 2.6.x doesn't support configuring multiple URLs per instance, there are external solutions available, such as network load balancers, which do support this functionality. See [#6620](https://github.com/rancher/dashboard/issues/6620).
  - Upon upgrade to Rancher v2.6.8, the UI consistently throws `Websocket Disconnected` errors. Note that alerts have been hidden behind a toggle by default so that systems remain usable. See [#6960](https://github.com/rancher/dashboard/issues/6960).
  - When navigating to the Continuous Delivery page from the Cluster Management page or Home page, the namespace filter is missing from the top-right corner. As a workaround, navigate to the Continuous Delivery page from the Cluster Explorer page to have access to the namespace filter. See [#7213](https://github.com/rancher/dashboard/issues/7213).
  - Kubernetes versions 1.24.x are incorrectly marked as “experimental” when provisioning AKS clusters (1.24.x versions are fully supported for AKS clusters). See [#7217](https://github.com/rancher/dashboard/issues/7217).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher v2.6 UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.6.12

> It's important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Major Bug Fixes

- Rancher has been updated to properly form the search URL for Quarkus-based Keycloak distributions. Previous versions of Rancher attempted to form a search URL for Keycloak by splitting the address string along the pattern, `/auth/`. Newer Keycloak versions, which use the Quarkus Distribution, don't include `/auth/` in the address string. This caused a panic when users attempted to integrate those versions of Keycloak with Rancher. Credit goes to Github user [@jamhed](https://github.com/jamhed) for developing a fix to this issue. See [#40554](https://github.com/rancher/rancher/issues/40554).
- Fixed a bug where CIS scans on K3s clusters took a long time to complete. This issue was seen on nodes due to an OS issue/kernel bug that was corrupting the IP checksum on VXLAN packets when offload was enabled, due to an upstream [Flannel bug](https://github.com/flannel-io/flannel/issues/1279). See [#39839](https://github.com/rancher/rancher/issues/39839).

# Rancher Behavior Changes

- Rancher no longer allows administrators to reuse the initial bootstrap password when changing the password after a fresh install.
- Restricted-Admins lost the ability to manage cluster and project members on clusters they didn't create. Rancher now adds Restricted-Admins as cluster-owners on all downstream clusters.
- Rancher now behaves the same regardless of whether you disable an auth provider through the UI, through deleting the auth config in Terraform, or by manually editing the configuration's `enabled` field to `false` through the Rancher API. Upon disabling the provider, Rancher will clean up resources associated with the auth provider and reset all fields of the corresponding configuration. Locking the auth configuration will prevent both resource cleanup and the configuration reset. See [#40896](https://github.com/rancher/rancher/issues/40896).

# Known Issues

- When you upgrade an RKE2 cluster, and use a Kubernetes version that isn't listed in the current Rancher release, your current Kubernetes version is listed at the top of the *Kubernetes Version* dropdown menu. This can make the version numbers in the list appear out of order. See [#8305](https://github.com/rancher/dashboard/issues/8305).
- RKE2/K3s clusters may remain in an Updating state until the UI is refreshed when cluster members attempt to take snapshots, scale node pools, or perform other actions. See [#8282](https://github.com/rancher/dashboard/issues/8282).
- When you create an RKE2/K3s cluster, the cluster enters an Active state immediately after being provisioned, then returns to a Reconciling state, instead of starting in and staying in a Reconciling state. See [#8276](https://github.com/rancher/dashboard/issues/8276).
- When a standard user edits an EKS cluster configuration, the UI makes a network request to `v3/authconfigs/azuread`. See [#8265](https://github.com/rancher/dashboard/issues/8265).
- If you set up multiple endpoints for accessing a single Rancher instance, then visit the Rancher UI, you might see the URL of an endpoint other than the one that you expected. Although Rancher 2.6.x doesn't support configuring multiple URLs per instance, there are external solutions available, such as network load balancers, which do support this functionality. See [#6620](https://github.com/rancher/dashboard/issues/6620).

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

- **App Permission Validation:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. Rancher recommends admins to add `Directory.Read. All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not be able to perform some of the actions within Azure AD, if the permissions are insufficient, so you may encounter errors. See [#38770](https://github.com/rancher/rancher/issues/38770).
- **Disabled Authentication Provider:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40379](https://github.com/rancher/rancher/pull/40379).
- **Project Monitoring:**
  - Previously, using Project Monitoring V2 required setting `helmProjectOperator.helmController.enabled: false` since earlier versions of RKE2 and K3s's Helm Controller operated on a cluster-wide level and didn't respect the `managedBy` annotation. This annotation is now respected by recent versions of RKE2 and K3s, so the default Helm Controller can be turned back on. See [#39904](https://github.com/rancher/rancher/issues/39904) for affected versions.
  - After upgrading Monitoring to 100.2.0+up40.1.2, SMS and Microsoft Teams alerts are no longer sent, unless you manually update the respective drivers' ConfigMap. This is because of an upstream change to avoid collisions with AlertManagerConfig objects. We've added [instructions](https://ranchermanager.docs.rancher.com/v2.6/reference-guides/monitoring-v2-configuration/receivers) on how to continue to receive alerts. See the [upstream PR](https://github.com/prometheus-operator/prometheus-operator/pull/4626) for details and [#40358](https://github.com/rancher/rancher/issues/40358#issuecomment-1426394330) for how this affects Rancher.
- **Cert-Manager:**
  - Rancher now supports cert-manager versions 1.6.2 and 1.7.1. We recommend v1.7.x because v 1.6.x reached end-of-life on March 30, 2022. To read more, see the [documentation](https://ranchermanager.docs.rancher.com/v2.6/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster#4-install-cert-manager).
  - When upgrading Rancher and cert-manager, you will need to use [Option B: Reinstalling Rancher and cert-manager](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/upgrades/#option-b-reinstalling-rancher-and-cert-manager) from the Rancher docs.
  - There are several versions of cert-manager which, due to their backwards incompatibility, are not recommended for use with Rancher. You can read more about which versions are affected by this issue in the [cert-manager docs](https://cert-manager.io/docs/installation/upgrading/ingress-class-compatibility/). As a result, only versions 1.6.2 and 1.7.1 are recommended for use at this time.
  - For instructions on upgrading cert-manager from version 1.5 to 1.6, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.5-1.6/).
  - For instructions on upgrading cert-manager from version 1.6 to 1.7, see the [relevant cert-manager docs](https://cert-manager.io/docs/installation/upgrading/upgrading-1.6-1.7/).
- **Readiness and Liveness Check:**
  - The `startupProbe` value along with its `failureThreshold` and `periodSeconds` sub-values are now exposed in the Rancher chart. They are off by default. Setting `startupProbe` value will use defaults for `failureThreshold` and `periodSeconds`, 1 and 30 respectively if they are not set. See [#38177](https://github.com/rancher/rancher/issues/38177).
  - Users can now configure the `Readiness Check` and `Liveness Check` of `coredns-autoscaler`. See [#24939](https://github.com/rancher/rancher/issues/24939).
- **Legacy Features:**
  - Users upgrading from Rancher <=v2.5.x will automatically have the `--legacy` feature flag enabled. New installations that require legacy features need to [enable](https://ranchermanager.docs.rancher.com/v2.6/pages-for-subheaders/enable-experimental-features) the flag on install or through the UI.
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
- **AWS Cloud Provider for RKE:**
  - Fixed an issue for RKE1 clusters with the AWS cloud provider around `hostname-override`. Rancher now always sets `hostname-override` for kubelet to fix `node not found` issues for custom clusters. It is now also required to enable `useInstanceHostnameMetadata` in `cluster.yml` to set `hostname-override` from ec2 instance metadata for kube-proxy. Please review [RKE behavior changes](https://github.com/rancher/rancher/issues/37634#issuecomment-1458916717) for more details.
- **Azure Cloud Provider for RKE2:**
  - For RKE2, the process to set up an Azure cloud provider is different than for RKE1 clusters. Users should refer to the [documentation](https://ranchermanager.docs.rancher.com/v2.6/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/azure) for the new instructions. See [#34367](https://github.com/rancher/rancher/issues/34367) for original issue.
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
- rancher/rancher:v2.6.12

### Tools
- CLI - [v2.6.11](https://github.com/rancher/cli/releases/tag/v2.6.11)
- RKE - [v1.3.20](https://github.com/rancher/rke/releases/tag/v1.3.20)

### Kubernetes Versions

- v1.24.13 (Default)
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

## All issues in v2.6.12 milestone

* [#41004](https://github.com/rancher/rancher/issues/41004) [BUG] cis benchmark chart v2.1.2-rc1 fails to install on RKE1 hardened cluster v1.24.10.
* [#40977](https://github.com/rancher/rancher/issues/40977) [Backport v2.6] [BUG] Incorrect node IP reported in certain setups
* [#40896](https://github.com/rancher/rancher/issues/40896) [BUG] [2.6 backport] Can't re-enable auth provider after setting "enabled" to false in auth config
* [#40860](https://github.com/rancher/rancher/issues/40860) [BUG] ProjectRoleTemplateBinding is not created for svc account when creating a new Project
* [#40695](https://github.com/rancher/rancher/issues/40695) [Backport v2.6] [BUG] CIS scan 5.3.2 fails on rke1 custom hardened cluster
* [#40681](https://github.com/rancher/rancher/issues/40681) [BUG] RKE1 Clusters taking hours to come back up after a migration via backup/restore operator
* [#40554](https://github.com/rancher/rancher/issues/40554) [Backport v2.6] [BUG] Potential panic in keycloakoidc client caused by uncaught error
* [#40358](https://github.com/rancher/rancher/issues/40358) [BUG] After monitoring upgrade from 100.1.3+up19.0.3 to 100.2.0+up40.1.2, user won't receive an alert.
* [#39839](https://github.com/rancher/rancher/issues/39839) [BUG] CIS scan on k3s clusters running for too long before it gets completed.
-----
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

## All issues in v2.6.11 milestone

* [#40787](https://github.com/rancher/rancher/issues/40787) AKS charts UN-RC for 2.6.11 
* [#40742](https://github.com/rancher/rancher/issues/40742) [Backport v2.6] [BUG] Updating internal server URL, internal server CA, and user token invalidates CAPI kubeconfig secret
* [#40724](https://github.com/rancher/rancher/issues/40724) [Backport v2.6] [Azure AD] Rancher does not handle an error when getting groups - leading to panic
* [#40722](https://github.com/rancher/rancher/issues/40722) [BUG] rancher-monitoring appreadme needs updating for v100.2.0+up40.1.2
* [#40709](https://github.com/rancher/rancher/issues/40709) [BUG] Fleet-Agent bundle errors out depending on Cluster Name
* [#40684](https://github.com/rancher/rancher/issues/40684) [Backport v2.6] [BUG] System-Upgrade-Controller bundle errors out depending on Cluster Name
* [#40694](https://github.com/rancher/rancher/issues/40694) RKE2/K3s v1.24 Kubernetes versions incorrectly appear as experimental verions
* [#40671](https://github.com/rancher/rancher/issues/40671) [BUG] Unsupported TLS protocol error after upgrading Rancher
* [#40668](https://github.com/rancher/rancher/issues/40668) Add v1.24.10-rancher4-1
* [#40653](https://github.com/rancher/rancher/issues/40653) Unable to Delete Custom Clusters from Rancher UI
* [#40610](https://github.com/rancher/rancher/issues/40610) [v2.6] [BUG] Azure node driver rke2/k3s nodes get recreated post rancher server upgrade
* [#40601](https://github.com/rancher/rancher/issues/40601) [Backport v2.6] [BUG, RKE1, Monitoring V2] RKE1 1.24 seems to be omitting relevant cadvisor container labels and metric series that break Monitoring V2 dashboards
* [#40596](https://github.com/rancher/rancher/issues/40596) [Backport v2.6] [BUG] Abnormally high CPU usage on Kubernetes 1.24.4
* [#40592](https://github.com/rancher/rancher/issues/40592) [Backport v2.6] Check release images using skopeo instead of docker manifest inspect
* [#40588](https://github.com/rancher/rancher/issues/40588) [v2.6] Azure rke2/k3s node driver clusters have etcd nodes stuck in deleting state post rancher upgrade
* [#40583](https://github.com/rancher/rancher/issues/40583) [BUG] Ingress created is unreachable through a node's public address
* [#40568](https://github.com/rancher/rancher/issues/40568) [BUG] intermittent Errimagepull issue with fleet in an airgap setup for RKE1 downstream clusters
* [#40567](https://github.com/rancher/rancher/issues/40567) [BUG] Monitoring Prometheus images are not using the global system registry setting
* [#40566](https://github.com/rancher/rancher/issues/40566) [BUG] upgrading Monitoring from  100.1.3+up19.0.3 to 100.2.0+up40.1.2 results in alert webhooks failing to send
* [#40547](https://github.com/rancher/rancher/issues/40547) [BUG]when provisioning downstream clusters, the namespace ingress-nginx is not being created
* [#40546](https://github.com/rancher/rancher/issues/40546) [BUG] System Default Private Registry not being used to pull images
* [#40542](https://github.com/rancher/rancher/issues/40542) [Backport v2.6] GlusterFS kubelet image issue
* [#40516](https://github.com/rancher/rancher/issues/40516) [Backport v2.6] Using latest metrics server image for kubernetes v1.24
* [#40667](https://github.com/rancher/rancher/issues/40667) [BUG][EKS][2.6/2.7] Unable to view YAML for downstream EKS clusters
* [#40497](https://github.com/rancher/rancher/issues/40497) RKE2 and K3S - KDM Update for K8s January patch release for Rancher 2.6
* [#40474](https://github.com/rancher/rancher/issues/40474) [Backport v2.6] Remove rancher-runtime references
* [#40457](https://github.com/rancher/rancher/issues/40457) [Backport v2.6] [BUG] Creating new clusters with v2.6.10 with private credentials fails to pull rke-tools
* [#40386](https://github.com/rancher/rancher/issues/40386) [Backport v2.6] Rancher security-scan-runner-scan runs on an etcd node, would like to run on a worker node
* [#40360](https://github.com/rancher/rancher/issues/40360) [Backport v2.6] [BUG] Logging in to rancher as an auth user throws 500 error after logging out of rancher
* [#40341](https://github.com/rancher/rancher/issues/40341) [BUG] [monitoring v2] GKE hosted cluster monitoring does not connect to grafana or prometheus - connection refused
* [#40340](https://github.com/rancher/rancher/issues/40340) [BUG][monitoring] rancher-monitoring-prometheus-node exporter is healthy in UI but unhealthyin prometheus targets
* [#40317](https://github.com/rancher/rancher/issues/40317) [BUG] `useInstanceMetadataHostname` not present in cluster.yml after initial provisioning of downstream RKE1 Custom cluster w/ cloud provider enabled
* [#40311](https://github.com/rancher/rancher/issues/40311) [Backport v2.6] [BUG] Provisioning log config map is empty
* [#40300](https://github.com/rancher/rancher/issues/40300) [Backport v2.6] [BUG] RKE2 Downstream Clusters Not Coming Up After Rancher Migration
* [#40292](https://github.com/rancher/rancher/issues/40292) [BUG][monitoring rebase] alertmanager failed to send alerts in rke2 clusters
* [#40280](https://github.com/rancher/rancher/issues/40280) Upgrading from k8s 1.23.14 to 1.23.15 fails in Rancher 2.6.9
* [#40277](https://github.com/rancher/rancher/issues/40277) [Backport ] [BUG] Hardened cluster should not have CIS "Fails"
* [#40268](https://github.com/rancher/rancher/issues/40268) [Backport v2.6] Drain provisioning test is flaky due to not forcing naked pods eviction
* [#40228](https://github.com/rancher/rancher/issues/40228) [Backport v2.6] Remove resource limits from flannel pods
* [#40225](https://github.com/rancher/rancher/issues/40225) [Backport v2.6] Update `ingress-nginx` to 1.5.1
* [#40221](https://github.com/rancher/rancher/issues/40221) [Backport ] [BUG] rancher-monitoring-ingress-nginx showing down on prom targets page but pod is healthy in rancher ui
* [#40211](https://github.com/rancher/rancher/issues/40211) [v2.6] KDM Update for K8s January patch release
* [#40207](https://github.com/rancher/rancher/issues/40207) [Backport v2.6] [BUG] VmwarevsphereMachine showing error state in vSphere provisioned RKE2 Cluster
* [#40202](https://github.com/rancher/rancher/issues/40202) [Backport v2.6] [RKE2] Unable to rotate encryption keys for large number of secrets
* [#40197](https://github.com/rancher/rancher/issues/40197) [Backport 2.6] RKE(1) unnecessarily causes DOS when generate_serving_certificate is set to true for the kubelet
* [#40191](https://github.com/rancher/rancher/issues/40191) [Enhancement] add STARTUP probe customization to the Rancher chart
* [#40148](https://github.com/rancher/rancher/issues/40148) [Backport ] [BUG] Memory leak in cluster provisioning/deletion process
* [#40144](https://github.com/rancher/rancher/issues/40144) [Backport dev-v2.6] vSphere CPI/CSI options omitted when selecting `vsphere` cloud provider in Rancher 2.6.7 or newer
* [#40126](https://github.com/rancher/rancher/issues/40126) [BUG] Rancher provisioned RKE1 clusters stay in updating state post rancher upgrade
* [#40122](https://github.com/rancher/rancher/issues/40122) [Backport v2.6] [BUG] Erroneous "Operation cannot be fulfilled" Error in RKE2 Provisioning Logs
* [#40109](https://github.com/rancher/rancher/issues/40109) [Backport v2.6] RKE2/k3s Provisioning Tests are stuck on k8s version 1.22.x; need to be running on the latest instead
* [#40103](https://github.com/rancher/rancher/issues/40103) [Backport ] [BUG] Rancher keeps closing web sockets
* [#40093](https://github.com/rancher/rancher/issues/40093) [Backport ] [BUG] grafana dashboard for kubernetes pods workloads shows 'no data to show' message
* [#40078](https://github.com/rancher/rancher/issues/40078) [Backport v2.6] [BUG] Users are unable to create RKE2 vSphere Node Driver clusters with more than 1 Windows worker node
* [#40052](https://github.com/rancher/rancher/issues/40052) [Backport 2.6] [BUG] Downstream k3s Node driver clusters fail to provision when etcd and controlplane roles are shared by a nodepool
* [#40002](https://github.com/rancher/rancher/issues/40002) [Backport] [dev-v2.6] [BUG] rancher-istio 100.3.0+up1.13.3: Remove istiod-remote chart to align with upstream, istiodRemote.enabled: true causes installation failure
* [#39977](https://github.com/rancher/rancher/issues/39977) [Backport v2.6] [BUG] New project creation with restricted or unrestricted PSP fails on k3s cluster
* [#39969](https://github.com/rancher/rancher/issues/39969) [Backport v2.6] vSphere CPI chart updates to upstream v1.24.3 / v1.23.3 / v1.22.7
* [#39967](https://github.com/rancher/rancher/issues/39967) [Backport v2.6] vSphere CPI chart updates to upstream v1.24.2
* [#39966](https://github.com/rancher/rancher/issues/39966) [Backport v2.6] vSphere CSI chart updates to upstream v2.6.2 / v2.5.4 / v2.4.3
* [#39942](https://github.com/rancher/rancher/issues/39942) [Backport ] [Enhancement] add probe customization to the Rancher chart
* [#39904](https://github.com/rancher/rancher/issues/39904) [Backport 2.6] [Project Monitoring V2] Rebase Project Monitoring against 40.x.x Rancher Monitoring
* [#39844](https://github.com/rancher/rancher/issues/39844) [Backport v2.6] Remove initial RancherD code and build process
* [#39838](https://github.com/rancher/rancher/issues/39838) [Backport ][dev v2.6] Upgrade "Alerting drivers " chart version to the newest version
* [#39821](https://github.com/rancher/rancher/issues/39821) [Backport v2.6] [BUG] Norman V3 Cloud Credential Schema omits AWS config even though EKS driver is enabled
* [#39785](https://github.com/rancher/rancher/issues/39785) [Backport ] Deletion of downstream RKE2 cluster with CIS1.6 profile - cattle-cleanup-c5s6d-g44cr stuck in CreateContainerConfigError
* [#39761](https://github.com/rancher/rancher/issues/39761) [Backport v2.6] [BUG] getting a panic: runtime.boundsError
* [#39729](https://github.com/rancher/rancher/issues/39729) [Backport v2.6] CoreDNS pod is not getting scheduled after the cluster upgrade
* [#39717](https://github.com/rancher/rancher/issues/39717) [Backport v2.6] [BUG] Non-user friendly/inaccurate message when attempting to delete Cloud Credentials being used
* [#39716](https://github.com/rancher/rancher/issues/39716) [Backport v2.6] [BUG] Some nodes are not deleted upon node-pool deletion
* [#39685](https://github.com/rancher/rancher/issues/39685) [Backport ] CIS Benchmark cannot be installed in airgapped env
* [#39613](https://github.com/rancher/rancher/issues/39613) [Backport v2.6] [RFE] Improve details available for Azure credentials issues troubleshooting
* [#39563](https://github.com/rancher/rancher/issues/39563) [Backport v2.6] [Issue] Windows OCI images are part of rancher-images.txt / assets
* [#39560](https://github.com/rancher/rancher/issues/39560) [Backport v2.6] Update embedded k3s version for Rancher to 1.24.8+
* [#39550](https://github.com/rancher/rancher/issues/39550) [Backport ] Need to add NeuVector upstream chart version 2.2.4 to Rancher version 2.6.9
* [#39533](https://github.com/rancher/rancher/issues/39533) "Not enough data for graph" shown in v1 monitoring after upgrading
* [#39528](https://github.com/rancher/rancher/issues/39528) Feature Charts: Add Longhorn 1.2.7 Chart in 2.6.x
* [#39485](https://github.com/rancher/rancher/issues/39485) [Backport v2.6] Provisioning tests failing due to cgroups remediation miss and bad published RKE2 version
* [#39387](https://github.com/rancher/rancher/issues/39387) [Backport v2.6] [BUG] loglevel trace are not set inside rke2 rancher-machine job
* [#39367](https://github.com/rancher/rancher/issues/39367) [Backport 2.6] CIS scan shows failure after kube-apiserver restart
* [#39343](https://github.com/rancher/rancher/issues/39343) [Backport v2.6] Upgrade Istio versions to 1.15.3
* [#39334](https://github.com/rancher/rancher/issues/39334) [Backport v2.6] Update Nutanix Node Driver to 3.3.0+
* [#39230](https://github.com/rancher/rancher/issues/39230) [Backport v2.6] [BUG] CIS scan runs indefinitely and never completes. windows RKE2 clusters
* [#39200](https://github.com/rancher/rancher/issues/39200) [Backport v2.6] [BUG] [RKE2] `node auto-replace` does not work on RKE2/k3s rancher provisioned clusters
* [#39138](https://github.com/rancher/rancher/issues/39138) [Backport v2.6] [BUG] Cluster Level Private Registry Isn't Respected When Creating `dashboard-Shell` container
* [#39136](https://github.com/rancher/rancher/issues/39136) [Backport v2.6] [Logging v2] Windows RKE2  rancher-logging-root-win-agent-fluentbit pod is in Imagepullbackoff
* [#39121](https://github.com/rancher/rancher/issues/39121) [Backport v2.6] [BUG] k3s provisioned clusters from Rancher do not have taints on etcd/cp nodes
* [#39114](https://github.com/rancher/rancher/issues/39114) [Backport v2.6] [BUG] harvester storage class does not respect PVC volume value. All volumes are created with 10Gi size
* [#39061](https://github.com/rancher/rancher/issues/39061) [Backport v2.6] rancher-cis-benchmark scan mis-matches as master any non-master node on which a running process has an argument containing the phrase kube-apiserver
* [#39042](https://github.com/rancher/rancher/issues/39042) [BUG]Cluster Disappears from Cluster Management when applying new Cluster Config Payload via API
* [#39015](https://github.com/rancher/rancher/issues/39015) [Backport v2.6] [BUG] Certs for some individual services are not being rotated correctly on RKE2 and K3s clusters
* [#39002](https://github.com/rancher/rancher/issues/39002) [Backport v2.6] [BUG] Editing the azure AD auth provider config before updating the endpoints result in failed to parse the 'roles' field in JWT 
* [#38942](https://github.com/rancher/rancher/issues/38942) [Backport v2.6] [BUG] Unable to provision K3s Custom Clusters
* [#38887](https://github.com/rancher/rancher/issues/38887) [Backport v2.6] [BUG] `user-node-remove` finalizer not being properly cleaned up.
* [#38775](https://github.com/rancher/rancher/issues/38775) Add user agent to handlers requests
* [#38770](https://github.com/rancher/rancher/issues/38770) Azure AD auth uses too broad permissions
* [#37778](https://github.com/rancher/rancher/issues/37778) [Monitoring V2] Rebase Monitoring V2 to upstream kube-prometheus-stack 40.x.x
* [#37634](https://github.com/rancher/rancher/issues/37634) node upgrade failed with 'node not found' in v2.6.4
* [#37039](https://github.com/rancher/rancher/issues/37039) kubernetes 1.22 conflicts with system-library-rancher-monitoring, cluster is in error state
* [#36914](https://github.com/rancher/rancher/issues/36914) [BUG] Rancher upgrade fail: Failed to find system chart "fleet"
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

## All issues in v2.6.10 milestone

* [#39401](https://github.com/rancher/rancher/issues/39401) [BUG] After v2.6.8 upgrade, high CPU/load on nodes and database, nodes flapping between ready/unready, excessive "refresh processing" logs
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


## All issues in v2.6.9 milestone

* [#39295](https://github.com/rancher/rancher/issues/39295) Feature Charts: Add NeuVector 2.2.3 Chart in 2.6.9
* [#39281](https://github.com/rancher/rancher/issues/39281) [BUG] Rancher fails to install on 22.04 Ubuntu with error - `mkdir: cannot create directory '/sys/fs/cgroup/init': Read-only file system`
* [#39280](https://github.com/rancher/rancher/issues/39280) Release install - docker script for 20.10.17
* [#39271](https://github.com/rancher/rancher/issues/39271) [Backport v2.6] KEv2 unit/integration tests
* [#39260](https://github.com/rancher/rancher/issues/39260) [Backport v2.6] Cert rotation integration tests for RKE2 
* [#39246](https://github.com/rancher/rancher/issues/39246)  Rancher-wins-upgrader 0.0.100 chart is visible on rancher-v2.6
* [#39238](https://github.com/rancher/rancher/issues/39238) [Backport v2.6] [RFE] Update EULA & T&C  in Rancher Helm Chart README
* [#39171](https://github.com/rancher/rancher/issues/39171) [Backport v2.6] [BUG] CIS scan failures on RKE2 hardened clusters
* [#39110](https://github.com/rancher/rancher/issues/39110) Validate vsphere 7.0u3 environemtn
* [#39104](https://github.com/rancher/rancher/issues/39104) [Backport v2.6] [BUG] RKE2 System Images Are Not Pulled From Cluster Level Registry 
* [#39097](https://github.com/rancher/rancher/issues/39097) [BUG] Install Monitoring + Rancher Upgrade on k3s HA Host/Tenant Causes OOM encountered, victim process: prometheus
* [#39072](https://github.com/rancher/rancher/issues/39072) [BUG] Rancher container is stuck in updating on Ubuntu 22.04
* [#39068](https://github.com/rancher/rancher/issues/39068) [Backport v2.6] [BUG] rke2/k3s proxied custom cluster unable to finish rancher-system-agent with ` Main process exited, code=exited, status=2/INVALIDARGUMENT`
* [#39047](https://github.com/rancher/rancher/issues/39047) [BUG]creating project throws exception with label "error updating PSPT ID"
* [#39039](https://github.com/rancher/rancher/issues/39039) [Backport v2.6] [BUG] Linode Node driver RKE2/K3s fails to register worker node + successfully provision
* [#39009](https://github.com/rancher/rancher/issues/39009) [Backport v2.6] Observed a panic: "invalid memory address or nil pointer dereference"
* [#38999](https://github.com/rancher/rancher/issues/38999) [Backport v2.6] [BUG] vSphere node driver cluster fails to provision when the nodes are cloned from a VM
* [#38918](https://github.com/rancher/rancher/issues/38918) [Backport v2.6] Rancher container is restarting every 15 seconds
* [#38916](https://github.com/rancher/rancher/issues/38916) [BUG] Timeout received when waiting for rancher connection info
* [#38915](https://github.com/rancher/rancher/issues/38915) [Backport v2.6] [BUG, RKE2] cluster with windows node fails to deploy System Upgrade Controller to windows node, `Write-EventLog : The source name "rancher-wins" does not exist on computer "localhost".` on pods using `rancher-wins` image
* [#38902](https://github.com/rancher/rancher/issues/38902) [Forwardport v2.6] [BUG] NodePool controller is racy
* [#38901](https://github.com/rancher/rancher/issues/38901) [Backport v2.6] [BUG] Panic encountered with managementapi/dynamicschema concurrent map read/write
* [#38893](https://github.com/rancher/rancher/issues/38893) [BUG] RKE2 custom clusters nodes are not able to finish registering when using 1 role per node
* [#38877](https://github.com/rancher/rancher/issues/38877) [Backport v2.6] [BUG] Upgrading Kubernetes Version does not retain RKE User Addons
* [#38876](https://github.com/rancher/rancher/issues/38876) [Backport v2.6] RKE deletes user addons on reconcile and redeploys before rke up 
* [#38873](https://github.com/rancher/rancher/issues/38873) [Backport v2.6] [BUG] proxy container of the helm-operation pod is not terminated and it becomes NotReady
* [#38845](https://github.com/rancher/rancher/issues/38845) [BUG] Latest `rancher-webhook` image upgrade gives regression `Internal error occurred: failed calling webhook "rancher.cattle.io": failed to call webhook...`
* [#38838](https://github.com/rancher/rancher/issues/38838) [BUG] Proxied node driver cluster fails to provision through rancher
* [#38837](https://github.com/rancher/rancher/issues/38837) [release/v2.6] Add 1.23 for EKS clusters
* [#38795](https://github.com/rancher/rancher/issues/38795) csp-adapter: Make a release checklist in the readme
* [#38794](https://github.com/rancher/rancher/issues/38794) Release 1.0.1 csp-adapter
* [#38785](https://github.com/rancher/rancher/issues/38785) Rancher-images.txt -Make sure all images are mirrored to Rancher DockerHub account 
* [#38754](https://github.com/rancher/rancher/issues/38754) [Backport v2.6.9][Azure AD] Always check access token from Microsoft Graph
* [#38753](https://github.com/rancher/rancher/issues/38753) [Azure AD] Properly parse annotations from UI when admins edit Auth Config in the UI
* [#38715](https://github.com/rancher/rancher/issues/38715) [BUG] AWS EKS Deployed (but waiting) Cluster can cause a crash/panic loop
* [#38712](https://github.com/rancher/rancher/issues/38712) [BUG] CSP Adapter includes nodes from the local cluster
* [#38706](https://github.com/rancher/rancher/issues/38706) [BUG] Local cluster v2prov non-functional when feature flag multi-cluster-management=false
* [#38699](https://github.com/rancher/rancher/issues/38699) [BUG] Unable to interact with downstream clusters after upgrading from 2.5.15 to 2.5.16
* [#38698](https://github.com/rancher/rancher/issues/38698) Can't set minimum scaling to 0 for EKS node groups
* [#38692](https://github.com/rancher/rancher/issues/38692) Add version matrix to install instructions
* [#38515](https://github.com/rancher/rancher/issues/38515) [BUG] Running `rancher clusters add-node` in the CLI does not add a new node to an existing Rancher cluster
* [#38419](https://github.com/rancher/rancher/issues/38419) [BUG] Circular RoleTemplate reference causes high CPU usage or crash
* [#38390](https://github.com/rancher/rancher/issues/38390) Add Docker 20.10.17
* [#38362](https://github.com/rancher/rancher/issues/38362) [BUG] Docker installation script fails on ubuntu 22.04 nodes
* [#38323](https://github.com/rancher/rancher/issues/38323) [BUG] Rancher API Audit Log fails to capture API calls at Audit Level 3
* [#38984](https://github.com/rancher/rancher/issues/38984) Validate ubuntu 22.04 from Rancher
* [#37955](https://github.com/rancher/rancher/issues/37955) Creating an AKS cluster with a duplicate name as an Azure cluster throws error
* [#37886](https://github.com/rancher/rancher/issues/37886) Support of Outscale providers
* [#37601](https://github.com/rancher/rancher/issues/37601) CIS Benchmark 1.0.700 Missing from helm repo
* [#37350](https://github.com/rancher/rancher/issues/37350) Add options to lasso that improve performance
* [#37030](https://github.com/rancher/rancher/issues/37030) Longhorn 100.1.2+up1.2.4 stuck uninstalling in RKE1 Windows cluster
* [#36752](https://github.com/rancher/rancher/issues/36752) SUC doesn't appear to be installed in long-named v2prov clusters 
* [#36096](https://github.com/rancher/rancher/issues/36096) Intermittent user auth errors relating to "impersonation" ClusterRoles
* [#35055](https://github.com/rancher/rancher/issues/35055) Resources left after creating and deleting a downstream cluster on Azure
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

## All issues in v2.6.8 milestone

* [#38752](https://github.com/rancher/rancher/issues/38752) Regression testing for Bundle Pruning
* [#38751](https://github.com/rancher/rancher/issues/38751) [Release Note] Update release notes for 2.6.8
* [#38672](https://github.com/rancher/rancher/issues/38672) [BUG] Fleet trying to uninstall monitoring and longhorn after upgrade from 2.6.6 to 2.6.7
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

## All issues in v2.6.7 milestone

* [#38652](https://github.com/rancher/rancher/issues/38652) [BUG] system-upgrade-controller version is not defaulting to 0.3.3
* [#38650](https://github.com/rancher/rancher/issues/38650) [BUG][Windows] check-wins-version container in rancher-monitoring-windows-exporter failing in windows rke2
* [#38618](https://github.com/rancher/rancher/issues/38618) Harvester cloud provider bump to 1.13 in charts 
* [#38610](https://github.com/rancher/rancher/issues/38610) Unable to effectively run Rancher as a Docker container on CentOS/RHEL 7
* [#38594](https://github.com/rancher/rancher/issues/38594) [BUG] Kubelet crashes when cri_dockerd is enabled on latest 1.21, 1.22, 1.23 RKE1 cluster 
* [#38568](https://github.com/rancher/rancher/issues/38568) [BUG] RKE1 1.24 clusters fail to provision when dns provider is kube-dns
* [#38564](https://github.com/rancher/rancher/issues/38564) [BUG] Nodelocal.IPAddress field is not used when creating kubelet arguments
* [#38555](https://github.com/rancher/rancher/issues/38555) [BUG] Unable to view cluster's YAML when logged in as a non-administrative user
* [#38552](https://github.com/rancher/rancher/issues/38552) CSP Adapter - Support for new Product ID
* [#38519](https://github.com/rancher/rancher/issues/38519) [BUG] Logging rke2 operators go in crashloop when upgrading to 3.17.7
* [#38514](https://github.com/rancher/rancher/issues/38514) [BUG] Cannot Provision RKE2 Cluster on 2.6-head
* [#38503](https://github.com/rancher/rancher/issues/38503) [BUG] rancher/mirrored-calico-cni:v3.22.0 is missing in rancher-images.txt
* [#38501](https://github.com/rancher/rancher/issues/38501) [BUG] Fleet bundle in error state after upgrade rancher from 2.6.6 to 2.6.7-rc5 
* [#38489](https://github.com/rancher/rancher/issues/38489) [BUG] When provisioning RKE1 downstream node driver cluster, the message `Container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:docker: network plugin is not ready: cni config uninitialized` appears
* [#38475](https://github.com/rancher/rancher/issues/38475) [BUG] Creating rke2 airgapped custom clusters fail immediately with failed calling webhook in an airgapped 
* [#38474](https://github.com/rancher/rancher/issues/38474) [BUG] RKE2 custom cluster stuck in Updating state after a Rancher backup restore upgrade rollback from 2.6.6 to 2.6.7-rc5 to 2.6.6 in the same Rancher server
* [#38473](https://github.com/rancher/rancher/issues/38473) [BUG] Airgap - RKE1 custom clusters stuck on provisioning state on k8s version 1.24
* [#38462](https://github.com/rancher/rancher/issues/38462) Migration Via Rancher Backup/Restore Failing to Bring Up Downstream Clusters
* [#38456](https://github.com/rancher/rancher/issues/38456) Change name for the kubeconfig TTL setting.
* [#38453](https://github.com/rancher/rancher/issues/38453) [BUG] CIS scan fails on RKE1 hardened HA setup
* [#38438](https://github.com/rancher/rancher/issues/38438) Airgap - RKE2 custom cluster upgrade from 1.23 to 1.24 kubernetes stuck in Updating state
* [#38436](https://github.com/rancher/rancher/issues/38436) [BUG] Logs do not appear when installing a chart from `apps & marketplace`
* [#38433](https://github.com/rancher/rancher/issues/38433) [BUG] Unable to set number value for Target Port when creating a service
* [#38429](https://github.com/rancher/rancher/issues/38429) [BUG] Virtualization Management `...` does not have available options -> cluster owners should be able to edit / view the yaml of virtualization management clusters
* [#38422](https://github.com/rancher/rancher/issues/38422) [BUG] AWS has errors when using the node driver, but those errors aren't showing in rancher
* [#38417](https://github.com/rancher/rancher/issues/38417) [BUG] Cluster agent shows running at 100% cpu
* [#38407](https://github.com/rancher/rancher/issues/38407) Prometheus Dashboard for Controllers not Populating
* [#38382](https://github.com/rancher/rancher/issues/38382) [BUG] Rancher-logging and rancher-monitoring require a constraints change in chart.yaml for kubernetes 1.24 testing.
* [#38369](https://github.com/rancher/rancher/issues/38369) [BUG] Bump RKE1 default version to 1.24
* [#38365](https://github.com/rancher/rancher/issues/38365) [BUG] Backup/Restore - Service account of a csp-adapter should not be restored on a migrated cluster 
* [#38358](https://github.com/rancher/rancher/issues/38358) Istio v2 chart tries to pull mirrored-kiali-kiali:v1.50.0 but it's not listed in rancher-images.txt 2.6.7-rc3
* [#38357](https://github.com/rancher/rancher/issues/38357) CIS Benchmark app is trying to use image rancher/cis-operator:v1.0.8 but v1.0.9 is listed in rancher-images.txt v2.6.7-rc3
* [#38351](https://github.com/rancher/rancher/issues/38351) [BUG] CSP Adapter invalid product string
* [#38348](https://github.com/rancher/rancher/issues/38348) Bump RKE2/K3s default version to 1.24 
* [#38342](https://github.com/rancher/rancher/issues/38342) [BUG] rke2-coredns and rke2-ingress-controller pod in crashloopbackoff for imported rke2 cluster post k8s upgrade
* [#38338](https://github.com/rancher/rancher/issues/38338) [BUG] RKE2 - Local etcd snapshot restore does not work
* [#38336](https://github.com/rancher/rancher/issues/38336) [BUG] Harvester Cloud Provider is not able to deploy upgraded container after upgrading the cluster
* [#38324](https://github.com/rancher/rancher/issues/38324) [BUG] some kube-system network jobs are not updating after upgrading from 1.23 -> 1.24 on a SLES custom rke1 cluster
* [#38322](https://github.com/rancher/rancher/issues/38322) Validate logging-operator 3.17.7
* [#38304](https://github.com/rancher/rancher/issues/38304) `Invalid value: "cluster-name-c-xx-rs-cwn4m_2022-03-24T20:07:42Z.zip-s3"` error during etcd snapshot on RKE2 cluster
* [#38277](https://github.com/rancher/rancher/issues/38277) [RKE2] Unable to rotate encryption keys after rotating once
* [#38270](https://github.com/rancher/rancher/issues/38270) Pods getting stuck into "Terminating" state on deletion after the cluster is upgraded to k8s v1.24
* [#38268](https://github.com/rancher/rancher/issues/38268) Error `Unable to find default k8s version 1.23.x` seen in 2.6.3-patch3 rancher
* [#38261](https://github.com/rancher/rancher/issues/38261) Unable to provision a hosted GKE cluster due to `rancher-gke-operator` image having a `ImagePullBackOff` error
* [#38258](https://github.com/rancher/rancher/issues/38258) Introduce  v1.24 RKE2 and k3s in Rancher 
* [#38255](https://github.com/rancher/rancher/issues/38255) 1.18 and 1.19 RKE clusters fail to come up; cluster agents restart with error `fatal msg="looking up cattle-system/cattle ca/token: failed to find configmap containing the CA crt: configmaps \"kube-root-ca.crt\" not found`
* [#38253](https://github.com/rancher/rancher/issues/38253) Rancher 2.6.5 does not have chart 'alerting-drivers' present
* [#38248](https://github.com/rancher/rancher/issues/38248) Fleet is in an error state in Rancher Hardened Cluster
* [#38247](https://github.com/rancher/rancher/issues/38247) Unable to provision RKE2 downstream clusters on HA Rancher install
* [#38245](https://github.com/rancher/rancher/issues/38245) Unable to provision downstream RHEL 8.5 Custom cluster with k8s 1.24
* [#38222](https://github.com/rancher/rancher/issues/38222) RKE1 Cluster is stuck in `Waiting for API to be available` state
* [#38217](https://github.com/rancher/rancher/issues/38217) Unable to provision downstream RKE1 clusters on rancher v2.6-head
* [#38215](https://github.com/rancher/rancher/issues/38215) Cannot update s3 credentials after cluster has been created.
* [#38199](https://github.com/rancher/rancher/issues/38199) `handler import-cluster: timeout getting credential for cluster group, requeuing` error in fleet-controller pods
* [#38198](https://github.com/rancher/rancher/issues/38198) `couldn't ensure service account impersonator` error seen in Rancher logs
* [#38192](https://github.com/rancher/rancher/issues/38192) Rancher logs show repetitive iNFO message `cri-dockerd is enabled for cluster version [v1.24.2-rancher1-1]`
* [#38190](https://github.com/rancher/rancher/issues/38190) Downstream RKE2 cluster provisioning failure
* [#38162](https://github.com/rancher/rancher/issues/38162) Unable to provision downstream clusters in Rancher HA Setup
* [#38160](https://github.com/rancher/rancher/issues/38160) Upgrade from k8s v1.23 to v1.24 fails due to restarting kubelet. 
* [#38149](https://github.com/rancher/rancher/issues/38149) Update kube-version annotation in webhook
* [#38135](https://github.com/rancher/rancher/issues/38135) Updates to RKE1 Provisioning testing
* [#38120](https://github.com/rancher/rancher/issues/38120) Intermittent LKE cluster provisioning failures
* [#38090](https://github.com/rancher/rancher/issues/38090) Discontinue re-election of init node if fixed init node cannot be found
* [#38086](https://github.com/rancher/rancher/issues/38086) Update Webhook Chart Annotations
* [#38067](https://github.com/rancher/rancher/issues/38067) Errors seen in rancher logs when group memberships are refreshed on a rancher upgrade
* [#38058](https://github.com/rancher/rancher/issues/38058) Propagate updates to `team/area1` images migrated to SLE-BCI
* [#38050](https://github.com/rancher/rancher/issues/38050) [CSP Adapter] Support for Custom Certs
* [#38025](https://github.com/rancher/rancher/issues/38025) Unable to login to rancher server after a rancher server roll back via docker when azure AD is enabled
* [#38024](https://github.com/rancher/rancher/issues/38024) csp adapter compliance message typo
* [#38022](https://github.com/rancher/rancher/issues/38022) Azure AD authentication fails when the end points are set to China
* [#38011](https://github.com/rancher/rancher/issues/38011) SupportConfig Winnowing issues
* [#37997](https://github.com/rancher/rancher/issues/37997) RHEL 8.6 is unable to successfully provision a downstream RKE2 cluster, custom or node driver
* [#37981](https://github.com/rancher/rancher/issues/37981) Distinguish CAPI log messages from CAPI controllers in Rancher logs
* [#37971](https://github.com/rancher/rancher/issues/37971) Chart for ingress-nginx ingress resource is missing ingressClassName
* [#37969](https://github.com/rancher/rancher/issues/37969) Rancher panics try to use local login when azure AD is enabled
* [#37964](https://github.com/rancher/rancher/issues/37964) Update phoenixNAP node driver to the latest version
* [#37960](https://github.com/rancher/rancher/issues/37960) Can only create new local users as "standard users"
* [#37959](https://github.com/rancher/rancher/issues/37959) Changing the admin user in the configured auth resets the graph end points to the old graph endpoints
* [#37952](https://github.com/rancher/rancher/issues/37952) Use distroless images for Istio proxy
* [#37947](https://github.com/rancher/rancher/issues/37947) Unable to login as an admin to the rancher server when AzureAD auth is enabled post graph endpoint migration 
* [#37945](https://github.com/rancher/rancher/issues/37945) [RKE2 Custom Cluster] Custom cluster cannot register more than one node
* [#37944](https://github.com/rancher/rancher/issues/37944) Multiple CIS scans fail on RKE1 hardened downstream clusters
* [#37943](https://github.com/rancher/rancher/issues/37943) EC2 Node Driver provisioning fails in EC2 environments with IMDSv2 enforced on instance creation
* [#37921](https://github.com/rancher/rancher/issues/37921) Uninstalling / Reinstalling CSP Adapter Creates Confusing Error Banner
* [#37920](https://github.com/rancher/rancher/issues/37920) CSP Adapter Out of Compliance Messaging
* [#37918](https://github.com/rancher/rancher/issues/37918) CSP Adapter: Upgrade Strategy
* [#37917](https://github.com/rancher/rancher/issues/37917) Upgrade gatekeeper chart to 3.8.1
* [#37916](https://github.com/rancher/rancher/issues/37916) Upgrade cis-benchmark chart
* [#37915](https://github.com/rancher/rancher/issues/37915) Upgrade Istio to 1.14.x
* [#37913](https://github.com/rancher/rancher/issues/37913) Downstream RKE1 Cluster fails to provision
* [#37911](https://github.com/rancher/rancher/issues/37911) KDM - wrong image is used for KubeDNS in RKE1 at multiple places 
* [#37894](https://github.com/rancher/rancher/issues/37894) Upgrade to 2.6.5 breaks default admin cluster role , with okta integration
* [#37888](https://github.com/rancher/rancher/issues/37888) csp adapter uninstall not fully cleaned up 
* [#37885](https://github.com/rancher/rancher/issues/37885) Fleet does not work when Rancher runs in 1.24 cluster 
* [#37880](https://github.com/rancher/rancher/issues/37880) RKE1 etcd snapshot stuck in restore without a snapshot
* [#37874](https://github.com/rancher/rancher/issues/37874) Running `kubectl delete -f <registration command>` on an imported cluster results in an indefinite hang for the `cattle-cluster-agent` service
* [#37855](https://github.com/rancher/rancher/issues/37855) Private hosted AKS cluster status indefinitely switches from `Active` to `Unavailable` after successful cluster provisioning
* [#37799](https://github.com/rancher/rancher/issues/37799) Neuvector chart installation fails on hardened clusters
* [#37775](https://github.com/rancher/rancher/issues/37775) [v2.6.5] Failing to create RKE cluster with spot instances enabled.
* [#37774](https://github.com/rancher/rancher/issues/37774) Job Annotations Longer than 64 char are Truncated
* [#37766](https://github.com/rancher/rancher/issues/37766) Trying to use AWS LB Controller w Rancher - fails on 63 chars limit
* [#37757](https://github.com/rancher/rancher/issues/37757) Publish csp-adapter to ECR
* [#37747](https://github.com/rancher/rancher/issues/37747) After a huge spike of requests on the API server the RKE downstream cluster got off on the Rancher UI
* [#37742](https://github.com/rancher/rancher/issues/37742) Image not available at dockerhub, but listed in rancher-images.txt for v2.6.5
* [#37738](https://github.com/rancher/rancher/issues/37738) Empty tag listed for harvester-csi-driver image in `rancher-images.txt` for v2.6.5
* [#37734](https://github.com/rancher/rancher/issues/37734) [Research] K8 1.25 Support 
* [#37733](https://github.com/rancher/rancher/issues/37733) Impersonation resources need more resilience against failed creation or accidental deletion
* [#37727](https://github.com/rancher/rancher/issues/37727) Charts Support Kubernetes 1.24
* [#37722](https://github.com/rancher/rancher/issues/37722) Add SupportConfig endpoint
* [#37711](https://github.com/rancher/rancher/issues/37711) Run Rancher in k8s 1.24
* [#37708](https://github.com/rancher/rancher/issues/37708) RKE Cluster Templates - fail to update private registry URL when the override option is not enabled
* [#37705](https://github.com/rancher/rancher/issues/37705) Rancher generates prefixed kubeconfig token for every download
* [#37704](https://github.com/rancher/rancher/issues/37704) Project resourceQuotas don't get cleared on the BE side
* [#37688](https://github.com/rancher/rancher/issues/37688) Windows worker nodes in RKE2 clusters that require a proxy to complete provisioning will not successfully provision
* [#37681](https://github.com/rancher/rancher/issues/37681) Importing a AKS cluster with complicated configuration is not editable from Rancher
* [#37676](https://github.com/rancher/rancher/issues/37676) Some resources are left behind when cleanup script is run while rolling back rancher using backup restore charts
* [#37675](https://github.com/rancher/rancher/issues/37675) rancher backup/restore cleanup script fails when deployed as a kubectl job
* [#37658](https://github.com/rancher/rancher/issues/37658) [2.6] Support for multiple private registries is broken
* [#37650](https://github.com/rancher/rancher/issues/37650) EKS operator's logs flooded with error message when cluster is in error state
* [#37644](https://github.com/rancher/rancher/issues/37644) Logging v1 settings n longer visible after update to 2.5.1/2.6.4
* [#37642](https://github.com/rancher/rancher/issues/37642) Improve backend logging when s3 snapshot restore fails due to invalid s3 configuration on RKE2 provisioned clusters
* [#37639](https://github.com/rancher/rancher/issues/37639) RKE1 etcd snapshot trying too frequently
* [#37630](https://github.com/rancher/rancher/issues/37630) Snapshots tab is missing for cluster owner that is a standard user
* [#37627](https://github.com/rancher/rancher/issues/37627) Cluster Explorer caused denial of service in downstream cluster
* [#37620](https://github.com/rancher/rancher/issues/37620) Update hyperkube base to Ubuntu 22.04
* [#37608](https://github.com/rancher/rancher/issues/37608) AKS-operator prevents cluster from becoming active on tags sync
* [#37597](https://github.com/rancher/rancher/issues/37597) Some RKE2 downstream cluster options are reset to UI defaults on first Edit
* [#37596](https://github.com/rancher/rancher/issues/37596) Review and update the image lists we build in scripts/package 
* [#37563](https://github.com/rancher/rancher/issues/37563) Project Monitoring v2 is documented for support
* [#37554](https://github.com/rancher/rancher/issues/37554) Incorrect Provider seen for clusters using Rancher CLI
* [#37550](https://github.com/rancher/rancher/issues/37550) [CLI] Running `rancher clusters create -h` shows the description `Creates a new empty cluster` twice instead of once
* [#37548](https://github.com/rancher/rancher/issues/37548) [CLI] Running `rancher clusters ls` shows hosted provider clusters as `Unknown` in the PROVIDER column
* [#37545](https://github.com/rancher/rancher/issues/37545) [CLI] Running `rancher server delete` or `rancher server switch` with no Rancher server results in faulty message to `Select a Server`
* [#37544](https://github.com/rancher/rancher/issues/37544) Rancher server crashes when deleting RKE2 Custom cluster that fails to provision
* [#37543](https://github.com/rancher/rancher/issues/37543) Home page shows RKE2 Custom cluster as Active when it has not successfully provisioned
* [#37535](https://github.com/rancher/rancher/issues/37535) RKE2 cluster name's max character limit is truly 63; Not 253;
* [#37528](https://github.com/rancher/rancher/issues/37528) After modifying cluster configuration to have a new node pool, cluster's status shows as `Active` when it should show `Updating`
* [#37510](https://github.com/rancher/rancher/issues/37510) `"privateNetworking":true` is ignored for DigitalOcean node-provisioned RKE2 clusters
* [#37495](https://github.com/rancher/rancher/issues/37495) EPIC:  CSP adapter
* [#37492](https://github.com/rancher/rancher/issues/37492) Unable to install rancher backup chart version 2.0.1 as the CRDs have apiextensions.k8s.io/v1beta1 api versions
* [#37476](https://github.com/rancher/rancher/issues/37476) Hide rancher-external-ip-webhook chart for k8s versions > 1.22
* [#37465](https://github.com/rancher/rancher/issues/37465) downstream rke2 cluster goes to `provisioning` state when upgrading rancher from 2.6.4 -> 2.6.5-rc2
* [#37457](https://github.com/rancher/rancher/issues/37457) Rancher logs have continuous errors `[ERROR] error syncing 'rancher-rke2-charts'` and `Failed to find system chart fleet-crd will try again`
* [#37414](https://github.com/rancher/rancher/issues/37414) [RKE2 secrets encryption rotation keys] Cluster is rotating when provisioning
* [#37409](https://github.com/rancher/rancher/issues/37409) Restricted Admins need to be distinguished from standard user.
* [#37395](https://github.com/rancher/rancher/issues/37395) Unable to provision private AKS Cluster
* [#37386](https://github.com/rancher/rancher/issues/37386) Rancher release checklist needs to be automated for future milestones.
* [#37385](https://github.com/rancher/rancher/issues/37385) Compliance status
* [#37384](https://github.com/rancher/rancher/issues/37384) node usage vs. entitlements/api
* [#37383](https://github.com/rancher/rancher/issues/37383) IAM on EKS
* [#37378](https://github.com/rancher/rancher/issues/37378) Scaling down RKE1 nodepool by one scales deletes whole nodepool
* [#37319](https://github.com/rancher/rancher/issues/37319) vSphere CPI Support for both 1.23 and 1.24 skew policy.
* [#37288](https://github.com/rancher/rancher/issues/37288) [rke2 windows] node information is not correct for k8s version, metrics, or external IP
* [#37283](https://github.com/rancher/rancher/issues/37283) Need to write a proper `system-agent` uninstall script
* [#37274](https://github.com/rancher/rancher/issues/37274) Remove object key from norman controller metrics
* [#37245](https://github.com/rancher/rancher/issues/37245) rancher token command generates new token and the old one becomes invalid
* [#37221](https://github.com/rancher/rancher/issues/37221) [BUG] RKE2 private registry setting doesn't apply to rancher-system-agent
* [#37196](https://github.com/rancher/rancher/issues/37196) Monitoring - Grafana Drill Down - broken after upgrading from 100.0.0 to 100.1.2 on Rancher 2.6
* [#37194](https://github.com/rancher/rancher/issues/37194) Rancher assumes auto-created service account token secrets
* [#37164](https://github.com/rancher/rancher/issues/37164) Private AKS cluster fails with 'error getting service account token'
* [#37159](https://github.com/rancher/rancher/issues/37159) rancher2 Terraform provider: Some resources use incorrect delete timeout values
* [#37147](https://github.com/rancher/rancher/issues/37147) Generating a kubeconfig for downstream cluster fails when cluster-agent is disconnected, even when token hashing is disabled
* [#37104](https://github.com/rancher/rancher/issues/37104) Plugins can be added to Rancher after a release
* [#37047](https://github.com/rancher/rancher/issues/37047) Consider deprecating system-tools
* [#37040](https://github.com/rancher/rancher/issues/37040) Improve performance of cleanup script for upgrade and rollback via backup and restore
* [#36997](https://github.com/rancher/rancher/issues/36997) vSphere Node Driver using unexpected IP where VM has multiple network interfaces
* [#36986](https://github.com/rancher/rancher/issues/36986) [vsphere node driver] windows is unable to register with the cluster
* [#36985](https://github.com/rancher/rancher/issues/36985) CoreDNS add-on config changes were lost after downstream RKE Upgrade
* [#36934](https://github.com/rancher/rancher/issues/36934) Feature charts: Add longhorn 1.3.0 chart in 2.6
* [#36890](https://github.com/rancher/rancher/issues/36890) Logging - When installing on RHEL 8.4 with k8s 1.22 logs do not flow to output
* [#36845](https://github.com/rancher/rancher/issues/36845) Concurrent map read/write panic in authprovisioningv2 controller 
* [#36820](https://github.com/rancher/rancher/issues/36820) Unable to provision node driver cluster using CentOS
* [#36764](https://github.com/rancher/rancher/issues/36764) vSphere CPI/CSI Version Tracking Issue
* [#36638](https://github.com/rancher/rancher/issues/36638) [Splunk] config error file="/fluentd/etc/fluent.conf" error_class=Fluent::ConfigError error="this plugin 'Fluent::Plugin::SplunkHecOutput' cannot handle arguments for <buffer ...> section
* [#36607](https://github.com/rancher/rancher/issues/36607) Upgrade of downstream cluster does not start if other (completed) plans exist in the cluster
* [#36574](https://github.com/rancher/rancher/issues/36574) [rke2] Windows unable to pull registration command script in a proxied environment
* [#36535](https://github.com/rancher/rancher/issues/36535) CFS Kernel Issue for CPU Limits
* [#36528](https://github.com/rancher/rancher/issues/36528) Constant configmap updates causing nonstop handler runs
* [#36527](https://github.com/rancher/rancher/issues/36527) Create NameSpace option is disabled for User ( Global Role- User base, Cluster Role - Member)
* [#36526](https://github.com/rancher/rancher/issues/36526) Cluster provisioning stuck on waiting for API to be available when using RHEL 8.4 AMI on a Node driver RKE1 cluster
* [#37669](https://github.com/rancher/rancher/issues/37669) Rancher Logging v2 - UI - In the UI Form for a Flow Object that is not in the cattle-logging-system, it is not possible to select a ClusterOutput
* [#36502](https://github.com/rancher/rancher/issues/36502) Scale down deletes two nodes when in Provisioning state
* [#36492](https://github.com/rancher/rancher/issues/36492) RKE1 etcd snapshot failure retention
* [#36483](https://github.com/rancher/rancher/issues/36483) [v2prov] General fortification/reliability enhancements for v2 provisioning framework
* [#36481](https://github.com/rancher/rancher/issues/36481) [v2prov] KDM-powered feature gates
* [#36357](https://github.com/rancher/rancher/issues/36357) CFS Kernel Issue for CPU Limits
* [#36332](https://github.com/rancher/rancher/issues/36332) Error while installing app through Rancher CLI
* [#36138](https://github.com/rancher/rancher/issues/36138) Migrate area1 images to SLE-BCI
* [#36359](https://github.com/rancher/rancher/issues/36359) Rancher sends thousands of 404 GET requests to EKS kube-apiserver
* [#35759](https://github.com/rancher/rancher/issues/35759) Node template - Linode shows only Ubuntu 18.04 as latest Ubuntu version to select from UI. We should show 20.04 too
* [#35742](https://github.com/rancher/rancher/issues/35742) Not able to install istio 1.11.4 on an air-gapped setup
* [#35688](https://github.com/rancher/rancher/issues/35688) [rancher 2.6] Unable to remove project resource quota
* [#35436](https://github.com/rancher/rancher/issues/35436) Support for RKE2 secrets encryption keys rotation
* [#35235](https://github.com/rancher/rancher/issues/35235) all kubectl exec attempts fail with "403 - upgrade_failed" when using istio for rancher ingress
* [#35199](https://github.com/rancher/rancher/issues/35199) Implement cache-control headers on responses from Rancher API response for agent nodeplan
* [#35135](https://github.com/rancher/rancher/issues/35135) [2.6.1] Adding repository fails when specifying valid SSH URL
* [#35210](https://github.com/rancher/rancher/issues/35210) rancher-logging: runAsNonRoot non-numeric user (fluent) - rancher-logging-fluentd - rke2
* [#34729](https://github.com/rancher/rancher/issues/34729) Rancher should clean up ssh keypairs it creates when deleting a downstream ec2 cluster
* [#34541](https://github.com/rancher/rancher/issues/34541) metrics server, coredns and cluster agent are not available on an upgraded Rancher server on a RHEL 8.3 cluster and 1.18k8s
* [#34125](https://github.com/rancher/rancher/issues/34125) Review Helm Feature Charts in Rancher for k8s 1.22 support
* [#32847](https://github.com/rancher/rancher/issues/32847) trying to FORCE delete a pod fails with `Error deleting converting (url.Values) to (v1.DeleteOptions): unknown conversion`
* [#29306](https://github.com/rancher/rancher/issues/29306) [RFE] Update Azure AD API from ADAL to MSAL
* [#28859](https://github.com/rancher/rancher/issues/28859) Unable to provide multiple storage-opts/log-opts when creating host via UI or REST API
* [#25500](https://github.com/rancher/rancher/issues/25500) kube-api extra args not accepting arrays
-----
**Rancher v2.6.6 is a mirror release of [v2.6.5](https://github.com/rancher/rancher/releases/tag/v2.6.5) with one change to address the following issue:**

- A major performance issue was occurring when Rancher was attempting to control large volumes of traffic from downstream clusters. This mechanism was not handling disconnects properly and would result in indefinite locks. See [#37250](https://github.com/rancher/rancher/issues/37250).

## All issues in v2.6.6 milestone

* [#37250](https://github.com/rancher/rancher/issues/37250) Clusters become unreachable via UI and kubectl after some times
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


## All issues in v2.6.5 milestone

* [#37694](https://github.com/rancher/rancher/issues/37694) [project monitoring v2] helm install cattle project monitoring job created in loop
* [#37682](https://github.com/rancher/rancher/issues/37682) [RKE2] etcd snapshot restore using restoreRKEConfig: "all" does not restore cluster config
* [#37677](https://github.com/rancher/rancher/issues/37677) [Project Monitoring V2, Airgap] rancher/mirrored-kiwigrid-k8s-sidecar 1.15.9 is not found in the rancher-images.txt
* [#37673](https://github.com/rancher/rancher/issues/37673) rotate encryption keys phase is automatically failed
* [#37665](https://github.com/rancher/rancher/issues/37665) When attempting to register Windows worker nodes to a RKE2 cluster, the `rancher-wins` service is unable to start
* [#37656](https://github.com/rancher/rancher/issues/37656) [Project Monitoring V2] Grafana shows error in logs due to faulty dashboards
* [#37641](https://github.com/rancher/rancher/issues/37641) [RKE2] Snapshot restore does not work on a cloud provider enabled cluster
* [#37628](https://github.com/rancher/rancher/issues/37628) Windows worker nodes are showing as `Reconciling` in Cluster Management, but showing as `Active` in Cluster Explorer
* [#37613](https://github.com/rancher/rancher/issues/37613) Planner sends unnecessary plan updates to controlplane nodes when utility operations are performed.
* [#37598](https://github.com/rancher/rancher/issues/37598) rke2 cluster upgrade fails to respond until Edit as Yaml Button is clicked
* [#37588](https://github.com/rancher/rancher/issues/37588) [RKE2] When etcd components certs are rotated, provisioning logs show that cert rotation happens on all the nodes - etcd/control-plane/worker nodes
* [#37587](https://github.com/rancher/rancher/issues/37587) [RKE2] When etcd components certs are rotated, all the nodes - etcd/control-plane/worker nodes drain/reconcile after the certs are rotated
* [#37577](https://github.com/rancher/rancher/issues/37577) [rke2] windows rke2 images should be included in manifests and rancher-images
* [#37575](https://github.com/rancher/rancher/issues/37575) Creating an etcd snapshot causes the cluster to reconcile, etcd node to drain and control plane node to reconcile before provisioning finishes
* [#37573](https://github.com/rancher/rancher/issues/37573) Creating a custom RKE2 cluster on distributed nodes causes `waiting for probes` error, resulting in cluster never provisioning
* [#37571](https://github.com/rancher/rancher/issues/37571) [HA Airgap] - "rke2-ingress-nginx-admission-create" fails to pull image from registry
* [#37561](https://github.com/rancher/rancher/issues/37561) Unable to create Ingress on RKE2 clusters
* [#37553](https://github.com/rancher/rancher/issues/37553) Backup restore cleanup script is stuck on deleting cattle-global-data/cattle-global-nt namespaces
* [#37547](https://github.com/rancher/rancher/issues/37547) [RKE2] Any 1.21 versions to be Rancher max at 2.6.4 version for RKE2 provisioning
* [#37542](https://github.com/rancher/rancher/issues/37542) Add 1.23 version for AKS v1 clusters
* [#37534](https://github.com/rancher/rancher/issues/37534) Add 1.22 for EKS v1 clusters
* [#37533](https://github.com/rancher/rancher/issues/37533) Potential Issues with Rancher 2.5.x -> 2.6.x upgrade when using v1 apps (Project Monitoring) in RKE1 clusters
* [#37526](https://github.com/rancher/rancher/issues/37526) [Neuvector]  Clicking on EULA do not accept button does not return anything and stays in the same page
* [#37514](https://github.com/rancher/rancher/issues/37514) Intermittently on upgrade, nodes become unavailable and unrecoverable with error MemoryPressure is Unknown
* [#37503](https://github.com/rancher/rancher/issues/37503) RKE2 cluster - Delay in cluster upgrade after k8s version upgrade
* [#37502](https://github.com/rancher/rancher/issues/37502) RKE2 cluster - Upgrade strategy for control plane is not adhered and cluster is stuck in Updating state
* [#37501](https://github.com/rancher/rancher/issues/37501) RKE2 cluster - Nodes drain automatically after cluster has provisioned 
* [#37500](https://github.com/rancher/rancher/issues/37500) Worker node of RKE2 cluster is stuck in `Reconciling` state on a Linode cluster when `createPrivateIp: true`
* [#37499](https://github.com/rancher/rancher/issues/37499) Etcd snapshot restore gets stuck draining node.
* [#37487](https://github.com/rancher/rancher/issues/37487) [monitoring v2] rancher-monitoring-kube-controller-manager is down
* [#37460](https://github.com/rancher/rancher/issues/37460) hostPort related test fails on RKE2 cluster.
* [#37459](https://github.com/rancher/rancher/issues/37459) Update sriov chart
* [#37449](https://github.com/rancher/rancher/issues/37449) Unable to create a VMware vSphere cluster with private registry
* [#37447](https://github.com/rancher/rancher/issues/37447) Nuevector feature chart installation fails when a neuvector partner chart already exists
* [#37443](https://github.com/rancher/rancher/issues/37443) Project level PSP is not respected while creating deployment.
* [#37434](https://github.com/rancher/rancher/issues/37434) [Neuvector] Unable to access neuvector UI when neuvector is installed via terraform
* [#37432](https://github.com/rancher/rancher/issues/37432) Default k8s version switch to 1.23
* [#37428](https://github.com/rancher/rancher/issues/37428) Rancher is unable to serve the wins-agent-install.ps1 script in airgap for RKE2 Windows clusters
* [#37422](https://github.com/rancher/rancher/issues/37422) RKE2 cluster provisioning fails with vSphere cloud provider
* [#37420](https://github.com/rancher/rancher/issues/37420) [Neuvector] SSO config is not enabled if the controllers are not ready in the intial startup
* [#37400](https://github.com/rancher/rancher/issues/37400) Neuvector - Unable to access the neuvector UI from rancher for a custom RKE1 cluster
* [#37397](https://github.com/rancher/rancher/issues/37397) CIS scans fail on a hardened rke2 cluster with multiple roles
* [#37394](https://github.com/rancher/rancher/issues/37394) Add ability to configure fluentd.bufferStorageVolume configuration in rancher-logging chart
* [#37392](https://github.com/rancher/rancher/issues/37392) [2.6.4] node driver provisioning of RKE clusters fails in certain use-cases when using a private CA and proxy 
* [#37382](https://github.com/rancher/rancher/issues/37382) [RKE2 snapshot] Inconsistent file size for etcd snapshot
* [#37377](https://github.com/rancher/rancher/issues/37377) Adds NeuVector chart
* [#37376](https://github.com/rancher/rancher/issues/37376) New Charts in v2.6.5
* [#37370](https://github.com/rancher/rancher/issues/37370) Intermittent provisioning test timeout in v2prov integration testing
* [#37364](https://github.com/rancher/rancher/issues/37364) RKE2 custom clusters fails to come active with nodes stuck on Waiting for Node Ref
* [#37348](https://github.com/rancher/rancher/issues/37348) v2.6.5- Release testing - Run Automation suite against 2.6.5-rc
* [#37347](https://github.com/rancher/rancher/issues/37347) v2.6.5 Support Matrix checks - Validate installing Rancher, Downstream clusters listed in the support matrix 2.6.5
* [#37346](https://github.com/rancher/rancher/issues/37346) Validate new OS/docker versions for 2.6.5
* [#37344](https://github.com/rancher/rancher/issues/37344) v2.6.5 Release Task - Final Release Cleanup
* [#37343](https://github.com/rancher/rancher/issues/37343) v2.6.5 Release Task - Update Release Notes/Other Areas and Cleanup
* [#37342](https://github.com/rancher/rancher/issues/37342) v2.6.5 Release Task - Promote the Helm Chart from latest to stable
* [#37341](https://github.com/rancher/rancher/issues/37341) v2.6.5 Release Task - Update the latest tag in Dockerhub
* [#37340](https://github.com/rancher/rancher/issues/37340) v2.6.5 Release Task - Tag and Push Rancher! 
* [#37339](https://github.com/rancher/rancher/issues/37339) v2.6.5 Release Task - Tag a Final RC with All Versions Set
* [#37338](https://github.com/rancher/rancher/issues/37338) v2.6.5 Release Task - Merge the final PR in the KDM branch
* [#37337](https://github.com/rancher/rancher/issues/37337) v2.6.5 Release Task - Update the final PR in the KDM branch
* [#37336](https://github.com/rancher/rancher/issues/37336) v2.6.5 Release Task - Update the final PR in the system-charts branch
* [#37335](https://github.com/rancher/rancher/issues/37335) v2.6.5 Release Task - Update the final PR in the feature-charts branch
* [#37334](https://github.com/rancher/rancher/issues/37334) v2.6.5 Release Task - Release System-Agent
* [#37333](https://github.com/rancher/rancher/issues/37333) v2.6.5 Release Task - Release CLI
* [#37332](https://github.com/rancher/rancher/issues/37332) v2.6.5 Release Task - Run Image-Scanning
* [#37331](https://github.com/rancher/rancher/issues/37331) v2.6.5 Release Task - Merge PR for KDM, Feature-Charts and System-Charts
* [#37330](https://github.com/rancher/rancher/issues/37330) v2.6.5 Release Task - Branch Repos If Needed
* [#37329](https://github.com/rancher/rancher/issues/37329) v2.6.5 Release Task - Do Charts Cleanup
* [#37326](https://github.com/rancher/rancher/issues/37326) v2.6.5 Release Task - Prepare Draft PRs for releasing charts.
* [#37323](https://github.com/rancher/rancher/issues/37323) v2.6.5 Release Task - Charts: Align Rancher internal operators to correct version.
* [#37320](https://github.com/rancher/rancher/issues/37320) v2.6.5 Release Task - Release RKE
* [#37317](https://github.com/rancher/rancher/issues/37317) v2.6.5 Release Task - AKS/EKS/GKE Operator: Align Rancher internal operators to correct version.
* [#37316](https://github.com/rancher/rancher/issues/37316) v2.6.5 Release Task - Review the KDM to ensure proper versioning.
* [#37315](https://github.com/rancher/rancher/issues/37315) v2.6.5 - Release Master Checklist
* [#37301](https://github.com/rancher/rancher/issues/37301) Error while creating k3s multi-node cluster in HA Airgap setup
* [#37297](https://github.com/rancher/rancher/issues/37297) Rancher should treat `{}` S3 config for v2prov etcd snapshot as disabled
* [#37296](https://github.com/rancher/rancher/issues/37296) system-agent should backoff applying/executing periodic instructions that are failing to apply
* [#37295](https://github.com/rancher/rancher/issues/37295) Fails to connect to downstream cluster's nodes when rancher is behind a proxy and nodes do not have public IPs
* [#37286](https://github.com/rancher/rancher/issues/37286) [windows rke2] registration command appears to be incorrectly formatted `curl option -Force;: is badly used here`
* [#37272](https://github.com/rancher/rancher/issues/37272) [rke2] unable to create an rke2 cluster with more than 1 node
* [#37271](https://github.com/rancher/rancher/issues/37271) [Forwardport] v2.6: Allow lasso resync time to be configured via env var
* [#37256](https://github.com/rancher/rancher/issues/37256) Imported AKS Cluster Cannot Be Deleted in the Rancher UI
* [#37252](https://github.com/rancher/rancher/issues/37252) [rke2] unable to deploy production-ready setup with RKE2 linux node driver (3etcd, 2cp, 3worker)
* [#37242](https://github.com/rancher/rancher/issues/37242) Update the CIS Hardening Guide for standalone RKE2
* [#37236](https://github.com/rancher/rancher/issues/37236) Steve API Fix - At-scale testing
* [#37229](https://github.com/rancher/rancher/issues/37229) Upgrade OPA Gatekeeper chart to v3.7.1
* [#37218](https://github.com/rancher/rancher/issues/37218) Upgrade Istio to 1.12.6
* [#37209](https://github.com/rancher/rancher/issues/37209) newUserDefault value for Cluster/Project/Namespace Role is discarded
* [#37201](https://github.com/rancher/rancher/issues/37201) Error while creating custom cluster in an Airgap setup
* [#37190](https://github.com/rancher/rancher/issues/37190) v2prov does not correct itself if config is changed before cluster is provisioned/available
* [#37157](https://github.com/rancher/rancher/issues/37157) Tracking: Upstream etcd v3.5 issues
* [#37133](https://github.com/rancher/rancher/issues/37133) RKE2 Provisioning - `[ERROR] init node not found` on cluster
* [#37129](https://github.com/rancher/rancher/issues/37129) CIS scans do not work with RKE2 recommended tolerations
* [#37079](https://github.com/rancher/rancher/issues/37079) [Forwardport v2.6] Add option to disable node-cleanup jobs
* [#37063](https://github.com/rancher/rancher/issues/37063) Pods can still hang when deleting cattle-node-cleanup job
* [#37060](https://github.com/rancher/rancher/issues/37060) Secret "bootstrap-secret" in namespace "cattle-system" exists and cannot be imported seen when upgrading/re-installing Rancher when bootstrap-secret is not created by Helm
* [#37058](https://github.com/rancher/rancher/issues/37058) vsphere rke1 node driver: some nodes stuck in `Waiting for VMware Tools to come online...`, unable to delete node through rancher
* [#37052](https://github.com/rancher/rancher/issues/37052) RKE2 clusters - Snapshots are not available on the UI for a cluster with cloud provider enabled
* [#37045](https://github.com/rancher/rancher/issues/37045) External IP Webhook installation fails on 1.22 and higher clusters
* [#37044](https://github.com/rancher/rancher/issues/37044) System Agent instructions improperly handles PowerShell environment variables.
* [#37031](https://github.com/rancher/rancher/issues/37031) System Agent Installer RKE2 for Windows has a bug when processing environment variables.
* [#37022](https://github.com/rancher/rancher/issues/37022) [monitoring, windows rke2] can't deploy windows-exporter on RKE2 cluster
* [#37017](https://github.com/rancher/rancher/issues/37017) [rke2] custom cluster gets to an active state with only `etcd` and `controlplane` node(s)
* [#37005](https://github.com/rancher/rancher/issues/37005) vSphere CSI update to 2.5.x to add support for 1.23.
* [#37004](https://github.com/rancher/rancher/issues/37004) vSphere CPI Support for both 1.23 and skew policy.
* [#37003](https://github.com/rancher/rancher/issues/37003) Helm upgrade fails with the error related to the secret "bootstrap-secret"
* [#37001](https://github.com/rancher/rancher/issues/37001) RKE2 | Custom cluster | etcd restore leaves etcd node stuck in `Waiting for kubelet to update`
* [#36993](https://github.com/rancher/rancher/issues/36993) Conditions for CAPI Machines needs to be reorganized
* [#36981](https://github.com/rancher/rancher/issues/36981) cattle-node-cleanup doesn't pull from private registry
* [#36976](https://github.com/rancher/rancher/issues/36976) Fleet, Webhook charts do not deploy in the rancher setup
* [#36969](https://github.com/rancher/rancher/issues/36969) RKE2 Cluster does not show an `Error` state when cluster upgrade has failed
* [#36968](https://github.com/rancher/rancher/issues/36968) RKE2 Cluster stuck in Provisioning state during control plane upgrade on upgrading k8s version
* [#36967](https://github.com/rancher/rancher/issues/36967) Rancher server restarts with error `[FATAL] k3s exited with: exit status 2`
* [#36959](https://github.com/rancher/rancher/issues/36959) AKS Basic LoadBalancer can't be used
* [#36958](https://github.com/rancher/rancher/issues/36958) Tags defined in Node Template for AWS Node Driver propagated to EC2 instance, but not EBS volume backing that EC2 instance
* [#36956](https://github.com/rancher/rancher/issues/36956) [harvester IPAM load balancer] LB service included a space in the random string for its name
* [#36948](https://github.com/rancher/rancher/issues/36948) [RKE2 snapshots] age of existing snapshots as new ones are taken after scaling up etcd nodes
* [#36943](https://github.com/rancher/rancher/issues/36943) [RKE2 snapshot] Standard User that is Cluster Owner cannot take snapshots
* [#36941](https://github.com/rancher/rancher/issues/36941) [RKE2 s3 snapshot] 2 copies of snapshot are created and snapshots are not backed up in S3 bucket
* [#36939](https://github.com/rancher/rancher/issues/36939) Cannot provision RKE2 node driver cluster
* [#36925](https://github.com/rancher/rancher/issues/36925) Panic seen in rancher server during start
* [#36910](https://github.com/rancher/rancher/issues/36910) Calico Probes Fail on Windows Nodes in 2.6.0-2.6.3 for RKE2 Installation
* [#37240](https://github.com/rancher/rancher/issues/37240) rke2 cluster in "hang" state following deletion by standard user
* [#36885](https://github.com/rancher/rancher/issues/36885) v2prov cluster etcd snapshot restore "all" option doesn't work all the time
* [#36870](https://github.com/rancher/rancher/issues/36870) Move `ensuring designated init node` logs into Debug level 
* [#36868](https://github.com/rancher/rancher/issues/36868) `system-agent-upgrader` pods in `Error` state in an RKE2 cluster 
* [#36827](https://github.com/rancher/rancher/issues/36827) Add support for default rke2/k3s version to be configured per rancher version 
* [#36822](https://github.com/rancher/rancher/issues/36822) Plan synchronization status not exposed in UI for v2prov clusters
* [#36812](https://github.com/rancher/rancher/issues/36812) etcd backup | error taking a snapshot on a custom rke1 RHEL 8.4 cluster
* [#36798](https://github.com/rancher/rancher/issues/36798) Deleting a cluster in error state doesn't remove management cluster object
* [#36774](https://github.com/rancher/rancher/issues/36774) Errors `Plan secret was not yet assigned for service account fleet-default/sow-new-bootstrap-template-xxxxx-machine-plan` seen initially during RKE2 provisioning
* [#36757](https://github.com/rancher/rancher/issues/36757) Non-admin user does not have backupEtcd as an available action which prevents snapshot / restore snapshot
* [#36748](https://github.com/rancher/rancher/issues/36748) RKE2 | Custom Windows 2022 cluster | Windows worker is "Unavailable" after snapshot restore
* [#36727](https://github.com/rancher/rancher/issues/36727) RKE2 | Custom cluster | Deleting a machine in Cluster Manager doesn't delete the node 
* [#36732](https://github.com/rancher/rancher/issues/36732) v2prov RKE2 clusters cannot be provisioned when using an egress proxy and setting Agent Environment Variables in the Rancher UI
* [#36711](https://github.com/rancher/rancher/issues/36711) Redundant error in rancher logs `error while creating etcd snapshot`
* [#36710](https://github.com/rancher/rancher/issues/36710) AWS node drivers rke1 cluster are stuck in waiting when the network provider is Weave
* [#36700](https://github.com/rancher/rancher/issues/36700) Intermittent API errors when importing EKS clusters with terraform
* [#36698](https://github.com/rancher/rancher/issues/36698) Info message displayed multiple times on the UI when an etcd snapshot creation is in progress
* [#36695](https://github.com/rancher/rancher/issues/36695) [rke2] etcd snapshot is not taken once cluster reaches `active` state (we should have parity with rke1 behavior)
* [#36694](https://github.com/rancher/rancher/issues/36694) Cluster stuck in Provisioning state with error `"etcdsnapshots.rke.cattle.io "sowmya-test-etcd-on-demand-sowmya-test-etcd-p1-ad3bbd6c-x-1eb30" not found"` after performing a restore on the RKE2 cluster
* [#36689](https://github.com/rancher/rancher/issues/36689) Cluster state changes to Provisioning when a worker node is deleted in an RKE2 cluster
* [#36684](https://github.com/rancher/rancher/issues/36684) Steve API should allow resources to be un-watched
* [#36683](https://github.com/rancher/rancher/issues/36683) Steve API should allow specific fields in responses to be excluded
* [#36668](https://github.com/rancher/rancher/issues/36668) Kiali fails to load a graph
* [#36631](https://github.com/rancher/rancher/issues/36631) Drain on delete - Node is stuck in deleting when tried to scale down
* [#36630](https://github.com/rancher/rancher/issues/36630) Update the CIS Hardening Guide for 2.6x for k3s cluster type
* [#36629](https://github.com/rancher/rancher/issues/36629) Add CIS Hardening Guide for 2.6x for RKE2 provisioned clusters
* [#36579](https://github.com/rancher/rancher/issues/36579) Rancher uses independent vSphere chart
* [#36563](https://github.com/rancher/rancher/issues/36563) Create rancher-selinux RPM for SLE Micro
* [#36552](https://github.com/rancher/rancher/issues/36552) [rke2] Install script for windows (custom cluster) currently links to public sources -> windows will fail in airgap setups
* [#36548](https://github.com/rancher/rancher/issues/36548) Kubelet stops posting status after upgrade; Intermittent issue
* [#36543](https://github.com/rancher/rancher/issues/36543) Token error with ADFS/SAML
* [#36531](https://github.com/rancher/rancher/issues/36531) Reset remotedialer buffer to reduce memory allocation
* [#36518](https://github.com/rancher/rancher/issues/36518) Unauthorized access on secondary control plane context
* [#36504](https://github.com/rancher/rancher/issues/36504) Cluster state changes to Provisioning when user takes a snapshot on an RKE2 cluster 
* [#36488](https://github.com/rancher/rancher/issues/36488) [area/harvester] failure to provision with air-gapped environment
* [#36473](https://github.com/rancher/rancher/issues/36473) [rke2] cloud-controller-manager sometimes is scheduled onto etcd nodes, so the pod indefinitely fails to get to active state.
* [#36432](https://github.com/rancher/rancher/issues/36432) Unable to execute shell for windows pods as admin user
* [#36382](https://github.com/rancher/rancher/issues/36382) Generate Kubeconfig doesn't respect TTL settings
* [#36365](https://github.com/rancher/rancher/issues/36365) unable to create Ingress on RKE2
* [#36364](https://github.com/rancher/rancher/issues/36364) Logging does not have proper permissions on SLE Micro 5.1
* [#36363](https://github.com/rancher/rancher/issues/36363) Scans are unsuccessful on SLE Micro 5.1 for k3s
* [#36360](https://github.com/rancher/rancher/issues/36360) unable to create rke2 cluster with linode error from node: `connection reset by peer`
* [#36350](https://github.com/rancher/rancher/issues/36350) Add annotation for Traefik chart to partner-charts for alignment with other charts
* [#36287](https://github.com/rancher/rancher/issues/36287) Add some message to identify machine provisioning logs vs. provisioning itself
* [#36271](https://github.com/rancher/rancher/issues/36271) Rocky Linux will not provision for a custom cluster with k8s version v1.18.20-rancher1-3
* [#36260](https://github.com/rancher/rancher/issues/36260) Rancher Container is crashing with Observed a panic: "assignment to entry in nil map" (assignment to entry in nil map)
* [#36155](https://github.com/rancher/rancher/issues/36155) rancher2_app_v2 resource does not respect delete timeout value
* [#36137](https://github.com/rancher/rancher/issues/36137) RKE2 not pulling all images from private registry
* [#36088](https://github.com/rancher/rancher/issues/36088) Project members cannot create namespace in the UI when there's no namespaces in the project
* [#36069](https://github.com/rancher/rancher/issues/36069) sriov network operator helm chart default toleration values
* [#36044](https://github.com/rancher/rancher/issues/36044) [Group] RKE2 Provisioning parity work for RKE2 Provisioning GA
* [#36229](https://github.com/rancher/rancher/issues/36229) CPU, memory, and pods are not correct on most K8s 1.20.13 and 1.20.14 clusters
* [#35736](https://github.com/rancher/rancher/issues/35736) Add Rancher Metrics integration
* [#35595](https://github.com/rancher/rancher/issues/35595) [Monitoring v2] Adding Windows Server 2022 support for rancher-monitoring
* [#35474](https://github.com/rancher/rancher/issues/35474) vSphere version pinning for RKE2 clusters
* [#35453](https://github.com/rancher/rancher/issues/35453) Create Namespace button is missing for cluster members and project owners/members when they are added to a newly created project
* [#36467](https://github.com/rancher/rancher/issues/36467) Air-gapped provisioning of RKE2 cluster fails when vSphere Cloud Provider (CPI/CSI) enabled in cluster configuration
* [#35148](https://github.com/rancher/rancher/issues/35148) Machine resource stuck in state "Resource scheduled for deletion"
* [#34822](https://github.com/rancher/rancher/issues/34822) Use `UserAttribute.ExtraByProvider` to populate impersonation role rules
* [#34494](https://github.com/rancher/rancher/issues/34494) RKE2 Cluster system agent upgrader failed mount
* [#34417](https://github.com/rancher/rancher/issues/34417) RKE2 Provisioning: Day 2 Ops - On Demand/Recurring Etcd Snapshot and Restore with Options
* [#34197](https://github.com/rancher/rancher/issues/34197) Unable to Execute Shell on pod running on windows node from Cluster Explorer
* [#32974](https://github.com/rancher/rancher/issues/32974) Project Monitoring V2
* [#31676](https://github.com/rancher/rancher/issues/31676) Adding a clusterrepos.catalog.cattle.io with custom certificate in a dowstream repo is failing.
* [#27734](https://github.com/rancher/rancher/issues/27734) systems pods being scheduled on dead nodes
* [#26192](https://github.com/rancher/rancher/issues/26192) [Chart] Audit logging logs to both sidecar and hostPath
* [#25150](https://github.com/rancher/rancher/issues/25150) Namespace quotas created by kubectl not being enforced
* [#23050](https://github.com/rancher/rancher/issues/23050) Secrets with namespace scope overwritten by secrets with project scope without warning
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

## All issues in v2.6.4 milestone

* [#37124](https://github.com/rancher/rancher/issues/37124) Fleet - Missing apiServerURL in fleet config for cluster auto registration error on downstream Fleet cluster
* [#37122](https://github.com/rancher/rancher/issues/37122) Monitoring installation fails on rke2 clusters
* [#37114](https://github.com/rancher/rancher/issues/37114) [v2.6.4-harvester1] fail to bootstrap the local cluster in air-gap environment
* [#37113](https://github.com/rancher/rancher/issues/37113) [v2.6.4-harvester1] rancher-webhook chart is not available
* [#37107](https://github.com/rancher/rancher/issues/37107) FAILED test_clustertemplate.py::test_disable_template_revision
* [#37067](https://github.com/rancher/rancher/issues/37067) Local cluster's k8s version should not be 1.23k3s for 2.6.4 Rancher
* [#37057](https://github.com/rancher/rancher/issues/37057) Default Local Admin is demoted to Standard User when Auth Provider is registered
* [#37050](https://github.com/rancher/rancher/issues/37050) [airgap, downstream rke2] able to curl <internal_airgap_IP>, but not `<internal_airgap_IP>/system-agent-install.sh`
* [#37035](https://github.com/rancher/rancher/issues/37035) vsphere pvc - unable to mount volume
* [#37028](https://github.com/rancher/rancher/issues/37028) logging-operator 3.17.1 shows nil pointer on startup in Windows RKE1 cluster
* [#37019](https://github.com/rancher/rancher/issues/37019) Post rancher upgrade rke1 cluster goes into updating state and comes backup active every few minutes
* [#36992](https://github.com/rancher/rancher/issues/36992)  RKE2 provisioned clusters fail to stabilize as `active`, following rancher upgrade
* [#36987](https://github.com/rancher/rancher/issues/36987) [vsphere cloud provider rke2] cpi/csi add-on options not appearing in UI for k8s 1.22.x, 1.23.x
* [#36978](https://github.com/rancher/rancher/issues/36978) Istio upgrade fails with the error - base component can only have k8s.overlays, not other K8s settings
* [#36937](https://github.com/rancher/rancher/issues/36937) [2.6.4] Airgap - unexpected end of JSON input when provisioning RKE1 Custom clusters
* [#36936](https://github.com/rancher/rancher/issues/36936) [2.6.4] - coredns image pull failed as the coredns workload in kube-system is trying to pull from upstream coredns/coredns instead of rancher/coredns-coredns
* [#36931](https://github.com/rancher/rancher/issues/36931) Run Conformance Tests for 1.23
* [#36924](https://github.com/rancher/rancher/issues/36924) Rancher is not able to upgrade with RKE2 clusters
* [#36899](https://github.com/rancher/rancher/issues/36899) [RKE1] kube-scheduler HTTPs ports cannot perform authn / authz by default
* [#36898](https://github.com/rancher/rancher/issues/36898) rancher/kubelet-pause container on windows worker node keeps getting removed and new one gets created.
* [#36896](https://github.com/rancher/rancher/issues/36896) rancher/rke-tools and rancher/hyperkube:1.23.4-rancher1 keeps restarting on windows worker node.
* [#36891](https://github.com/rancher/rancher/issues/36891) Rke1 azure cloud provider enabled worker nodes are stuck on waiting with a panic in kubelet logs
* [#36887](https://github.com/rancher/rancher/issues/36887) Panic in Machine on v2.6-head
* [#36876](https://github.com/rancher/rancher/issues/36876) Monitoring - after install rancher-monitoring-kube-scheduler is down
* [#36867](https://github.com/rancher/rancher/issues/36867) Panic in rancher server
* [#36864](https://github.com/rancher/rancher/issues/36864) Cluster is stuck in `Updating` state after k8s version upgrade
* [#36862](https://github.com/rancher/rancher/issues/36862) downstream cluster continuously switching between `active` and `updating` states following k8s cluster upgrade
* [#36860](https://github.com/rancher/rancher/issues/36860) Nodes showing incorrect roles in an RKE1 node driver cluster
* [#36859](https://github.com/rancher/rancher/issues/36859) RKE2 Cluster is stuck in provisioning state after an upgrade to 2.6-head and rollback to 2.6.3
* [#36849](https://github.com/rancher/rancher/issues/36849) Windows worker nodes do not upgrade to k8s 1.23
* [#36842](https://github.com/rancher/rancher/issues/36842) v2prov etcd snapshot restore is incorrectly prepending cluster name to snapshot
* [#36826](https://github.com/rancher/rancher/issues/36826) Cannot provision rancher HA with 2.6.4-rc6 and rke 1.3.8-rc4
* [#36825](https://github.com/rancher/rancher/issues/36825) RKE1 | Can't provision a 1.20.16 k8s cluster
* [#36823](https://github.com/rancher/rancher/issues/36823) Remove unnecessary re-alignment of long object names in v2prov
* [#36877](https://github.com/rancher/rancher/issues/36877) Can't delete a custom RKE1 cluster
* [#36807](https://github.com/rancher/rancher/issues/36807) After upgrade from 2.6.3 to 2.6.4-rc6, RKE2 cluster stuck in Provisioning status
* [#36803](https://github.com/rancher/rancher/issues/36803) Rancher backup | Can't rollback (restore) Rancher from 2.6-head to 2.6.3
* [#36801](https://github.com/rancher/rancher/issues/36801) Error while retrieving plan secret for machine during RKE2 provisioning
* [#36796](https://github.com/rancher/rancher/issues/36796) Feature charts: Add longhorn 1.2.4 chart in 2.6
* [#36794](https://github.com/rancher/rancher/issues/36794) RKE2 Cluster is stuck in Provisioning State after Taking Snapshot continuously
* [#36790](https://github.com/rancher/rancher/issues/36790) Unable to get notifiers to the email when we configure legacy notifiers with sendgrid
* [#36776](https://github.com/rancher/rancher/issues/36776) Multiple etcd nodes upgrade at the same time during k8s upgrade in an RKE2 cluster
* [#36773](https://github.com/rancher/rancher/issues/36773) Rancher logs have multiple Info level `ensuring designated init node` logs
* [#36772](https://github.com/rancher/rancher/issues/36772) Cluster goes into Provisioning state multiple times after it has finished provisioning
* [#36770](https://github.com/rancher/rancher/issues/36770) Not seeing changes from rancher/charts for monitoring
* [#36767](https://github.com/rancher/rancher/issues/36767) Errors Config not found: //sa.kubeconfig are seen in the istio installer job when we install/upgrade to version 1.11.700
* [#36763](https://github.com/rancher/rancher/issues/36763) RKE2 | Custom cluster | Cluster stays in Provisioning state after adding a Windows node
* [#36742](https://github.com/rancher/rancher/issues/36742) [Monitoring v2] - Error: failed to create resource: ServiceMonitor.monitoring.coreos.com on Cluster with RHEL 8.5 nodes
* [#36728](https://github.com/rancher/rancher/issues/36728) RKE2 | Custom cluster | Admin still sees machines and clusters which were deleted by a standard user/cluster owner
* [#36723](https://github.com/rancher/rancher/issues/36723) Installing apps from private catalog fails with Secrets "cattle-global-data/catalog-password-j6qm8" not found
* [#36720](https://github.com/rancher/rancher/issues/36720) Panic in steve when `summary.Relationship` is changed
* [#36716](https://github.com/rancher/rancher/issues/36716) Unable to provision harvester rke2 cluster from rancher, stuck in provisioning on bootstrap node
* [#36722](https://github.com/rancher/rancher/issues/36722) Number of snapshots change in the UI snapshot is in progress in an RKE2 cluster
* [#36704](https://github.com/rancher/rancher/issues/36704) Deleting RKE2 custom clusters doesn't work
* [#36697](https://github.com/rancher/rancher/issues/36697) [rke2 snapshots] age of existing snapshots changes as new ones are taken
* [#36696](https://github.com/rancher/rancher/issues/36696) No snapshots are taken when RKE2 cluster names are long
* [#36693](https://github.com/rancher/rancher/issues/36693) Validate the latest cert-manager in Rancher server helm chart to latest
* [#36691](https://github.com/rancher/rancher/issues/36691) Error while provisioning vSphere node driver cluster on env 7 for RKE1 and RKE2
* [#36679](https://github.com/rancher/rancher/issues/36679) Unable to pull images when private registry is enabled on rke1 clusters Error response from daemon: unauthorized: authentication required]
* [#36690](https://github.com/rancher/rancher/issues/36690) Unable to edit imported AKS clusters
* [#36671](https://github.com/rancher/rancher/issues/36671) Not authorized to provision an RKE2 cluster using a bearer token created by a standard user
* [#36660](https://github.com/rancher/rancher/issues/36660) Unable to take s3 enabled etcd snapshots on rke1 clusters
* [#36653](https://github.com/rancher/rancher/issues/36653) ISOs created by rancher-machine do not work for vSphere Windows VMs
* [#36640](https://github.com/rancher/rancher/issues/36640) RKE1 | Incorrect cluster state is returned when node pool is scaled up
* [#36639](https://github.com/rancher/rancher/issues/36639) [Monitoring] upgrade failed when uninstalling and upgrading from monitoring v1 to v2
* [#36637](https://github.com/rancher/rancher/issues/36637) [2.6.4] v2prov bootstrap secrets are taking too long to be created by Rancher
* [#36627](https://github.com/rancher/rancher/issues/36627) RKE2 node driver cluster | nodes are replaced when upgrading Rancher from 2.6.3 to 2.6-head
* [#36626](https://github.com/rancher/rancher/issues/36626) Unable to provision rke2 node driver linode cluster errors with - `ls: cannot access 'docker-machine-driver-*': No such file or directory`
* [#36588](https://github.com/rancher/rancher/issues/36588) Rancher crashes when provisioning a RKE1 node driver cluster
* [#36583](https://github.com/rancher/rancher/issues/36583) Unable to Delete Null KEv2 Clusters
* [#36573](https://github.com/rancher/rancher/issues/36573) Worker node stuck in `Waiting for Node Ref` in a DO RKE2 cluster
* [#36562](https://github.com/rancher/rancher/issues/36562) RKE2 | Cluster goes into "Provisioning" state when etcd pool scaled down to 1 machine
* [#36560](https://github.com/rancher/rancher/issues/36560) Hostports are not working properly through rancher
* [#36559](https://github.com/rancher/rancher/issues/36559) apply-system-agent-upgrader job on the rke2 clusters won't come up active when the PSP is set to restricted or restricted-noroot during cluster creation
* [#36555](https://github.com/rancher/rancher/issues/36555) [rke2] errors in rancher pods while provisioning rke2 clusters
* [#36547](https://github.com/rancher/rancher/issues/36547) Provisioning machine job can't finish
* [#36536](https://github.com/rancher/rancher/issues/36536) RKE2 upgrade doesn't work if pre-drain/post-drain hooks are enabled
* [#36522](https://github.com/rancher/rancher/issues/36522) Alerting in 1.22 fails due to rancher-monitoring-kube-controller-manager being down
* [#36512](https://github.com/rancher/rancher/issues/36512) modifying loglevel inside of a rancher pod causes a panic
* [#36506](https://github.com/rancher/rancher/issues/36506) Machine drain errors are not exposed  in the UI during cluster upgrade on an RKE2 cluster
* [#36505](https://github.com/rancher/rancher/issues/36505) Issue with RKE2 upgrade with Upgrade strategy set
* [#36782](https://github.com/rancher/rancher/issues/36782) The nodes' state do not change to Upgrading when the cluster upgrades
* [#36503](https://github.com/rancher/rancher/issues/36503) Snapshots are not created on RKE2 cluster
* [#36480](https://github.com/rancher/rancher/issues/36480) Can't promote a agent node to server node
* [#36474](https://github.com/rancher/rancher/issues/36474) Losing connection to Rancher Server UI
* [#36471](https://github.com/rancher/rancher/issues/36471) After upgrade of local cluster to 1.22, UI is not reachable though all pods are healthy
* [#36469](https://github.com/rancher/rancher/issues/36469) Upgrading a k3s local cluster is unsuccessful. 
* [#36464](https://github.com/rancher/rancher/issues/36464) Upgrade Helm to v3.8.0
* [#36430](https://github.com/rancher/rancher/issues/36430) [rke2] updating an incorrect image name for a workload deploys a new pod instead of removing the old one. Removing the old pod manually fails, until the pod with the correct image goes to an active state
* [#36425](https://github.com/rancher/rancher/issues/36425) AKS-operator OMS agent panic
* [#36410](https://github.com/rancher/rancher/issues/36410) Implement additional metrics for nodes
* [#36407](https://github.com/rancher/rancher/issues/36407) v2.6.4 Release Task - Final Release Cleanup
* [#36406](https://github.com/rancher/rancher/issues/36406) v2.6.4 Release Task - Update Release Notes/Other Areas and Cleanup
* [#36405](https://github.com/rancher/rancher/issues/36405) v2.6.4 Release Task - Promote the Helm Chart from latest to stable
* [#36404](https://github.com/rancher/rancher/issues/36404) v2.6.4 Release Task - Update the latest tag in Dockerhub
* [#36403](https://github.com/rancher/rancher/issues/36403) [Apps & Marketplace V2] Add RKE1 Linux tolerations and RKE2 nodeSelectors to all feature charts
* [#36402](https://github.com/rancher/rancher/issues/36402) v2.6.4 Release Task - Tag and Push Rancher!
* [#36401](https://github.com/rancher/rancher/issues/36401) [Apps & Marketplace V2] Add or update annotations to support RKE2 clusters to all charts
* [#36394](https://github.com/rancher/rancher/issues/36394) v2.6.4 Release Task - Tag a Final RC with All Versions Set
* [#36393](https://github.com/rancher/rancher/issues/36393) v2.6.4 Release Task - Update the final PR in the KDM branch
* [#36392](https://github.com/rancher/rancher/issues/36392) v2.6.4 Release Task - Update the final PR in the KDM branch
* [#36391](https://github.com/rancher/rancher/issues/36391) v2.6.4 Release Task - Update the final PR in the system-charts branch
* [#36390](https://github.com/rancher/rancher/issues/36390) v2.6.4 Release Task - Update the final PR in the feature-charts branch
* [#36389](https://github.com/rancher/rancher/issues/36389) v2.6.4 Release Task - Release System-Agent
* [#36388](https://github.com/rancher/rancher/issues/36388) v2.6.4 Release Task - Release CLI
* [#36387](https://github.com/rancher/rancher/issues/36387) v2.6.4 Release Task - Release RKE
* [#36386](https://github.com/rancher/rancher/issues/36386) v2.6.4 Release Task - Run Image-Scanning
* [#36385](https://github.com/rancher/rancher/issues/36385) v2.6.4 Release Task - Merge PR for KDM, Feature-Charts and System-Charts
* [#36384](https://github.com/rancher/rancher/issues/36384) v2.6.4 Release Task - Do Charts Cleanup
* [#36383](https://github.com/rancher/rancher/issues/36383) v2.6.4 Release Task - Prepare Draft PRs for releasing charts.
* [#36380](https://github.com/rancher/rancher/issues/36380) v2.6.4 Release Task - Branch Repos If Needed
* [#36379](https://github.com/rancher/rancher/issues/36379) v2.6.4 Release Task - Review the KDM to ensure proper versioning.
* [#36377](https://github.com/rancher/rancher/issues/36377) v2.6.4 Release Task - AKS/EKS/GKE Operator: Align Rancher internal operators to correct version.
* [#36376](https://github.com/rancher/rancher/issues/36376) v2.6.4 Release Task - Charts: Align Rancher internal operators to correct version.
* [#36375](https://github.com/rancher/rancher/issues/36375) [WIP] v2.6.4 - Release Master Checklist
* [#36370](https://github.com/rancher/rancher/issues/36370) Rancher should log a message when it is refusing to update due to an exceeded unavailable threshold.
* [#36351](https://github.com/rancher/rancher/issues/36351) No entries found in provisioning log during RKE2 provisioning
* [#36349](https://github.com/rancher/rancher/issues/36349) Unable to provision 1.22/1.21 RKE2 AWS Cluster
* [#36348](https://github.com/rancher/rancher/issues/36348) Nutanix Rancher Node Driver 
* [#36333](https://github.com/rancher/rancher/issues/36333) Creating RKE cluster with rotateEncryptionKey set to true crashes rancher
* [#36327](https://github.com/rancher/rancher/issues/36327) Validate cluster provisioning use cases using Terraform
* [#36321](https://github.com/rancher/rancher/issues/36321) The fleet-agent app in the downstream cluster does not update to use the new image if the global registry is changed
* [#36316](https://github.com/rancher/rancher/issues/36316) Tenant Cluster in Unavailable state where the Super Rancher setup is on 2.6.3 and Tenant Rancher is 2.5.12
* [#36305](https://github.com/rancher/rancher/issues/36305) Validate Rhel 8.4 on 2.6.4
* [#36294](https://github.com/rancher/rancher/issues/36294) Can't remove RKE2 cluster if Harvester Cloud Credential is deleted
* [#36277](https://github.com/rancher/rancher/issues/36277) v2.6.4 Support Matrix checks - Validate installing Rancher, Downstream clusters listed in the support matrix 2.6.4
* [#36275](https://github.com/rancher/rancher/issues/36275) v2.6.4- Release testing - Run Automation suite against 2.6.4-rc
* [#36274](https://github.com/rancher/rancher/issues/36274) Validate new OS/docker versions for 2.6.4
* [#36242](https://github.com/rancher/rancher/issues/36242) Helm Multiple Values Files not Processed Correctly
* [#36241](https://github.com/rancher/rancher/issues/36241) Modifying a cluster's label doesn't remove the bundles applied via clusterSelector
* [#36234](https://github.com/rancher/rancher/issues/36234) Support mounted service account tokens for rancher service monitor
* [#36228](https://github.com/rancher/rancher/issues/36228) fleet gitrepo says, "first path segment in URL cannot contain colon " while adding gitrepo with ssh URL
* [#36223](https://github.com/rancher/rancher/issues/36223) Remove provisioning machine job will let Machine status be stuck in Provisioning
* [#36216](https://github.com/rancher/rancher/issues/36216) Rancher logs spammed with RoleBinding.rbac.authorization.k8s.io  is invalid: when any auth group is assigned restricted admin global role
* [#36210](https://github.com/rancher/rancher/issues/36210) [forwardport] etcd backups 'thrash' when multiple backups occur at once (i.e. user starts manual backup, and recurring backup starts before manual backup finishes)
* [#36209](https://github.com/rancher/rancher/issues/36209) etcd backups 'thrash' when multiple backups occur at once (i.e. user starts manual backup, and recurring backup starts before manual backup finishes)
* [#36185](https://github.com/rancher/rancher/issues/36185) New Charts in 2.6.4
* [#36159](https://github.com/rancher/rancher/issues/36159) DNS redirect iptables rules not created by istio-cni
* [#36154](https://github.com/rancher/rancher/issues/36154) Adding https://git.rancher.io/helm3-charts does not result in any charts being returned
* [#36140](https://github.com/rancher/rancher/issues/36140) rancher-monitoring node-exporter and pushprox-clients listen on hostNetwork
* [#36128](https://github.com/rancher/rancher/issues/36128) KEv2 clusters imported using the Rancher client have their config improperly rewritten
* [#36125](https://github.com/rancher/rancher/issues/36125) Pods for some type of deployments fail to become Active in a hardened Rancher server 
* [#36116](https://github.com/rancher/rancher/issues/36116) Add node metrics permissions to cluster members
* [#36115](https://github.com/rancher/rancher/issues/36115) [forwardport] Rancher 2.6 downstream - iptables segfault in RHEL 8.4
* [#36109](https://github.com/rancher/rancher/issues/36109) Files secret not passed to rancher-machine command
* [#36105](https://github.com/rancher/rancher/issues/36105) [monitoring v2]  `pushprox-kube-etcd-client` daemonset is in crashloopbackoff, targets are down on SELinux with RPM enabled
* [#36093](https://github.com/rancher/rancher/issues/36093) Update RKE Downstream cluster failed: Not a valid ECR registry, requeuing
* [#36079](https://github.com/rancher/rancher/issues/36079) Make webhook certificate auto renew ahead of expiration
* [#36070](https://github.com/rancher/rancher/issues/36070) Default scrape interval for ingressNginx ServiceMonitor in rancher-monitoring chart too small for NGINX / Request Performance Handling dashboard queries
* [#36062](https://github.com/rancher/rancher/issues/36062) RKE2 | Worker node is not ready after migrating to a new cluster
* [#36057](https://github.com/rancher/rancher/issues/36057) Rancher backup | Migrate from single docker to HA set up
* [#36055](https://github.com/rancher/rancher/issues/36055) Unable to remove node with "Waiting on user-node-remove" message
* [#36054](https://github.com/rancher/rancher/issues/36054) Many "will not create impersonation" errors in logs
* [#36051](https://github.com/rancher/rancher/issues/36051) RKE2 cluster provisioning broken since v1.21.8 release
* [#36039](https://github.com/rancher/rancher/issues/36039) Splunk Buffer errors in logging pods after install
* [#36018](https://github.com/rancher/rancher/issues/36018) [Forwardport v2.6] Cluster explorer and websocket connection broken after upgrading to rancher 2.5.8 (fine with 2.5.7)
* [#36017](https://github.com/rancher/rancher/issues/36017) [Forwardport v2.6] Intermittent health check failure causes unreachable downstream clusters
* [#36004](https://github.com/rancher/rancher/issues/36004) `no data found for resource with given identifier` for network, templates, etc. when creating a vsphere rke2 cluster
* [#36000](https://github.com/rancher/rancher/issues/36000) Upgrade Plan for K3s downstream cluster does not honor system-default-registry
* [#35999](https://github.com/rancher/rancher/issues/35999) Multiple nodes are upgraded at the same time when enabling pre/post-drain hooks during a RKE2 upgrade
* [#35955](https://github.com/rancher/rancher/issues/35955) Rancher 2.6.2 upgrade 2.6.3 cluster down.
* [#35942](https://github.com/rancher/rancher/issues/35942) CoreDNS add-on config changes were lost after Rancher upgrade
* [#35922](https://github.com/rancher/rancher/issues/35922) [airgap] unable to provision k3s custom cluster -> images are not being pulled from systemDefaultRegistry
* [#35921](https://github.com/rancher/rancher/issues/35921) Update Drone to remove unnecessary steps for PRs
* [#35917](https://github.com/rancher/rancher/issues/35917) Ensure SUC charts version is updated
* [#35913](https://github.com/rancher/rancher/issues/35913) Fail to provision RKE2 clusters when agent envvars sets NO_PROXY with Rancher server CIDR
* [#35899](https://github.com/rancher/rancher/issues/35899) Standard user loses access to provisioned RKE2 cluster before cluster is deleted
* [#35868](https://github.com/rancher/rancher/issues/35868) Standard user gets error `Method PUT not supported` when creating an rke2 cluster through  `edit as yaml` 
* [#35867](https://github.com/rancher/rancher/issues/35867) unable to provision cluster using k8s v1.21.7-rc2+rke2r3
* [#35844](https://github.com/rancher/rancher/issues/35844) CIS v2: Add AKS as an option to run the CIS Scan
* [#35840](https://github.com/rancher/rancher/issues/35840) Support k8s 1.22 as default version
* [#35833](https://github.com/rancher/rancher/issues/35833) The IP addresses didn't match within rancher and aws/ec2 after provisioning causing nodes to be unvailable
* [#35822](https://github.com/rancher/rancher/issues/35822) `v1.21.6+rke2r1` RKE2 cluster is stuck in provisioning state on a Rancher server upgrade when a worker node is stuck in `Nodeconditionsfailed` state
* [#35795](https://github.com/rancher/rancher/issues/35795) [Intermittent] Machines not deleted for provisioned RKE2 clusters
* [#35790](https://github.com/rancher/rancher/issues/35790) [monitoring v1] custom metrics endpoint is not working after upgrade from 2.6.2 -> 2.6.3
* [#35756](https://github.com/rancher/rancher/issues/35756) [RKE2] scale down button is not shown on rke2 clusters, but is for rke1 in the `manage` cluster page
* [#35753](https://github.com/rancher/rancher/issues/35753) [scale down behavior] rke1 scale down for rke1 deletes the oldest node in the pool, while rke2 deletes the newest node in the pool
* [#35750](https://github.com/rancher/rancher/issues/35750) Rancher reports cluster as active even though the add-on's are not upgraded as part of k8s version upgrade
* [#35739](https://github.com/rancher/rancher/issues/35739) Add Rancher support for k8s 1.23
* [#35737](https://github.com/rancher/rancher/issues/35737) Add metrics and graphs for performance/scaling
* [#35735](https://github.com/rancher/rancher/issues/35735) Update the CIS Hardening Guide for 2.6x
* [#35729](https://github.com/rancher/rancher/issues/35729) Workload/Deployment Not Working from Custom RKE2 Cluster
* [#35719](https://github.com/rancher/rancher/issues/35719) Add SLE BCI image for security-scan:v0.2.4
* [#35718](https://github.com/rancher/rancher/issues/35718) Add SLE BCI image for security-scan:v0.1.14
* [#35709](https://github.com/rancher/rancher/issues/35709) Update hyperkube base to using iptables >1.8.5
* [#35706](https://github.com/rancher/rancher/issues/35706) Add SLE BCI image for cis-operator
* [#35705](https://github.com/rancher/rancher/issues/35705) Add SLE BCI image for istio-1.5-migration
* [#35704](https://github.com/rancher/rancher/issues/35704) Add SLE BCI image for istio-installer
* [#35702](https://github.com/rancher/rancher/issues/35702) Create independent repo for vSphere charts
* [#35701](https://github.com/rancher/rancher/issues/35701) Deleting provisioned RKE2 cluster could leave jobs/secrets around
* [#35700](https://github.com/rancher/rancher/issues/35700) Deleting an imported cluster that was unavailable doesn't fully delete it
* [#35687](https://github.com/rancher/rancher/issues/35687) Images from unused charts are in rancher-images.txt
* [#35647](https://github.com/rancher/rancher/issues/35647) Incorrect resource quota set for namespaces where Project quota is enabled
* [#35639](https://github.com/rancher/rancher/issues/35639) Cannot login to rancher
* [#35625](https://github.com/rancher/rancher/issues/35625) Etcd restore does not work on a k8s 1.22 RKE1 cluster
* [#35618](https://github.com/rancher/rancher/issues/35618) Unable to provision RKE2 clusters using Amazon cloud provider with k8s 1.22
* [#35571](https://github.com/rancher/rancher/issues/35571) [monitoring v2] `rancher-monitoring-kube-controller-manager` prometheus target is down; pod `rancher-monitoring-admission-patch` fails, causing monitoring install to fail on k8s 1.22
* [#35565](https://github.com/rancher/rancher/issues/35565) Minimize caches ran on followers
* [#35555](https://github.com/rancher/rancher/issues/35555) pod-infra-container-image does not take effect when using cri-dockerd
* [#35547](https://github.com/rancher/rancher/issues/35547) Minimize writes to the kontainer-engine v1 state secret
* [#35540](https://github.com/rancher/rancher/issues/35540) Move user controllers to agent where possible
* [#35527](https://github.com/rancher/rancher/issues/35527) Non-Windows charts are listed on an RKE2 Windows cluster in Cluster tools and Apps & Marketplace
* [#35489](https://github.com/rancher/rancher/issues/35489) CAPI (Cluster API) update to version 1.0+
* [#35468](https://github.com/rancher/rancher/issues/35468) Support for k3s/RKE2 etcd snapshot restore options
* [#35440](https://github.com/rancher/rancher/issues/35440) Rancher server logs error syncing machine-worker-label on imported harvester 0.3.0 cluster
* [#35395](https://github.com/rancher/rancher/issues/35395) fluentd stops sending logs to elasticsearch
* [#35385](https://github.com/rancher/rancher/issues/35385) Rancher 2.6.2 - Management of ResourceQuotas broken on projects/namespaces
* [#35344](https://github.com/rancher/rancher/issues/35344) Integrate K3s/RKE2 etcd snapshot metadata enhancement into Rancher to store cluster config
* [#35343](https://github.com/rancher/rancher/issues/35343) Support for RKE2 provisioned cluster certificate rotation
* [#35334](https://github.com/rancher/rancher/issues/35334) cattle-node-cleanup jobs stick around forever
* [#35331](https://github.com/rancher/rancher/issues/35331) About the bug of Monitoring unit
* [#35275](https://github.com/rancher/rancher/issues/35275) Support for automatic replacement of unreachable nodes in RKE2 machine pool
* [#35274](https://github.com/rancher/rancher/issues/35274) "Drain Before Delete" support for RKE2 machine pools
* [#36266](https://github.com/rancher/rancher/issues/36266) Ensure Istio works when there are Windows nodes in RKE2-provisioned cluster
* [#36265](https://github.com/rancher/rancher/issues/36265) Ensure CIS scan works when there are Windows nodes in RKE2-provisioned cluster
* [#35452](https://github.com/rancher/rancher/issues/35452) Scale Node Pool Up or Down for RKE2 provisioned clusters is not working for long cluster/node pool names
* [#35272](https://github.com/rancher/rancher/issues/35272) Add Docker 20.10.10 & 20.10.11
* [#35246](https://github.com/rancher/rancher/issues/35246) Integrate our drone CI into upstream's Github Workflow CI in our NGINX fork
* [#35197](https://github.com/rancher/rancher/issues/35197) Logging v2 - Syslog output with UDP not working
* [#35191](https://github.com/rancher/rancher/issues/35191) Deviation from upstream restricted PSP
* [#35177](https://github.com/rancher/rancher/issues/35177) [BUG] Users with Create Cluster permissions can not see available RKE2 cluster templates
* [#35125](https://github.com/rancher/rancher/issues/35125) When Logging v1 and v2 coexist v1 fluentd pods get stuck crashlooping
* [#35101](https://github.com/rancher/rancher/issues/35101) Replace downloaded K3s binary with its Docker image in the Dockerfile
* [#35073](https://github.com/rancher/rancher/issues/35073) RKE2 version does not get refreshed upon a refresh of rke-metadata-config 
* [#35031](https://github.com/rancher/rancher/issues/35031) Add Docker 20.10.8 & 20.10.9
* [#34892](https://github.com/rancher/rancher/issues/34892) [Backup] Investigate "context aware" backup check intervals and retries
* [#34890](https://github.com/rancher/rancher/issues/34890) s3 etcd backups taking longer than 5 minutes cause backup loop
* [#34909](https://github.com/rancher/rancher/issues/34909) Amazon ec2 scaling up the machine pools for rke2 cluster as a cluster Owner with no access to cloud credentials displays the error The request must contain the parameter AWSAccessKeyId
* [#34910](https://github.com/rancher/rancher/issues/34910) vsphere scaling up the machine pools for rke2 cluster as a cluster Owner with no access to cloud credentials displays `NotFound: cloud credential not found` but scales up the nodes when tried by editing the config 
* [#34844](https://github.com/rancher/rancher/issues/34844) [rke2 templates] unable to create cluster from an rke2 template as non-admin user
* [#34749](https://github.com/rancher/rancher/issues/34749) EKS - rancher downstream cluster does not add security group to launch template
* [#34615](https://github.com/rancher/rancher/issues/34615) Support install docker by "rancher/install-docker" on Rocky Linux/OpenSUSE/RHEL/SLES
* [#34564](https://github.com/rancher/rancher/issues/34564) [etcd snapshots with rke2, not always reproducible] etcd node was unable to recover after restoring from a snapshot
* [#34560](https://github.com/rancher/rancher/issues/34560) RKE2 upgrade takes a long time to finish upgrading and sometimes get stuck after upgrading one master node
* [#35828](https://github.com/rancher/rancher/issues/35828) Actions that cannot be performed by a Cluster member are available on an RKE1 cluster in a rancher setup when RKE2 flag is disabled
* [#34361](https://github.com/rancher/rancher/issues/34361) [ Monitoring v2 ] Pod: prometheus-rancher-monitoring-prometheus-0 CrashLoopBackOff if "Persistent Storage for Prometheus" option enabled
* [#34315](https://github.com/rancher/rancher/issues/34315) RKE2 missing the following agent arguments
* [#35142](https://github.com/rancher/rancher/issues/35142) enable generic `in-tree` option for cloud provider
* [#34275](https://github.com/rancher/rancher/issues/34275) RKE2 with cilium and project network isolation breaks ingress controller to pod communication
* [#34224](https://github.com/rancher/rancher/issues/34224) RKE2 Provisioning: Registries - Validate setting up mirror and registry configuration
* [#34101](https://github.com/rancher/rancher/issues/34101) RKE2 - Unable to provision ec2 clusters - cannot reproduce
* [#34060](https://github.com/rancher/rancher/issues/34060) Validate Rancher supports k8s 1.22
* [#34057](https://github.com/rancher/rancher/issues/34057) Validate Apps & Marketplace features on k8s 1.22 clusters
* [#33967](https://github.com/rancher/rancher/issues/33967) Multiple "handler need-a-cert" errors on installing Rancher in a single node docker install
* [#33926](https://github.com/rancher/rancher/issues/33926) Add Docker 20.10.8
* [#33848](https://github.com/rancher/rancher/issues/33848) vSphere CSI Driver does not support Kubernetes 1.22
* [#33786](https://github.com/rancher/rancher/issues/33786) RKE2 missing the following server arguments
* [#33709](https://github.com/rancher/rancher/issues/33709) Configuring Keycloak (SAML) authentication fails with decoding error 
* [#33392](https://github.com/rancher/rancher/issues/33392) Automation - RKE2 Cluster Provisioning - Custom Cluster
* [#33391](https://github.com/rancher/rancher/issues/33391) Automation - RKE2 cluster provisioning - DO Nodedriver
* [#33291](https://github.com/rancher/rancher/issues/33291) Istio 100.0.0 v2 : book demo app deployment fails on SELinux RHEL 8.4 enabled on the clusters
* [#33290](https://github.com/rancher/rancher/issues/33290) CIS v2 scan fails to run on an SElinux enabled cluster
* [#33037](https://github.com/rancher/rancher/issues/33037) Update rancher-images generator to support feature and system charts min/max version constraint
* [#32930](https://github.com/rancher/rancher/issues/32930) Replace go-version with a library that handles prereleases correctly in catalog rancher check
* [#32803](https://github.com/rancher/rancher/issues/32803) Upgrade Plan for RKE2 downstream cluster does not honor system-default-registry / does not work in airgapped scenarios
* [#36247](https://github.com/rancher/rancher/issues/36247) comparePatches running only last operation
* [#32676](https://github.com/rancher/rancher/issues/32676) [Bug] Authentication Proxy does not work with Skaffold (blocks on rollout status)
* [#32425](https://github.com/rancher/rancher/issues/32425) Metrics-server v0.4.1 timeout - already fixed in upstream
* [#32419](https://github.com/rancher/rancher/issues/32419) Investigate why requests timeout on large objects only in kubernetes v1.19.10+ and v1.20+
* [#32175](https://github.com/rancher/rancher/issues/32175) Adding Bitnami chart causes 2-3 minute CPU spikes every 15 minutes and 30-40 minute CPU spike when rancher restarted
* [#32157](https://github.com/rancher/rancher/issues/32157) rancher-gatekeeper chart sets --exempt-namespace to wrong Namespace on gatekeeper-controller-manager
* [#32144](https://github.com/rancher/rancher/issues/32144) Syslog over UDP doesn't work with Logging v2
* [#31640](https://github.com/rancher/rancher/issues/31640) Upgrade k8s version sees memory increase on downstream clusters
* [#31546](https://github.com/rancher/rancher/issues/31546) Leftover cluster namespaces after cluster deletion
* [#30363](https://github.com/rancher/rancher/issues/30363) Hairpin rules are not added when using IPVS with a cloudprovider enabled
* [#30230](https://github.com/rancher/rancher/issues/30230) Kubectl error "You must be logged in to the server"
* [#30099](https://github.com/rancher/rancher/issues/30099) Cluster Templates - RKE2 Example Template
* [#29882](https://github.com/rancher/rancher/issues/29882) Pod Predicate NodeAffinity failed error seen on default-http-backend pod
* [#29076](https://github.com/rancher/rancher/issues/29076) [ISTIO] Hardened Cluster Support - CIS scan should pass
* [#28796](https://github.com/rancher/rancher/issues/28796) [Logging v2] additionalLoggingSources is retrieving only latest log lines (tail)
* [#28622](https://github.com/rancher/rancher/issues/28622) Istio v2 cannot deploy in a hardened cluster
* [#28419](https://github.com/rancher/rancher/issues/28419) Cluster update breaks namespace labels with OPA gatekeeper
* [#28411](https://github.com/rancher/rancher/issues/28411) Node provisioning stuck on `Waiting for ssh` when provisioning from an airgapped environment with proxy
* [#27750](https://github.com/rancher/rancher/issues/27750) Creating a namespace via kubectl will not set Container Default Resource Limit, creating a pod fails due to quota
* [#27166](https://github.com/rancher/rancher/issues/27166) RKE Template private registry url, user and password overrides do not work
* [#25443](https://github.com/rancher/rancher/issues/25443) kontainer-engine and docker-machine zombie processes
* [#25416](https://github.com/rancher/rancher/issues/25416) [cli] Loading rke config doesn't work
* [#25103](https://github.com/rancher/rancher/issues/25103) Enabling Cluster Monitoring through API sets different memory limits than UI
* [#25076](https://github.com/rancher/rancher/issues/25076) Namespace with -1 limit stuck in Activating
* [#24337](https://github.com/rancher/rancher/issues/24337) AWS EC2 provisioner opening port 2376 on existing security group open to 0.0.0.0/0
* [#22416](https://github.com/rancher/rancher/issues/22416) kube-proxy: --hostname-override in AWS Cloud Provider
* [#18877](https://github.com/rancher/rancher/issues/18877) container default resource limit from the project level is not propagated to existing namespaces
-----


## All issues in v2.6.3-patch2 milestone

* [#36645](https://github.com/rancher/rancher/issues/36645) [Forwardport v2.6.3-patch2] cattle-node-cleanup jobs stick around forever
* [#36644](https://github.com/rancher/rancher/issues/36644) [Forwardport v2.6.3-patch2] s3 etcd backups taking longer than 5 minutes cause backup loop
* [#36642](https://github.com/rancher/rancher/issues/36642) [Forwardport v2.6.3-patch2] Rancher reports cluster as active even though the add-on's are not upgraded as part of k8s version upgrade
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

## All issues in v2.6.3-patch1 milestone

* [#36303](https://github.com/rancher/rancher/issues/36303) Kubernetes experimental version 1.22.5-rancher1-1 is not showing up for rke1 downstream clusters on a rancher patch version
* [#36301](https://github.com/rancher/rancher/issues/36301) helm v3/v2 apps from system charts should not be deployable on rancher patch version when the rancher max version exceeds
* [#36270](https://github.com/rancher/rancher/issues/36270) Upgrading k8s version of imported rke2 cluster running on 2.6.3-patch1-rc2 Fails
* [#36268](https://github.com/rancher/rancher/issues/36268) upgrade job is not deploying when upgrading k8s for an imported rke2 cluster
* [#36192](https://github.com/rancher/rancher/issues/36192) [Forwardport v2.6] Cluster explorer and websocket connection broken after upgrading to rancher 2.5.8 (fine with 2.5.7)
* [#36191](https://github.com/rancher/rancher/issues/36191) [Forwardport v2.6] Intermittent health check failure causes unreachable downstream clusters
* [#36178](https://github.com/rancher/rancher/issues/36178) [Backport v2.6.3-patch1] (Docker Install) Rancher 2.6.2 upgrade 2.6.3 cluster down.
* [#36177](https://github.com/rancher/rancher/issues/36177) [2.6.3-p1] Make webhook certificate auto renew ahead of expiration
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

## All issues in v2.6.3 milestone

* [#35905](https://github.com/rancher/rancher/issues/35905) Error seen for EKS clusters "[ERROR] error syncing 'c-m8jwl': handler cluster-stats: strconv.Atoi: parsing "21+": invalid syntax, requeuing"
* [#35904](https://github.com/rancher/rancher/issues/35904) Editing/updating existing catalog apps Validation failed in API: rancher max version exceeded
* [#35902](https://github.com/rancher/rancher/issues/35902) Rancher pods when installed on k8s 1.22 have `handler cluster-stats: object missing name,` scrolling through continuously
* [#35897](https://github.com/rancher/rancher/issues/35897) Review Helm System Charts in Rancher for k8s 1.22 support
* [#35891](https://github.com/rancher/rancher/issues/35891) invalid image version of jettech-kube-webhook-certgen
* [#35880](https://github.com/rancher/rancher/issues/35880) Metrics requests hang for downstream cluster after project is created
* [#35875](https://github.com/rancher/rancher/issues/35875) [2.6.3] - Update AKS / EKS / GKE operators to the latest wrangler
* [#35851](https://github.com/rancher/rancher/issues/35851) [monitoring v2] RKE2 Windows (2022) nodes are not reporting to `serviceMonitor/kube-system/rancher-monitoring-kubelet` in prometheus
* [#35839](https://github.com/rancher/rancher/issues/35839) Set k8s 1.22 as experimental for Rancher v2.6.3 
* [#35838](https://github.com/rancher/rancher/issues/35838) Downstream metrics are not being recorded
* [#35831](https://github.com/rancher/rancher/issues/35831) Downstream clusters with Calico network provider getting stuck into "Waiting" state on rancher v2.6-head
* [#35825](https://github.com/rancher/rancher/issues/35825) the default value in the questions.yml didn't take effect
* [#35823](https://github.com/rancher/rancher/issues/35823) No timeout when trying to delete an AWS node when the cloud credential is deleted.
* [#35821](https://github.com/rancher/rancher/issues/35821) `v1.21.6+rke2r1` RKE2 cluster goes into provisioning state on a rancher server upgrade 
* [#35819](https://github.com/rancher/rancher/issues/35819) [airgap rke2] custom rke2 cluster SUC system-agent-upgrader containers stuck in re-deploying/terminating state `didn't match pod anti-affinity rules.`
* [#35812](https://github.com/rancher/rancher/issues/35812) rancher upgrade causes rke2 cluster to get stuck in provisioning after upgrade
* [#35804](https://github.com/rancher/rancher/issues/35804) EKS Node Group deletion piloted by Rancher
* [#35798](https://github.com/rancher/rancher/issues/35798) Rancher logs spammed with "Updating workload [ingress-nginx/nginx-ingress-controller]" and "Updating service [frontend] with public endpoints" on a rollback
* [#35797](https://github.com/rancher/rancher/issues/35797) Local k3s clusters were not able to be upgraded within Rancher post upgrade from 2.5 to 2.6
* [#35796](https://github.com/rancher/rancher/issues/35796) helm upgrade of rancher server from 2.6.2 to 2.6.3-rc4 errored out when rancher backup is taken with fleet git repos created
* [#35784](https://github.com/rancher/rancher/issues/35784) Rhel 8.4 Docker 2.10.7 cluster | Cluster agent fail to update
* [#35783](https://github.com/rancher/rancher/issues/35783) 2004 Windows cluster | windows node agent and fleet agent do not get upgraded to 2.6.3-rc4
* [#35776](https://github.com/rancher/rancher/issues/35776) v1 alerts are not working on 2.6.3 -> alerts are not `firing` when there is activity
* [#35767](https://github.com/rancher/rancher/issues/35767) Downstream cluster toggles between Active and Unavailable states for sometime after a rancher server upgrade
* [#35766](https://github.com/rancher/rancher/issues/35766) Ingress are not accessible after a rancher server upgrade
* [#35764](https://github.com/rancher/rancher/issues/35764) Ingress isnt working on a rancher server upgrade from 2.5.11 on RKE1 Node driver clusters on 1.18 and 1.17 clusters
* [#35763](https://github.com/rancher/rancher/issues/35763) Webhook restarts with error no matches for kind \"CustomResourceDefinition\" in version \"apiextensions.k8s.io/v1beta1\" during rancher upgrade
* [#35762](https://github.com/rancher/rancher/issues/35762) Cluster is stuck in provisioning state with error "Waiting for daemon set "cattle-node-agent" rollout to finish" when a worker node is unavailable after a rancher upgrade
* [#35761](https://github.com/rancher/rancher/issues/35761) One node of downstream cluster is in Unavailable state after rancher upgrade
* [#35760](https://github.com/rancher/rancher/issues/35760) Monitoring v1 is unavailable after an upgrade of rancher server
* [#35752](https://github.com/rancher/rancher/issues/35752) [Monitoring V2, RKE1 1.22] Use HTTPs port to scrape kube-controller-manager and kube-scheduler
* [#35751](https://github.com/rancher/rancher/issues/35751) [RKE1] kube-controller-manager / kube-scheduler HTTPs ports cannot perform authn / authz by default
* [#35744](https://github.com/rancher/rancher/issues/35744) V2 Monitoring Fails to upgrade when crd is in a failed state
* [#35740](https://github.com/rancher/rancher/issues/35740) Windows node's k8s version is different than cluster's kubernetes version
* [#35730](https://github.com/rancher/rancher/issues/35730) "[INFO] rkecluster fleet-default/sow-new: waiting for at least one bootstrap node" messages spamming the rancher logs
* [#35726](https://github.com/rancher/rancher/issues/35726) ember installed app with many revisions can't upgrade or rollback after rancher upgraded to 2.6.3-rc3
* [#35714](https://github.com/rancher/rancher/issues/35714) Unable to deploy an RKE2 cluster using v1.21.7-rc3+rke2r1 version
* [#35710](https://github.com/rancher/rancher/issues/35710) [custom cluster] unable to register rke2 nodes to custom cluster -> /etc/ssl/certs/ca-certificates.crt = `none`
* [#35696](https://github.com/rancher/rancher/issues/35696) When rke2 feature flag is disabled, upgrade to 2.6-head ruins downstream rke2 cluster
* [#35692](https://github.com/rancher/rancher/issues/35692) Allow upgrading apps even if Rancher version exceeds `rancher_max_version`
* [#35686](https://github.com/rancher/rancher/issues/35686) kiali crd is not installed when installing istio version 100.1.0+up1.11.4
* [#35684](https://github.com/rancher/rancher/issues/35684) Installing the same helm3 chart in the ember UI after its deleted is updating the existing migrated chart in the explorer UI 
* [#35683](https://github.com/rancher/rancher/issues/35683) Cannot provision k3s cluster using v1.22.4+k3s1
* [#35681](https://github.com/rancher/rancher/issues/35681) [windows 2022] SUC and rke2-coredns are down once windows node is added, user is unable to deploy new workloads
* [#35680](https://github.com/rancher/rancher/issues/35680) Old Catalog API needs to be updated so versionLinks returns the version of the app that is currently installed
* [#35658](https://github.com/rancher/rancher/issues/35658) Not able to upgrade library app from the dashboard UI legacy apps
* [#35656](https://github.com/rancher/rancher/issues/35656) rancher/wrangler#183 breaks application of DesiredSet containing mix of namespaced and cluster-scoped resources
* [#35670](https://github.com/rancher/rancher/issues/35670) "All Categories" dropdown under Apps still lists the number of apps even though there are none
* [#35650](https://github.com/rancher/rancher/issues/35650) Not able to import rke1 clusters into the rancher server
* [#35643](https://github.com/rancher/rancher/issues/35643) Rancher pod fails with error: `panic: indexer conflict: map[byPod:{}]`
* [#35641](https://github.com/rancher/rancher/issues/35641) Machine pools page is not seen on an RKE1 cluster initially during provisioning
* [#35640](https://github.com/rancher/rancher/issues/35640) Cluster state switches between Active and Unavailable after provisioning
* [#35636](https://github.com/rancher/rancher/issues/35636) Ingresses not loading for RKE1 downstream clusters on k8s 1.22.3 when HA local cluster is on k8s 1.18
* [#35628](https://github.com/rancher/rancher/issues/35628) "Failed to parse cluster status version: Invalid character(s) found in minor number "21+"" Error seen on a fresh install of EKSv2 cluster
* [#35627](https://github.com/rancher/rancher/issues/35627) Panic in rancher server while provisioning an RKE1 cluster
* [#35646](https://github.com/rancher/rancher/issues/35646) Unavailable node is seen Active in Cluster Management --> Machine Pools page
* [#35620](https://github.com/rancher/rancher/issues/35620) Errors "template system-library-rancher-logging incompatible with rancher version or cluster's [local] kubernetes version" seen in rancher server
* [#35619](https://github.com/rancher/rancher/issues/35619) clusters stuck in 'unavailable' when upgrading from 2.5.11 to 2.6-head
* [#35614](https://github.com/rancher/rancher/issues/35614) windows 2019 nodes are not registering with k8s v1.22.3-rancher1-1 in an RKE1 cluster
* [#35593](https://github.com/rancher/rancher/issues/35593) [custom cluster] adding 1 node all roles to custom rke2 cluster fails with `unable to create impersonator account: error getting service account token`
* [#35583](https://github.com/rancher/rancher/issues/35583) Errors seen in the nginx controller logs `Failed to update lock: configmaps "ingress-controller-leader" is forbidden` 
* [#35578](https://github.com/rancher/rancher/issues/35578) Not able to create ingress on k8s 1.22 
* [#35576](https://github.com/rancher/rancher/issues/35576) Monitoring v1 Grafana will not be able to scrape from prometheus in k8s 1.22+
* [#35574](https://github.com/rancher/rancher/issues/35574) [monitoring v1] Install fails on k8s 1.22 with message `Failed to install app cluster-monitoring. Error: unable to recognize "": no matches for kind "CustomResourceDefinition" in version "apiextensions.k8s.io/v1beta1"`
* [#35573](https://github.com/rancher/rancher/issues/35573) Errors  `failed to parse constraint for kubeversion <1.21: Could not parse Range "<1.21"` are seen in the docker logs when downstream clusters are created on k8s 1.22
* [#35559](https://github.com/rancher/rancher/issues/35559) RKE1 v1.22 errors for metrics.k8s.io/v1beta1
* [#35550](https://github.com/rancher/rancher/issues/35550) [rke2] kube-api `additional args` breaks kube api server, cluster is unable to come to active. However, same var on rke1 works as expected 
* [#35546](https://github.com/rancher/rancher/issues/35546) Gracefully handle disconnected clusters
* [#35544](https://github.com/rancher/rancher/issues/35544) Flapping behavior seen on rolebinding
* [#35531](https://github.com/rancher/rancher/issues/35531) Run Conformance Testing for k8s 1.22
* [#35513](https://github.com/rancher/rancher/issues/35513) Ensure we use protobuf where applicable
* [#35511](https://github.com/rancher/rancher/issues/35511) Update rancher/helm to support 1.22 
* [#35503](https://github.com/rancher/rancher/issues/35503) Do not start controllers for legacy features if not needed
* [#35496](https://github.com/rancher/rancher/issues/35496) RKE1 Downstream 1.22 stuck in provisioning
* [#35495](https://github.com/rancher/rancher/issues/35495) Webhook fails to start on Rancher local 1.22
* [#35491](https://github.com/rancher/rancher/issues/35491) Edit cluster page does not show node pools on an edit of RKE1 Node driver cluster
* [#35613](https://github.com/rancher/rancher/issues/35613) [2.6.3] Add support for new chart annotation: kube-version 
* [#35487](https://github.com/rancher/rancher/issues/35487) Support Windows Server 2022
* [#35485](https://github.com/rancher/rancher/issues/35485) Some charts are not correctly deployed in airgapped environments
* [#35475](https://github.com/rancher/rancher/issues/35475) Local Rancher cluster has 2 Default and 2 System Projects by default
* [#35464](https://github.com/rancher/rancher/issues/35464) Custom hooks before and after Rancher draining a node when upgrading RKE2
* [#35454](https://github.com/rancher/rancher/issues/35454) Unable to provision clusters in latest v2.6-head
* [#35446](https://github.com/rancher/rancher/issues/35446) [Forwardport] Fix handler registration issue affecting access control
* [#35445](https://github.com/rancher/rancher/issues/35445) Node Templates | Location and Size info is not present on UI (API call does not return them)
* [#35437](https://github.com/rancher/rancher/issues/35437) [v2.6] KDM Update for K8s November patch release
* [#35427](https://github.com/rancher/rancher/issues/35427) Namespace is stuck in removing when a resource eg, config map with a finalizer is created in this namespace
* [#35413](https://github.com/rancher/rancher/issues/35413) [KEv2] Cluster owners should be able to change cloud credential
* [#35411](https://github.com/rancher/rancher/issues/35411) Clusters stuck in Configuring state when upgrade from Rancher 2.5.11 to v2.6-head
* [#35390](https://github.com/rancher/rancher/issues/35390) [Monitoring v2] Wrong permissions in the PSP for Grafana
* [#35378](https://github.com/rancher/rancher/issues/35378) [2.6] Fix vSphere charts upgrade path and forward port new charts 
* [#35370](https://github.com/rancher/rancher/issues/35370) v2.6.3 - Tracking issue for K3s k8s November Patches
* [#35369](https://github.com/rancher/rancher/issues/35369) v2.6.3 - Tracking issue for RKE2 k8s November Patches
* [#35366](https://github.com/rancher/rancher/issues/35366) Extend `webhook` certificate expiration to 10 years from 1 year
* [#35353](https://github.com/rancher/rancher/issues/35353) Hide existing partner charts in "helm3-library" catalog
* [#35352](https://github.com/rancher/rancher/issues/35352) Hide existing partner charts in "library" catalog
* [#35351](https://github.com/rancher/rancher/issues/35351) Hide existing non-partner charts in "helm3-library" catalog
* [#35347](https://github.com/rancher/rancher/issues/35347) Hide existing non-partner charts in "library" catalog
* [#35340](https://github.com/rancher/rancher/issues/35340) [Monitoring] - Add Deployment and Daemonset kind to Rancher / Workload dashboards
* [#35339](https://github.com/rancher/rancher/issues/35339) [Istio] k8s IP service is set to default IP which does not work for all environments
* [#35338](https://github.com/rancher/rancher/issues/35338) Unable to set ACE when editing an RKE2 cluster provisioned by Rancher
* [#35336](https://github.com/rancher/rancher/issues/35336) Logs not shipping to Splunk
* [#35324](https://github.com/rancher/rancher/issues/35324) Namespaces can be created that exceed project quota
* [#35310](https://github.com/rancher/rancher/issues/35310) Fail to upgrade a local RKE2 cluster if node drain is enabled
* [#35288](https://github.com/rancher/rancher/issues/35288) [rancher-monitoring] Disable the testFramework in Grafana
* [#35268](https://github.com/rancher/rancher/issues/35268) Centralize Fleet consts
* [#35262](https://github.com/rancher/rancher/issues/35262) [Solution Design] Rancher-driven etcd snapshot for RKE2
* [#35264](https://github.com/rancher/rancher/issues/35264) [Monitoring v2] Duplicate 'rules' key in rancher-monitoring 100.0.0+up16.6.0
* [#35222](https://github.com/rancher/rancher/issues/35222) [Feature Charts] Stop Releasing non-user-facing dependency charts 
* [#35217](https://github.com/rancher/rancher/issues/35217) [Forward-port][rancher-pushprox] duplicate label in ServiceMonitor resource
* [#35215](https://github.com/rancher/rancher/issues/35215) Logging should expose all fluentbit and fluentd options in the values.yaml
* [#35208](https://github.com/rancher/rancher/issues/35208) Initial login lands on Error page
* [#35205](https://github.com/rancher/rancher/issues/35205) [BUG] Deleting a cluster in rancher dashboard doesn't fully remove it
* [#35204](https://github.com/rancher/rancher/issues/35204) [Monitoring v2] Stop releasing dependency charts
* [#35203](https://github.com/rancher/rancher/issues/35203) Support SSH for V2 (RKE2) provisioned nodes
* [#35180](https://github.com/rancher/rancher/issues/35180) RKE1 and RKE2 Clusters are stuck in Removing state
* [#35179](https://github.com/rancher/rancher/issues/35179) Nodes are not deleted from existing RKE2 cluster when clusters are deleted when RKE2 feature flag is disabled
* [#35161](https://github.com/rancher/rancher/issues/35161) Authorized Cluster Endpoint (ACE) support for imported RKE2/K3S clusters
* [#35140](https://github.com/rancher/rancher/issues/35140) Warn istio users not to upgrade more than one minor version at a time
* [#35112](https://github.com/rancher/rancher/issues/35112) Authorized Cluster Endpoint (ACE) for Imported RKE2 clusters
* [#35111](https://github.com/rancher/rancher/issues/35111) Rancher max version for logging V1
* [#35109](https://github.com/rancher/rancher/issues/35109) Logging failing to reach output set in rancher due to fluentd crashing repeatedly
* [#35100](https://github.com/rancher/rancher/issues/35100) New charts in 2.6.3
* [#35065](https://github.com/rancher/rancher/issues/35065) RKE2 / Harvester: Nodes stuck in provisioning when master nodes lack worker role - Still need to be tested for k8s 1.22
* [#35052](https://github.com/rancher/rancher/issues/35052) Enabling then disabling a node driver causes v2 provisioning to be extremely slow
* [#35018](https://github.com/rancher/rancher/issues/35018) Deleting a cluster that provisioned successfully but is in error state doesn't remove management cluster
* [#35000](https://github.com/rancher/rancher/issues/35000) [harvester] add rke1 cloud provider for harvester
* [#34997](https://github.com/rancher/rancher/issues/34997) RKE2 cluster never becomes healthy with certain machine pool names
* [#34992](https://github.com/rancher/rancher/issues/34992) [harvester node driver] unable to provision 1 role per node RKE2 cluster using harvester node driver 
* [#34990](https://github.com/rancher/rancher/issues/34990) remove Rancher related namespaces when removing cluster agents on imported provider clusters.
* [#34988](https://github.com/rancher/rancher/issues/34988) [KEv2] - remove fleet-agent when removing cluster agents on imported provider clusters.
* [#34978](https://github.com/rancher/rancher/issues/34978) [2.6] Forwardport vSphere CPI
* [#34972](https://github.com/rancher/rancher/issues/34972) Upgrade rancher base image to sle15:15.3.17.8.8
* [#34964](https://github.com/rancher/rancher/issues/34964) The managed system-upgrade-controller's version need to be updated
* [#34946](https://github.com/rancher/rancher/issues/34946) [harvester node driver] often, nodes are not being deleted on the backend when a cluster is deleted through rancher
* [#34945](https://github.com/rancher/rancher/issues/34945) RKE2 cluster stuck in deleting state on deleting it when one of the node pools failed provisioning
* [#34942](https://github.com/rancher/rancher/issues/34942) [rancher-alerting-drivers] bump prom2teams and sachet
* [#35529](https://github.com/rancher/rancher/issues/35529) [Monitoring v2] Update the Prometheus default memory limit to 3000Mi
* [#34914](https://github.com/rancher/rancher/issues/34914) RKE2 Provisioning - Nodepool doesn't self heal after correcting it's configuration. Custom Driver.
* [#34908](https://github.com/rancher/rancher/issues/34908) Updating cluster agentEnvVars does not trigger system agent upgrade
* [#34898](https://github.com/rancher/rancher/issues/34898) [monitoring v1] upgrade/install option not available in `cluster tools` after upgrading from 2.5.9 -> 2.6.1-rc3
* [#34894](https://github.com/rancher/rancher/issues/34894) Errors like "error syncing 'system-default-registry'" seen in rancher logs on a rancher server upgrade
* [#34886](https://github.com/rancher/rancher/issues/34886) [harvester global flag] toggle harvester node driver with the harvester global flag
* [#34876](https://github.com/rancher/rancher/issues/34876) Convert sync handler to env variables
* [#34845](https://github.com/rancher/rancher/issues/34845) Unable to provision RKE2 node driver clusters in an air-gapped setup in v2.6
* [#34825](https://github.com/rancher/rancher/issues/34825) Terraform AKSv2 - can't delete cluster object from Rancher after there's an error during import/create as Standard User
* [#34821](https://github.com/rancher/rancher/issues/34821) After clicking Create, no sign new cluster is being successfully added in UI
* [#34817](https://github.com/rancher/rancher/issues/34817) Failed delete cluster
* [#34815](https://github.com/rancher/rancher/issues/34815) Downstream cluster not listed in Cluster  Management page for sometime after rancher upgrade
* [#34801](https://github.com/rancher/rancher/issues/34801) Failed to download external drivers with Rancher proxy set
* [#34800](https://github.com/rancher/rancher/issues/34800) Cluster owner not able to edit Harvester cluster without accessing cloud credential
* [#35295](https://github.com/rancher/rancher/issues/35295) EKS upgrades loop without a default AMI list for v1.19 onwards
* [#34740](https://github.com/rancher/rancher/issues/34740) Update Kiali to 1.40.1
* [#34736](https://github.com/rancher/rancher/issues/34736) Feature charts: Add longhorn 1.2.2 chart in 2.6 and 2.5
* [#34734](https://github.com/rancher/rancher/issues/34734) Pin SLE BCI image version for KEv2 operators
* [#34721](https://github.com/rancher/rancher/issues/34721) Dashboard can be slow listing many large resources
* [#34720](https://github.com/rancher/rancher/issues/34720) [Logging v2] Add option to disable automation JSON parsing
* [#34712](https://github.com/rancher/rancher/issues/34712) Project owners don't have access to import yaml
* [#34701](https://github.com/rancher/rancher/issues/34701) Add support for annotation that prevents helm install and v1 App deletion when deleting v3 App
* [#34700](https://github.com/rancher/rancher/issues/34700) Cannot upgrade apps with deployments that were created in ember
* [#34686](https://github.com/rancher/rancher/issues/34686) Rancher 2.6 Cannot Login
* [#34628](https://github.com/rancher/rancher/issues/34628) [2.6] Forwardport vSphere CSI
* [#34597](https://github.com/rancher/rancher/issues/34597) [Forwardport, 2.6] Kubernetes Version in "edit cluster" not the same as in "clusters" (RKE2)
* [#34592](https://github.com/rancher/rancher/issues/34592) Missing Permissions in catalog management roles
* [#34591](https://github.com/rancher/rancher/issues/34591) [Forwardport] namespaces that are later added to SystemNamespaces don't get into system-project
* [#34584](https://github.com/rancher/rancher/issues/34584) Cluster Explorer Apps: Cannot download catalog that responds with a redirect
* [#34577](https://github.com/rancher/rancher/issues/34577) [Monitoring V2] Rebase Monitoring V2 to upstream kube-prometheus-stack 19.x.x
* [#34563](https://github.com/rancher/rancher/issues/34563) When restoring an RKE2 snapshot, the UI for a time shows an Error during restoration - it is benign but could confuse users
* [#34488](https://github.com/rancher/rancher/issues/34488) Failed to communicate with API server when etcd role node is removed
* [#34470](https://github.com/rancher/rancher/issues/34470) RKE2 version is not displaying it is an RC for imported clusters
* [#34403](https://github.com/rancher/rancher/issues/34403) Can't explore RKE2 cluster from Dashboard on byo-self-signed Rancher setup
* [#34367](https://github.com/rancher/rancher/issues/34367) RKE2 Azure clusters with Azure cloud provider only support 1 cloud config per cluster, but RKE2/k8s requires per node cloud provider config
* [#34308](https://github.com/rancher/rancher/issues/34308) "Error setting machine     configuration from flags provided: digitalocean driver requires the --digitalocean-access-token" seen on a machine pool during RKE2 provisioning
* [#34287](https://github.com/rancher/rancher/issues/34287) Upgrade helm chart to support cert-manager 1.5 -> 
* [#34190](https://github.com/rancher/rancher/issues/34190) "Error 500: Failed to findSession for client stv-cluster-c-xy" Seen on rancher server upgrade
* [#34154](https://github.com/rancher/rancher/issues/34154) Warning "CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+" when installing rancher backups
* [#34124](https://github.com/rancher/rancher/issues/34124) Update kubeversion for standard partner charts to be < k8s 1.22 for any partner charts that haven't introduced a k8s 1.22 supported chart
* [#34059](https://github.com/rancher/rancher/issues/34059) Validate the specific legacy features on k8s 1.22
* [#34058](https://github.com/rancher/rancher/issues/34058) Update Rancher server helm chart to allow deploying on k8s 1.22 clusters
* [#34056](https://github.com/rancher/rancher/issues/34056) Support k8s 1.22 in RKE2/k3s
* [#34055](https://github.com/rancher/rancher/issues/34055) Handling ComponentStatus (dropped API in k8s 1.22) in Rancher
* [#34054](https://github.com/rancher/rancher/issues/34054) Support k8s 1.22 in k8s clusters (updating go-client)
* [#34017](https://github.com/rancher/rancher/issues/34017) Jaeger All-In-One 1.25+
* [#33971](https://github.com/rancher/rancher/issues/33971) Deprecated APIs in cattle-cluster-agent logs in a downstream cluster
* [#33919](https://github.com/rancher/rancher/issues/33919) Cluster and Fleet agents cannot communicate with Rancher server behind a proxy with a certificate
* [#33916](https://github.com/rancher/rancher/issues/33916) Make Keycloak refresh token more efficient
* [#33895](https://github.com/rancher/rancher/issues/33895) Upgrade Helm to 3.6.3+
* [#33893](https://github.com/rancher/rancher/issues/33893) Cap rancher-external-ip-webhook to <=1.21
* [#33850](https://github.com/rancher/rancher/issues/33850) Use embedded etcd from k3s for single node usage
* [#33825](https://github.com/rancher/rancher/issues/33825) Remove EKS deprecated k8s version 1.17.
* [#35141](https://github.com/rancher/rancher/issues/35141) Nodenames for RKE2 provision on AWS - not matched on AWS provider
* [#33815](https://github.com/rancher/rancher/issues/33815) [forwardport 2.6] RoleBinding creation logs not outputting binding namespace
* [#33770](https://github.com/rancher/rancher/issues/33770) Warnings "CustomResourceDefinition is deprecated in v1.16+" seen in Rancher logs
* [#33758](https://github.com/rancher/rancher/issues/33758) Update the node driver from "Packet" to "Equinix Metal"
* [#33689](https://github.com/rancher/rancher/issues/33689) Secret available for all namespace not respect the labels provided
* [#33683](https://github.com/rancher/rancher/issues/33683) Istio 1.11+
* [#33672](https://github.com/rancher/rancher/issues/33672) Upgrade rancher logging to latest upstream
* [#33664](https://github.com/rancher/rancher/issues/33664) Rancher UI refreshes the UI page with no relevant logs in the rancher server
* [#33640](https://github.com/rancher/rancher/issues/33640) [cli] Make validating checksums easier
* [#33634](https://github.com/rancher/rancher/issues/33634) Remove k8s 1.22 "beta" prior to the 2.6 release
* [#33623](https://github.com/rancher/rancher/issues/33623) Update rancher-eks-operator to support kubernetes 1.22
* [#33622](https://github.com/rancher/rancher/issues/33622) Update rancher-aks-operator to support kubernetes 1.22
* [#33621](https://github.com/rancher/rancher/issues/33621) Update rancher-gke-operator to support kubernetes 1.22
* [#33518](https://github.com/rancher/rancher/issues/33518) Enable Azure Marketplace images through Node Driver
* [#33513](https://github.com/rancher/rancher/issues/33513) Update rancher-externalip-webhook chart to support kubernetes 1.22
* [#33465](https://github.com/rancher/rancher/issues/33465) [Monitoring V1, RKE1, RKE2] k8s 1.21 clusters do not display any metrics on Grafana
* [#33382](https://github.com/rancher/rancher/issues/33382) Validate Logging v1 can run on k8s 1.22 clusters
* [#34439](https://github.com/rancher/rancher/issues/34439) rancher-monitoring-crd chart does not make use of global toleration settings
* [#33332](https://github.com/rancher/rancher/issues/33332) Modernize kube-api-auth codebase
* [#33312](https://github.com/rancher/rancher/issues/33312) Update Ingress usages to support k8s 1.22
* [#33222](https://github.com/rancher/rancher/issues/33222) Validate Rancher runtime resources supported on k8s 1.22 clusters
* [#33126](https://github.com/rancher/rancher/issues/33126) Add 2.6 Audit log enhancements to Kubectl access path.
* [#33114](https://github.com/rancher/rancher/issues/33114) Add K8S v1.22.0 into KDM and RKE1
* [#33027](https://github.com/rancher/rancher/issues/33027) Add Enable PNI Option for AKS Clusters
* [#32884](https://github.com/rancher/rancher/issues/32884) [monitoring v2] Prometheus -> Classic UI is not working (404 errors) -> proxyURL is added twice to the request URL
* [#32833](https://github.com/rancher/rancher/issues/32833) Allow for Project Network Isolation (PNI) to be enabled for AKS clusters
* [#32744](https://github.com/rancher/rancher/issues/32744) Update vSphere CPI CSI default node selector label
* [#32742](https://github.com/rancher/rancher/issues/32742) Update RKE node selector label
* [#32634](https://github.com/rancher/rancher/issues/32634) RKE2 Provisioning - Self Signed and CA Certs
* [#32633](https://github.com/rancher/rancher/issues/32633) RKE2 Provisioning - Support Downstream Clusters behind a Proxy
* [#32304](https://github.com/rancher/rancher/issues/32304) Nodes do not get deleted in the backend during cluster creation when nodepools have same name
* [#32300](https://github.com/rancher/rancher/issues/32300) Update OPA chart to support k8s 1.22
* [#32262](https://github.com/rancher/rancher/issues/32262) Upgrade vSphere CSI Chart to v2.2.0
* [#32050](https://github.com/rancher/rancher/issues/32050) RKE2/K3S Upgrades from Rancher not working if master nodes are tainted on imported rke2/k3s clusters
* [#32412](https://github.com/rancher/rancher/issues/32412) Wrong icon for Longhorn app in Apps & Marketplace
* [#30718](https://github.com/rancher/rancher/issues/30718) Dashboard generates too many requests when listing resources
* [#30053](https://github.com/rancher/rancher/issues/30053) Update ingress api when lowest supported k8s version is 1.19
* [#29893](https://github.com/rancher/rancher/issues/29893) CVE Scanning
* [#29413](https://github.com/rancher/rancher/issues/29413) Clusters with AWS cloud provider enabled and using a VPC with private hosted zones (custom DNS) can't use cloud provider resources
* [#25487](https://github.com/rancher/rancher/issues/25487) Listing many large resources can be slow on the ember UI
* [#20654](https://github.com/rancher/rancher/issues/20654) Add functionality to specify limit of app revisions stored
* [#13666](https://github.com/rancher/rancher/issues/13666) After disabling and enabling AD using a different user for test and enable auth , this user is not allowed to log in to rancher server anymore. 
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

## All issues in v2.6.2 milestone

* [#35160](https://github.com/rancher/rancher/issues/35160) Panic seen after deleting imported cluster
* [#30842](https://github.com/rancher/rancher/issues/30842) Unable to update istio configuration in air-gapped environment in Rancher v2.5.x
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

## All issues in v2.6.1 milestone

* [#35062](https://github.com/rancher/rancher/issues/35062) [CI] Ensure `-patchX` and `-harvesterX` tags are marked as prereleases
* [#35047](https://github.com/rancher/rancher/issues/35047) BuildSubjectFromRTB does not include an APIGroup so apply fights k8s
* [#35046](https://github.com/rancher/rancher/issues/35046) RoleBindings for provisiong cluster roles are not unique
* [#35045](https://github.com/rancher/rancher/issues/35045) Add clusterID to managementuser settings controller error logging
* [#35004](https://github.com/rancher/rancher/issues/35004) [Provisioning v2] Race condition where fleet-local/local cluster is created with no kubeconfig secret
* [#34987](https://github.com/rancher/rancher/issues/34987) task: Harvester v0.3.0 related release note for Rancher v2.6.1
* [#34986](https://github.com/rancher/rancher/issues/34986) `rancher/machine` not found in `rancher-images.txt`
* [#34970](https://github.com/rancher/rancher/issues/34970) Error is seen: `error in planner for 'fleet-local/local': ignore handler error`
* [#34954](https://github.com/rancher/rancher/issues/34954) Fleet deploys repo to Harvester Clusters
* [#34948](https://github.com/rancher/rancher/issues/34948) Services are deploying, but are not working properly (i.e. nodeport)
* [#34947](https://github.com/rancher/rancher/issues/34947) [harvester node driver] unable to deploy v2 charts (i.e. monitoring v2, longhorn)
* [#34941](https://github.com/rancher/rancher/issues/34941) [harvester node driver] user can't provision rke1 cluster, node is stuck in `exit 0` loop
* [#34919](https://github.com/rancher/rancher/issues/34919) Can not edit/upgrade the app if the original chart is hidden by the rancher-version annotation 
* [#34901](https://github.com/rancher/rancher/issues/34901) AKS v2 [upgraded from v2.6.0 --> v2.6.1-rc3] stuck in loading resources while trying to edit the config 
* [#34900](https://github.com/rancher/rancher/issues/34900) [monitoring v2] unable to upgrade from 14.5.100 -> 100.0.0+up16.6.0 after rancher upgrade 2.5.9 -> 2.6.1-rc3. One of the CP nodes is not accessible
* [#34899](https://github.com/rancher/rancher/issues/34899) [monitoring v1] on v0.2.2, prometheus container is reporting OOM -- very frequent restarts after upgrading from 2.5.9 -> 2.6.1-rc3
* [#34897](https://github.com/rancher/rancher/issues/34897) OPA - mirrored-openpolicyagent-gatekeeper-crds:v3.6.0 image missing from rancher-images.txt of v2.6.1-rc3
* [#34891](https://github.com/rancher/rancher/issues/34891) [harvester node driver]  cluster is not provisioning; potential issue with nodes unable to pull docker images
* [#34889](https://github.com/rancher/rancher/issues/34889) [Hosted Rancher] resourceQuota controllers error logs on missing projects
* [#34880](https://github.com/rancher/rancher/issues/34880) Identify imported Harvester cluster
* [#34875](https://github.com/rancher/rancher/issues/34875) Convert ServerVersion to downstream env var
* [#34866](https://github.com/rancher/rancher/issues/34866) Unable to complete RKE2 cluster provision with rancherd
* [#34863](https://github.com/rancher/rancher/issues/34863) [2.6] Add support for cluster-level registry(rke) for shell and helm
* [#34862](https://github.com/rancher/rancher/issues/34862) v2.6.0 to v2.6-head upgrade- failed to create fleet-local `admission webhook "rancherauth.cattle.io" denied the request` errors are seen in the logs of rancher pods for a brief period when the mcm flag is set to false
* [#34855](https://github.com/rancher/rancher/issues/34855) Generating management schemas with `userAttribute` set to `true` results in panic
* [#34850](https://github.com/rancher/rancher/issues/34850) prometheus and prometheus-agent pods keep restarting on the local cluster of HA rancher setup when local cluster is k3s 
* [#34848](https://github.com/rancher/rancher/issues/34848) Errors seen spamming rancher server on an upgrade from 2.5.9 to 2.6.1
* [#34837](https://github.com/rancher/rancher/issues/34837) Hosted clusters are not deployed on Rancher Hosted setup after upgrade
* [#34835](https://github.com/rancher/rancher/issues/34835) Upgrading rancher server single node install by setting mcm to false `Failed to find system chart fleet` errors are seen in the rancher logs continuously
* [#34833](https://github.com/rancher/rancher/issues/34833) [Hosted Rancher, Monitoring V1, Alerting V1] CPU spike observed when Monitoring / Alerting installed in downstream Rancher's local cluster
* [#34824](https://github.com/rancher/rancher/issues/34824) "unable to create impersonator account ... serviceaccounts not found" error after upgrade from 2.5.9 to 2.6.0
* [#34807](https://github.com/rancher/rancher/issues/34807) Failures seen when rke-profile-permissive-1.6 scan is run on an rke1 node driver cluster
* [#34792](https://github.com/rancher/rancher/issues/34792) CI is failing based on Rancher panic in RKE cleanup
* [#34778](https://github.com/rancher/rancher/issues/34778) Terraform AKSv2 - network_plugin setting should default to kubenet
* [#34776](https://github.com/rancher/rancher/issues/34776) [Hosted Rancher] Fleet infinitely creates cluster management secrets when no system namespace exists
* [#34760](https://github.com/rancher/rancher/issues/34760) Clusters are stuck in unavailable state after upgrading from 2.5.9 to 2.6-head
* [#34758](https://github.com/rancher/rancher/issues/34758) Terraform AKSv2 - Terraform requires the dns_prefix field while Importing an AKS cluster but import fails as it cannot be changed
* [#34752](https://github.com/rancher/rancher/issues/34752) Terraform AKSv2 - Nodepool Error when using the default documented example
* [#34750](https://github.com/rancher/rancher/issues/34750) Terraform AKSv2 - 	Field [dnsServiceIp] must be provided for cluster [] config when Azure CNI network plugin is used
* [#34746](https://github.com/rancher/rancher/issues/34746) [Hosted Rancher] Consistent Max CPU load upon upgrade to v2.6.0
* [#34744](https://github.com/rancher/rancher/issues/34744) Downstream clusters are deleted upon upgrade that are managed in API-created Fleet workspaces
* [#34732](https://github.com/rancher/rancher/issues/34732) [Forwardport] RBAC project role (caching?) issue in Rancher
* [#34727](https://github.com/rancher/rancher/issues/34727) Pin SLE base image version
* [#34723](https://github.com/rancher/rancher/issues/34723) [cli] Rancher 2.6 Project context switching support
* [#34716](https://github.com/rancher/rancher/issues/34716) Services get deleted after importing Harvester to Rancher
* [#34713](https://github.com/rancher/rancher/issues/34713) RKE2 Provisioning: can't delete misconfigured node from node pool/cluster in Rancher
* [#34699](https://github.com/rancher/rancher/issues/34699) Istio v2 upgrade fails from 1.8.6 to 1.9.x when policy is enabled previously and the charts are uninstalled and reinstalled `upgrade version check failed: 1.8.6 -> 1.9.8. Error: found 1 unsupported v1alpha1 security policy`
* [#34696](https://github.com/rancher/rancher/issues/34696) [2.6]Corrupted Backup - No Restore Rancher Management Cluster / Rancher Server
* [#34691](https://github.com/rancher/rancher/issues/34691) Unable to upgrade RKE2 cluster (rancherd installation)
* [#34671](https://github.com/rancher/rancher/issues/34671) helm upgrade/delete intermittently fails with errors like "unable to create impersonator account: error setting up impersonation for user u-xxxxx..Operation cannot be fulfilled on clusterroles.rbac.authorization.k8s.io \"cattle-impersonation-u-8j72f\": the object has been modified; please apply your changes to the latest version and try again."
* [#34663](https://github.com/rancher/rancher/issues/34663) No way to determine if v1 istio is installed in a cluster
* [#34639](https://github.com/rancher/rancher/issues/34639) [2.6] Automatic creation/sync of services <-> workload ports permanently lost after 2.5.8->2.6.0
* [#34636](https://github.com/rancher/rancher/issues/34636) [2.6] Deployment init container, init logs are not visible
* [#34631](https://github.com/rancher/rancher/issues/34631) [v2.6] KDM Update for K8s September patch release
* [#34756](https://github.com/rancher/rancher/issues/34756) Rancher 2.6: Fetching the secret from Azure AD occasionally fails
* [#34593](https://github.com/rancher/rancher/issues/34593) OPA Gatekeeper - Update to 3.6.0
* [#34589](https://github.com/rancher/rancher/issues/34589) New Charts in 2.6.1
* [#34580](https://github.com/rancher/rancher/issues/34580) Rancher 2.6.0 rancher-agent fails to provision on FIPS enabled node
* [#34565](https://github.com/rancher/rancher/issues/34565) AWS rke2 node driver multi-nodes are stuck in provisioning in cluster management page with only etcd and control plane active in the explore cluster page
* [#34561](https://github.com/rancher/rancher/issues/34561) [KEv2] Cluster agents on imported hosted provider clusters aren't cleaned up
* [#34555](https://github.com/rancher/rancher/issues/34555) Corrupted Backup - No Restore Rancher Management Cluster / Rancher Server
* [#34542](https://github.com/rancher/rancher/issues/34542) [not always reproducible] RKE2 Nodes are not being removed from backend/provider when deleting infrastructure-provider clusters through rancher
* [#34508](https://github.com/rancher/rancher/issues/34508) [Rancher Webhook] pre-delete-hook-psp is created when preDelete.enabled is set to false
* [#34486](https://github.com/rancher/rancher/issues/34486) cluster-agent pod is not deleted from an imported cluster running rancher.
* [#34479](https://github.com/rancher/rancher/issues/34479) Feature charts: Add max of 2.5.99 on all 2.5.x charts, add min of 2.6.0 on all 2.6.x charts.
* [#34473](https://github.com/rancher/rancher/issues/34473) when user updates rke-metadata-config on dev-v2.6, refreshing `Kontainer-driver-metadata` does not update available k8s versions
* [#34462](https://github.com/rancher/rancher/issues/34462) Attempting to restore a local snapshot a second time has no effect
* [#34437](https://github.com/rancher/rancher/issues/34437) Update provisioning tests to use the correct environment variable for system-agent image
* [#34425](https://github.com/rancher/rancher/issues/34425) cluster not recoverable after adding base64 encoded ca.pem to `ca cert bundle` option when provisioning cluster (private registries -> advanced)
* [#34306](https://github.com/rancher/rancher/issues/34306) Change events and deleting provisioning clusters is causing clusters to re-appear in the UI 
* [#34292](https://github.com/rancher/rancher/issues/34292) Remove the Rancher dependency on the PowerShell commandlets
* [#34291](https://github.com/rancher/rancher/issues/34291) Ability to specify network tags for node pools in GKE cluster (via Terraform provider)
* [#34161](https://github.com/rancher/rancher/issues/34161) Rancher 2.6 - updating/upgrading  aks cluster
* [#34065](https://github.com/rancher/rancher/issues/34065) [Forwardport] ingress controller workload fails to deploy in a windows 1.21 cluster
* [#34035](https://github.com/rancher/rancher/issues/34035) forwardport: RKE2 Templates: Deleting cluster created with a template does not clean up all resources (digitaloceanConfigs left behind)
* [#33889](https://github.com/rancher/rancher/issues/33889) aks operators api *string type doesn't match at generated rancher go cli
* [#33843](https://github.com/rancher/rancher/issues/33843) Istio upgrade from v1.7.301 to v1.10.2 fails with the error `version: 1.7.3 does not match the target version 1.10.2` when policy is enabled in 1.7.301
* [#33839](https://github.com/rancher/rancher/issues/33839) [Logging v1] fluentd:v0.1.28 is stuck in installing state
* [#33838](https://github.com/rancher/rancher/issues/33838) Istio v1 1.5.920 fails to install on an upgrade with the error `Failed to install app cluster-istio. Error: UPGRADE FAILED: release: "cluster-istio.v2" already exists`
* [#33831](https://github.com/rancher/rancher/issues/33831) Unable to install monitoring v1 0.2.3 `Failed to install app cluster-alerting. Error: validation failed: unable to recognize "": no matches for kind "ServiceMonitor" in version "monitoring.coreos.com/v1"`
* [#33800](https://github.com/rancher/rancher/issues/33800) Should not delete the cattle-system namespace when deleting the imported k8s cluster when Rancher pod is running in it
* [#33774](https://github.com/rancher/rancher/issues/33774) Clusters deleted immediately from Cluster Management page but not from Home page
* [#33605](https://github.com/rancher/rancher/issues/33605) Harvester Integration - Feature Flag for Harvester
* [#33583](https://github.com/rancher/rancher/issues/33583) Add built-in Harvester node driver
* [#33694](https://github.com/rancher/rancher/issues/33694) Unable to create custom rke2 cluster with specific names
* [#33426](https://github.com/rancher/rancher/issues/33426) aksv2 - upgrading CP's k8s version along with adding a NP, throws error
* [#33335](https://github.com/rancher/rancher/issues/33335) Test CIS v2 with upstream newer Sonobuoy version
* [#33110](https://github.com/rancher/rancher/issues/33110) Restricted admin can't install RKE2 templates
* [#32964](https://github.com/rancher/rancher/issues/32964) Unable to remove offline node from HA cluster
* [#32624](https://github.com/rancher/rancher/issues/32624) [rancher alerting drivers] Need a Logo for the helm chart 
* [#32405](https://github.com/rancher/rancher/issues/32405) Test 1.22 early as it is dropping support for deprecated features
* [#32390](https://github.com/rancher/rancher/issues/32390) RKE2 Provisioning: Cluster Options - Cloud Provider Support
* [#32373](https://github.com/rancher/rancher/issues/32373) RKE2 Provisioning: Generic Machine Driver (Node Pool)
* [#31296](https://github.com/rancher/rancher/issues/31296) Update terraform provider for AKSv2
* [#28776](https://github.com/rancher/rancher/issues/28776) Rancher crashes after adding a catalog containing a chart with missing name and version
* [#27864](https://github.com/rancher/rancher/issues/27864) floating ip race condition in openstack node driver
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
