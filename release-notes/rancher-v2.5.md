# Release v2.5.17

**This release concludes support for [Rancher 2.5](https://www.suse.com/lifecycle/). Please upgrade to a newer version of Rancher for continued support.**

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.5.17 is a security release to address the following issues:**

# Security Fixes for Rancher Vulnerabilities

This release addresses **04 security issues** found in Rancher:

- Improved authorization logic checks around project role template binding (PRTB) and `-promoted` roles to protect against possible privilege escalation. For more information, see [CVE-2022-43759](https://github.com/rancher/rancher/security/advisories/GHSA-7m72-mh5r-6j3r).

- Fixed an issue in Rancher's Git package that could potentially lead to command injection. For more information, see [CVE-2022-43758](https://github.com/rancher/rancher/security/advisories/GHSA-34p5-jp77-fcrc).

- Fixed an issue where sensitive fields and credentials like secret tokens, encryption keys, and SSH keys were stored as plaintext on Kubernetes objects. This is a follow-up security fix to address the fields missed in [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f). For more information, see [CVE-2022-43757](https://github.com/rancher/rancher/security/advisories/GHSA-cq4p-vp5q-4522).

- Fixed an authorization logic flaw that allowed an authenticated user on any downstream cluster to (1) open a shell pod in the Rancher local cluster and (2) have limited kubectl access to the local cluster. For more information, see [CVE-2022-21953](https://github.com/rancher/rancher/security/advisories/GHSA-g25r-gvq3-wrq7).

Additionally, the following security related updates were performed in this release to address security issues:

- Fixed a validation check issue where Rancher generated tokens are not revoked after modifications are made to a configured authentication provider. This issue is only applicable if external authentication providers were configured in Rancher. For more information, see security advisory [GHSA-c45c-39f6-6gw9](https://github.com/rancher/rancher/security/advisories/GHSA-c45c-39f6-6gw9).

- Updated the version of Rancher's Fleet chart to `0.3.1000+up0.3.10-security1` to address two security issues in [`rancher/wrangler`](https://github.com/rancher/wrangler) dependency:

  - The high severity [CVE-2022-31249](https://github.com/rancher/wrangler/security/advisories/GHSA-qrg7-hfx7-95c5) that could lead to a command injection vulnerability in Rancher's Continuous Delivery feature through Fleet's GitJob pod.

  - The medium severity [CVE-2022-43756](https://github.com/rancher/wrangler/security/advisories/GHSA-8fcj-gf77-47mg) that could cause a denial of service (DoS) attack in Fleet's GitJob pod.

- Updated the version of [`crewjam/saml`](https://github.com/crewjam/saml) SAML library to address the critical severity [CVE-2022-41912](https://github.com/crewjam/saml/security/advisories/GHSA-j2jp-wvqg-wc2g).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:**
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:**
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:**
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS requirements:**
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:**
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:**
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**:
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.17
- rancher/rancher-agent:v2.5.17

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.22](https://github.com/rancher/rke/releases/tag/v1.2.22)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - AKS Kubernetes versions 1.20 and earlier have reached end of life. As Rancher v2.5 does not support Kubernetes greater than 1.20, it is not possible to provision new downstream AKS clusters. See [#38406](https://github.com/rancher/rancher/issues/38406).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.
- **Cluster Tools**
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022.
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.
  - **Docker installs:**
    - UI issues may occur due to a longer startup time.
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----
# Release v2.5.16

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Fixes for Rancher Vulnerabilities

This release addresses three **critical severity** security issues found in Rancher:

- Fixed an issue where sensitive fields like passwords, API keys, and Rancher's service account token were stored as plaintext on Kubernetes objects. Any user with read access to those objects in the Kubernetes API could retrieve the plaintext version of those sensitive data. For more information, see [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f).

- Improved the sanitization (removal) of credentials from cluster template answers. Failure to sanitize data can lead to plaintext storage and exposure of credentials, passwords, and API tokens. For more information, see [CVE-2021-36783](https://github.com/rancher/rancher/security/advisories/GHSA-8w87-58w6-hfv8).

- Fixed an authorization logic flaw that allowed privilege escalation in downstream clusters through cluster role template binding (CRTB) and project role template binding (PRTB). For more information, see [CVE-2022-31247](https://github.com/rancher/rancher/security/advisories/GHSA-6x34-89p7-95wg).

For more details, see the [Security Advisories page](https://github.com/rancher/rancher/security/advisories).

# Features and Enhancements

### Azure Active Directory API Migration

Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#37228](https://github.com/rancher/rancher/issues/37228) for details.

- **Limitations**
  - Attempts to log in will fail after rolling back a Docker install of Rancher if the following conditions have occurred:
    - Azure AD is enabled.
    - Before the rollback, admins committed to the Azure AD configuration update.

    This is because the Azure AD endpoints will not be rolled back if the rollback is not performed via the backup-restore operator. If you want to roll back Rancher to use the old Azure AD Graph API without using the backup-restore operator, follow this [workaround](https://github.com/rancher/rancher/issues/38025#issuecomment-1213208087) to edit the AzureAD authconfig resource stored in the local cluster's database. The old Azure AD Graph API endpoints will not be rolled back on a Rancher rollback. See [#38025](https://github.com/rancher/rancher/issues/38025).
- **Other**
  - Multi-factor authentication (MFA) now works with the Azure AD auth provider. Some Rancher setups might have had MFA enabled in Azure from before, but Rancher wasn't working with it correctly. Be aware that on upgrade, if MFA is enabled for the Azure app, Rancher will require additional verification. See [#38028](https://github.com/rancher/rancher/pull/38028).
  - Before starting the migration process or enabling Azure AD for the first time in v2.6.7+, ensure that you add the Azure app registration's permissions of type **Application** and **NOT Delegated** for Microsoft Graph. Otherwise, you may not be able to login to Azure AD. This issue will persist even after you disable/re-enable Azure AD and will require an hour wait, or manual deletion of a cache value to resolve.

# Major Bug Fixes

- Prior to `v2.5.16`, if S3 or other kinds of credentials were added to a cluster after it was already created, the reference to the secret containing the credentials was lost because the cluster status cannot updated through the API. The references are now moved to the cluster Spec so that they can be updated added after creation. To repair a cluster after a upgrade to `v2.5.16`, edit the cluster and change the etcd snapshot configuration back to local and save it, then edit again to configure S3 snapshots again. See [#38397](https://github.com/rancher/rancher/issues/38397).
- Fixed a bug that overloaded the downstream Kubernetes API server when the Cluster Explorer dashboard was left open to a page for a downstream cluster for over 30 minutes and would start rapidly opening and closing watch requests perpetually. See [#37986](https://github.com/rancher/rancher/issues/37986).
- Fixed an issue where issues in a downstream cluster would cause a controller to frequently restart and eventually lead to a Goroutine leak. See [#37965](https://github.com/rancher/rancher/issues/37965).
- Updated an internal download link that was causing upgrades to fail. See [#37859](https://github.com/rancher/rancher/issues/37859).
- Increased entropy of CSRF (cross-site request forgery) token. See [#15](https://github.com/rancher/apiserver/pull/15) and [#419](https://github.com/rancher/norman/pull/419).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:**
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:**
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:**
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS requirements:**
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:**
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:**
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**:
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.16
- rancher/rancher-agent:v2.5.16

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.22](https://github.com/rancher/rke/releases/tag/v1.2.22)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - AKS Kubernetes versions 1.20 and earlier have reached end of life. As Rancher v2.5 does not support Kubernetes greater than 1.20, it is not possible to provision new downstream AKS clusters. See [#38406](https://github.com/rancher/rancher/issues/38406).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.
- **Cluster Tools**
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022.
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.
  - **Docker installs:**
    - UI issues may occur due to a longer startup time.
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).
-----
**Rancher v2.5.15 is a mirror release of [v2.5.14](https://github.com/rancher/rancher/releases/tag/v2.5.14) with one change to address the following issue:**

- A major performance issue was occurring when Rancher was attempting to control large volumes of traffic from downstream clusters. This mechanism was not handling disconnects properly and would result in indefinite locks. See [#38097](https://github.com/rancher/rancher/issues/38097).
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Fixes for Rancher Vulnerabilities

This release addresses one security issue found in Rancher:

- Fixed an issue in RKE Templates when creating a cluster with Weave as CNI: the template was not configuring a password for network traffic encryption in Weave, and therefore network traffic in the cluster was being sent unencrypted. For more information, see [CVE-2022-21951](https://github.com/rancher/rancher/security/advisories/GHSA-vrph-m5jj-c46c).

For more details, see the [security advisories page](https://github.com/rancher/rancher/security/advisories).

# Major Bug Fixes

- Rancher now successfully provisions all downstream cluster types with private registries with the RKE template as expected. See [#37515](https://github.com/rancher/rancher/issues/37515).
- Fixed an issue in which a new log was introduced under error level rather than debug level. Note that if conditions occur that result in these log messages, no user intervention is necessary. The buffer will simply be paused from taking any input until it is no longer full. See [#36584](https://github.com/rancher/rancher/issues/36584).
- After the YAML is directly modified in RKE clusters, support for multiple private registries now functions as expected. See [#37732](https://github.com/rancher/rancher/pull/37732).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:** 
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** 
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** 
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** 
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** 
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** 
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**: 
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.14
- rancher/rancher-agent:v2.5.14

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.20](https://github.com/rancher/rke/releases/tag/v1.2.20)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.  
- **Cluster Tools**
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022. 
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** 
    - UI issues may occur due to a longer startup time. 
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----
# Release v2.5.13

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Fixes for Rancher Vulnerabilities

This release addresses security issues found in Rancher:

- Improved authorization check to prevent privilege escalation of users who have `create` and `update` permissions on Global Roles. For more information see: [CVE-2021-36784](https://github.com/rancher/rancher/security/advisories/GHSA-jwvr-vv7p-gpwq).
- Fixed an issue that granted write permissions on `CatalogTemplates` or `CatalogTemplateVersions` to regular users when `restricted-admin` is enabled as default user in Rancher. For more information see: [CVE-2021-4200](https://github.com/rancher/rancher/security/advisories/GHSA-hx8w-ghh8-r4xf).
- Updated version of external `go-getter` library used in Fleet to avoid leaking SSH private keys in Rancher UI and in Fleet's deployment pod logs. For more information see: [GHSA-wm2r-rp98-8pmh](https://github.com/rancher/rancher/security/advisories/GHSA-wm2r-rp98-8pmh).

For more details, see the [security advisories page](https://github.com/rancher/rancher/security/advisories).

# Major Bug Fixes

- When an auth group is assigned to the Restricted Admin global role, not all permissions are properly applied and the Rancher logs are spammed with the error `RoleBinding.rbac.authorization.k8s.io "my-role-name" is invalid`. See [#36621](https://github.com/rancher/rancher/issues/36621).
- Equinix Metal driver version updated. See [#34742](https://github.com/rancher/rancher/issues/34742).
- Cannot create a backup in Cluster Explorer after switching the interface language to Simplified Chinese. See [#33654](https://github.com/rancher/rancher/issues/33654).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:** 
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** 
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** 
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** 
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** 
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** 
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**: 
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.13
- rancher/rancher-agent:v2.5.13

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.19](https://github.com/rancher/rke/releases/tag/v1.2.19)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in v2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being rewritten and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.  
- **Cluster Tools**
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022. 
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** 
    - UI issues may occur due to a longer startup time. 
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----

-----

-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Major Bug Fixes

- Fixed RBAC issue in Cluster Explorer in which the schema was not being updated. See [#31982](https://github.com/rancher/rancher/issues/31982).
- Updated YAML for rancher logging output fields such that the secret containing the value is referenced correctly. See [#4578](https://github.com/rancher/dashboard/issues/4578).
- Fixed an issue in which LDAP servers that returned specific high-value error codes (such as 4096) would cause Rancher to invalidate users' kubeconfig tokens during the nightly auth refresh, or when users attempted to use their kubeconfig tokens. See [#35791](https://github.com/rancher/rancher/issues/35791).
- New and existing rancher-webhook deployments will automatically renew their TLS certificates when the expiration date is 30 days or less. See [#35068](https://github.com/rancher/rancher/issues/35068).
- Backups that take longer than five minutes no longer cause Rancher to start a new backup nor delete the backup that is currently running. See [#36038](https://github.com/rancher/rancher/issues/36038). 
- Fixed an issue in which `iptables-save` failed due to segfault in RHEL 8.2, 8.3, and 8.4. See [#34604](https://github.com/rancher/rancher/issues/34604).
- Rancher now properly ensures the old add-on upgrade jobs are deleted as part of the Kubernetes version upgrade process; this prevents an issue where a cluster may end up reporting as "Active" without having some add-on(s) actually upgraded. See [#36037](https://github.com/rancher/rancher/issues/36037).
- Cluster health checks no longer fail from random downstream clusters becoming unreachable. See [#34819](https://github.com/rancher/rancher/issues/34819).
- Fixed an issue in which the restricted admin user had limited capabilities and was unable to perform essential tasks such as viewing downstream clusters and changing Rancher's settings. See [#36094](https://github.com/rancher/rancher/pull/36094).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:** 
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** 
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade with RKE1 to Kubernetes v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** 
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** 
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** 
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** 
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**: 
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.12
- rancher/rancher-agent:v2.5.12

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.16](https://github.com/rancher/rke/releases/tag/v1.2.16)

### Kubernetes Versions
- 1.20.14 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in v2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being rewritten and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.  
- **Cluster Tools**
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022. 
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** 
    - UI issues may occur due to a longer startup time. 
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----

-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Enhancements

- Updated NGINX to latest and make allow-snippets-annotations configurable. See [#35164](https://github.com/rancher/rancher/issues/35164).

# Major Bug Fixes

- The API Server has been updated to fix slow consumers causing deadlocks. See [#34907](https://github.com/rancher/rancher/pull/34907).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
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
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE Requirements:** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** There was a setting for Rancher versions prior to 2.5.8 allowing users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in app & marketplace there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used and it should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the documentation for the new instructions.
- **Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.11
- rancher/rancher-agent:v2.5.11

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.14](https://github.com/rancher/rke/releases/tag/v1.2.14)

### Kubernetes Versions
- 1.20.12 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)

### Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
- **Cluster Tools**
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring**
  - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
  - **Legacy Monitoring**
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
  - **Installation Requirements**
    - Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
  - **Backup and Restore**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.
# Features and Enhancements

- **Deploying on hardened clusters**: Support has been added for deploying EKS, AKS, and GKE clusters when the Rancher Management server cluster has been CIS hardened. See [#33172](https://github.com/rancher/rancher/issues/33172).

### Security Enhancements

- Fixed RBAC project role issue in Rancher v2.5 Cluster Explorer. Role revisions are now properly tracked for ClusterRoles associated to RoleBinding resources. This allows returning up-to-date schemas for users and not evaluating a user's access from stale access states. See [#31982](https://github.com/rancher/rancher/issues/31982).

# Major Bug Fixes

- Project Network Isolation ingress NetworkPolicy resources now get configured correctly when using Calico CNI with IPIP or VXLAN routing. See [#34084](https://github.com/rancher/rancher/issues/34084).
- The health status of the Controller Mananger and Scheduler on the dashboard will show as Not Applicable on clusters where the componentstatus is not available. See [#32905](https://github.com/rancher/rancher/issues/32905).
- EKS, AKS, and GKE provisioners now correctly use any additional CAs passed to Rancher, if provided. See [#32903](https://github.com/rancher/rancher/issues/32903).
- When deploying an EKS or GKE cluster on hosted Rancher, cluster provisioning is now successful. See [#33053](https://github.com/rancher/rancher/issues/33053).
- The API Server has been updated to fix slow consumers causing deadlocks. See [#34907](https://github.com/rancher/rancher/pull/34907).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
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
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE Requirements:** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** There was a setting for Rancher versions prior to 2.5.8 allowing users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in app & marketplace there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used and it should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the documentation for the new instructions.
- **Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.10
- rancher/rancher-agent:v2.5.10

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.13](https://github.com/rancher/rke/releases/tag/v1.2.13)

### Kubernetes Versions
- 1.20.8 (Default)
- 1.19.12
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)

### Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
- **Cluster Tools**
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring**
  - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
  - **Legacy Monitoring**
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
  - **Installation Requirements**
    - Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
  - **Backup and Restore**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).

-----
# Release v2.5.9

# Changes in this Release

## Security Fixes for Rancher Vulnerabilities

This release addresses security issues found in Rancher:

- Prevented privilege escalation via a malicious "Connection" header. [#33588](https://github.com/rancher/rancher/issues/33588) Fixes [CVE-2021-31999.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-31999)
- Used apiGroups instead of "*" when creating Kubernetes RBAC resources for apps to avoid granting permissions to all app CRDs that exist in the cluster. Fixes [CVE-2021-25318.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25318) [#33590](https://github.com/rancher/rancher/issues/33590)
- An unprivileged user can no longer use another user's cloud credential for API requests to a cloud provider. Fixes [CVE-2021-25320.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25320) [#33589](https://github.com/rancher/rancher/issues/33589)

For more details, see the [security advisories page](https://github.com/rancher/rancher/security/advisories).

## Additional Security Fixes

- Processes no longer panic upon receipt of malicious protobuf messages. Fixes [CVE-2021-3121.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121) [#32944](https://github.com/rancher/rancher/pull/32944)
- Updated minio-go, removed dependency on etcd, and updated rancherd RKE2 version to v1.20.7+rke2r2. [#33050](https://github.com/rancher/rancher/pull/33050)

## Bug Fixes

- vSphere vCenter server entries are removed properly. [#27306](https://github.com/rancher/rancher/issues/27306)
- The size of v3.Catalog objects was reduced to avoid timeouts and CPU consumption spikes. [#33256](https://github.com/rancher/rancher/issues/33256)
- Services that are automatically deployed for workloads are removed when the workloads are removed. [#33180](https://github.com/rancher/rancher/issues/33180)
- Rancher startup is no longer blocked by CleanupDuplicateBindings. [#32873](https://github.com/rancher/rancher/issues/32873)
- Move non-error logging for etcd backups to debug to avoid flooding logs when a lot of clusters are managed. [#32826](https://github.com/rancher/rancher/issues/32826)
- Fixed an issue where nodes get stuck in Active when more than 5 nodes are being created at a time. [#32681](https://github.com/rancher/rancher/issues/32681)
- Errors are no longer seen when registering more than 100 clusters simultaneously. [#32154](https://github.com/rancher/rancher/issues/32154)
- Nodes are no longer stuck at "waiting to register" after Rancher is upgraded. [#31999](https://github.com/rancher/rancher/issues/31999)

# Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)
- For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. [#32002](https://github.com/rancher/rancher/issues/32002)
- For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster.
[#32216](https://github.com/rancher/rancher/issues/32216)
- For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. [#3226](https://github.com/rancher/docs/issues/3226)
- There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. [#31789](https://github.com/rancher/rancher/issues/31789)
- When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in app & marketplace there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used and it should not delete the real fleet-agent deployment since it has been migrated. [#362](https://github.com/rancher/fleet/issues/362)

### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time. [#28800](https://github.com/rancher/rancher/issues/28800) [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

# Known Major Issues
- Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. [#32325](https://github.com/rancher/rancher/issues/32325)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5. Please see above in Deprecated Features.
- In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.
- Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
- Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. [#32535](https://github.com/rancher/rancher/issues/32535)
- Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. [#32563](https://github.com/rancher/rancher/issues/32563)

# Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - When accessing tracing information for a service in the Kiali dashboard bundled with v1.9.3 and v1.8.5, attempting to change the display options may result in a persistent error for that service's tracing information. We recommend using the Jaeger dashboard if you would like different details for a particular services tracing until this issue is resolved. The resolution for this issue can be found in [#32330](https://github.com/rancher/rancher/issues/32330)
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)


# Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

# Versions within Rancher

### Images
- rancher/rancher:v2.5.9
- rancher/rancher-agent:v2.5.9

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.9](https://github.com/rancher/rke/releases/tag/v1.2.9)

### Kubernetes Versions

- 1.20.8 (Default)
- 1.19.12
- 1.18.20
- 1.17.17

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/)

Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.

**Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----

-----
# Release v2.5.8

# Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)
- For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. [#32002](https://github.com/rancher/rancher/issues/32002)
- For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster.
[#32216](https://github.com/rancher/rancher/issues/32216)
- For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. [#3226](https://github.com/rancher/docs/issues/3226)
- There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. [#31789](https://github.com/rancher/rancher/issues/31789)

### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time. [#28800](https://github.com/rancher/rancher/issues/28800) [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

# Enhancements


### Monitoring Enhancements

- Monitoring graphs have been added to the Cluster Explorer in the Rancher UI. [#30126](https://github.com/rancher/rancher/issues/30126)
- A new RBAC role has been added to give users read-only access to monitoring components such as the Grafana dashboard. [#31411](https://github.com/rancher/rancher/issues/31411) [Docs](https://rancher.com/docs/rancher/v2.5/en/monitoring-alerting/rbac/#additional-monitoring-clusterroles)
- Persistent Grafana dashboards can now be created by adding a ConfigMap to any namespace, and a narrower permission named **Manage Config Maps** is required to create them. [#31921](https://github.com/rancher/rancher/issues/31921) [Docs](https://rancher.com/docs/rancher/v2.5/en/monitoring-alerting/persist-grafana/)
- As of v2.5.8, users no longer need to manually annotate the `cattle-dashboards` namespace with `helm.sh/resource-policy: "keep"` to prevent it, and its associated resources, from being deleted when uninstalling the Monitoring chart. For users who are using Monitoring V2 v9.4.203 or below, the namespace still needs to be manually marked with the annotation `helm.sh/resource-policy: "keep"`. [#31769](https://github.com/rancher/rancher/issues/31769)
- You can now more easily set up SMS and Teams notifiers using our new `rancher-alerting-drivers` Helm chart that helps you install alerting drivers that are not natively supported by Prometheus. [#29951](https://github.com/rancher/rancher/issues/29951)

##### Windows Support for Monitoring V2

- For metrics to be scraped from Windows nodes, each Windows node in the cluster must use wins v.0.1.0. For details on upgrading wins on Windows nodes, refer to [this page.](https://rancher.com/docs/rancher/v2.5/en/monitoring-alerting/windows-clusters/#upgrading-existing-clusters-to-wins-v0-1-0) [#31842](https://github.com/rancher/rancher/issues/31842)
- Metrics will be scraped from Windows nodes using [windows\_exporter](https://github.com/prometheus-community/windows_exporter) (a community project previously named `wmi_exporter` when deployed in Monitoring V1). [#31148](https://github.com/rancher/rancher/issues/31148) [#31497](https://github.com/rancher/rancher/issues/31497)
- The Monitoring V2 application adds Linux nodeSelectors and tolerations throughout all monitoring components to ensure they are never deployed on a Windows host. [#31498](https://github.com/rancher/rancher/issues/31498)
- We now allow a container to publish a port available on the host network as a container port. This allows privileged containers using wins to avoid exposing a port on the host itself when it only needs to be exposed on the container level. [#13](https://github.com/rancher/wins/issues/13)
- As of v2.5.8, when Rancher provisions a new Windows cluster, the cluster is able to support wins upgrades and it is able to use the new Monitoring V2 chart with no changes. [#31499](https://github.com/rancher/rancher/issues/31499)

### Enhanced GKE Lifecycle Management

Full lifecycle management has been brought to GKE clusters that are newly provisioned or registered:

-   [Shared VPCs](https://cloud.google.com/vpc/docs/shared-vpc) are now supported.
-   We now support more options for configuring private GKE clusters. Note: This advanced setup can require more steps during the cluster provisioning process. For details, see [this section.](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/gke/#private-clusters)
-   We now support more configuration options for Rancher managed GKE clusters. For the full list of options, see the [docs.](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/gke/config-reference/)
-   When provisioning a GKE cluster, you can now use reusable cloud credentials instead of using a service account token directly to create the cluster.
-   Greater management capabilities are now available for registered GKE clusters. The same configuration options are available for registered GKE clusters as for the GKE clusters created through the Rancher UI. [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/registered-clusters/#additional-features-for-registered-eks-and-gke-clusters)

### Logging Enhancements

- Upgraded the Banzai logging operator. [#31644](https://github.com/rancher/rancher/issues/31644)
- Logging now works on SELinux enabled setups and has been tested on RHEL/CentOS 7 and 8. Note that If journald is configured in persistent mode on RKE2 cluster nodes you will need to set `systemdLogPath` to `/var/log/journal`. This is the default behavior in Ubuntu. [#30949](https://github.com/rancher/rancher/issues/30949) [#31309](https://github.com/rancher/rancher/issues/31309) [Rancher RPM installation docs.](https://rancher.com/docs/rancher/v2.5/en/security/selinux/)

##### Windows Support for Logging V2

- Added support for Windows clusters. Logs can now be collected from Windows Nodes. [#28721](https://github.com/rancher/rancher/issues/28721)

### Istio Enhancements

- Clusters with PSPs enabled are now supported. PSP templates have been added and can be enabled for Istio, Kiali, and Tracing. [#30744](https://github.com/rancher/rancher/issues/30744)
- Added v1.9.3 and v1.8.5 for Istio, which both address a vulnerability. For more info see the [security announcement](https://istio.io/latest/news/security/istio-security-2021-002/). Only v1.9.3 supports an air gapped installation.

### Backup Enhancements

- Rancher Continuous Delivery (Fleet) and rancher-operator are now handled during backup. [Backup#69](https://github.com/rancher/backup-restore-operator/issues/69)

### CIS Scan Enhancements

- Support for CIS scans using the CIS 1.6 benchmark has been added for RKE2 and K3s clusters. [#29649](https://github.com/rancher/rancher/issues/29649)

### Fleet Enhancements

- All labels on Rancher clusters are available using `global.fleet.clusterLabels.LABELNAME`. These can now be accessed directly as variables. [#152](https://github.com/rancher/fleet/issues/152) [Docs](https://github.com/rancher/fleet/blob/master/docs/gitrepo-structure.md)
- Downstream Fleet agents now fall back to Linux nodes if Windows nodes are not yet available in Windows clusters. [#324](https://github.com/rancher/fleet/issues/324)
- Fleet now supports authentication with private Helm repositories. Note that SSH keys with passphrase are not supported. [#120](https://github.com/rancher/fleet/issues/120) [Docs](https://github.com/rancher/fleet/blob/master/docs/gitrepo-structure.md)
- Fleet now supports using webhook to receive changes from git. [#252](https://github.com/rancher/fleet/issues/252)
- Rancher agent and Fleet agent work behind a proxy. RFE tickets: [#29993](https://github.com/rancher/rancher/issues/29993) and [#25412](https://github.com/rancher/rancher/issues/25412)

### RKE Cluster Enhancements

Users can enable project network isolation on any RKE cluster if the CNI network plugin supports the enforcement of Kubernetes network policies. Previously, the Canal network plugin was required for project network isolation. [#31338](https://github.com/rancher/rancher/issues/31338)

### Release Image Enhancements

- Releases now include an annotated copy images.txt displaying the source of each image. [#31663](https://github.com/rancher/rancher/issues/31663)
- Windows image digests are now included with releases. [#25222](https://github.com/rancher/rancher/issues/25222)

# Security Fixes

- A security issue was discovered in the current image of RANCHER/NGINX-INGRESS-CONTROLLER version 0.43.0-rancher1. This issue was assigned CVE-2021-3449 and CVE-2021-3540. To fix the issue, the openssl version of the image "nginx-0.43.0-rancher1" was updated from 1.1.1i to 1.1.1k. [#538](https://github.com/rancher/kontainer-driver-metadata/pull/538) [#2522](https://github.com/rancher/rke/pull/2522)
- Multiple critical and high CVEs were discovered in the `rancher/library-nginx:1.19.2-alpine` image. The image has since been updated to `rancher/library-nginx:1.19.9-alpine` and addresses the CVEs listed. [#82](https://github.com/rancher/image-mirror/pull/82) [#440](https://github.com/rancher/system-charts/pull/440)
  - Curl: CVE-2020-8231, CVE-2020-8285, CVE-2020-8169, CVE-2020-8286, and CVE-2020-8177
  - libxml2: CVE-2020-24977
  - freetype: CVE-2020-15999
  - musl: CVE-2020-28928 

# Major Bug Fixes

- Fixed several [UI issues.](https://github.com/rancher/rancher/issues?q=is%3Aissue+milestone%3Av2.5.8+is%3Aclosed+label%3Ateam%2Fui)
- Switched to deterministic naming strategy for ClusterRoleBinding and RoleBinding resources to mitigate duplicate issues. [#29932](https://github.com/rancher/rancher/issues/29932)
- Uninstalling Rancher no longer leaves pods running in the cluster for apps like Fleet, Rancher-Operator or Rancher-Webhook. [#30924](https://github.com/rancher/rancher/issues/30924)
- Logging in the Cluster Explorer when using RKE no longer creates large files in `/var/lib/rancher/logging/rke`. After upgrading, this file can be safely deleted. [#31309](https://github.com/rancher/rancher/issues/31309)
- EKS contained a bug where certain regions failed during deployment when using default user data. [#31612](https://github.com/rancher/rancher/issues/31612)
- When provisioning EC2 clusters, AMIs are now up to date. [#31708](https://github.com/rancher/rancher/issues/31708)
- When provisioning RKE clusters with a private registry, the private registry is applied properly to all system images. [#31726](https://github.com/rancher/rancher/issues/31726)
- Windows images for air gap are now available for charts maintained in [rancher/charts](https://github.com/rancher/charts). [#32290](https://github.com/rancher/rancher/issues/32290)
- Deleting a nodepool with multiple nodes no longer incorrectly deletes only one node in the provider. [#31765](https://github.com/rancher/rancher/issues/31765)
- After upgrading Rancher, new nodes are no longer stuck at the "waiting to register" stage. [#31999](https://github.com/rancher/rancher/issues/31999)
- The private registry setting in RKE is now respected by kubectl/shell and Helm operation pods. [#30735](https://github.com/rancher/rancher/issues/30735)
- GCS backups past retention now get deleted. [#30565](https://github.com/rancher/rancher/issues/30565)
- Added NetworkPolicy resources to system project-based namespaces to allow for Hardened CIS Scan to pass when Project Network Isolation is enabled. [30211](https://github.com/rancher/rancher/issues/30211)
- Only delete Rancher-created NetworkPolicy resources when disabling Project Network Isolation. [#30135](https://github.com/rancher/rancher/issues/30135)
- Domains in the AWS China region are now whitelisted to allow users to add and edit EKS clusters using cloud credentials associated with the AWS China region. [#29666](https://github.com/rancher/rancher/issues/29666)
- Amazon EC2 nodes can now be automatically provisioned in the AWS Middle East region. [#31980](https://github.com/rancher/rancher/issues/31980)
- PSP templates annotations are now properly applied to downstream cluster PSPs. Only annotations without names containing `.cattle.io/` are applied. [#22093](https://github.com/rancher/rancher/issues/22093)

# UI Updates

The primary UI in Rancher since v2.0 is now referred to as Cluster Manager in the UI. The new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. There are some new features in the new UI with similar functionality as existing features in Cluster Manager, but differences in implementation may cause variation.

## Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

# Known Major Issues
- Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. [#32325](https://github.com/rancher/rancher/issues/32325)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5. Please see above in Deprecated Features.
- In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.
- Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
- When registering EKS and GKE clusters via Terraform, all unmanaged fields must be set to empty in order to avoid overriding configuration in the registered cluster. [#648](https://github.com/rancher/terraform-provider-rancher2/issues/648)
- Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. [#32535](https://github.com/rancher/rancher/issues/32535)
- Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. [#32563](https://github.com/rancher/rancher/issues/32563)

# Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - When accessing tracing information for a service in the Kiali dashboard bundled with v1.9.3 and v1.8.5, attempting to change the display options may result in a persistent error for that service's tracing information. We recommend using the Jaeger dashboard if you would like different details for a particular services tracing until this issue is resolved. The resolution for this issue can be found in [#32330](https://github.com/rancher/rancher/issues/32330)
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)


# Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

# Versions within Rancher

### Images
- rancher/rancher:v2.5.8
- rancher/rancher-agent:v2.5.8

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.8](https://github.com/rancher/rke/releases/tag/v1.2.8)

### Kubernetes
- v1.20.6 (default)
- v1.19.10
- v1.18.18
- v1.17.17

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/)

Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.

**Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----

-----
# Release v2.5.7

**Rancher v2.5.7 is a mirror release of v2.5.6 to address one issue:**

When using a private registry without authentication, provisioning or updating RKE clusters created with nodes from an infrastructure provider will fail. [#31600](https://github.com/rancher/rancher/issues/31600)

## Important

This release addresses a security vulnerability found in Rancher:

- CVE-2021-25313 - XSS attack on the Rancher API - When accessing the Rancher API with a browser, the URL was not properly escaped, making it vulnerable to an XSS attack. Specially crafted URLs to these API endpoints could include JavaScript which would be embedded in the page and execute in a browser. There is no direct mitigation. Avoid clicking on untrusted links to your Rancher server. [#31583](https://github.com/rancher/rancher/issues/31583)

### Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

## Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

## Enhancements
- Added support for Kubernetes v1.20
- Added ability to set environment variables to the agent in order to support downstream clusters behind a proxy [#31370](https://github.com/rancher/rancher/issues/31370) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/options/#agent-environment-variables)
- Added the ingress.enabled rancher Helm flag. When set to false, Helm will not install a Rancher ingress. Set the option to false to deploy your own ingress. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/chart-options/#advanced-options)
- **EKS**
  - Added ability to use launch templates for EKS managed node groups [#30019](https://github.com/rancher/rancher/issues/30019) [#30020](https://github.com/rancher/rancher/issues/30020) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/eks/#bring-your-own-launch-template)
- **Node Pool Enhancements**
  - Added ability to select which node to delete when scaling down a node pool [#22871](https://github.com/rancher/rancher/issues/22871)
  - Added an ability to select drain on delete to be used when scaling down node pools [#27458](https://github.com/rancher/rancher/issues/27458)
- **vSphere out of tree cloud provider** - Added ability to configure the vSphere external cloud provider through the Apps and Marketplace in the Cluster Explorer. By using the vSphere Cloud Provider Interface (CPI) and Cloud Storage Interface (CSI) charts, the vsphere out-of-tree provider can be configured. Note: Your cluster must have the cloud provider set as `external` in order for the cluster to allow out-of-tree provider configuration. For those already using the vSphere in-tree provider, migrations docs are available. [#20131](https://github.com/rancher/rancher/issues/20131) [#23357](https://github.com/rancher/rancher/issues/23357) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/cloud-providers/vsphere/out-of-tree/)
- **RKE**
  - Added ability to set `PriorityClassName` on RKE addons [#30047](https://github.com/rancher/rancher/issues/30047)
  - Added ability to configure timeout value for the etcd backup job [#30663](https://github.com/rancher/rancher/issues/30663)
- **Continuous Delivery**
  - Previously any new charts for Fleet would automatically be deployed into any existing Rancher install, as of v2.5.6, we've added the ability to put a minimum version for Fleet charts so they wouldn't automatically be deployed [#30934](https://github.com/rancher/rancher/issues/30934)
- **Windows**
  - Added ability to deploy onto Windows 2004 and 20H2 Servers [#27451](https://github.com/rancher/rancher/issues/27451) [#30701](https://github.com/rancher/rancher/issues/30701) [#30808](https://github.com/rancher/rancher/issues/30808)
  - Added ability to run Fleet on Windows clusters [#30516](https://github.com/rancher/rancher/issues/30516)
- **Linode Kubernetes Engine (LKE)** is now available as a cluster driver and new Kubernetes clusters can be spun up directly with LKE. The cluster driver is inactive by default and will need to be activated to appear as an option.

### Cluster Explorer Features

- **Logging**
  - Added support for being able to configure resource settings [#31099](https://github.com/rancher/rancher/issues/31099)

### Cluster Manager Tools

- Added minimum CPU and memory to monitoring and Istio charts to prevent the charts from being installed on clusters without enough resources [#30684](https://github.com/rancher/rancher/issues/30684) [#30144](https://github.com/rancher/rancher/issues/30144)

- **Logging**
  - Added 3.9.0 [#30917](https://github.com/rancher/rancher/issues/30917)
  - Added ability to mount certs on fluentd [#29784](https://github.com/rancher/rancher/issues/29784)
- **Istio**
  - Added v1.8.3 [#29812](https://github.com/rancher/rancher/issues/29812) [#31187](https://github.com/rancher/rancher/issues/31187) [#30410](https://github.com/rancher/rancher/issues/30410)
- **OPA Gatekeeper**
  - Updated to GA [#31203](https://github.com/rancher/rancher/issues/31203)
  - Added v3.3.0 [#31204](https://github.com/rancher/rancher/issues/31204)

## Major Bug Fixes
- Fixed an issue where the Rancher server chart couldn't be installed onto a Kubernetes cluster without an ingress [#30535](https://github.com/rancher/rancher/issues/30535)
- Fixed an issue where etcd would have increased traffic and memory usage after upgrading [#30168](https://github.com/rancher/rancher/issues/30168)
- Fixed an issue where public Helm chart repository were not working on clusters behind a proxy [#29961](https://github.com/rancher/rancher/issues/29961)
- Fixed an issue where telemetry client had a socket leak and cause upgrade issues or general k8s issues  [#28360](https://github.com/rancher/rancher/issues/28360) [#27870](https://github.com/rancher/rancher/issues/27870)
- Fixed an issue where vSphere vCenter server entries from the in-tree cloud provider configuration would not be removed [#30606](https://github.com/rancher/rancher/issues/30606)
- Fixed an issue where the cluster private registry was not working with the rancher-agent image for clusters provided by node drivers [#30605](https://github.com/rancher/rancher/issues/30605)
- Fixed an issue where EC2 node provisioning failed when using a SLES15 AMI [#30717](https://github.com/rancher/rancher/issues/30717)
- Fixed an issue where nodes wouldn't drain before deleting when scaling down if the node had pods with emptyDir volumes [#31455](https://github.com/rancher/rancher/issues/31455)
- Fixed an issue where RKE clusters would get stuck when there were `Cordoned` worker nodes and starting to remove master nodes [#30049](https://github.com/rancher/rancher/issues/30049)
- Fixed an issue where clusters couldn't be imported with the kubernets-python-client due to additional `---` at the end of the the import file[#31252](https://github.com/rancher/rancher/issues/31252)
- Fixed an issue where imported clusters would return 404s from the agent [#15172](https://github.com/rancher/rancher/issues/15172)
- Fixed an issue where windows nodes failed to create RKE log directory if `prefixPath` was not set [#30966](https://github.com/rancher/rancher/issues/30966)
- Fixed an issue where monitoring in Cluster Explorer wasn't working on Windows server-core versions [#27911](https://github.com/rancher/rancher/issues/27911)
- Fixed an issue when configuring OpenLDAP with StartTLS [#30930](https://github.com/rancher/rancher/issues/30930)
- Fixed an issue with Fleet where GitRepos and clusters would get stuck in a `Modified` state [#30696](https://github.com/rancher/rancher/issues/30696)
- Fixed an issue with Fleet where adding a Git repo with uppercase letters in the path would fail [#30792](https://github.com/rancher/rancher/issues/30792)
- Fixed an issue where the logging in the Cluster Manager UI was previously failing on new AKS clusters [#30425](https://github.com/rancher/rancher/issues/30425)
- Fixed an issue where the logging in Cluster Explorer was not working with non-standard Docker root directory [#30329](https://github.com/rancher/rancher/issues/30329)
- Fixed an issue where the display name was incorrect when nodes in a single cluster have FQDN hostnames under multiple different subdomains. [#27873](https://github.com/rancher/rancher/issues/27873)
- Fixed an issue where ClusterRoleBinding's apiVersion would log deprecation warning for any k8s 1.19 clusters [#30043](https://github.com/rancher/rancher/issues/)
- Fixed a list of UI issues [within Cluster Manager](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.6+label%3Ateam%2Fui+) and [within Cluster Explorer](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.6+is%3Aclosed)

## UI Updates

The primary UI in Rancher since v2.0 is now referred to as Cluster Manager in the UI. The new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. There are some new features in the new UI with similar functionality as existing features in Cluster Manager, but differences in implementation may cause differences details may cause variation.

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

## Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |

### Known Major Issues
- Kubernetes v1.20 has an issue with the vSphere in-tree cloud provider. Rancher supports the out-of-tree vSphere cloud provider starting as of v2.5.6, which is when k8s 1.20 support was introduced. [#31172](https://github.com/rancher/rancher/issues/31172)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Logging in the cluster explorer may not capture all kubelet logs for cloud providers. [#30383](https://github.com/rancher/rancher/issues/30383)
- Istio 1.5.10 is not supported in air gapped environments.
- In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run the Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#69](https://github.com/rancher/backup-restore-operator/issues/69)
- **Monitoring**
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in RKE clusters that use a mix of RancherOS hosts and non-RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815).
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)

## Versions within Rancher

### Images
- rancher/rancher:v2.5.7
- rancher/rancher-agent:v2.5.7

### Tools
- cli - [2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [1.2.6](https://github.com/rancher/rke/releases/tag/v1.2.6)

### Kubernetes
- 1.20.4 (default)
- 1.19.8
- 1.18.16
- 1.17.17

## Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----
# Release v2.5.6

**Please install [v2.5.7](https://github.com/rancher/rancher/releases/tag/v2.5.7) instead of v2.5.6**
v2.5.7 contains one fix that is an issue in this release:

When using a private registry without authentication, provisioning or updating RKE clusters created with nodes from an infrastructure provider will fail. [#31600](https://github.com/rancher/rancher/issues/31600)

## Important

This release addresses a security vulnerability found in Rancher:

- CVE-2021-25313 - XSS attack on the Rancher API - When accessing the Rancher API with a browser, the URL was not properly escaped, making it vulnerable to an XSS attack. Specially crafted URLs to these API endpoints could include JavaScript which would be embedded in the page and execute in a browser. There is no direct mitigation. Avoid clicking on untrusted links to your Rancher server. [#31583](https://github.com/rancher/rancher/issues/31583)

### Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

## Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

## Enhancements
- Added support for Kubernetes v1.20
- Added ability to set environment variables to the agent in order to support downstream clusters behind a proxy [#31370](https://github.com/rancher/rancher/issues/31370) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/options/#agent-environment-variables)
- Added the ingress.enabled rancher Helm flag. When set to false, Helm will not install a Rancher ingress. Set the option to false to deploy your own ingress. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/chart-options/#advanced-options)
- **EKS**
  - Added ability to use launch templates for EKS managed node groups [#30019](https://github.com/rancher/rancher/issues/30019) [#30020](https://github.com/rancher/rancher/issues/30020) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/eks/#bring-your-own-launch-template)
- **Node Pool Enhancements**
  - Added ability to select which node to delete when scaling down a node pool [#22871](https://github.com/rancher/rancher/issues/22871)
  - Added an ability to select drain on delete to be used when scaling down node pools [#27458](https://github.com/rancher/rancher/issues/27458)
- **vSphere out of tree cloud provider** - Added ability to configure the vSphere external cloud provider through the Apps and Marketplace in the Cluster Explorer. By using the vSphere Cloud Provider Interface (CPI) and Cloud Storage Interface (CSI) charts, the vsphere out-of-tree provider can be configured. Note: Your cluster must have the cloud provider set as `external` in order for the cluster to allow out-of-tree provider configuration. For those already using the vSphere in-tree provider, migrations docs are available. [#20131](https://github.com/rancher/rancher/issues/20131) [#23357](https://github.com/rancher/rancher/issues/23357) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/cloud-providers/vsphere/out-of-tree/)
- **RKE**
  - Added ability to set `PriorityClassName` on RKE addons [#30047](https://github.com/rancher/rancher/issues/30047)
  - Added ability to configure timeout value for the etcd backup job [#30663](https://github.com/rancher/rancher/issues/30663)
- **Continuous Delivery**
  - Previously any new charts for Fleet would automatically be deployed into any existing Rancher install, as of v2.5.6, we've added the ability to put a minimum version for Fleet charts so they wouldn't automatically be deployed [#30934](https://github.com/rancher/rancher/issues/30934)
- **Windows**
  - Added ability to deploy onto Windows 2004 and 20H2 Servers [#27451](https://github.com/rancher/rancher/issues/27451) [#30701](https://github.com/rancher/rancher/issues/30701) [#30808](https://github.com/rancher/rancher/issues/30808)
  - Added ability to run Fleet on Windows clusters [#30516](https://github.com/rancher/rancher/issues/30516)
- **Linode Kubernetes Engine (LKE)** is now available as a cluster driver and new Kubernetes clusters can be spun up directly with LKE. The cluster driver is inactive by default and will need to be activated to appear as an option.

### Cluster Explorer Features

- **Logging**
  - Added support for being able to configure resource settings [#31099](https://github.com/rancher/rancher/issues/31099)

### Cluster Manager Tools

- Added minimum CPU and memory to monitoring and Istio charts to prevent the charts from being installed on clusters without enough resources [#30684](https://github.com/rancher/rancher/issues/30684) [#30144](https://github.com/rancher/rancher/issues/30144)

- **Logging**
  - Added 3.9.0 [#30917](https://github.com/rancher/rancher/issues/30917)
  - Added ability to mount certs on fluentd [#29784](https://github.com/rancher/rancher/issues/29784)
- **Istio**
  - Added v1.8.3 [#29812](https://github.com/rancher/rancher/issues/29812) [#31187](https://github.com/rancher/rancher/issues/31187) [#30410](https://github.com/rancher/rancher/issues/30410)
- **OPA Gatekeeper**
  - Updated to GA [#31203](https://github.com/rancher/rancher/issues/31203)
  - Added v3.3.0 [#31204](https://github.com/rancher/rancher/issues/31204)

## Major Bug Fixes
- Fixed an issue where the Rancher server chart couldn't be installed onto a Kubernetes cluster without an ingress [#30535](https://github.com/rancher/rancher/issues/30535)
- Fixed an issue where etcd would have increased traffic and memory usage after upgrading [#30168](https://github.com/rancher/rancher/issues/30168)
- Fixed an issue where public Helm chart repository were not working on clusters behind a proxy [#29961](https://github.com/rancher/rancher/issues/29961)
- Fixed an issue where telemetry client had a socket leak and cause upgrade issues or general k8s issues  [#28360](https://github.com/rancher/rancher/issues/28360) [#27870](https://github.com/rancher/rancher/issues/27870)
- Fixed an issue where vSphere vCenter server entries from the in-tree cloud provider configuration would not be removed [#30606](https://github.com/rancher/rancher/issues/30606)
- Fixed an issue where the cluster private registry was not working with the rancher-agent image for clusters provided by node drivers [#30605](https://github.com/rancher/rancher/issues/30605)
- Fixed an issue where EC2 node provisioning failed when using a SLES15 AMI [#30717](https://github.com/rancher/rancher/issues/30717)
- Fixed an issue where nodes wouldn't drain before deleting when scaling down if the node had pods with emptyDir volumes [#31455](https://github.com/rancher/rancher/issues/31455)
- Fixed an issue where RKE clusters would get stuck when there were `Cordoned` worker nodes and starting to remove master nodes [#30049](https://github.com/rancher/rancher/issues/30049)
- Fixed an issue where clusters couldn't be imported with the kubernets-python-client due to additional `---` at the end of the the import file[#31252](https://github.com/rancher/rancher/issues/31252)
- Fixed an issue where imported clusters would return 404s from the agent [#15172](https://github.com/rancher/rancher/issues/15172)
- Fixed an issue where windows nodes failed to create RKE log directory if `prefixPath` was not set [#30966](https://github.com/rancher/rancher/issues/30966)
- Fixed an issue where monitoring in Cluster Explorer wasn't working on Windows server-core versions [#27911](https://github.com/rancher/rancher/issues/27911)
- Fixed an issue when configuring OpenLDAP with StartTLS [#30930](https://github.com/rancher/rancher/issues/30930)
- Fixed an issue with Fleet where GitRepos and clusters would get stuck in a `Modified` state [#30696](https://github.com/rancher/rancher/issues/30696)
- Fixed an issue with Fleet where adding a Git repo with uppercase letters in the path would fail [#30792](https://github.com/rancher/rancher/issues/30792)
- Fixed an issue where the logging in the Cluster Manager UI was previously failing on new AKS clusters [#30425](https://github.com/rancher/rancher/issues/30425)
- Fixed an issue where the logging in Cluster Explorer was not working with non-standard Docker root directory [#30329](https://github.com/rancher/rancher/issues/30329)
- Fixed an issue where the display name was incorrect when nodes in a single cluster have FQDN hostnames under multiple different subdomains. [#27873](https://github.com/rancher/rancher/issues/27873)
- Fixed an issue where ClusterRoleBinding's apiVersion would log deprecation warning for any k8s 1.19 clusters [#30043](https://github.com/rancher/rancher/issues/)
- Fixed a list of UI issues [within Cluster Manager](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.6+label%3Ateam%2Fui+) and [within Cluster Explorer](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.6+is%3Aclosed)

## UI Updates

The primary UI in Rancher since v2.0 is now referred to as Cluster Manager in the UI. The new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. There are some new features in the new UI with similar functionality as existing features in Cluster Manager, but differences in implementation may cause differences details may cause variation.

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

## Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |

### Known Major Issues
- Kubernetes v1.20 has an issue with the vSphere in-tree cloud provider. Rancher supports the out-of-tree vSphere cloud provider starting as of v2.5.6, which is when k8s 1.20 support was introduced. [#31172](https://github.com/rancher/rancher/issues/31172)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Logging in the cluster explorer may not capture all kubelet logs for cloud providers. [#30383](https://github.com/rancher/rancher/issues/30383)
- Istio 1.5.10 is not supported in air gapped environments.
- In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run the Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#69](https://github.com/rancher/backup-restore-operator/issues/69)
- **Monitoring**
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in RKE clusters that use a mix of RancherOS hosts and non-RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815).
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)

## Versions within Rancher

### Images
- rancher/rancher:v2.5.6
- rancher/rancher-agent:v2.5.6

### Tools
- cli - [2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [1.2.6](https://github.com/rancher/rke/releases/tag/v1.2.6)

### Kubernetes
- 1.20.4 (default)
- 1.19.8
- 1.18.16
- 1.17.17

## Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.
-----
**Rancher v2.5.5 is a mirror release of v2.5.4 to address a few minor issues:**
- The dashboard could crash if helm charts were missing certain annotations. [link](https://github.com/rancher/dashboard/issues/2182)
- The rancher helm chart was restricted to Kubernetes version less than 1.20.0. This restriction was added to prevent Rancher from being installed on incompatible versions of Kubernetes. The v2.5.5 chart was originally released without this restriction. Users who install the chart before 01/12/2020 may experience issues on unsupported Kubernetes versions. [link](https://github.com/rancher/rancher/pull/30757)
- Rancher’s Cluster Explorer now only displays Windows compatible charts on Windows clusters.
- Added support for RKE2 clusters to be upgraded to Kubernetes version v1.18.13. [link](https://github.com/rancher/kontainer-driver-metadata/pull/462)

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

# Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.5 | `rancher/rancher:latest` | server-charts/latest |v2.5.5 |
  | Stable | v2.5.5 | `rancher/rancher:stable` | server-charts/stable | v2.5.5 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

# Major Bug Fixes
- Switched to xml-roundtrip-validator package to address xml vulnerabilities in go's xml package - [link](https://mattermost.com/blog/coordinated-disclosure-go-xml-vulnerabilities/)
- Fixed intermittent installation fails with cluster manager monitoring. #30188 
- Fixed cluster explorer monitoring installation errors on hardened clusters. #29980 
- Fixed error when execing into pods via kubectl shell. #29668
- Rancher now supports startTLS when using OpenLDAP. #29153 
- Fixed error message in cluster manager monitoring when secret webhook-receiver is not found. #28954 
- Rancher pods are no long scheduled on dead nodes. #27734 
- Noes running Amazon Linux no longer fail to provision. #21648 
- Fixed cluster manager logging support for clusters with Windows Server SAC 1909 nodes and for clusters with Windows Server LTSC 2019 nodes #30279 
- Fixed cluster manager monitoring's prometheus operator container startup error with nfs subpaths #29149

## Other Notes

### Known Major Issues
- Istio deployments can fail if sidecar injection is enabled in a cluster with a PSP where `FS Group` is set to `MustRunAs` with a range of `1..1024`  #29700
- Cluster explorer logging may not capture all kubelet logs for cloud providers. #30383 
- Rotating encryption keys with a custom encryption can fail. #30539 

### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)

# Enhancements
- CIS v2 enhancements – Schedule/Alert, Custom Benchmark #30123
- CIS 1.6 for RKE1 #29649 
- CIS 1.5 for RKE2 #29649 
- Istio enhancements - CNI, Jaeger ​support #29903 #27377 
- Cluster Explorer logging enhancements - Syslog support and GKE/AKS node logs #29892 #28574 #28573
- Tolerations can now be configured per add-on and apply to Deployment resources. The configured tolerations will replace the existing tolerations so make sure you configure all the tolerations you need. This resolves an issue where add-on pods with wildcard tolerations (toleration that tolerates all taints) were not evicted and if manually deleted, could be scheduled to a NotReady node. To avoid unschedulable pods on upgrade, the default configuration will be the same (so with wildcard tolerations) so you will need to configure tolerations to override the default configuration. See the [documentation](https://rancher.com/docs/rke/latest/en/config-options/add-ons/#tolerations) for more information. #27734
- RKE encryption keys can now be rotated from the rancher API #27735 
- The default nginx http backend can optionally be disabled.  It is installed by default. #25590
- Dashboard supports configuring additional alerting receivers - [link](https://github.com/rancher/dashboard/issues/1216)
- Dashboard now supports additional logging outputs - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+additional+outputs+-label%3Akind%2Fbug+)
- UI polishing in Cluster Explorer - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+-label%3Akind%2Fbug+-label%3Abug)

# Versions
## Images
- rancher/rancher:v2.5.5
- rancher/rancher-agent:v2.5.5

## Tools
- cli - [2.4.10](https://github.com/rancher/cli/releases/tag/v2.4.10)
- RKE - [1.2.4](https://github.com/rancher/rke/releases/tag/v1.2.4) 

## Kubernetes
- 1.19.6 (default)
- 1.18.14
- 1.17.16

# Bug Fixes
- Fixed increased CPU and memory usage #30652
- Suppressed excessive "rejected by webhook" messages #30452 
- the reset-admin url is no longer a private ip #29162
- Fixed panic when provisioning RKE clusters #30143
- Resolved error when installing RKE on node running flatcar os #29841 #30326 
- Fixed error when creating hosted EKS V2 cluster with the same name as an existing EKS cluster #29549
- Prevented existing clusters in eks from being updated when a cluster with the same name is created with rancher #29103
- Suppressed constant deprecation log #28943 #29144
- Fixed rule deployer errors when enabling alerts #29318
- Fixed error when installing OPA gatekeeper v2 after v1 #29188
- Fixed nil pointer error when provisioning rke clusters #30373
- Stopped using deprecated networking resources #22487 
- Fixed RKE missing ingress on install #30405 
- Fixed issue when upgrading from rancher 2.5.2 #30434 
- Fixed panic when deleting a node that is currently being provisioned #30430 
- reset-password no longer causes a panic #29565 
- EKSv2 now works with private-only endpoint​s #29907" can be changed to "Removed the necessity of extra network configuration for private-only endpoint​s in EKSv2 #29907
- added missing images to images.txt #30496 
- Numerous dashboard bug fixes - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+label%3Akind%2Fbug+)
- Numerous UI fixes - [link](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.4)

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----
**Please install [v2.5.5](https://github.com/rancher/rancher/releases/tag/v2.5.5) instead of v2.5.4**
v2.5.5 contains some minor bug fixes to address issues in this release.


## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

# Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.4 | `rancher/rancher:latest` | server-charts/latest |v2.5.4 |
  | Stable | v2.5.4 | `rancher/rancher:stable` | server-charts/stable | v2.5.4 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

# Major Bug Fixes
- Switched to xml-roundtrip-validator package to address xml vulnerabilities in go's xml package - [link](https://mattermost.com/blog/coordinated-disclosure-go-xml-vulnerabilities/)
- Fixed intermittent installation fails with cluster manager monitoring. #30188 
- Fixed cluster explorer monitoring installation errors on hardened clusters. #29980 
- Fixed error when execing into pods via kubectl shell. #29668
- Rancher now supports startTLS when using OpenLDAP. #29153 
- Fixed error message in cluster manager monitoring when secret webhook-receiver is not found. #28954 
- Rancher pods are no long scheduled on dead nodes. #27734 
- Noes running Amazon Linux no longer fail to provision. #21648 
- Fixed cluster manager logging support for clusters with Windows Server SAC 1909 nodes and for clusters with Windows Server LTSC 2019 nodes #30279 
- Fixed cluster manager monitoring's prometheus operator container startup error with nfs subpaths #29149

## Other Notes

### Known Major Issues
- Istio deployments can fail if sidecar injection is enabled in a cluster with a PSP where `FS Group` is set to `MustRunAs` with a range of `1..1024`  #29700
- Cluster explorer logging may not capture all kubelet logs for cloud providers. #30383 
- Rotating encryption keys with a custom encryption can fail. #30539 

### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- OPA Gatekeeper

# Enhancements
- CIS v2 enhancements – Schedule/Alert, Custom Benchmark #30123
- CIS 1.6 for RKE1 #29649 
- CIS 1.5 for RKE2 #29649 
- Istio enhancements - CNI, Jaeger ​support #29903 #27377 
- Cluster Explorer logging enhancements - Syslog support and GKE/AKS node logs #29892 #28574 #28573
- Tolerations can now be configured per add-on and apply to Deployment resources. The configured tolerations will replace the existing tolerations so make sure you configure all the tolerations you need. This resolves an issue where add-on pods with wildcard tolerations (toleration that tolerates all taints) were not evicted and if manually deleted, could be scheduled to a NotReady node. To avoid unschedulable pods on upgrade, the default configuration will be the same (so with wildcard tolerations) so you will need to configure tolerations to override the default configuration. See the [documentation](https://rancher.com/docs/rke/latest/en/config-options/add-ons/#tolerations) for more information. #27734
- RKE encryption keys can now be rotated from the rancher API #27735 
- The default nginx http backend can optionally be disabled.  It is installed by default. #25590
- Dashboard supports configuring additional alerting receivers - [link](https://github.com/rancher/dashboard/issues/1216)
- Dashboard now supports additional logging outputs - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+additional+outputs+-label%3Akind%2Fbug+)
- UI polishing in Cluster Explorer - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+-label%3Akind%2Fbug+-label%3Abug)

# Versions
## Images
- rancher/rancher:v2.5.4
- rancher/rancher-agent:v2.5.4

## Tools
- cli - [2.4.10](https://github.com/rancher/cli/releases/tag/v2.4.10)
- RKE - [1.2.4](https://github.com/rancher/rke/releases/tag/v1.2.4) 

## Kubernetes
- 1.19.6 (default)
- 1.18.14
- 1.17.16

# Bug Fixes
- Fixed increased CPU and memory usage #30652
- Suppressed excessive "rejected by webhook" messages #30452 
- the reset-admin url is no longer a private ip #29162
- Fixed panic when provisioning RKE clusters #30143
- Resolved error when installing RKE on node running flatcar os #29841 #30326 
- Fixed error when creating hosted EKS V2 cluster with the same name as an existing EKS cluster #29549
- Prevented existing clusters in eks from being updated when a cluster with the same name is created with rancher #29103
- Suppressed constant deprecation log #28943 #29144
- Fixed rule deployer errors when enabling alerts #29318
- Fixed error when installing OPA gatekeeper v2 after v1 #29188
- Fixed nil pointer error when provisioning rke clusters #30373
- Stopped using deprecated networking resources #22487 
- Fixed RKE missing ingress on install #30405 
- Fixed issue when upgrading from rancher 2.5.2 #30434 
- Fixed panic when deleting a node that is currently being provisioned #30430 
- reset-password no longer causes a panic #29565 
- EKSv2 now works with private-only endpoint​s #29907" can be changed to "Removed the necessity of extra network configuration for private-only endpoint​s in EKSv2 #29907
- added missing images to images.txt #30496 
- Numerous dashboard bug fixes - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+label%3Akind%2Fbug+)
- Numerous UI fixes - [link](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.4)

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----
# Release v2.5.3

>  **Only addresses a high cpu usage issue in v2.5.2 for upgraded clusters with Project Network Isolation Enabled [#30048], [#30052], [#30089]. Please note that Release notes remain the same as v2.5.2.**  
> Note: This requires redeploying `nginx-ingress-controller`. Please refer to [this comment](https://github.com/rancher/rancher/issues/30045#issuecomment-731653007) for more details. 

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.3 | `rancher/rancher:latest` | server-charts/latest |v2.5.3 |
  | Stable | v2.5.3 | `rancher/rancher:stable` | server-charts/stable | v2.5.3 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.5.1

- Local cluster will no longer run the cattle cluster-agent and node-agent. On upgrade to 2.5.2 these pods will get deleted. [#29397](https://github.com/rancher/rancher/issues/29397)
- If you are using Rancher to manage other Rancher instances, you can now upgrade Rancher without facing elevated CPU, load or network issues. [#29364](https://github.com/rancher/rancher/issues/29364).
- Cluster Explorer's Monitoring feature can now be installed on a K8s 1.16 cluster. [#29395](https://github.com/rancher/rancher/issues/29395)
- Cluster Explorer's Monitoring feature can now be installed in a hardened cluster using chart version 9.4.201 and up. [#28536](https://github.com/rancher/rancher/issues/28536)
- Istio can now be installed with the Ingress Gateway disabled. [#29383](https://github.com/rancher/rancher/issues/29383)
- Fixed a bug where Longhorn uninstallation was getting stalled. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- Rancher now supports deploying an EKS cluster in an air gap environment. [#29070](https://github.com/rancher/rancher/issues/29070)
- Fixed a bug where the Auto Replace feature of Node Pools wasn't working as expected in 2.5.1. [#29754](https://github.com/rancher/rancher/issues/29754)
- You can now run a forked build of the UI and set `ui-index` setting to `local` and force that to load. [#29362](https://github.com/rancher/rancher/issues/29362)
- Fixed a bug where Launch kubectl feature wasn't working as expected. [#29511](https://github.com/rancher/rancher/issues/29511)
- Fixed a bug where Windows worker nodes could not join a cluster with a cloud provider enabled. [#29782](https://github.com/rancher/rancher/issues/29782)
- Fixed a bug for the Rancher Terraform provider where node draining could not be disabled. [Terraform#440](https://github.com/rancher/terraform-provider-rancher2/issues/440)
- Fixed a bug where private Git repo in fleet didn't work when adding http/ssh credential in dashboard. [Fleet#134](https://github.com/rancher/fleet/issues/134)


## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)
- The setting to hide local cluster can only be set through API after Rancher is installed. It cannot be set during install because of an issue with Rancher API stripping quotes off of helm values. [#29325](https://github.com/rancher/rancher/issues/29325#issuecomment-719864450)
- When provisioning EKS clusters, Rancher currently relies on public endpoints to connect to the cluster. Disabling public access is not recommended if Rancher does not have network access, as it will affect Rancher's ability to communicate with the cluster.
 [#29907](https://github.com/rancher/rancher/issues/29907)
- When Project Network Isolation is turned on, upgrading from a previous Rancher version to 2.5.2 will cause an increase in CPU / Logging. Workaround is turn off PNI. [#30052](https://github.com/rancher/rancher/issues/30052). Fix is tracked in [#30045](https://github.com/rancher/rancher/issues/30045).


### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- OPA Gatekeeper (Experimental)
  - The first edition of OPA must be uninstalled before the new OPA features are installed. [#29188](https://github.com/rancher/rancher/issues/29188)

### Enhancements
- Admins can now choose to use the CentOS/RHEL 8 operating system with Docker CE for both, the local Rancher HA cluster and clusters provisioned by Rancher. Please note this is only available for Docker CE 19.03.13 and higher. To be able to use our [Docker install script](https://releases.rancher.com/install-docker/19.03.13.sh) to install Docker CE 19.03.13, if the OS image you are using contains the package `runc`, it needs to be removed manually before you can use the install script, because the `containerd` package will conflict with this package. The requirement of installing the package `iptables` is handled in the install script. [#23045](https://github.com/rancher/rancher/issues/23045)
- Stats will now aggregate resources of all nodes that do not have the following four taints instead of relying on the worker node-role label: [#29139](https://github.com/rancher/rancher/issues/29139)
  - "node-role.kubernetes.io/controlplane"
  - "node-role.kubernetes.io/control-plane"
  - "node-role.kubernetes.io/etcd"
  - "node-role.kubernetes.io/master"  
- Starting with version 9.4.201 of the Rancher Monitoring chart, k3s clusters will switch to using one PushProx exporter instead of three PushProx exporters so increased memory limits are no longer required for k3s clusters. [#29445](https://github.com/rancher/rancher/issues/29445)
- Keycloak SAML provider now accepts a custom Entity ID field. [#29212](https://github.com/rancher/rancher/issues/29212)
- Logs now include data about the source. [#29410](https://github.com/rancher/rancher/issues/29410)
- UI images path can now be specified in the Rancher Helm chart. [#29419](https://github.com/rancher/rancher/issues/29419) 
- Istio installer automatically adds Istio dashboards to Grafana when using Cluster Explorer's Monitoring feature. [#28468](https://github.com/rancher/rancher/issues/28468)


## Versions

### Images
- rancher/rancher:v2.5.3
- rancher/rancher-agent:v2.5.3

### Tools
- cli - [v2.4.9](https://github.com/rancher/cli/releases/tag/v2.4.9)
- rke - [v1.2.2](https://github.com/rancher/rke/releases/tag/v1.2.2)

### Kubernetes

-  [1.19.3](https://github.com/rancher/hyperkube/releases/tag/v1.19.3-rancher1) (default)
-  [1.18.10](https://github.com/rancher/hyperkube/releases/tag/v1.18.10-rancher1)
-  [1.17.13](https://github.com/rancher/hyperkube/releases/tag/v1.17.13-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher2) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.2

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.2 | `rancher/rancher:latest` | server-charts/latest |v2.5.2 |
  | Stable | v2.5.2 | `rancher/rancher:stable` | server-charts/stable | v2.5.2 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.5.1

- Local cluster will no longer run the cattle cluster-agent and node-agent. On upgrade to 2.5.2 these pods will get deleted. [#29397](https://github.com/rancher/rancher/issues/29397)
- If you are using Rancher to manage other Rancher instances, you can now upgrade Rancher without facing elevated CPU, load or network issues. [#29364](https://github.com/rancher/rancher/issues/29364).
- Cluster Explorer's Monitoring feature can now be installed on a K8s 1.16 cluster. [#29395](https://github.com/rancher/rancher/issues/29395)
- Cluster Explorer's Monitoring feature can now be installed in a hardened cluster using chart version 9.4.201 and up. [#28536](https://github.com/rancher/rancher/issues/28536)
- Istio can now be installed with the Ingress Gateway disabled. [#29383](https://github.com/rancher/rancher/issues/29383)
- Fixed a bug where Longhorn uninstallation was getting stalled. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- Rancher now supports deploying an EKS cluster in an air gap environment. [#29070](https://github.com/rancher/rancher/issues/29070)
- Fixed a bug where the Auto Replace feature of Node Pools wasn't working as expected in 2.5.1. [#29754](https://github.com/rancher/rancher/issues/29754)
- You can now run a forked build of the UI and set `ui-index` setting to `local` and force that to load. [#29362](https://github.com/rancher/rancher/issues/29362)
- Fixed a bug where Launch kubectl feature wasn't working as expected. [#29511](https://github.com/rancher/rancher/issues/29511)
- Fixed a bug where Windows worker nodes could not join a cluster with a cloud provider enabled. [#29782](https://github.com/rancher/rancher/issues/29782)
- Fixed a bug for the Rancher Terraform provider where node draining could not be disabled. [Terraform#440](https://github.com/rancher/terraform-provider-rancher2/issues/440)
- Fixed a bug where private Git repo in fleet didn't work when adding http/ssh credential in dashboard. [Fleet#134](https://github.com/rancher/fleet/issues/134)


## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)
- The setting to hide local cluster can only be set through API after Rancher is installed. It cannot be set during install because of an issue with Rancher API stripping quotes off of helm values. [#29325](https://github.com/rancher/rancher/issues/29325#issuecomment-719864450)
- When provisioning EKS clusters, Rancher currently relies on public endpoints to connect to the cluster. Disabling public access is not recommended if Rancher does not have network access, as it will affect Rancher's ability to communicate with the cluster.
 [#29907](https://github.com/rancher/rancher/issues/29907)
- When Project Network Isolation is turned on, upgrading from a previous Rancher version to 2.5.2 will cause an increase in CPU / Logging. Workaround is turn off PNI. [#30052](https://github.com/rancher/rancher/issues/30052). Fix is tracked in [#30045](https://github.com/rancher/rancher/issues/30045).


### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- OPA Gatekeeper (Experimental)
  - The first edition of OPA must be uninstalled before the new OPA features are installed. [#29188](https://github.com/rancher/rancher/issues/29188)

### Enhancements
- Admins can now choose to use the CentOS/RHEL 8 operating system with Docker CE for both, the local Rancher HA cluster and clusters provisioned by Rancher. Please note this is only available for Docker CE 19.03.13 and higher. To be able to use our [Docker install script](https://releases.rancher.com/install-docker/19.03.13.sh) to install Docker CE 19.03.13, if the OS image you are using contains the package `runc`, it needs to be removed manually before you can use the install script, because the `containerd` package will conflict with this package. The requirement of installing the package `iptables` is handled in the install script. [#23045](https://github.com/rancher/rancher/issues/23045)
- Stats will now aggregate resources of all nodes that do not have the following four taints instead of relying on the worker node-role label: [#29139](https://github.com/rancher/rancher/issues/29139)
  - "node-role.kubernetes.io/controlplane"
  - "node-role.kubernetes.io/control-plane"
  - "node-role.kubernetes.io/etcd"
  - "node-role.kubernetes.io/master"  
- Starting with version 9.4.201 of the Rancher Monitoring chart, k3s clusters will switch to using one PushProx exporter instead of three PushProx exporters so increased memory limits are no longer required for k3s clusters. [#29445](https://github.com/rancher/rancher/issues/29445)
- Keycloak SAML provider now accepts a custom Entity ID field. [#29212](https://github.com/rancher/rancher/issues/29212)
- Logs now include data about the source. [#29410](https://github.com/rancher/rancher/issues/29410)
- UI images path can now be specified in the Rancher Helm chart. [#29419](https://github.com/rancher/rancher/issues/29419) 
- Istio installer automatically adds Istio dashboards to Grafana when using Cluster Explorer's Monitoring feature. [#28468](https://github.com/rancher/rancher/issues/28468)


## Versions

### Images
- rancher/rancher:v2.5.2
- rancher/rancher-agent:v2.5.2

### Tools
- cli - [v2.4.9](https://github.com/rancher/cli/releases/tag/v2.4.9)
- rke - [v1.2.2](https://github.com/rancher/rke/releases/tag/v1.2.2)

### Kubernetes

-  [1.19.3](https://github.com/rancher/hyperkube/releases/tag/v1.19.3-rancher1) (default)
-  [1.18.10](https://github.com/rancher/hyperkube/releases/tag/v1.18.10-rancher1)
-  [1.17.13](https://github.com/rancher/hyperkube/releases/tag/v1.17.13-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher2) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.1

Due to a random corruption of the rancher-agent image on Dockerhub, Rancher 2.5.1 is a mirror release of 2.5.0 but with rebuilt images. There are no bug fixes or enhancements introduced in this version. [#29424](https://github.com/rancher/rancher/issues/29424)

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. 
- If you are using Rancher to manage other Rancher instances, do not upgrade at this time as there are known issues around conflicting controllers. [#29364](https://github.com/rancher/rancher/issues/29364).
- If you are running a forked build of the UI and set the `ui-index` setting to `local`, you currently are unable to force that to load . [#29362](https://github.com/rancher/rancher/issues/29362)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- If you're using custom certs with the Docker install, clusters cannot be provisioned. [#28605](https://github.com/rancher/rancher/issues/28605)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.1 | `rancher/rancher:latest` | server-charts/latest |v2.5.1 |
  | Stable | v2.4.8 | `rancher/rancher:stable` | server-charts/stable | v2.4.8 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Features and Enhancements
 - **Cluster Explorer**:  A UI to provide a deeper look into clusters under management. With this new UI, you can:
   * Manage all Kubernetes cluster resources including custom resources from the Kubernetes operator ecosystem.
   * Deploy Helm charts from our new Apps and Marketplace.
   * View and edit Helm3 CLI releases from the new Apps UI.
   * Visibility to resources based on RBAC permissions
   * View logs and interact with kubectl shell in a new IDE-like viewer.
   * New Observability and Operations Tooling :
     - **Rancher Server Backups**: Previously admins relied on etcd backups of the Rancher management cluster for disaster recovery and rollback scenarios. The new backup and recovery process no longer requires access to the etcd database. Now admins can perform ad-hoc or scheduled backups of the Rancher application directly from the Rancher dashboard. Restore data into any Kubernetes cluster.

      - **Monitoring and Alerting powered by Prometheus**: Users can now define how to monitor, alert, and visualize application health as part of the deployment configuration. The new monitoring system can be configured with GitOps based workflows using the Prometheus Operator custom resources. Alertmanager can be configured to use all built-in notification integrations. Alert templates can be customized to tailor notifications the on-call team receives. Users can deploy their own Grafana dashboards into the built-in Grafana instance. 

     - **Logging powered by Banzai Cloud**: New cluster-level logging pipelines that incorporate lighter weight FluentBit and Fluentd to ship logs to a remote data store. The pipeline functionality is orchestrated Kubernetes objects enabling configuration through GitOps based workflows. Users will have the ability to customize both the FluentBit and Fluentd configurations. 

     - **Expanded CIS Scans powered by kube-bench**: Rancher CIS scanning now runs on EKS and GKE platforms in addition to RKE clusters. The scanning tool also includes a new standard CIS-1.5 profile untailored for a specific K8s distribution. The benchmark versions have been updated to CIS 1.5, EKS-1.0, and GKE-1.0. 
 
- **Rancher Continuous Delivery powered by Fleet**:  Rancher Continuous Delivery is a built-in deployment tool powered by Rancher's Fleet project. Users can leverage this tool to deliver applications and configurations from a Git source repository across multiple clusters. Rancher Continuous Delivery is able to scale to a large number of clusters under management using a staged checkout and pull-based update model.  The staged checkout allows the Continuous Delivery control plane to gradually roll deployments out to clusters instead of all at once. Using a pull-based update model, administrators don't need to configure network access to every remote cluster. Administrators can organize clusters into groups for easier management within Rancher Continuous Delivery. Git source repositories are mapped to cluster group targets by admins, without needing the end-user to access the control plane configuration. Application owners and admins can deploy any Kubernetes resource defined by manifests, kustomize, or Helm.

 - **Enhanced EKS Lifecycle Management**: EKS provisioning has been enhanced to support managed node groups, private access, and control plane logging. Users can now register existing EKS clusters provisioned with other tools like eksctl into Rancher to allow the management of upgrades and configuration going forward. Support has been added for multiple managed node groups with heterogeneous configurations to enable GPU and non-GPU workloads in the same cluster. The EKS cluster configuration in Rancher now uses cloud credentials decoupling the AWS key management from the cluster configuration. 

 - **Istio 1.7**: The Istio project has made a lot of changes to the installation process over the last several releases. The new Rancher Istio integration now deploys the latest Istio Operator allowing for users to deploy multiple ingress and egress gateways. Users can also manage the Istio custom resources in a customized UX in the new dashboard. 

 - **RKE Government**: A new Kubernetes distribution that supports FIPS encryption, SELinux, and container-d. The RKE-Gov distribution has out-of-the-box CIS compliance. Management of etcd backups and restores are built into the distribution.   

- **CentOS/RHEL 8 Support**: Admins can use RKE Government clusters installed on RHEL and CentOS 8 systems. RKE support will come in a later update and use Docker CE. 

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.4.8

- Rancher no longer panic's during a drain action from the API [#28905](https://github.com/rancher/rancher/issues/28905)
- Argo rollout pods can now be seen in the cluster explorer [#27923](https://github.com/rancher/rancher/issues/27923)
- Helm's max history can now be configured [#28728](https://github.com/rancher/rancher/issues/28728)
- The Cluster Manager UI dropdown now works on mobile [#23298](https://github.com/rancher/rancher/issues/23298)
- The new EKS provisioning supports API Server Endpoint Access Control [#19051](https://github.com/rancher/rancher/issues/19051)
- Cluster Explorer supports CRUD action on CRDs [#18013](https://github.com/rancher/rancher/issues/18013)

## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)

### Cluster Explorer Feature Caveats and Upgrades

- General
	- Not all new features are currently installable on a hardened cluster.
	- New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
	- The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- Rancher Backup
	- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
	- Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
	- The Monitoring stack currently is not installable on a K8s 1.16 cluster [#29395](https://github.com/rancher/rancher/issues/29395)
	- When the new Monitoring feature is deployed on K3s, it needs to have specific memory/cpu limits set [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
	- Monitoring sometimes errors on installation because it can't identify CRDs [#29171](https://github.com/rancher/rancher/issues/29171)
        - The new monitoring chart deploys a standard Prometheus installation which does not support project-level isolation.
- Istio
	- Installation for Istio fails when the ingress gateway is disabled [#29383](https://github.com/rancher/rancher/issues/29383)
- Longhorn
	- Longhorn has seen an issue where uninstallation may get stalled if there are daemonset changes occurring. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- OPA Gatekeeper (Experimental)
	- The first edition of OPA must be uninstalled before the new OPA features are installed [#29188](https://github.com/rancher/rancher/issues/29188)

### Air gap

- Deploying an EKS cluster in an air gap environment is not supported [#29070](https://github.com/rancher/rancher/issues/29070)
- Air gap has rarely seen an issue where the downstream cluster does not correctly get the registry setting, causing pods to fail. To workaround the issue, simply restart the agent [#28923](https://github.com/rancher/rancher/issues/28923)

## Versions

### Images
- rancher/rancher:v2.5.1
- rancher/rancher-agent:v2.5.1

### Tools
- cli - [v2.4.6](https://github.com/rancher/cli/releases/tag/v2.4.6)
- rke - [v1.2.0](https://github.com/rancher/rke/releases/tag/v1.2.0)

### Kubernetes

-  [1.19.2](https://github.com/rancher/hyperkube/releases/tag/v1.19.2-rancher1) (default)
-  [1.18.9](https://github.com/rancher/hyperkube/releases/tag/v1.18.9-rancher1)
-  [1.17.12](https://github.com/rancher/hyperkube/releases/tag/v1.17.12-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher1) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.0

Due to a random corruption of the rancher-agent image on Dockerhub, only amd64 is available for 2.5.0. Rancher 2.5.1 is a mirror release of 2.5.0 but with rebuilt images, please use that version instead. [#29424](https://github.com/rancher/rancher/issues/29424)


## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. 
- If you are using Rancher to manage other Rancher instances, do not upgrade at this time as there are known issues around conflicting controllers. [#29364](https://github.com/rancher/rancher/issues/29364).
- If you are running a forked build of the UI and set the `ui-index` setting to `local`, you currently are unable to force that to load . [#29362](https://github.com/rancher/rancher/issues/29362)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- If you're using custom certs with the Docker install, clusters cannot be provisioned. [#28605](https://github.com/rancher/rancher/issues/28605)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.0 | `rancher/rancher:latest` | server-charts/latest |v2.5.0 |
  | Stable | v2.4.8 | `rancher/rancher:stable` | server-charts/stable | v2.4.8 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Features and Enhancements
 - **Cluster Explorer**:  A UI to provide a deeper look into clusters under management. With this new UI, you can:
   * Manage all Kubernetes cluster resources including custom resources from the Kubernetes operator ecosystem.
   * Deploy Helm charts from our new Apps and Marketplace.
   * View and edit Helm3 CLI releases from the new Apps UI.
   * Visibility to resources based on RBAC permissions
   * View logs and interact with kubectl shell in a new IDE-like viewer.
   * New Observability and Operations Tooling :
     - **Rancher Server Backups**: Previously admins relied on etcd backups of the Rancher management cluster for disaster recovery and rollback scenarios. The new backup and recovery process no longer requires access to the etcd database. Now admins can perform ad-hoc or scheduled backups of the Rancher application directly from the Rancher dashboard. Restore data into any Kubernetes cluster.

      - **Monitoring and Alerting powered by Prometheus**: Users can now define how to monitor, alert, and visualize application health as part of the deployment configuration. The new monitoring system can be configured with GitOps based workflows using the Prometheus Operator custom resources. Alertmanager can be configured to use all built-in notification integrations. Alert templates can be customized to tailor notifications the on-call team receives. Users can deploy their own Grafana dashboards into the built-in Grafana instance. 

     - **Logging powered by Banzai Cloud**: New cluster-level logging pipelines that incorporate lighter weight FluentBit and Fluentd to ship logs to a remote data store. The pipeline functionality is orchestrated Kubernetes objects enabling configuration through GitOps based workflows. Users will have the ability to customize both the FluentBit and Fluentd configurations. 

     - **Expanded CIS Scans powered by kube-bench**: Rancher CIS scanning now runs on EKS and GKE platforms in addition to RKE clusters. The scanning tool also includes a new standard CIS-1.5 profile untailored for a specific K8s distribution. The benchmark versions have been updated to CIS 1.5, EKS-1.0, and GKE-1.0. 
 
- **Rancher Continuous Delivery powered by Fleet**:  Rancher Continuous Delivery is a built-in deployment tool powered by Rancher's Fleet project. Users can leverage this tool to deliver applications and configurations from a Git source repository across multiple clusters. Rancher Continuous Delivery is able to scale to a large number of clusters under management using a staged checkout and pull-based update model.  The staged checkout allows the Continuous Delivery control plane to gradually roll deployments out to clusters instead of all at once. Using a pull-based update model, administrators don't need to configure network access to every remote cluster. Administrators can organize clusters into groups for easier management within Rancher Continuous Delivery. Git source repositories are mapped to cluster group targets by admins, without needing the end-user to access the control plane configuration. Application owners and admins can deploy any Kubernetes resource defined by manifests, kustomize, or Helm.

 - **Enhanced EKS Lifecycle Management**: EKS provisioning has been enhanced to support managed node groups, private access, and control plane logging. Users can now register existing EKS clusters provisioned with other tools like eksctl into Rancher to allow the management of upgrades and configuration going forward. Support has been added for multiple managed node groups with heterogeneous configurations to enable GPU and non-GPU workloads in the same cluster. The EKS cluster configuration in Rancher now uses cloud credentials decoupling the AWS key management from the cluster configuration. 

 - **Istio 1.7**: The Istio project has made a lot of changes to the installation process over the last several releases. The new Rancher Istio integration now deploys the latest Istio Operator allowing for users to deploy multiple ingress and egress gateways. Users can also manage the Istio custom resources in a customized UX in the new dashboard. 

 - **RKE Government**: A new Kubernetes distribution that supports FIPS encryption, SELinux, and container-d. The RKE-Gov distribution has out-of-the-box CIS compliance. Management of etcd backups and restores are built into the distribution.   

- **CentOS/RHEL 8 Support**: Admins can use RKE Government clusters installed on RHEL and CentOS 8 systems. RKE support will come in a later update and use Docker CE. 

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.4.8

- Rancher no longer panic's during a drain action from the API [#28905](https://github.com/rancher/rancher/issues/28905)
- Argo rollout pods can now be seen in the cluster explorer [#27923](https://github.com/rancher/rancher/issues/27923)
- Helm's max history can now be configured [#28728](https://github.com/rancher/rancher/issues/28728)
- The Cluster Manager UI dropdown now works on mobile [#23298](https://github.com/rancher/rancher/issues/23298)
- The new EKS provisioning supports API Server Endpoint Access Control [#19051](https://github.com/rancher/rancher/issues/19051)
- Cluster Explorer supports CRUD action on CRDs [#18013](https://github.com/rancher/rancher/issues/18013)

## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)

### Cluster Explorer Feature Caveats and Upgrades

- General
	- Not all new features are currently installable on a hardened cluster.
	- New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
	- The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- Rancher Backup
	- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
	- Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
	- The Monitoring stack currently is not installable on a K8s 1.16 cluster [#29395](https://github.com/rancher/rancher/issues/29395)
	- When the new Monitoring feature is deployed on K3s, it needs to have specific memory/cpu limits set [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
	- Monitoring sometimes errors on installation because it can't identify CRDs [#29171](https://github.com/rancher/rancher/issues/29171)
        - The new monitoring chart deploys a standard Prometheus installation which does not support project-level isolation.
- Istio
	- Installation for Istio fails when the ingress gateway is disabled [#29383](https://github.com/rancher/rancher/issues/29383)
- Longhorn
	- Longhorn has seen an issue where uninstallation may get stalled if there are daemonset changes occurring. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- OPA Gatekeeper (Experimental)
	- The first edition of OPA must be uninstalled before the new OPA features are installed [#29188](https://github.com/rancher/rancher/issues/29188)

### Air gap

- Deploying an EKS cluster in an air gap environment is not supported [#29070](https://github.com/rancher/rancher/issues/29070)
- Air gap has rarely seen an issue where the downstream cluster does not correctly get the registry setting, causing pods to fail. To workaround the issue, simply restart the agent [#28923](https://github.com/rancher/rancher/issues/28923)

## Versions

### Images
- rancher/rancher:v2.5.0
- rancher/rancher-agent:v2.5.0

### Tools
- cli - [v2.4.6](https://github.com/rancher/cli/releases/tag/v2.4.6)
- rke - [v1.2.0](https://github.com/rancher/rke/releases/tag/v1.2.0)

### Kubernetes

-  [1.19.2](https://github.com/rancher/hyperkube/releases/tag/v1.19.2-rancher1) (default)
-  [1.18.9](https://github.com/rancher/hyperkube/releases/tag/v1.18.9-rancher1)
-  [1.17.12](https://github.com/rancher/hyperkube/releases/tag/v1.17.12-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher1) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.17

**This release concludes support for [Rancher 2.5](https://www.suse.com/lifecycle/). Please upgrade to a newer version of Rancher for continued support.**

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.5.17 is a security release to address the following issues:**

# Security Fixes for Rancher Vulnerabilities

This release addresses **04 security issues** found in Rancher:

- Improved authorization logic checks around project role template binding (PRTB) and `-promoted` roles to protect against possible privilege escalation. For more information, see [CVE-2022-43759](https://github.com/rancher/rancher/security/advisories/GHSA-7m72-mh5r-6j3r).

- Fixed an issue in Rancher's Git package that could potentially lead to command injection. For more information, see [CVE-2022-43758](https://github.com/rancher/rancher/security/advisories/GHSA-34p5-jp77-fcrc).

- Fixed an issue where sensitive fields and credentials like secret tokens, encryption keys, and SSH keys were stored as plaintext on Kubernetes objects. This is a follow-up security fix to address the fields missed in [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f). For more information, see [CVE-2022-43757](https://github.com/rancher/rancher/security/advisories/GHSA-cq4p-vp5q-4522).

- Fixed an authorization logic flaw that allowed an authenticated user on any downstream cluster to (1) open a shell pod in the Rancher local cluster and (2) have limited kubectl access to the local cluster. For more information, see [CVE-2022-21953](https://github.com/rancher/rancher/security/advisories/GHSA-g25r-gvq3-wrq7).

Additionally, the following security related updates were performed in this release to address security issues:

- Fixed a validation check issue where Rancher generated tokens are not revoked after modifications are made to a configured authentication provider. This issue is only applicable if external authentication providers were configured in Rancher. For more information, see security advisory [GHSA-c45c-39f6-6gw9](https://github.com/rancher/rancher/security/advisories/GHSA-c45c-39f6-6gw9).

- Updated the version of Rancher's Fleet chart to `0.3.1000+up0.3.10-security1` to address two security issues in [`rancher/wrangler`](https://github.com/rancher/wrangler) dependency:

  - The high severity [CVE-2022-31249](https://github.com/rancher/wrangler/security/advisories/GHSA-qrg7-hfx7-95c5) that could lead to a command injection vulnerability in Rancher's Continuous Delivery feature through Fleet's GitJob pod.

  - The medium severity [CVE-2022-43756](https://github.com/rancher/wrangler/security/advisories/GHSA-8fcj-gf77-47mg) that could cause a denial of service (DoS) attack in Fleet's GitJob pod.

- Updated the version of [`crewjam/saml`](https://github.com/crewjam/saml) SAML library to address the critical severity [CVE-2022-41912](https://github.com/crewjam/saml/security/advisories/GHSA-j2jp-wvqg-wc2g).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:**
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:**
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:**
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS requirements:**
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:**
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:**
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**:
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.17
- rancher/rancher-agent:v2.5.17

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.22](https://github.com/rancher/rke/releases/tag/v1.2.22)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - AKS Kubernetes versions 1.20 and earlier have reached end of life. As Rancher v2.5 does not support Kubernetes greater than 1.20, it is not possible to provision new downstream AKS clusters. See [#38406](https://github.com/rancher/rancher/issues/38406).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.
- **Cluster Tools**
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022.
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.
  - **Docker installs:**
    - UI issues may occur due to a longer startup time.
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----
# Release v2.5.16

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Fixes for Rancher Vulnerabilities

This release addresses three **critical severity** security issues found in Rancher:

- Fixed an issue where sensitive fields like passwords, API keys, and Rancher's service account token were stored as plaintext on Kubernetes objects. Any user with read access to those objects in the Kubernetes API could retrieve the plaintext version of those sensitive data. For more information, see [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f).

- Improved the sanitization (removal) of credentials from cluster template answers. Failure to sanitize data can lead to plaintext storage and exposure of credentials, passwords, and API tokens. For more information, see [CVE-2021-36783](https://github.com/rancher/rancher/security/advisories/GHSA-8w87-58w6-hfv8).

- Fixed an authorization logic flaw that allowed privilege escalation in downstream clusters through cluster role template binding (CRTB) and project role template binding (PRTB). For more information, see [CVE-2022-31247](https://github.com/rancher/rancher/security/advisories/GHSA-6x34-89p7-95wg).

For more details, see the [Security Advisories page](https://github.com/rancher/rancher/security/advisories).

# Features and Enhancements

### Azure Active Directory API Migration

Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/authentication/azure-ad/#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#37228](https://github.com/rancher/rancher/issues/37228) for details.

- **Limitations**
  - Attempts to log in will fail after rolling back a Docker install of Rancher if the following conditions have occurred:
    - Azure AD is enabled.
    - Before the rollback, admins committed to the Azure AD configuration update.

    This is because the Azure AD endpoints will not be rolled back if the rollback is not performed via the backup-restore operator. If you want to roll back Rancher to use the old Azure AD Graph API without using the backup-restore operator, follow this [workaround](https://github.com/rancher/rancher/issues/38025#issuecomment-1213208087) to edit the AzureAD authconfig resource stored in the local cluster's database. The old Azure AD Graph API endpoints will not be rolled back on a Rancher rollback. See [#38025](https://github.com/rancher/rancher/issues/38025).
- **Other**
  - Multi-factor authentication (MFA) now works with the Azure AD auth provider. Some Rancher setups might have had MFA enabled in Azure from before, but Rancher wasn't working with it correctly. Be aware that on upgrade, if MFA is enabled for the Azure app, Rancher will require additional verification. See [#38028](https://github.com/rancher/rancher/pull/38028).
  - Before starting the migration process or enabling Azure AD for the first time in v2.6.7+, ensure that you add the Azure app registration's permissions of type **Application** and **NOT Delegated** for Microsoft Graph. Otherwise, you may not be able to login to Azure AD. This issue will persist even after you disable/re-enable Azure AD and will require an hour wait, or manual deletion of a cache value to resolve.

# Major Bug Fixes

- Prior to `v2.5.16`, if S3 or other kinds of credentials were added to a cluster after it was already created, the reference to the secret containing the credentials was lost because the cluster status cannot updated through the API. The references are now moved to the cluster Spec so that they can be updated added after creation. To repair a cluster after a upgrade to `v2.5.16`, edit the cluster and change the etcd snapshot configuration back to local and save it, then edit again to configure S3 snapshots again. See [#38397](https://github.com/rancher/rancher/issues/38397).
- Fixed a bug that overloaded the downstream Kubernetes API server when the Cluster Explorer dashboard was left open to a page for a downstream cluster for over 30 minutes and would start rapidly opening and closing watch requests perpetually. See [#37986](https://github.com/rancher/rancher/issues/37986).
- Fixed an issue where issues in a downstream cluster would cause a controller to frequently restart and eventually lead to a Goroutine leak. See [#37965](https://github.com/rancher/rancher/issues/37965).
- Updated an internal download link that was causing upgrades to fail. See [#37859](https://github.com/rancher/rancher/issues/37859).
- Increased entropy of CSRF (cross-site request forgery) token. See [#15](https://github.com/rancher/apiserver/pull/15) and [#419](https://github.com/rancher/norman/pull/419).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:**
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:**
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:**
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:**
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).
- **EKS requirements:**
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:**
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:**
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**:
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:**
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.16
- rancher/rancher-agent:v2.5.16

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.22](https://github.com/rancher/rke/releases/tag/v1.2.22)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - AKS Kubernetes versions 1.20 and earlier have reached end of life. As Rancher v2.5 does not support Kubernetes greater than 1.20, it is not possible to provision new downstream AKS clusters. See [#38406](https://github.com/rancher/rancher/issues/38406).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.
- **Cluster Tools**
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022.
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.
  - **Docker installs:**
    - UI issues may occur due to a longer startup time.
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).
-----
**Rancher v2.5.15 is a mirror release of [v2.5.14](https://github.com/rancher/rancher/releases/tag/v2.5.14) with one change to address the following issue:**

- A major performance issue was occurring when Rancher was attempting to control large volumes of traffic from downstream clusters. This mechanism was not handling disconnects properly and would result in indefinite locks. See [#38097](https://github.com/rancher/rancher/issues/38097).
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Fixes for Rancher Vulnerabilities

This release addresses one security issue found in Rancher:

- Fixed an issue in RKE Templates when creating a cluster with Weave as CNI: the template was not configuring a password for network traffic encryption in Weave, and therefore network traffic in the cluster was being sent unencrypted. For more information, see [CVE-2022-21951](https://github.com/rancher/rancher/security/advisories/GHSA-vrph-m5jj-c46c).

For more details, see the [security advisories page](https://github.com/rancher/rancher/security/advisories).

# Major Bug Fixes

- Rancher now successfully provisions all downstream cluster types with private registries with the RKE template as expected. See [#37515](https://github.com/rancher/rancher/issues/37515).
- Fixed an issue in which a new log was introduced under error level rather than debug level. Note that if conditions occur that result in these log messages, no user intervention is necessary. The buffer will simply be paused from taking any input until it is no longer full. See [#36584](https://github.com/rancher/rancher/issues/36584).
- After the YAML is directly modified in RKE clusters, support for multiple private registries now functions as expected. See [#37732](https://github.com/rancher/rancher/pull/37732).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:** 
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** 
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** 
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** 
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** 
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** 
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**: 
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.14
- rancher/rancher-agent:v2.5.14

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.20](https://github.com/rancher/rke/releases/tag/v1.2.20)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced as part of Rancher v2.5.4 through v2.5.10 as an experimental feature but is now deprecated. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.  
- **Cluster Tools**
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022. 
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** 
    - UI issues may occur due to a longer startup time. 
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----
# Release v2.5.13

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Fixes for Rancher Vulnerabilities

This release addresses security issues found in Rancher:

- Improved authorization check to prevent privilege escalation of users who have `create` and `update` permissions on Global Roles. For more information see: [CVE-2021-36784](https://github.com/rancher/rancher/security/advisories/GHSA-jwvr-vv7p-gpwq).
- Fixed an issue that granted write permissions on `CatalogTemplates` or `CatalogTemplateVersions` to regular users when `restricted-admin` is enabled as default user in Rancher. For more information see: [CVE-2021-4200](https://github.com/rancher/rancher/security/advisories/GHSA-hx8w-ghh8-r4xf).
- Updated version of external `go-getter` library used in Fleet to avoid leaking SSH private keys in Rancher UI and in Fleet's deployment pod logs. For more information see: [GHSA-wm2r-rp98-8pmh](https://github.com/rancher/rancher/security/advisories/GHSA-wm2r-rp98-8pmh).

For more details, see the [security advisories page](https://github.com/rancher/rancher/security/advisories).

# Major Bug Fixes

- When an auth group is assigned to the Restricted Admin global role, not all permissions are properly applied and the Rancher logs are spammed with the error `RoleBinding.rbac.authorization.k8s.io "my-role-name" is invalid`. See [#36621](https://github.com/rancher/rancher/issues/36621).
- Equinix Metal driver version updated. See [#34742](https://github.com/rancher/rancher/issues/34742).
- Cannot create a backup in Cluster Explorer after switching the interface language to Simplified Chinese. See [#33654](https://github.com/rancher/rancher/issues/33654).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:** 
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** 
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** 
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** 
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** 
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** 
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**: 
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.13
- rancher/rancher-agent:v2.5.13

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.19](https://github.com/rancher/rke/releases/tag/v1.2.19)

### Kubernetes Versions
- 1.20.15 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in v2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being rewritten and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.  
- **Cluster Tools**
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022. 
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** 
    - UI issues may occur due to a longer startup time. 
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----

-----

-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Major Bug Fixes

- Fixed RBAC issue in Cluster Explorer in which the schema was not being updated. See [#31982](https://github.com/rancher/rancher/issues/31982).
- Updated YAML for rancher logging output fields such that the secret containing the value is referenced correctly. See [#4578](https://github.com/rancher/dashboard/issues/4578).
- Fixed an issue in which LDAP servers that returned specific high-value error codes (such as 4096) would cause Rancher to invalidate users' kubeconfig tokens during the nightly auth refresh, or when users attempted to use their kubeconfig tokens. See [#35791](https://github.com/rancher/rancher/issues/35791).
- New and existing rancher-webhook deployments will automatically renew their TLS certificates when the expiration date is 30 days or less. See [#35068](https://github.com/rancher/rancher/issues/35068).
- Backups that take longer than five minutes no longer cause Rancher to start a new backup nor delete the backup that is currently running. See [#36038](https://github.com/rancher/rancher/issues/36038). 
- Fixed an issue in which `iptables-save` failed due to segfault in RHEL 8.2, 8.3, and 8.4. See [#34604](https://github.com/rancher/rancher/issues/34604).
- Rancher now properly ensures the old add-on upgrade jobs are deleted as part of the Kubernetes version upgrade process; this prevents an issue where a cluster may end up reporting as "Active" without having some add-on(s) actually upgraded. See [#36037](https://github.com/rancher/rancher/issues/36037).
- Cluster health checks no longer fail from random downstream clusters becoming unreachable. See [#34819](https://github.com/rancher/rancher/issues/34819).
- Fixed an issue in which the restricted admin user had limited capabilities and was unable to perform essential tasks such as viewing downstream clusters and changing Rancher's settings. See [#36094](https://github.com/rancher/rancher/pull/36094).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/).

### Upgrade Requirements

- **Creating backups:** 
  - We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** 
  - Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade with RKE1 to Kubernetes v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
  - For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. See [#32002](https://github.com/rancher/rancher/issues/32002).
- **Requirements for air-gapped environments:**
  - For installing or upgrading Rancher in an air-gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/) and [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Cert-manager version requirements:** 
  - Recent changes to cert-manager require an upgrade if you have a high-availability install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) for information on how to upgrade cert-manager.
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. [See the documentation](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and works as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE requirements:** 
  - For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and Save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit, and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** 
  - There was a setting for Rancher versions prior to 2.5.8 that allowed users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** 
  - When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in Apps & Marketplace, there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used, and doing so should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** 
  - Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or roll back to change the Rancher version.
  - Please be aware when upgrading to v2.3.0+, any edits to a Rancher-launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/rollbacks/#rolling-back-to-rancher-v2-5-0) for the new instructions.
- **Important**: 
  - When rolling back, we are expecting you to roll back to the state at the time of your upgrade. Any changes post-upgrade would not be reflected.
- **The local cluster can no longer be turned off:** 
  - In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. Access to the local cluster can now be disabled by setting `hide_local_cluster` to **true** from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.12
- rancher/rancher-agent:v2.5.12

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.16](https://github.com/rancher/rke/releases/tag/v1.2.16)

### Kubernetes Versions
- 1.20.14 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in v2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being rewritten and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed a feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General:**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **UI Shell:**
  - After closing the shell in the Rancher UI, be aware that the corresponding processes remain running indefinitely for each shell in the pod. See [#16192](https://github.com/rancher/rancher/issues/16192).
- **Continuous Delivery:**
  - Restricted admins are not able to create git repos from the Continuous Delivery option under Cluster Explorer; the screen will become stuck in a loading status. See [#4909](https://github.com/rancher/dashboard/issues/4909).
- **Rancher Backup:**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location; it must continue to use the same URL.
- **Monitoring:**
  - Monitoring sometimes errors on installation because it can't identify CRDs. See [#29171](https://github.com/rancher/rancher/issues/29171).
- **Istio:**
  - Be aware that when upgrading from Istio v1.7.4 or earlier to any later version, there may be connectivity issues. See [upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) and [#31811](https://github.com/rancher/rancher/issues/31811).
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means that the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. See [#31761](https://github.com/rancher/rancher/issues/31761) and [#31265](https://github.com/rancher/rancher/issues/31265).
  - Istio v1.10 and earlier versions are now End-of-life but are required for the upgrade path in order to not skip a minor version. See [#33824](https://github.com/rancher/rancher/issues/33824).

### Cluster Manager Feature Caveats and Upgrades
- **GKE:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty: at least one label must be set. See [#32553](https://github.com/rancher/rancher/issues/32553).
- **EKS & GKE:**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. See [#32440](https://github.com/rancher/rancher/issues/32440).

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
  - **AKS:**
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://rancher.com/docs/rancher/v2.5/en/helm-charts/#repositories) and [#35940](https://github.com/rancher/rancher/issues/35940) for more information.  
- **Cluster Tools**
  - **Hardened clusters:** 
    - Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring:**
    - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
    - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on, if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging:**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing Helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - Istio v1.5 is not supported in air-gapped environments. Please note that the Istio project has ended support for Istio v1.5.
    - [Istio v1.10 support ended](https://istio.io/latest/news/support/announcing-1.10-eol-final/) on January 7th, 2022. 
  - **Legacy Monitoring:**
    - In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air-gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart.
      - Manually import the necessary images into your private registry for the Monitoring application to use.
  - **Installation requirements:**
    - Importing a Kubernetes v1.21 cluster might not work properly and is unsupported.
  - **Backup and Restore:**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** 
    - UI issues may occur due to a longer startup time. 
    - Users may receive an error message when logging in for the first time. See [#28800](https://github.com/rancher/rancher/issues/28800).
    - Users may be redirected to the login screen before a password and default view have been set. See [#28798](https://github.com/rancher/rancher/issues/28798).

-----

-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

# Security Enhancements

- Updated NGINX to latest and make allow-snippets-annotations configurable. See [#35164](https://github.com/rancher/rancher/issues/35164).

# Major Bug Fixes

- The API Server has been updated to fix slow consumers causing deadlocks. See [#34907](https://github.com/rancher/rancher/pull/34907).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
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
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE Requirements:** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** There was a setting for Rancher versions prior to 2.5.8 allowing users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in app & marketplace there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used and it should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the documentation for the new instructions.
- **Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.11
- rancher/rancher-agent:v2.5.11

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.14](https://github.com/rancher/rke/releases/tag/v1.2.14)

### Kubernetes Versions
- 1.20.12 (Default)
- 1.19.16
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)

### Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
- **Cluster Tools**
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring**
  - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
  - **Legacy Monitoring**
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
  - **Installation Requirements**
    - Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
  - **Backup and Restore**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.
# Features and Enhancements

- **Deploying on hardened clusters**: Support has been added for deploying EKS, AKS, and GKE clusters when the Rancher Management server cluster has been CIS hardened. See [#33172](https://github.com/rancher/rancher/issues/33172).

### Security Enhancements

- Fixed RBAC project role issue in Rancher v2.5 Cluster Explorer. Role revisions are now properly tracked for ClusterRoles associated to RoleBinding resources. This allows returning up-to-date schemas for users and not evaluating a user's access from stale access states. See [#31982](https://github.com/rancher/rancher/issues/31982).

# Major Bug Fixes

- Project Network Isolation ingress NetworkPolicy resources now get configured correctly when using Calico CNI with IPIP or VXLAN routing. See [#34084](https://github.com/rancher/rancher/issues/34084).
- The health status of the Controller Mananger and Scheduler on the dashboard will show as Not Applicable on clusters where the componentstatus is not available. See [#32905](https://github.com/rancher/rancher/issues/32905).
- EKS, AKS, and GKE provisioners now correctly use any additional CAs passed to Rancher, if provided. See [#32903](https://github.com/rancher/rancher/issues/32903).
- When deploying an EKS or GKE cluster on hosted Rancher, cluster provisioning is now successful. See [#33053](https://github.com/rancher/rancher/issues/33053).
- The API Server has been updated to fix slow consumers causing deadlocks. See [#34907](https://github.com/rancher/rancher/pull/34907).

# Install/Upgrade Notes

> If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://rancher.com/docs/rancher/v2.5/en/installation/requirements/)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://rancher.com/docs/rancher/v2.5/en/backups/back-up-rancher/).
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **Kubernetes version:**
  - The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5+.
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
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).
- **RKE Requirements:** For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)`, please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster. See [#32216](https://github.com/rancher/rancher/issues/32216).  
- **EKS requirements:** There was a setting for Rancher versions prior to 2.5.8 allowing users to configure the length of refresh time in cron format: eks-refresh-cron. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: eks-refresh. If previously set, the migration will happen automatically. See [#31789](https://github.com/rancher/rancher/issues/31789).
- **Fleet-agent:** When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in app & marketplace there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used and it should not delete the real fleet-agent deployment since it has been migrated. See [#362](https://github.com/rancher/fleet/issues/362).

### Rancher Behavior Changes

- **Upgrades and Rollbacks:** Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.
  - Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.
  - Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the [documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/) on how to upgrade cert-manager.
  - Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.
  - The process to roll back Rancher has been updated for versions v2.5.0 and above. Refer to the documentation for the new instructions.
- **Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.
- **The local cluster can no longer be turned off.** In older Rancher versions, the local cluster could be hidden to restrict admin access to the Rancher server's local Kubernetes cluster, but that feature has been deprecated. The local Kubernetes cluster can no longer be hidden and all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. See the [documentation](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) and [#29325](https://github.com/rancher/rancher/issues/29325). For more information on upgrading from Rancher with a hidden local cluster, see the documentation.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.


### Images
- rancher/rancher:v2.5.10
- rancher/rancher-agent:v2.5.10

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.13](https://github.com/rancher/rke/releases/tag/v1.2.13)

### Kubernetes Versions
- 1.20.8 (Default)
- 1.19.12
- 1.18.20
- 1.17.17

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
|**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

### Experimental Features

RancherD was introduced in 2.5 as an easy-to-use installation binary. With the introduction of RKE2 provisioning, this project is being re-written and will be available at a later time. See [#33423](https://github.com/rancher/rancher/issues/33423).

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)

### Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

### Known Major Issues

- **Kubernetes Cluster Distributions**
  - **RKE**
    - Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)    
    - After migrating from the in-tree vSphere cloud provider to the out-of-tree cloud provider, attempts to upgrade the cluster will not complete. This is due to nodes containing workloads with bound volumes before the migration failing to drain. Users will observe these nodes stuck in a `draining` state. Follow this [workaround](https://github.com/rancher/rancher/issues/35102#issuecomment-943493870) to continue with the upgrade. See [#35102](https://github.com/rancher/rancher/issues/35102).
- **Cluster Tools**
  - **Hardened clusters:** Not all cluster tools can currently be installed on a hardened cluster. 
  - **Monitoring**
  - Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. See [#32563](https://github.com/rancher/rancher/issues/32563).
  - **Logging**
    - Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio versions:**
    - [Istio 1.9 support ended](https://istio.io/latest/news/support/announcing-1.9-eol-final/) on October 8th, 2021.
    - Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5.
  - **Legacy Monitoring**
    - In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Legacy Monitoring, also called Monitoring V1, which is compatible with Kubernetes 1.15 clusters. If you are running Kubernetes 1.15 clusters in an air gapped environment, and you want to either install Monitoring V1 or upgrade Monitoring V1 to the latest that is offered by Rancher for Kubernetes 1.15 clusters, you will need to take one of the following actions:
      - Upgrade the Kubernetes version so that you can use v0.2.x of the Monitoring application Helm chart
      - Manually import the necessary images into your private registry for the Monitoring application to use
  - **Installation Requirements**
    - Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
  - **Backup and Restore**
    - Reinstalling Rancher 2.5.x on the same cluster may fail due to a lingering `rancher.cattle.io.` MutatingWebhookConfiguration object from a previous installation. Manually deleting it will resolve the issue.  
  - **Docker installs:** There are UI issues around startup time. See [#28800](https://github.com/rancher/rancher/issues/28800) and [#28798](https://github.com/rancher/rancher/issues/28798).

-----
# Release v2.5.9

# Changes in this Release

## Security Fixes for Rancher Vulnerabilities

This release addresses security issues found in Rancher:

- Prevented privilege escalation via a malicious "Connection" header. [#33588](https://github.com/rancher/rancher/issues/33588) Fixes [CVE-2021-31999.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-31999)
- Used apiGroups instead of "*" when creating Kubernetes RBAC resources for apps to avoid granting permissions to all app CRDs that exist in the cluster. Fixes [CVE-2021-25318.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25318) [#33590](https://github.com/rancher/rancher/issues/33590)
- An unprivileged user can no longer use another user's cloud credential for API requests to a cloud provider. Fixes [CVE-2021-25320.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25320) [#33589](https://github.com/rancher/rancher/issues/33589)

For more details, see the [security advisories page](https://github.com/rancher/rancher/security/advisories).

## Additional Security Fixes

- Processes no longer panic upon receipt of malicious protobuf messages. Fixes [CVE-2021-3121.](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121) [#32944](https://github.com/rancher/rancher/pull/32944)
- Updated minio-go, removed dependency on etcd, and updated rancherd RKE2 version to v1.20.7+rke2r2. [#33050](https://github.com/rancher/rancher/pull/33050)

## Bug Fixes

- vSphere vCenter server entries are removed properly. [#27306](https://github.com/rancher/rancher/issues/27306)
- The size of v3.Catalog objects was reduced to avoid timeouts and CPU consumption spikes. [#33256](https://github.com/rancher/rancher/issues/33256)
- Services that are automatically deployed for workloads are removed when the workloads are removed. [#33180](https://github.com/rancher/rancher/issues/33180)
- Rancher startup is no longer blocked by CleanupDuplicateBindings. [#32873](https://github.com/rancher/rancher/issues/32873)
- Move non-error logging for etcd backups to debug to avoid flooding logs when a lot of clusters are managed. [#32826](https://github.com/rancher/rancher/issues/32826)
- Fixed an issue where nodes get stuck in Active when more than 5 nodes are being created at a time. [#32681](https://github.com/rancher/rancher/issues/32681)
- Errors are no longer seen when registering more than 100 clusters simultaneously. [#32154](https://github.com/rancher/rancher/issues/32154)
- Nodes are no longer stuck at "waiting to register" after Rancher is upgraded. [#31999](https://github.com/rancher/rancher/issues/31999)

# Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)
- For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. [#32002](https://github.com/rancher/rancher/issues/32002)
- For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster.
[#32216](https://github.com/rancher/rancher/issues/32216)
- For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. [#3226](https://github.com/rancher/docs/issues/3226)
- There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. [#31789](https://github.com/rancher/rancher/issues/31789)
- When upgrading `<=v2.5.7` to `>=v2.5.8`, you may notice that in app & marketplace there is a fleet-agent release stuck at uninstalling. This is caused by migrating fleet-agent release name. It is safe to delete fleet-agent release as it is no longer used and it should not delete the real fleet-agent deployment since it has been migrated. [#362](https://github.com/rancher/fleet/issues/362)

### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time. [#28800](https://github.com/rancher/rancher/issues/28800) [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

# Known Major Issues
- Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. [#32325](https://github.com/rancher/rancher/issues/32325)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5. Please see above in Deprecated Features.
- In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.
- Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
- Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. [#32535](https://github.com/rancher/rancher/issues/32535)
- Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. [#32563](https://github.com/rancher/rancher/issues/32563)

# Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - When accessing tracing information for a service in the Kiali dashboard bundled with v1.9.3 and v1.8.5, attempting to change the display options may result in a persistent error for that service's tracing information. We recommend using the Jaeger dashboard if you would like different details for a particular services tracing until this issue is resolved. The resolution for this issue can be found in [#32330](https://github.com/rancher/rancher/issues/32330)
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)


# Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

# Versions within Rancher

### Images
- rancher/rancher:v2.5.9
- rancher/rancher-agent:v2.5.9

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.9](https://github.com/rancher/rke/releases/tag/v1.2.9)

### Kubernetes Versions

- 1.20.8 (Default)
- 1.19.12
- 1.18.20
- 1.17.17

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/)

Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.

**Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----

-----
# Release v2.5.8

# Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- The local Kubernetes cluster for the Rancher server should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)
- For users upgrading from `>=v2.4.4` to `v2.5.x` with clusters where ACI CNI is enabled, note that upgrading Rancher will result in automatic cluster reconciliation. This is applicable for Kubernetes versions `v1.17.16-rancher1-1`, `v1.17.17-rancher1-1`, `v1.17.17-rancher2-1`, `v1.18.14-rancher1-1`, `v1.18.15-rancher1-1`, `v1.18.16-rancher1-1`, and `v1.18.17-rancher1-1`. Please refer to the [workaround](https://github.com/rancher/rancher/issues/32002#issuecomment-818374779) BEFORE upgrading to `v2.5.x`. [#32002](https://github.com/rancher/rancher/issues/32002)
- For users upgrading from `<=v2.4.8 (<= RKE v1.1.6)` to `v2.4.12+ (RKE v1.1.13+)`/`v2.5.0+ (RKE v1.2.0+)` , please note that Edit and save cluster (even with no changes or a trivial change like cluster name) will result in cluster reconciliation and upgrading `kube-proxy` on all nodes [because of a change in `kube-proxy` binds](https://github.com/rancher/rke/pull/2214#issuecomment-680001568). This only happens on the first edit and later edits shouldn't affect the cluster.
[#32216](https://github.com/rancher/rancher/issues/32216)
- For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. [#3226](https://github.com/rancher/docs/issues/3226)
- There is currently a setting allowing users to configure the length of refresh time in cron format: `eks-refresh-cron`. That setting is now deprecated and has been migrated to a standard seconds format in a new setting: `eks-refresh`. If previously set, the migration will happen automatically. [#31789](https://github.com/rancher/rancher/issues/31789)

### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info.](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time. [#28800](https://github.com/rancher/rancher/issues/28800) [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

# Enhancements


### Monitoring Enhancements

- Monitoring graphs have been added to the Cluster Explorer in the Rancher UI. [#30126](https://github.com/rancher/rancher/issues/30126)
- A new RBAC role has been added to give users read-only access to monitoring components such as the Grafana dashboard. [#31411](https://github.com/rancher/rancher/issues/31411) [Docs](https://rancher.com/docs/rancher/v2.5/en/monitoring-alerting/rbac/#additional-monitoring-clusterroles)
- Persistent Grafana dashboards can now be created by adding a ConfigMap to any namespace, and a narrower permission named **Manage Config Maps** is required to create them. [#31921](https://github.com/rancher/rancher/issues/31921) [Docs](https://rancher.com/docs/rancher/v2.5/en/monitoring-alerting/persist-grafana/)
- As of v2.5.8, users no longer need to manually annotate the `cattle-dashboards` namespace with `helm.sh/resource-policy: "keep"` to prevent it, and its associated resources, from being deleted when uninstalling the Monitoring chart. For users who are using Monitoring V2 v9.4.203 or below, the namespace still needs to be manually marked with the annotation `helm.sh/resource-policy: "keep"`. [#31769](https://github.com/rancher/rancher/issues/31769)
- You can now more easily set up SMS and Teams notifiers using our new `rancher-alerting-drivers` Helm chart that helps you install alerting drivers that are not natively supported by Prometheus. [#29951](https://github.com/rancher/rancher/issues/29951)

##### Windows Support for Monitoring V2

- For metrics to be scraped from Windows nodes, each Windows node in the cluster must use wins v.0.1.0. For details on upgrading wins on Windows nodes, refer to [this page.](https://rancher.com/docs/rancher/v2.5/en/monitoring-alerting/windows-clusters/#upgrading-existing-clusters-to-wins-v0-1-0) [#31842](https://github.com/rancher/rancher/issues/31842)
- Metrics will be scraped from Windows nodes using [windows\_exporter](https://github.com/prometheus-community/windows_exporter) (a community project previously named `wmi_exporter` when deployed in Monitoring V1). [#31148](https://github.com/rancher/rancher/issues/31148) [#31497](https://github.com/rancher/rancher/issues/31497)
- The Monitoring V2 application adds Linux nodeSelectors and tolerations throughout all monitoring components to ensure they are never deployed on a Windows host. [#31498](https://github.com/rancher/rancher/issues/31498)
- We now allow a container to publish a port available on the host network as a container port. This allows privileged containers using wins to avoid exposing a port on the host itself when it only needs to be exposed on the container level. [#13](https://github.com/rancher/wins/issues/13)
- As of v2.5.8, when Rancher provisions a new Windows cluster, the cluster is able to support wins upgrades and it is able to use the new Monitoring V2 chart with no changes. [#31499](https://github.com/rancher/rancher/issues/31499)

### Enhanced GKE Lifecycle Management

Full lifecycle management has been brought to GKE clusters that are newly provisioned or registered:

-   [Shared VPCs](https://cloud.google.com/vpc/docs/shared-vpc) are now supported.
-   We now support more options for configuring private GKE clusters. Note: This advanced setup can require more steps during the cluster provisioning process. For details, see [this section.](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/gke/#private-clusters)
-   We now support more configuration options for Rancher managed GKE clusters. For the full list of options, see the [docs.](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/gke/config-reference/)
-   When provisioning a GKE cluster, you can now use reusable cloud credentials instead of using a service account token directly to create the cluster.
-   Greater management capabilities are now available for registered GKE clusters. The same configuration options are available for registered GKE clusters as for the GKE clusters created through the Rancher UI. [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/registered-clusters/#additional-features-for-registered-eks-and-gke-clusters)

### Logging Enhancements

- Upgraded the Banzai logging operator. [#31644](https://github.com/rancher/rancher/issues/31644)
- Logging now works on SELinux enabled setups and has been tested on RHEL/CentOS 7 and 8. Note that If journald is configured in persistent mode on RKE2 cluster nodes you will need to set `systemdLogPath` to `/var/log/journal`. This is the default behavior in Ubuntu. [#30949](https://github.com/rancher/rancher/issues/30949) [#31309](https://github.com/rancher/rancher/issues/31309) [Rancher RPM installation docs.](https://rancher.com/docs/rancher/v2.5/en/security/selinux/)

##### Windows Support for Logging V2

- Added support for Windows clusters. Logs can now be collected from Windows Nodes. [#28721](https://github.com/rancher/rancher/issues/28721)

### Istio Enhancements

- Clusters with PSPs enabled are now supported. PSP templates have been added and can be enabled for Istio, Kiali, and Tracing. [#30744](https://github.com/rancher/rancher/issues/30744)
- Added v1.9.3 and v1.8.5 for Istio, which both address a vulnerability. For more info see the [security announcement](https://istio.io/latest/news/security/istio-security-2021-002/). Only v1.9.3 supports an air gapped installation.

### Backup Enhancements

- Rancher Continuous Delivery (Fleet) and rancher-operator are now handled during backup. [Backup#69](https://github.com/rancher/backup-restore-operator/issues/69)

### CIS Scan Enhancements

- Support for CIS scans using the CIS 1.6 benchmark has been added for RKE2 and K3s clusters. [#29649](https://github.com/rancher/rancher/issues/29649)

### Fleet Enhancements

- All labels on Rancher clusters are available using `global.fleet.clusterLabels.LABELNAME`. These can now be accessed directly as variables. [#152](https://github.com/rancher/fleet/issues/152) [Docs](https://github.com/rancher/fleet/blob/master/docs/gitrepo-structure.md)
- Downstream Fleet agents now fall back to Linux nodes if Windows nodes are not yet available in Windows clusters. [#324](https://github.com/rancher/fleet/issues/324)
- Fleet now supports authentication with private Helm repositories. Note that SSH keys with passphrase are not supported. [#120](https://github.com/rancher/fleet/issues/120) [Docs](https://github.com/rancher/fleet/blob/master/docs/gitrepo-structure.md)
- Fleet now supports using webhook to receive changes from git. [#252](https://github.com/rancher/fleet/issues/252)
- Rancher agent and Fleet agent work behind a proxy. RFE tickets: [#29993](https://github.com/rancher/rancher/issues/29993) and [#25412](https://github.com/rancher/rancher/issues/25412)

### RKE Cluster Enhancements

Users can enable project network isolation on any RKE cluster if the CNI network plugin supports the enforcement of Kubernetes network policies. Previously, the Canal network plugin was required for project network isolation. [#31338](https://github.com/rancher/rancher/issues/31338)

### Release Image Enhancements

- Releases now include an annotated copy images.txt displaying the source of each image. [#31663](https://github.com/rancher/rancher/issues/31663)
- Windows image digests are now included with releases. [#25222](https://github.com/rancher/rancher/issues/25222)

# Security Fixes

- A security issue was discovered in the current image of RANCHER/NGINX-INGRESS-CONTROLLER version 0.43.0-rancher1. This issue was assigned CVE-2021-3449 and CVE-2021-3540. To fix the issue, the openssl version of the image "nginx-0.43.0-rancher1" was updated from 1.1.1i to 1.1.1k. [#538](https://github.com/rancher/kontainer-driver-metadata/pull/538) [#2522](https://github.com/rancher/rke/pull/2522)
- Multiple critical and high CVEs were discovered in the `rancher/library-nginx:1.19.2-alpine` image. The image has since been updated to `rancher/library-nginx:1.19.9-alpine` and addresses the CVEs listed. [#82](https://github.com/rancher/image-mirror/pull/82) [#440](https://github.com/rancher/system-charts/pull/440)
  - Curl: CVE-2020-8231, CVE-2020-8285, CVE-2020-8169, CVE-2020-8286, and CVE-2020-8177
  - libxml2: CVE-2020-24977
  - freetype: CVE-2020-15999
  - musl: CVE-2020-28928 

# Major Bug Fixes

- Fixed several [UI issues.](https://github.com/rancher/rancher/issues?q=is%3Aissue+milestone%3Av2.5.8+is%3Aclosed+label%3Ateam%2Fui)
- Switched to deterministic naming strategy for ClusterRoleBinding and RoleBinding resources to mitigate duplicate issues. [#29932](https://github.com/rancher/rancher/issues/29932)
- Uninstalling Rancher no longer leaves pods running in the cluster for apps like Fleet, Rancher-Operator or Rancher-Webhook. [#30924](https://github.com/rancher/rancher/issues/30924)
- Logging in the Cluster Explorer when using RKE no longer creates large files in `/var/lib/rancher/logging/rke`. After upgrading, this file can be safely deleted. [#31309](https://github.com/rancher/rancher/issues/31309)
- EKS contained a bug where certain regions failed during deployment when using default user data. [#31612](https://github.com/rancher/rancher/issues/31612)
- When provisioning EC2 clusters, AMIs are now up to date. [#31708](https://github.com/rancher/rancher/issues/31708)
- When provisioning RKE clusters with a private registry, the private registry is applied properly to all system images. [#31726](https://github.com/rancher/rancher/issues/31726)
- Windows images for air gap are now available for charts maintained in [rancher/charts](https://github.com/rancher/charts). [#32290](https://github.com/rancher/rancher/issues/32290)
- Deleting a nodepool with multiple nodes no longer incorrectly deletes only one node in the provider. [#31765](https://github.com/rancher/rancher/issues/31765)
- After upgrading Rancher, new nodes are no longer stuck at the "waiting to register" stage. [#31999](https://github.com/rancher/rancher/issues/31999)
- The private registry setting in RKE is now respected by kubectl/shell and Helm operation pods. [#30735](https://github.com/rancher/rancher/issues/30735)
- GCS backups past retention now get deleted. [#30565](https://github.com/rancher/rancher/issues/30565)
- Added NetworkPolicy resources to system project-based namespaces to allow for Hardened CIS Scan to pass when Project Network Isolation is enabled. [30211](https://github.com/rancher/rancher/issues/30211)
- Only delete Rancher-created NetworkPolicy resources when disabling Project Network Isolation. [#30135](https://github.com/rancher/rancher/issues/30135)
- Domains in the AWS China region are now whitelisted to allow users to add and edit EKS clusters using cloud credentials associated with the AWS China region. [#29666](https://github.com/rancher/rancher/issues/29666)
- Amazon EC2 nodes can now be automatically provisioned in the AWS Middle East region. [#31980](https://github.com/rancher/rancher/issues/31980)
- PSP templates annotations are now properly applied to downstream cluster PSPs. Only annotations without names containing `.cattle.io/` are applied. [#22093](https://github.com/rancher/rancher/issues/22093)

# UI Updates

The primary UI in Rancher since v2.0 is now referred to as Cluster Manager in the UI. The new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. There are some new features in the new UI with similar functionality as existing features in Cluster Manager, but differences in implementation may cause variation.

## Duplicated Features in Cluster Manager and Cluster Explorer
- Only one version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall it in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

# Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Provision Kubernetes v1.16 Clusters** | We have ended support for Kubernetes v1.16. Cluster Manager no longer provisions new v1.16 clusters. If you already have a v1.16 cluster, it is unaffected. |

# Known Major Issues
- Logging (Cluster Explorer): Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. [#32325](https://github.com/rancher/rancher/issues/32325)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Istio 1.5 is not supported in air gapped environments. Please note that the Istio project has ended support for Istio 1.5. Please see above in Deprecated Features.
- In air gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.
- Importing a Kubernetes v1.21 cluster might not work properly. We are planning to add support for Kubernetes v1.21 in the future.
- When registering EKS and GKE clusters via Terraform, all unmanaged fields must be set to empty in order to avoid overriding configuration in the registered cluster. [#648](https://github.com/rancher/terraform-provider-rancher2/issues/648)
- Deploying Monitoring V2 on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. [#32535](https://github.com/rancher/rancher/issues/32535)
- Monitoring V2 fails to scrape ingress-nginx pods on any nodes except for the one Prometheus is deployed on if the security group used by worker nodes blocks incoming requests to port 10254. The workaround for this issue is to open up port 10254 on all hosts. [#32563](https://github.com/rancher/rancher/issues/32563)

# Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm 3 CLI and not with the Rancher CLI.
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
- **Monitoring**
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- **Istio**
  - When accessing tracing information for a service in the Kiali dashboard bundled with v1.9.3 and v1.8.5, attempting to change the display options may result in a persistent error for that service's tracing information. We recommend using the Jaeger dashboard if you would like different details for a particular services tracing until this issue is resolved. The resolution for this issue can be found in [#32330](https://github.com/rancher/rancher/issues/32330)
  - Be aware that when upgrading from Istio 1.7.4 or earlier to any later version there may be connectivity issues. [Upgrade notes](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#connectivity-issues-among-your-proxies-when-updating-from-1-7-x-where-x-5) [#31811](https://github.com/rancher/rancher/issues/31811)
  - Starting in v1.8.x, [DNS is supported natively](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/upgrade-notes/#istio-coredns-plugin-deprecation). This means the additional addon component `istioCoreDNS` is deprecated in v1.8.x and is not supported in v1.9x. If you are upgrading from v1.8.x to v1.9.x and you are using the `istioCoreDNS` addon, it is recommended that you disable it and switch to the natively supported DNS prior to upgrade. If you upgrade without disabling it, you will need to manually clean up your installation as it will not get removed automatically. [#31761](https://github.com/rancher/rancher/issues/31761) [#31265](https://github.com/rancher/rancher/issues/31265)


# Cluster Manager Feature Caveats and Upgrades
- **GKE**
  - Basic authentication must be explicitly disabed in GCP before upgrading a GKE cluster to 1.19+ in Rancher. [#32312](https://github.com/rancher/rancher/issues/32312)
  - When creating GKE clusters in Terraform, the `labels` field cannot be empty, at least one label must be set [#32553](https://github.com/rancher/rancher/issues/32553)
- **EKS & GKE**
  - When creating EKS and GKE clusters in Terraform, string fields cannot be set to empty. [#32440](https://github.com/rancher/rancher/issues/32440)

# Versions within Rancher

### Images
- rancher/rancher:v2.5.8
- rancher/rancher-agent:v2.5.8

### Tools
- CLI - [v2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [v1.2.8](https://github.com/rancher/rke/releases/tag/v1.2.8)

### Kubernetes
- v1.20.6 (default)
- v1.19.10
- v1.18.18
- v1.17.17

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/resources/upgrading-cert-manager/)

Existing GKE clusters and imported clusters will continue to operate as-is. Only new creations and registered clusters will use the new full lifecycle management.

**Important**: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----

-----
# Release v2.5.7

**Rancher v2.5.7 is a mirror release of v2.5.6 to address one issue:**

When using a private registry without authentication, provisioning or updating RKE clusters created with nodes from an infrastructure provider will fail. [#31600](https://github.com/rancher/rancher/issues/31600)

## Important

This release addresses a security vulnerability found in Rancher:

- CVE-2021-25313 - XSS attack on the Rancher API - When accessing the Rancher API with a browser, the URL was not properly escaped, making it vulnerable to an XSS attack. Specially crafted URLs to these API endpoints could include JavaScript which would be embedded in the page and execute in a browser. There is no direct mitigation. Avoid clicking on untrusted links to your Rancher server. [#31583](https://github.com/rancher/rancher/issues/31583)

### Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

## Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

## Enhancements
- Added support for Kubernetes v1.20
- Added ability to set environment variables to the agent in order to support downstream clusters behind a proxy [#31370](https://github.com/rancher/rancher/issues/31370) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/options/#agent-environment-variables)
- Added the ingress.enabled rancher Helm flag. When set to false, Helm will not install a Rancher ingress. Set the option to false to deploy your own ingress. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/chart-options/#advanced-options)
- **EKS**
  - Added ability to use launch templates for EKS managed node groups [#30019](https://github.com/rancher/rancher/issues/30019) [#30020](https://github.com/rancher/rancher/issues/30020) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/eks/#bring-your-own-launch-template)
- **Node Pool Enhancements**
  - Added ability to select which node to delete when scaling down a node pool [#22871](https://github.com/rancher/rancher/issues/22871)
  - Added an ability to select drain on delete to be used when scaling down node pools [#27458](https://github.com/rancher/rancher/issues/27458)
- **vSphere out of tree cloud provider** - Added ability to configure the vSphere external cloud provider through the Apps and Marketplace in the Cluster Explorer. By using the vSphere Cloud Provider Interface (CPI) and Cloud Storage Interface (CSI) charts, the vsphere out-of-tree provider can be configured. Note: Your cluster must have the cloud provider set as `external` in order for the cluster to allow out-of-tree provider configuration. For those already using the vSphere in-tree provider, migrations docs are available. [#20131](https://github.com/rancher/rancher/issues/20131) [#23357](https://github.com/rancher/rancher/issues/23357) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/cloud-providers/vsphere/out-of-tree/)
- **RKE**
  - Added ability to set `PriorityClassName` on RKE addons [#30047](https://github.com/rancher/rancher/issues/30047)
  - Added ability to configure timeout value for the etcd backup job [#30663](https://github.com/rancher/rancher/issues/30663)
- **Continuous Delivery**
  - Previously any new charts for Fleet would automatically be deployed into any existing Rancher install, as of v2.5.6, we've added the ability to put a minimum version for Fleet charts so they wouldn't automatically be deployed [#30934](https://github.com/rancher/rancher/issues/30934)
- **Windows**
  - Added ability to deploy onto Windows 2004 and 20H2 Servers [#27451](https://github.com/rancher/rancher/issues/27451) [#30701](https://github.com/rancher/rancher/issues/30701) [#30808](https://github.com/rancher/rancher/issues/30808)
  - Added ability to run Fleet on Windows clusters [#30516](https://github.com/rancher/rancher/issues/30516)
- **Linode Kubernetes Engine (LKE)** is now available as a cluster driver and new Kubernetes clusters can be spun up directly with LKE. The cluster driver is inactive by default and will need to be activated to appear as an option.

### Cluster Explorer Features

- **Logging**
  - Added support for being able to configure resource settings [#31099](https://github.com/rancher/rancher/issues/31099)

### Cluster Manager Tools

- Added minimum CPU and memory to monitoring and Istio charts to prevent the charts from being installed on clusters without enough resources [#30684](https://github.com/rancher/rancher/issues/30684) [#30144](https://github.com/rancher/rancher/issues/30144)

- **Logging**
  - Added 3.9.0 [#30917](https://github.com/rancher/rancher/issues/30917)
  - Added ability to mount certs on fluentd [#29784](https://github.com/rancher/rancher/issues/29784)
- **Istio**
  - Added v1.8.3 [#29812](https://github.com/rancher/rancher/issues/29812) [#31187](https://github.com/rancher/rancher/issues/31187) [#30410](https://github.com/rancher/rancher/issues/30410)
- **OPA Gatekeeper**
  - Updated to GA [#31203](https://github.com/rancher/rancher/issues/31203)
  - Added v3.3.0 [#31204](https://github.com/rancher/rancher/issues/31204)

## Major Bug Fixes
- Fixed an issue where the Rancher server chart couldn't be installed onto a Kubernetes cluster without an ingress [#30535](https://github.com/rancher/rancher/issues/30535)
- Fixed an issue where etcd would have increased traffic and memory usage after upgrading [#30168](https://github.com/rancher/rancher/issues/30168)
- Fixed an issue where public Helm chart repository were not working on clusters behind a proxy [#29961](https://github.com/rancher/rancher/issues/29961)
- Fixed an issue where telemetry client had a socket leak and cause upgrade issues or general k8s issues  [#28360](https://github.com/rancher/rancher/issues/28360) [#27870](https://github.com/rancher/rancher/issues/27870)
- Fixed an issue where vSphere vCenter server entries from the in-tree cloud provider configuration would not be removed [#30606](https://github.com/rancher/rancher/issues/30606)
- Fixed an issue where the cluster private registry was not working with the rancher-agent image for clusters provided by node drivers [#30605](https://github.com/rancher/rancher/issues/30605)
- Fixed an issue where EC2 node provisioning failed when using a SLES15 AMI [#30717](https://github.com/rancher/rancher/issues/30717)
- Fixed an issue where nodes wouldn't drain before deleting when scaling down if the node had pods with emptyDir volumes [#31455](https://github.com/rancher/rancher/issues/31455)
- Fixed an issue where RKE clusters would get stuck when there were `Cordoned` worker nodes and starting to remove master nodes [#30049](https://github.com/rancher/rancher/issues/30049)
- Fixed an issue where clusters couldn't be imported with the kubernets-python-client due to additional `---` at the end of the the import file[#31252](https://github.com/rancher/rancher/issues/31252)
- Fixed an issue where imported clusters would return 404s from the agent [#15172](https://github.com/rancher/rancher/issues/15172)
- Fixed an issue where windows nodes failed to create RKE log directory if `prefixPath` was not set [#30966](https://github.com/rancher/rancher/issues/30966)
- Fixed an issue where monitoring in Cluster Explorer wasn't working on Windows server-core versions [#27911](https://github.com/rancher/rancher/issues/27911)
- Fixed an issue when configuring OpenLDAP with StartTLS [#30930](https://github.com/rancher/rancher/issues/30930)
- Fixed an issue with Fleet where GitRepos and clusters would get stuck in a `Modified` state [#30696](https://github.com/rancher/rancher/issues/30696)
- Fixed an issue with Fleet where adding a Git repo with uppercase letters in the path would fail [#30792](https://github.com/rancher/rancher/issues/30792)
- Fixed an issue where the logging in the Cluster Manager UI was previously failing on new AKS clusters [#30425](https://github.com/rancher/rancher/issues/30425)
- Fixed an issue where the logging in Cluster Explorer was not working with non-standard Docker root directory [#30329](https://github.com/rancher/rancher/issues/30329)
- Fixed an issue where the display name was incorrect when nodes in a single cluster have FQDN hostnames under multiple different subdomains. [#27873](https://github.com/rancher/rancher/issues/27873)
- Fixed an issue where ClusterRoleBinding's apiVersion would log deprecation warning for any k8s 1.19 clusters [#30043](https://github.com/rancher/rancher/issues/)
- Fixed a list of UI issues [within Cluster Manager](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.6+label%3Ateam%2Fui+) and [within Cluster Explorer](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.6+is%3Aclosed)

## UI Updates

The primary UI in Rancher since v2.0 is now referred to as Cluster Manager in the UI. The new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. There are some new features in the new UI with similar functionality as existing features in Cluster Manager, but differences in implementation may cause differences details may cause variation.

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

## Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |

### Known Major Issues
- Kubernetes v1.20 has an issue with the vSphere in-tree cloud provider. Rancher supports the out-of-tree vSphere cloud provider starting as of v2.5.6, which is when k8s 1.20 support was introduced. [#31172](https://github.com/rancher/rancher/issues/31172)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Logging in the cluster explorer may not capture all kubelet logs for cloud providers. [#30383](https://github.com/rancher/rancher/issues/30383)
- Istio 1.5.10 is not supported in air gapped environments.
- In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run the Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#69](https://github.com/rancher/backup-restore-operator/issues/69)
- **Monitoring**
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in RKE clusters that use a mix of RancherOS hosts and non-RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815).
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)

## Versions within Rancher

### Images
- rancher/rancher:v2.5.7
- rancher/rancher-agent:v2.5.7

### Tools
- cli - [2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [1.2.6](https://github.com/rancher/rke/releases/tag/v1.2.6)

### Kubernetes
- 1.20.4 (default)
- 1.19.8
- 1.18.16
- 1.17.17

## Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----
# Release v2.5.6

**Please install [v2.5.7](https://github.com/rancher/rancher/releases/tag/v2.5.7) instead of v2.5.6**
v2.5.7 contains one fix that is an issue in this release:

When using a private registry without authentication, provisioning or updating RKE clusters created with nodes from an infrastructure provider will fail. [#31600](https://github.com/rancher/rancher/issues/31600)

## Important

This release addresses a security vulnerability found in Rancher:

- CVE-2021-25313 - XSS attack on the Rancher API - When accessing the Rancher API with a browser, the URL was not properly escaped, making it vulnerable to an XSS attack. Specially crafted URLs to these API endpoints could include JavaScript which would be embedded in the page and execute in a browser. There is no direct mitigation. Avoid clicking on untrusted links to your Rancher server. [#31583](https://github.com/rancher/rancher/issues/31583)

### Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584) [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325) [Docs](https://rancher.com/docs/rancher/v2.5/en/admin-settings/rbac/global-permissions/#restricted-admin)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Kubernetes 1.19 + firewalld

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)

## Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://rancher.com/docs/rancher/v2.5/en/installation/resources/choosing-version/) for more details on versioning and tagging conventions.

## Enhancements
- Added support for Kubernetes v1.20
- Added ability to set environment variables to the agent in order to support downstream clusters behind a proxy [#31370](https://github.com/rancher/rancher/issues/31370) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/options/#agent-environment-variables)
- Added the ingress.enabled rancher Helm flag. When set to false, Helm will not install a Rancher ingress. Set the option to false to deploy your own ingress. [Docs](https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/chart-options/#advanced-options)
- **EKS**
  - Added ability to use launch templates for EKS managed node groups [#30019](https://github.com/rancher/rancher/issues/30019) [#30020](https://github.com/rancher/rancher/issues/30020) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/hosted-kubernetes-clusters/eks/#bring-your-own-launch-template)
- **Node Pool Enhancements**
  - Added ability to select which node to delete when scaling down a node pool [#22871](https://github.com/rancher/rancher/issues/22871)
  - Added an ability to select drain on delete to be used when scaling down node pools [#27458](https://github.com/rancher/rancher/issues/27458)
- **vSphere out of tree cloud provider** - Added ability to configure the vSphere external cloud provider through the Apps and Marketplace in the Cluster Explorer. By using the vSphere Cloud Provider Interface (CPI) and Cloud Storage Interface (CSI) charts, the vsphere out-of-tree provider can be configured. Note: Your cluster must have the cloud provider set as `external` in order for the cluster to allow out-of-tree provider configuration. For those already using the vSphere in-tree provider, migrations docs are available. [#20131](https://github.com/rancher/rancher/issues/20131) [#23357](https://github.com/rancher/rancher/issues/23357) [Docs](https://rancher.com/docs/rancher/v2.5/en/cluster-provisioning/rke-clusters/cloud-providers/vsphere/out-of-tree/)
- **RKE**
  - Added ability to set `PriorityClassName` on RKE addons [#30047](https://github.com/rancher/rancher/issues/30047)
  - Added ability to configure timeout value for the etcd backup job [#30663](https://github.com/rancher/rancher/issues/30663)
- **Continuous Delivery**
  - Previously any new charts for Fleet would automatically be deployed into any existing Rancher install, as of v2.5.6, we've added the ability to put a minimum version for Fleet charts so they wouldn't automatically be deployed [#30934](https://github.com/rancher/rancher/issues/30934)
- **Windows**
  - Added ability to deploy onto Windows 2004 and 20H2 Servers [#27451](https://github.com/rancher/rancher/issues/27451) [#30701](https://github.com/rancher/rancher/issues/30701) [#30808](https://github.com/rancher/rancher/issues/30808)
  - Added ability to run Fleet on Windows clusters [#30516](https://github.com/rancher/rancher/issues/30516)
- **Linode Kubernetes Engine (LKE)** is now available as a cluster driver and new Kubernetes clusters can be spun up directly with LKE. The cluster driver is inactive by default and will need to be activated to appear as an option.

### Cluster Explorer Features

- **Logging**
  - Added support for being able to configure resource settings [#31099](https://github.com/rancher/rancher/issues/31099)

### Cluster Manager Tools

- Added minimum CPU and memory to monitoring and Istio charts to prevent the charts from being installed on clusters without enough resources [#30684](https://github.com/rancher/rancher/issues/30684) [#30144](https://github.com/rancher/rancher/issues/30144)

- **Logging**
  - Added 3.9.0 [#30917](https://github.com/rancher/rancher/issues/30917)
  - Added ability to mount certs on fluentd [#29784](https://github.com/rancher/rancher/issues/29784)
- **Istio**
  - Added v1.8.3 [#29812](https://github.com/rancher/rancher/issues/29812) [#31187](https://github.com/rancher/rancher/issues/31187) [#30410](https://github.com/rancher/rancher/issues/30410)
- **OPA Gatekeeper**
  - Updated to GA [#31203](https://github.com/rancher/rancher/issues/31203)
  - Added v3.3.0 [#31204](https://github.com/rancher/rancher/issues/31204)

## Major Bug Fixes
- Fixed an issue where the Rancher server chart couldn't be installed onto a Kubernetes cluster without an ingress [#30535](https://github.com/rancher/rancher/issues/30535)
- Fixed an issue where etcd would have increased traffic and memory usage after upgrading [#30168](https://github.com/rancher/rancher/issues/30168)
- Fixed an issue where public Helm chart repository were not working on clusters behind a proxy [#29961](https://github.com/rancher/rancher/issues/29961)
- Fixed an issue where telemetry client had a socket leak and cause upgrade issues or general k8s issues  [#28360](https://github.com/rancher/rancher/issues/28360) [#27870](https://github.com/rancher/rancher/issues/27870)
- Fixed an issue where vSphere vCenter server entries from the in-tree cloud provider configuration would not be removed [#30606](https://github.com/rancher/rancher/issues/30606)
- Fixed an issue where the cluster private registry was not working with the rancher-agent image for clusters provided by node drivers [#30605](https://github.com/rancher/rancher/issues/30605)
- Fixed an issue where EC2 node provisioning failed when using a SLES15 AMI [#30717](https://github.com/rancher/rancher/issues/30717)
- Fixed an issue where nodes wouldn't drain before deleting when scaling down if the node had pods with emptyDir volumes [#31455](https://github.com/rancher/rancher/issues/31455)
- Fixed an issue where RKE clusters would get stuck when there were `Cordoned` worker nodes and starting to remove master nodes [#30049](https://github.com/rancher/rancher/issues/30049)
- Fixed an issue where clusters couldn't be imported with the kubernets-python-client due to additional `---` at the end of the the import file[#31252](https://github.com/rancher/rancher/issues/31252)
- Fixed an issue where imported clusters would return 404s from the agent [#15172](https://github.com/rancher/rancher/issues/15172)
- Fixed an issue where windows nodes failed to create RKE log directory if `prefixPath` was not set [#30966](https://github.com/rancher/rancher/issues/30966)
- Fixed an issue where monitoring in Cluster Explorer wasn't working on Windows server-core versions [#27911](https://github.com/rancher/rancher/issues/27911)
- Fixed an issue when configuring OpenLDAP with StartTLS [#30930](https://github.com/rancher/rancher/issues/30930)
- Fixed an issue with Fleet where GitRepos and clusters would get stuck in a `Modified` state [#30696](https://github.com/rancher/rancher/issues/30696)
- Fixed an issue with Fleet where adding a Git repo with uppercase letters in the path would fail [#30792](https://github.com/rancher/rancher/issues/30792)
- Fixed an issue where the logging in the Cluster Manager UI was previously failing on new AKS clusters [#30425](https://github.com/rancher/rancher/issues/30425)
- Fixed an issue where the logging in Cluster Explorer was not working with non-standard Docker root directory [#30329](https://github.com/rancher/rancher/issues/30329)
- Fixed an issue where the display name was incorrect when nodes in a single cluster have FQDN hostnames under multiple different subdomains. [#27873](https://github.com/rancher/rancher/issues/27873)
- Fixed an issue where ClusterRoleBinding's apiVersion would log deprecation warning for any k8s 1.19 clusters [#30043](https://github.com/rancher/rancher/issues/)
- Fixed a list of UI issues [within Cluster Manager](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.6+label%3Ateam%2Fui+) and [within Cluster Explorer](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.6+is%3Aclosed)

## UI Updates

The primary UI in Rancher since v2.0 is now referred to as Cluster Manager in the UI. The new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. There are some new features in the new UI with similar functionality as existing features in Cluster Manager, but differences in implementation may cause differences details may cause variation.

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from.
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard.

## Other Notes

### Deprecated Features

 |Feature | Justification |
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Newer Istio versions are now available as a chart in the Apps & Marketplace in Cluster Explorer. |

### Known Major Issues
- Kubernetes v1.20 has an issue with the vSphere in-tree cloud provider. Rancher supports the out-of-tree vSphere cloud provider starting as of v2.5.6, which is when k8s 1.20 support was introduced. [#31172](https://github.com/rancher/rancher/issues/31172)
- Rotating encryption keys with a custom encryption provider is not supported. [#30539](https://github.com/rancher/rancher/issues/30539)
- Logging in the cluster explorer may not capture all kubelet logs for cloud providers. [#30383](https://github.com/rancher/rancher/issues/30383)
- Istio 1.5.10 is not supported in air gapped environments.
- In air-gapped setups, the generated `rancher-images.txt` that is used to mirror images on private registries does not contain the images required to run the Monitoring in Cluster Manager v0.1.x. Clusters running k8s 1.15 and below will need to upgrade their k8s versions and leverage Monitoring in Cluster Manager v0.2.x or upgrade to Monitoring in Cluster Explorer.

### Cluster Explorer Feature Caveats and Upgrades

- **General**
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- **Rancher Backup**
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#69](https://github.com/rancher/backup-restore-operator/issues/69)
- **Monitoring**
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in RKE clusters that use a mix of RancherOS hosts and non-RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815).
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)

## Versions within Rancher

### Images
- rancher/rancher:v2.5.6
- rancher/rancher-agent:v2.5.6

### Tools
- cli - [2.4.11](https://github.com/rancher/cli/releases/tag/v2.4.11)
- RKE - [1.2.6](https://github.com/rancher/rke/releases/tag/v1.2.6)

### Kubernetes
- 1.20.4 (default)
- 1.19.8
- 1.18.16
- 1.17.17

## Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.
-----
**Rancher v2.5.5 is a mirror release of v2.5.4 to address a few minor issues:**
- The dashboard could crash if helm charts were missing certain annotations. [link](https://github.com/rancher/dashboard/issues/2182)
- The rancher helm chart was restricted to Kubernetes version less than 1.20.0. This restriction was added to prevent Rancher from being installed on incompatible versions of Kubernetes. The v2.5.5 chart was originally released without this restriction. Users who install the chart before 01/12/2020 may experience issues on unsupported Kubernetes versions. [link](https://github.com/rancher/rancher/pull/30757)
- Rancher’s Cluster Explorer now only displays Windows compatible charts on Windows clusters.
- Added support for RKE2 clusters to be upgraded to Kubernetes version v1.18.13. [link](https://github.com/rancher/kontainer-driver-metadata/pull/462)

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

# Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.5 | `rancher/rancher:latest` | server-charts/latest |v2.5.5 |
  | Stable | v2.5.5 | `rancher/rancher:stable` | server-charts/stable | v2.5.5 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

# Major Bug Fixes
- Switched to xml-roundtrip-validator package to address xml vulnerabilities in go's xml package - [link](https://mattermost.com/blog/coordinated-disclosure-go-xml-vulnerabilities/)
- Fixed intermittent installation fails with cluster manager monitoring. #30188 
- Fixed cluster explorer monitoring installation errors on hardened clusters. #29980 
- Fixed error when execing into pods via kubectl shell. #29668
- Rancher now supports startTLS when using OpenLDAP. #29153 
- Fixed error message in cluster manager monitoring when secret webhook-receiver is not found. #28954 
- Rancher pods are no long scheduled on dead nodes. #27734 
- Noes running Amazon Linux no longer fail to provision. #21648 
- Fixed cluster manager logging support for clusters with Windows Server SAC 1909 nodes and for clusters with Windows Server LTSC 2019 nodes #30279 
- Fixed cluster manager monitoring's prometheus operator container startup error with nfs subpaths #29149

## Other Notes

### Known Major Issues
- Istio deployments can fail if sidecar injection is enabled in a cluster with a PSP where `FS Group` is set to `MustRunAs` with a range of `1..1024`  #29700
- Cluster explorer logging may not capture all kubelet logs for cloud providers. #30383 
- Rotating encryption keys with a custom encryption can fail. #30539 

### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)

# Enhancements
- CIS v2 enhancements – Schedule/Alert, Custom Benchmark #30123
- CIS 1.6 for RKE1 #29649 
- CIS 1.5 for RKE2 #29649 
- Istio enhancements - CNI, Jaeger ​support #29903 #27377 
- Cluster Explorer logging enhancements - Syslog support and GKE/AKS node logs #29892 #28574 #28573
- Tolerations can now be configured per add-on and apply to Deployment resources. The configured tolerations will replace the existing tolerations so make sure you configure all the tolerations you need. This resolves an issue where add-on pods with wildcard tolerations (toleration that tolerates all taints) were not evicted and if manually deleted, could be scheduled to a NotReady node. To avoid unschedulable pods on upgrade, the default configuration will be the same (so with wildcard tolerations) so you will need to configure tolerations to override the default configuration. See the [documentation](https://rancher.com/docs/rke/latest/en/config-options/add-ons/#tolerations) for more information. #27734
- RKE encryption keys can now be rotated from the rancher API #27735 
- The default nginx http backend can optionally be disabled.  It is installed by default. #25590
- Dashboard supports configuring additional alerting receivers - [link](https://github.com/rancher/dashboard/issues/1216)
- Dashboard now supports additional logging outputs - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+additional+outputs+-label%3Akind%2Fbug+)
- UI polishing in Cluster Explorer - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+-label%3Akind%2Fbug+-label%3Abug)

# Versions
## Images
- rancher/rancher:v2.5.5
- rancher/rancher-agent:v2.5.5

## Tools
- cli - [2.4.10](https://github.com/rancher/cli/releases/tag/v2.4.10)
- RKE - [1.2.4](https://github.com/rancher/rke/releases/tag/v1.2.4) 

## Kubernetes
- 1.19.6 (default)
- 1.18.14
- 1.17.16

# Bug Fixes
- Fixed increased CPU and memory usage #30652
- Suppressed excessive "rejected by webhook" messages #30452 
- the reset-admin url is no longer a private ip #29162
- Fixed panic when provisioning RKE clusters #30143
- Resolved error when installing RKE on node running flatcar os #29841 #30326 
- Fixed error when creating hosted EKS V2 cluster with the same name as an existing EKS cluster #29549
- Prevented existing clusters in eks from being updated when a cluster with the same name is created with rancher #29103
- Suppressed constant deprecation log #28943 #29144
- Fixed rule deployer errors when enabling alerts #29318
- Fixed error when installing OPA gatekeeper v2 after v1 #29188
- Fixed nil pointer error when provisioning rke clusters #30373
- Stopped using deprecated networking resources #22487 
- Fixed RKE missing ingress on install #30405 
- Fixed issue when upgrading from rancher 2.5.2 #30434 
- Fixed panic when deleting a node that is currently being provisioned #30430 
- reset-password no longer causes a panic #29565 
- EKSv2 now works with private-only endpoint​s #29907" can be changed to "Removed the necessity of extra network configuration for private-only endpoint​s in EKSv2 #29907
- added missing images to images.txt #30496 
- Numerous dashboard bug fixes - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+label%3Akind%2Fbug+)
- Numerous UI fixes - [link](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.4)

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----
**Please install [v2.5.5](https://github.com/rancher/rancher/releases/tag/v2.5.5) instead of v2.5.4**
v2.5.5 contains some minor bug fixes to address issues in this release.


## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

# Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.4 | `rancher/rancher:latest` | server-charts/latest |v2.5.4 |
  | Stable | v2.5.4 | `rancher/rancher:stable` | server-charts/stable | v2.5.4 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

# Major Bug Fixes
- Switched to xml-roundtrip-validator package to address xml vulnerabilities in go's xml package - [link](https://mattermost.com/blog/coordinated-disclosure-go-xml-vulnerabilities/)
- Fixed intermittent installation fails with cluster manager monitoring. #30188 
- Fixed cluster explorer monitoring installation errors on hardened clusters. #29980 
- Fixed error when execing into pods via kubectl shell. #29668
- Rancher now supports startTLS when using OpenLDAP. #29153 
- Fixed error message in cluster manager monitoring when secret webhook-receiver is not found. #28954 
- Rancher pods are no long scheduled on dead nodes. #27734 
- Noes running Amazon Linux no longer fail to provision. #21648 
- Fixed cluster manager logging support for clusters with Windows Server SAC 1909 nodes and for clusters with Windows Server LTSC 2019 nodes #30279 
- Fixed cluster manager monitoring's prometheus operator container startup error with nfs subpaths #29149

## Other Notes

### Known Major Issues
- Istio deployments can fail if sidecar injection is enabled in a cluster with a PSP where `FS Group` is set to `MustRunAs` with a range of `1..1024`  #29700
- Cluster explorer logging may not capture all kubelet logs for cloud providers. #30383 
- Rotating encryption keys with a custom encryption can fail. #30539 

### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- OPA Gatekeeper

# Enhancements
- CIS v2 enhancements – Schedule/Alert, Custom Benchmark #30123
- CIS 1.6 for RKE1 #29649 
- CIS 1.5 for RKE2 #29649 
- Istio enhancements - CNI, Jaeger ​support #29903 #27377 
- Cluster Explorer logging enhancements - Syslog support and GKE/AKS node logs #29892 #28574 #28573
- Tolerations can now be configured per add-on and apply to Deployment resources. The configured tolerations will replace the existing tolerations so make sure you configure all the tolerations you need. This resolves an issue where add-on pods with wildcard tolerations (toleration that tolerates all taints) were not evicted and if manually deleted, could be scheduled to a NotReady node. To avoid unschedulable pods on upgrade, the default configuration will be the same (so with wildcard tolerations) so you will need to configure tolerations to override the default configuration. See the [documentation](https://rancher.com/docs/rke/latest/en/config-options/add-ons/#tolerations) for more information. #27734
- RKE encryption keys can now be rotated from the rancher API #27735 
- The default nginx http backend can optionally be disabled.  It is installed by default. #25590
- Dashboard supports configuring additional alerting receivers - [link](https://github.com/rancher/dashboard/issues/1216)
- Dashboard now supports additional logging outputs - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+additional+outputs+-label%3Akind%2Fbug+)
- UI polishing in Cluster Explorer - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+-label%3Akind%2Fbug+-label%3Abug)

# Versions
## Images
- rancher/rancher:v2.5.4
- rancher/rancher-agent:v2.5.4

## Tools
- cli - [2.4.10](https://github.com/rancher/cli/releases/tag/v2.4.10)
- RKE - [1.2.4](https://github.com/rancher/rke/releases/tag/v1.2.4) 

## Kubernetes
- 1.19.6 (default)
- 1.18.14
- 1.17.16

# Bug Fixes
- Fixed increased CPU and memory usage #30652
- Suppressed excessive "rejected by webhook" messages #30452 
- the reset-admin url is no longer a private ip #29162
- Fixed panic when provisioning RKE clusters #30143
- Resolved error when installing RKE on node running flatcar os #29841 #30326 
- Fixed error when creating hosted EKS V2 cluster with the same name as an existing EKS cluster #29549
- Prevented existing clusters in eks from being updated when a cluster with the same name is created with rancher #29103
- Suppressed constant deprecation log #28943 #29144
- Fixed rule deployer errors when enabling alerts #29318
- Fixed error when installing OPA gatekeeper v2 after v1 #29188
- Fixed nil pointer error when provisioning rke clusters #30373
- Stopped using deprecated networking resources #22487 
- Fixed RKE missing ingress on install #30405 
- Fixed issue when upgrading from rancher 2.5.2 #30434 
- Fixed panic when deleting a node that is currently being provisioned #30430 
- reset-password no longer causes a panic #29565 
- EKSv2 now works with private-only endpoint​s #29907" can be changed to "Removed the necessity of extra network configuration for private-only endpoint​s in EKSv2 #29907
- added missing images to images.txt #30496 
- Numerous dashboard bug fixes - [link](https://github.com/rancher/dashboard/issues?q=is%3Aissue+milestone%3Av2.5.4+is%3Aclosed+label%3Akind%2Fbug+)
- Numerous UI fixes - [link](https://github.com/rancher/rancher/issues?q=is%3Aissue+is%3Aclosed+milestone%3Av2.5.4)

# Upgrades and Rollbacks
Rancher supports both upgrade and rollback. Please note the version you would like to upgrade or rollback to change the Rancher version.

Please be aware that upon an upgrade to v2.3.0+, any edits to a Rancher launched Kubernetes cluster will cause all system components to restart due to added tolerations to Kubernetes system components. Plan accordingly.

Recent changes to cert-manager require an upgrade if you have an HA install of Rancher using self-signed certificates. If you are using cert-manager older than v0.9.1, please see the documentation on how to upgrade cert-manager.

Important: When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected.

-----
# Release v2.5.3

>  **Only addresses a high cpu usage issue in v2.5.2 for upgraded clusters with Project Network Isolation Enabled [#30048], [#30052], [#30089]. Please note that Release notes remain the same as v2.5.2.**  
> Note: This requires redeploying `nginx-ingress-controller`. Please refer to [this comment](https://github.com/rancher/rancher/issues/30045#issuecomment-731653007) for more details. 

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.3 | `rancher/rancher:latest` | server-charts/latest |v2.5.3 |
  | Stable | v2.5.3 | `rancher/rancher:stable` | server-charts/stable | v2.5.3 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.5.1

- Local cluster will no longer run the cattle cluster-agent and node-agent. On upgrade to 2.5.2 these pods will get deleted. [#29397](https://github.com/rancher/rancher/issues/29397)
- If you are using Rancher to manage other Rancher instances, you can now upgrade Rancher without facing elevated CPU, load or network issues. [#29364](https://github.com/rancher/rancher/issues/29364).
- Cluster Explorer's Monitoring feature can now be installed on a K8s 1.16 cluster. [#29395](https://github.com/rancher/rancher/issues/29395)
- Cluster Explorer's Monitoring feature can now be installed in a hardened cluster using chart version 9.4.201 and up. [#28536](https://github.com/rancher/rancher/issues/28536)
- Istio can now be installed with the Ingress Gateway disabled. [#29383](https://github.com/rancher/rancher/issues/29383)
- Fixed a bug where Longhorn uninstallation was getting stalled. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- Rancher now supports deploying an EKS cluster in an air gap environment. [#29070](https://github.com/rancher/rancher/issues/29070)
- Fixed a bug where the Auto Replace feature of Node Pools wasn't working as expected in 2.5.1. [#29754](https://github.com/rancher/rancher/issues/29754)
- You can now run a forked build of the UI and set `ui-index` setting to `local` and force that to load. [#29362](https://github.com/rancher/rancher/issues/29362)
- Fixed a bug where Launch kubectl feature wasn't working as expected. [#29511](https://github.com/rancher/rancher/issues/29511)
- Fixed a bug where Windows worker nodes could not join a cluster with a cloud provider enabled. [#29782](https://github.com/rancher/rancher/issues/29782)
- Fixed a bug for the Rancher Terraform provider where node draining could not be disabled. [Terraform#440](https://github.com/rancher/terraform-provider-rancher2/issues/440)
- Fixed a bug where private Git repo in fleet didn't work when adding http/ssh credential in dashboard. [Fleet#134](https://github.com/rancher/fleet/issues/134)


## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)
- The setting to hide local cluster can only be set through API after Rancher is installed. It cannot be set during install because of an issue with Rancher API stripping quotes off of helm values. [#29325](https://github.com/rancher/rancher/issues/29325#issuecomment-719864450)
- When provisioning EKS clusters, Rancher currently relies on public endpoints to connect to the cluster. Disabling public access is not recommended if Rancher does not have network access, as it will affect Rancher's ability to communicate with the cluster.
 [#29907](https://github.com/rancher/rancher/issues/29907)
- When Project Network Isolation is turned on, upgrading from a previous Rancher version to 2.5.2 will cause an increase in CPU / Logging. Workaround is turn off PNI. [#30052](https://github.com/rancher/rancher/issues/30052). Fix is tracked in [#30045](https://github.com/rancher/rancher/issues/30045).


### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- OPA Gatekeeper (Experimental)
  - The first edition of OPA must be uninstalled before the new OPA features are installed. [#29188](https://github.com/rancher/rancher/issues/29188)

### Enhancements
- Admins can now choose to use the CentOS/RHEL 8 operating system with Docker CE for both, the local Rancher HA cluster and clusters provisioned by Rancher. Please note this is only available for Docker CE 19.03.13 and higher. To be able to use our [Docker install script](https://releases.rancher.com/install-docker/19.03.13.sh) to install Docker CE 19.03.13, if the OS image you are using contains the package `runc`, it needs to be removed manually before you can use the install script, because the `containerd` package will conflict with this package. The requirement of installing the package `iptables` is handled in the install script. [#23045](https://github.com/rancher/rancher/issues/23045)
- Stats will now aggregate resources of all nodes that do not have the following four taints instead of relying on the worker node-role label: [#29139](https://github.com/rancher/rancher/issues/29139)
  - "node-role.kubernetes.io/controlplane"
  - "node-role.kubernetes.io/control-plane"
  - "node-role.kubernetes.io/etcd"
  - "node-role.kubernetes.io/master"  
- Starting with version 9.4.201 of the Rancher Monitoring chart, k3s clusters will switch to using one PushProx exporter instead of three PushProx exporters so increased memory limits are no longer required for k3s clusters. [#29445](https://github.com/rancher/rancher/issues/29445)
- Keycloak SAML provider now accepts a custom Entity ID field. [#29212](https://github.com/rancher/rancher/issues/29212)
- Logs now include data about the source. [#29410](https://github.com/rancher/rancher/issues/29410)
- UI images path can now be specified in the Rancher Helm chart. [#29419](https://github.com/rancher/rancher/issues/29419) 
- Istio installer automatically adds Istio dashboards to Grafana when using Cluster Explorer's Monitoring feature. [#28468](https://github.com/rancher/rancher/issues/28468)


## Versions

### Images
- rancher/rancher:v2.5.3
- rancher/rancher-agent:v2.5.3

### Tools
- cli - [v2.4.9](https://github.com/rancher/cli/releases/tag/v2.4.9)
- rke - [v1.2.2](https://github.com/rancher/rke/releases/tag/v1.2.2)

### Kubernetes

-  [1.19.3](https://github.com/rancher/hyperkube/releases/tag/v1.19.3-rancher1) (default)
-  [1.18.10](https://github.com/rancher/hyperkube/releases/tag/v1.18.10-rancher1)
-  [1.17.13](https://github.com/rancher/hyperkube/releases/tag/v1.17.13-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher2) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.2

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar in functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. The access to local cluster can now be disabled by setting `hide_local_cluster` to true from the v3/settings API. [#29325](https://github.com/rancher/rancher/issues/29325)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.2 | `rancher/rancher:latest` | server-charts/latest |v2.5.2 |
  | Stable | v2.5.2 | `rancher/rancher:stable` | server-charts/stable | v2.5.2 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.5.1

- Local cluster will no longer run the cattle cluster-agent and node-agent. On upgrade to 2.5.2 these pods will get deleted. [#29397](https://github.com/rancher/rancher/issues/29397)
- If you are using Rancher to manage other Rancher instances, you can now upgrade Rancher without facing elevated CPU, load or network issues. [#29364](https://github.com/rancher/rancher/issues/29364).
- Cluster Explorer's Monitoring feature can now be installed on a K8s 1.16 cluster. [#29395](https://github.com/rancher/rancher/issues/29395)
- Cluster Explorer's Monitoring feature can now be installed in a hardened cluster using chart version 9.4.201 and up. [#28536](https://github.com/rancher/rancher/issues/28536)
- Istio can now be installed with the Ingress Gateway disabled. [#29383](https://github.com/rancher/rancher/issues/29383)
- Fixed a bug where Longhorn uninstallation was getting stalled. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- Rancher now supports deploying an EKS cluster in an air gap environment. [#29070](https://github.com/rancher/rancher/issues/29070)
- Fixed a bug where the Auto Replace feature of Node Pools wasn't working as expected in 2.5.1. [#29754](https://github.com/rancher/rancher/issues/29754)
- You can now run a forked build of the UI and set `ui-index` setting to `local` and force that to load. [#29362](https://github.com/rancher/rancher/issues/29362)
- Fixed a bug where Launch kubectl feature wasn't working as expected. [#29511](https://github.com/rancher/rancher/issues/29511)
- Fixed a bug where Windows worker nodes could not join a cluster with a cloud provider enabled. [#29782](https://github.com/rancher/rancher/issues/29782)
- Fixed a bug for the Rancher Terraform provider where node draining could not be disabled. [Terraform#440](https://github.com/rancher/terraform-provider-rancher2/issues/440)
- Fixed a bug where private Git repo in fleet didn't work when adding http/ssh credential in dashboard. [Fleet#134](https://github.com/rancher/fleet/issues/134)


## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)
- The setting to hide local cluster can only be set through API after Rancher is installed. It cannot be set during install because of an issue with Rancher API stripping quotes off of helm values. [#29325](https://github.com/rancher/rancher/issues/29325#issuecomment-719864450)
- When provisioning EKS clusters, Rancher currently relies on public endpoints to connect to the cluster. Disabling public access is not recommended if Rancher does not have network access, as it will affect Rancher's ability to communicate with the cluster.
 [#29907](https://github.com/rancher/rancher/issues/29907)
- When Project Network Isolation is turned on, upgrading from a previous Rancher version to 2.5.2 will cause an increase in CPU / Logging. Workaround is turn off PNI. [#30052](https://github.com/rancher/rancher/issues/30052). Fix is tracked in [#30045](https://github.com/rancher/rancher/issues/30045).


### Cluster Explorer Feature Caveats and Upgrades

- General
  - Not all new features are currently installable on a hardened cluster.
  - New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
  - The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
  - An error can be seen during cluster provisioning intermittently, and it recovers within a couple of minutes without any user intervention. [#28836](https://github.com/rancher/rancher/issues/28836)
- Rancher Backup
  - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
  - Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
  - There is a known issue with using Rancher Monitoring to monitor etcd nodes in clusters that use RancherOS hosts for etcd [#29815](https://github.com/rancher/rancher/issues/29815). If your etcd plane only consists of RancherOS hosts, a workaround for this issue can be found [here](https://github.com/rancher/rancher/issues/29815#issuecomment-718890687). However there is no existing workaround for clusters that use a mix of RancherOS and non-RancherOS hosts in their etcd plane.
  - To continue to support users who are using version 9.4.200 of the Rancher Monitoring chart, the default memory limits for k3s clusters set by the Dashboard UI have been increased to 2500Mi. This increased limit is not required for users who upgrade to chart version 9.4.201 but is recommended. [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
  - Monitoring sometimes errors on installation because it can't identify CRDs. [#29171](https://github.com/rancher/rancher/issues/29171)
- OPA Gatekeeper (Experimental)
  - The first edition of OPA must be uninstalled before the new OPA features are installed. [#29188](https://github.com/rancher/rancher/issues/29188)

### Enhancements
- Admins can now choose to use the CentOS/RHEL 8 operating system with Docker CE for both, the local Rancher HA cluster and clusters provisioned by Rancher. Please note this is only available for Docker CE 19.03.13 and higher. To be able to use our [Docker install script](https://releases.rancher.com/install-docker/19.03.13.sh) to install Docker CE 19.03.13, if the OS image you are using contains the package `runc`, it needs to be removed manually before you can use the install script, because the `containerd` package will conflict with this package. The requirement of installing the package `iptables` is handled in the install script. [#23045](https://github.com/rancher/rancher/issues/23045)
- Stats will now aggregate resources of all nodes that do not have the following four taints instead of relying on the worker node-role label: [#29139](https://github.com/rancher/rancher/issues/29139)
  - "node-role.kubernetes.io/controlplane"
  - "node-role.kubernetes.io/control-plane"
  - "node-role.kubernetes.io/etcd"
  - "node-role.kubernetes.io/master"  
- Starting with version 9.4.201 of the Rancher Monitoring chart, k3s clusters will switch to using one PushProx exporter instead of three PushProx exporters so increased memory limits are no longer required for k3s clusters. [#29445](https://github.com/rancher/rancher/issues/29445)
- Keycloak SAML provider now accepts a custom Entity ID field. [#29212](https://github.com/rancher/rancher/issues/29212)
- Logs now include data about the source. [#29410](https://github.com/rancher/rancher/issues/29410)
- UI images path can now be specified in the Rancher Helm chart. [#29419](https://github.com/rancher/rancher/issues/29419) 
- Istio installer automatically adds Istio dashboards to Grafana when using Cluster Explorer's Monitoring feature. [#28468](https://github.com/rancher/rancher/issues/28468)


## Versions

### Images
- rancher/rancher:v2.5.2
- rancher/rancher-agent:v2.5.2

### Tools
- cli - [v2.4.9](https://github.com/rancher/cli/releases/tag/v2.4.9)
- rke - [v1.2.2](https://github.com/rancher/rke/releases/tag/v1.2.2)

### Kubernetes

-  [1.19.3](https://github.com/rancher/hyperkube/releases/tag/v1.19.3-rancher1) (default)
-  [1.18.10](https://github.com/rancher/hyperkube/releases/tag/v1.18.10-rancher1)
-  [1.17.13](https://github.com/rancher/hyperkube/releases/tag/v1.17.13-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher2) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.1

Due to a random corruption of the rancher-agent image on Dockerhub, Rancher 2.5.1 is a mirror release of 2.5.0 but with rebuilt images. There are no bug fixes or enhancements introduced in this version. [#29424](https://github.com/rancher/rancher/issues/29424)

## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes


- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. 
- If you are using Rancher to manage other Rancher instances, do not upgrade at this time as there are known issues around conflicting controllers. [#29364](https://github.com/rancher/rancher/issues/29364).
- If you are running a forked build of the UI and set the `ui-index` setting to `local`, you currently are unable to force that to load . [#29362](https://github.com/rancher/rancher/issues/29362)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- If you're using custom certs with the Docker install, clusters cannot be provisioned. [#28605](https://github.com/rancher/rancher/issues/28605)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.1 | `rancher/rancher:latest` | server-charts/latest |v2.5.1 |
  | Stable | v2.4.8 | `rancher/rancher:stable` | server-charts/stable | v2.4.8 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Features and Enhancements
 - **Cluster Explorer**:  A UI to provide a deeper look into clusters under management. With this new UI, you can:
   * Manage all Kubernetes cluster resources including custom resources from the Kubernetes operator ecosystem.
   * Deploy Helm charts from our new Apps and Marketplace.
   * View and edit Helm3 CLI releases from the new Apps UI.
   * Visibility to resources based on RBAC permissions
   * View logs and interact with kubectl shell in a new IDE-like viewer.
   * New Observability and Operations Tooling :
     - **Rancher Server Backups**: Previously admins relied on etcd backups of the Rancher management cluster for disaster recovery and rollback scenarios. The new backup and recovery process no longer requires access to the etcd database. Now admins can perform ad-hoc or scheduled backups of the Rancher application directly from the Rancher dashboard. Restore data into any Kubernetes cluster.

      - **Monitoring and Alerting powered by Prometheus**: Users can now define how to monitor, alert, and visualize application health as part of the deployment configuration. The new monitoring system can be configured with GitOps based workflows using the Prometheus Operator custom resources. Alertmanager can be configured to use all built-in notification integrations. Alert templates can be customized to tailor notifications the on-call team receives. Users can deploy their own Grafana dashboards into the built-in Grafana instance. 

     - **Logging powered by Banzai Cloud**: New cluster-level logging pipelines that incorporate lighter weight FluentBit and Fluentd to ship logs to a remote data store. The pipeline functionality is orchestrated Kubernetes objects enabling configuration through GitOps based workflows. Users will have the ability to customize both the FluentBit and Fluentd configurations. 

     - **Expanded CIS Scans powered by kube-bench**: Rancher CIS scanning now runs on EKS and GKE platforms in addition to RKE clusters. The scanning tool also includes a new standard CIS-1.5 profile untailored for a specific K8s distribution. The benchmark versions have been updated to CIS 1.5, EKS-1.0, and GKE-1.0. 
 
- **Rancher Continuous Delivery powered by Fleet**:  Rancher Continuous Delivery is a built-in deployment tool powered by Rancher's Fleet project. Users can leverage this tool to deliver applications and configurations from a Git source repository across multiple clusters. Rancher Continuous Delivery is able to scale to a large number of clusters under management using a staged checkout and pull-based update model.  The staged checkout allows the Continuous Delivery control plane to gradually roll deployments out to clusters instead of all at once. Using a pull-based update model, administrators don't need to configure network access to every remote cluster. Administrators can organize clusters into groups for easier management within Rancher Continuous Delivery. Git source repositories are mapped to cluster group targets by admins, without needing the end-user to access the control plane configuration. Application owners and admins can deploy any Kubernetes resource defined by manifests, kustomize, or Helm.

 - **Enhanced EKS Lifecycle Management**: EKS provisioning has been enhanced to support managed node groups, private access, and control plane logging. Users can now register existing EKS clusters provisioned with other tools like eksctl into Rancher to allow the management of upgrades and configuration going forward. Support has been added for multiple managed node groups with heterogeneous configurations to enable GPU and non-GPU workloads in the same cluster. The EKS cluster configuration in Rancher now uses cloud credentials decoupling the AWS key management from the cluster configuration. 

 - **Istio 1.7**: The Istio project has made a lot of changes to the installation process over the last several releases. The new Rancher Istio integration now deploys the latest Istio Operator allowing for users to deploy multiple ingress and egress gateways. Users can also manage the Istio custom resources in a customized UX in the new dashboard. 

 - **RKE Government**: A new Kubernetes distribution that supports FIPS encryption, SELinux, and container-d. The RKE-Gov distribution has out-of-the-box CIS compliance. Management of etcd backups and restores are built into the distribution.   

- **CentOS/RHEL 8 Support**: Admins can use RKE Government clusters installed on RHEL and CentOS 8 systems. RKE support will come in a later update and use Docker CE. 

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.4.8

- Rancher no longer panic's during a drain action from the API [#28905](https://github.com/rancher/rancher/issues/28905)
- Argo rollout pods can now be seen in the cluster explorer [#27923](https://github.com/rancher/rancher/issues/27923)
- Helm's max history can now be configured [#28728](https://github.com/rancher/rancher/issues/28728)
- The Cluster Manager UI dropdown now works on mobile [#23298](https://github.com/rancher/rancher/issues/23298)
- The new EKS provisioning supports API Server Endpoint Access Control [#19051](https://github.com/rancher/rancher/issues/19051)
- Cluster Explorer supports CRUD action on CRDs [#18013](https://github.com/rancher/rancher/issues/18013)

## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)

### Cluster Explorer Feature Caveats and Upgrades

- General
	- Not all new features are currently installable on a hardened cluster.
	- New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
	- The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- Rancher Backup
	- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
	- Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
	- The Monitoring stack currently is not installable on a K8s 1.16 cluster [#29395](https://github.com/rancher/rancher/issues/29395)
	- When the new Monitoring feature is deployed on K3s, it needs to have specific memory/cpu limits set [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
	- Monitoring sometimes errors on installation because it can't identify CRDs [#29171](https://github.com/rancher/rancher/issues/29171)
        - The new monitoring chart deploys a standard Prometheus installation which does not support project-level isolation.
- Istio
	- Installation for Istio fails when the ingress gateway is disabled [#29383](https://github.com/rancher/rancher/issues/29383)
- Longhorn
	- Longhorn has seen an issue where uninstallation may get stalled if there are daemonset changes occurring. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- OPA Gatekeeper (Experimental)
	- The first edition of OPA must be uninstalled before the new OPA features are installed [#29188](https://github.com/rancher/rancher/issues/29188)

### Air gap

- Deploying an EKS cluster in an air gap environment is not supported [#29070](https://github.com/rancher/rancher/issues/29070)
- Air gap has rarely seen an issue where the downstream cluster does not correctly get the registry setting, causing pods to fail. To workaround the issue, simply restart the agent [#28923](https://github.com/rancher/rancher/issues/28923)

## Versions

### Images
- rancher/rancher:v2.5.1
- rancher/rancher-agent:v2.5.1

### Tools
- cli - [v2.4.6](https://github.com/rancher/cli/releases/tag/v2.4.6)
- rke - [v1.2.0](https://github.com/rancher/rke/releases/tag/v1.2.0)

### Kubernetes

-  [1.19.2](https://github.com/rancher/hyperkube/releases/tag/v1.19.2-rancher1) (default)
-  [1.18.9](https://github.com/rancher/hyperkube/releases/tag/v1.18.9-rancher1)
-  [1.17.12](https://github.com/rancher/hyperkube/releases/tag/v1.17.12-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher1) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
# Release v2.5.0

Due to a random corruption of the rancher-agent image on Dockerhub, only amd64 is available for 2.5.0. Rancher 2.5.1 is a mirror release of 2.5.0 but with rebuilt images, please use that version instead. [#29424](https://github.com/rancher/rancher/issues/29424)


## Important

The primary UI in Rancher since version 2.0 is now called Cluster Manager. Our new Cluster Explorer dashboard, experimentally released in Rancher 2.4, has graduated to GA status. There are new features only available in the new Cluster Explorer dashboard. Some of these new features are similar functionality to existing features in the Cluster Manager and we will try to differentiate them based on where they are located in the UI. 


### Install/Upgrade Notes

- Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. [#29213](https://github.com/rancher/rancher/issues/29213)
- Rancher HA cluster should be upgraded to Kubernetes 1.17+ before installing Rancher 2.5.
- If using a proxy in front of an air-gapped Rancher, you must pass additional parameters to `NO_PROXY`. [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584)
- The [local cluster can no longer be turned off](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#upgrading-from-rancher-with-a-hidden-local-cluster), which means all admins will have access to the local cluster. If you would like to restrict permissions to the local cluster, there is a new [restricted-admin role](https://rancher.com/docs/rancher/v2.x/en/admin-settings/rbac/global-permissions/#restricted-admin) that must be used. 
- If you are using Rancher to manage other Rancher instances, do not upgrade at this time as there are known issues around conflicting controllers. [#29364](https://github.com/rancher/rancher/issues/29364).
- If you are running a forked build of the UI and set the `ui-index` setting to `local`, you currently are unable to force that to load . [#29362](https://github.com/rancher/rancher/issues/29362)

#### Docker Install

- When starting the Rancher Docker container, the privileged flag must be used. [See the docs for more info](https://staging.rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/)
- If you're using custom certs with the Docker install, clusters cannot be provisioned. [#28605](https://github.com/rancher/rancher/issues/28605)
- When installing in an air gap environment, you must supply a custom registries.yaml file to the Docker run command as shown in the [k3s docs](https://rancher.com/docs/k3s/latest/en/installation/private-registry/). If the registry has certs, then you will need to also supply those. [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229)
- There are UI issues around startup time [#28800](https://github.com/rancher/rancher/issues/28800), [#28798](https://github.com/rancher/rancher/issues/28798)

### Duplicated Features in Cluster Manager and Cluster Explorer
- Only 1 version of the feature may be installed at any given time due to potentially conflicting CRDs.
- Each feature should only be managed by the UI that it was deployed from. 
- If you have installed the feature in Cluster Manager, you must uninstall in Cluster Manager before attempting to install the new version in Cluster Explorer dashboard. 

### Kubernetes 1.19

- For K8s 1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. [#28840](https://github.com/rancher/rancher/issues/28840)
- Certain alerts in Cluster Manager are not working with k8s 1.19 as certain metrics have changed in Kubernetes 1.19 [#29292](https://github.com/rancher/rancher/issues/29292)

### Deprecated Features

 |Feature | Justification | 
  |---|---|
 |**Cluster Manager - Rancher Monitoring** | Monitoring in Cluster Manager UI has been replaced with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Alerts and Notifiers**| Alerting and notifiers functionality is now directly integrated with a new monitoring chart available in the Apps & Marketplace in Cluster Explorer.  |
|**Cluster Manager - Rancher Logging** | Functionality replaced with a new logging solution using a new logging chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - MultiCluster Apps**| Deploying to multiple clusters is now recommended to be handled with Rancher Continuous Delivery powered by Fleet available in Cluster Explorer.|
|**Cluster Manager - Kubernetes CIS 1.4 Scanning**|  Kubernetes CIS 1.5+ benchmark scanning is now replaced with a new scan tool deployed with a cis benchmarks chart available in the Apps & Marketplace in Cluster Explorer. |
|**Cluster Manager - Rancher Pipelines**|  Git-based deployment pipelines is now recommend to be handled with  Rancher Continuous Delivery powered by Fleet available in Cluster Explorer. |
|**Cluster Manager - Istio v1.5**| The Istio project has ended support for Istio 1.5 and has recommended all users upgrade. Istio 1.7 is now available as an Istio chart in the Apps & Marketplace in Cluster Explorer. |

## Versions

The following versions are now latest and stable:

  |Type | Rancher Version | Docker Tag |Helm Repo| Helm Chart Version |
  |---|---|---|---|---|
  | Latest | v2.5.0 | `rancher/rancher:latest` | server-charts/latest |v2.5.0 |
  | Stable | v2.4.8 | `rancher/rancher:stable` | server-charts/stable | v2.4.8 | 

Please review our [version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) for more details on versioning and tagging conventions.

## Features and Enhancements
 - **Cluster Explorer**:  A UI to provide a deeper look into clusters under management. With this new UI, you can:
   * Manage all Kubernetes cluster resources including custom resources from the Kubernetes operator ecosystem.
   * Deploy Helm charts from our new Apps and Marketplace.
   * View and edit Helm3 CLI releases from the new Apps UI.
   * Visibility to resources based on RBAC permissions
   * View logs and interact with kubectl shell in a new IDE-like viewer.
   * New Observability and Operations Tooling :
     - **Rancher Server Backups**: Previously admins relied on etcd backups of the Rancher management cluster for disaster recovery and rollback scenarios. The new backup and recovery process no longer requires access to the etcd database. Now admins can perform ad-hoc or scheduled backups of the Rancher application directly from the Rancher dashboard. Restore data into any Kubernetes cluster.

      - **Monitoring and Alerting powered by Prometheus**: Users can now define how to monitor, alert, and visualize application health as part of the deployment configuration. The new monitoring system can be configured with GitOps based workflows using the Prometheus Operator custom resources. Alertmanager can be configured to use all built-in notification integrations. Alert templates can be customized to tailor notifications the on-call team receives. Users can deploy their own Grafana dashboards into the built-in Grafana instance. 

     - **Logging powered by Banzai Cloud**: New cluster-level logging pipelines that incorporate lighter weight FluentBit and Fluentd to ship logs to a remote data store. The pipeline functionality is orchestrated Kubernetes objects enabling configuration through GitOps based workflows. Users will have the ability to customize both the FluentBit and Fluentd configurations. 

     - **Expanded CIS Scans powered by kube-bench**: Rancher CIS scanning now runs on EKS and GKE platforms in addition to RKE clusters. The scanning tool also includes a new standard CIS-1.5 profile untailored for a specific K8s distribution. The benchmark versions have been updated to CIS 1.5, EKS-1.0, and GKE-1.0. 
 
- **Rancher Continuous Delivery powered by Fleet**:  Rancher Continuous Delivery is a built-in deployment tool powered by Rancher's Fleet project. Users can leverage this tool to deliver applications and configurations from a Git source repository across multiple clusters. Rancher Continuous Delivery is able to scale to a large number of clusters under management using a staged checkout and pull-based update model.  The staged checkout allows the Continuous Delivery control plane to gradually roll deployments out to clusters instead of all at once. Using a pull-based update model, administrators don't need to configure network access to every remote cluster. Administrators can organize clusters into groups for easier management within Rancher Continuous Delivery. Git source repositories are mapped to cluster group targets by admins, without needing the end-user to access the control plane configuration. Application owners and admins can deploy any Kubernetes resource defined by manifests, kustomize, or Helm.

 - **Enhanced EKS Lifecycle Management**: EKS provisioning has been enhanced to support managed node groups, private access, and control plane logging. Users can now register existing EKS clusters provisioned with other tools like eksctl into Rancher to allow the management of upgrades and configuration going forward. Support has been added for multiple managed node groups with heterogeneous configurations to enable GPU and non-GPU workloads in the same cluster. The EKS cluster configuration in Rancher now uses cloud credentials decoupling the AWS key management from the cluster configuration. 

 - **Istio 1.7**: The Istio project has made a lot of changes to the installation process over the last several releases. The new Rancher Istio integration now deploys the latest Istio Operator allowing for users to deploy multiple ingress and egress gateways. Users can also manage the Istio custom resources in a customized UX in the new dashboard. 

 - **RKE Government**: A new Kubernetes distribution that supports FIPS encryption, SELinux, and container-d. The RKE-Gov distribution has out-of-the-box CIS compliance. Management of etcd backups and restores are built into the distribution.   

- **CentOS/RHEL 8 Support**: Admins can use RKE Government clusters installed on RHEL and CentOS 8 systems. RKE support will come in a later update and use Docker CE. 

## Experimental Features

- **OPA Gatekeeper:** Users can deploy and manage the updated GA version of OPA Gatekeeper through Rancher. Users must uninstall the first Rancher installed version OPA Gatekeeper before installing this new feature.

- **RancherD:** A single binary installation of Rancher. Admins create 1 or 3 hosts, and start the RancherD binary to perform all the work of installing Rancher. Check out [this blog article](https://rancher.com/blog/2020/rancherd-simplifies-rancher-deployment) for more details.

## Major Bugs Fixed Since v2.4.8

- Rancher no longer panic's during a drain action from the API [#28905](https://github.com/rancher/rancher/issues/28905)
- Argo rollout pods can now be seen in the cluster explorer [#27923](https://github.com/rancher/rancher/issues/27923)
- Helm's max history can now be configured [#28728](https://github.com/rancher/rancher/issues/28728)
- The Cluster Manager UI dropdown now works on mobile [#23298](https://github.com/rancher/rancher/issues/23298)
- The new EKS provisioning supports API Server Endpoint Access Control [#19051](https://github.com/rancher/rancher/issues/19051)
- Cluster Explorer supports CRUD action on CRDs [#18013](https://github.com/rancher/rancher/issues/18013)

## Other notes

### Known Major Issues
- Cluster Manager's Monitoring stack does not install on the local cluster if it is K3s  [#29328](https://github.com/rancher/rancher/issues/29328)

### Cluster Explorer Feature Caveats and Upgrades

- General
	- Not all new features are currently installable on a hardened cluster.
	- New features are expected to be deployed using the Helm3 CLI and not with the Rancher CLI
	- The new Logging and Monitoring features do not yet work with windows clusters. [#28721](https://github.com/rancher/rancher/issues/28721) [#28327](https://github.com/rancher/rancher/issues/28327)
- Rancher Backup
	- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location, it must continue to use the same URL.
	- Rancher Continuous Delivery (Fleet) is not handled during backup. [Backup#46](https://github.com/rancher/backup-restore-operator/issues/46)
- Monitoring
	- The Monitoring stack currently is not installable on a K8s 1.16 cluster [#29395](https://github.com/rancher/rancher/issues/29395)
	- When the new Monitoring feature is deployed on K3s, it needs to have specific memory/cpu limits set [#28787](https://github.com/rancher/rancher/issues/28787#issuecomment-693611821)
	- Monitoring sometimes errors on installation because it can't identify CRDs [#29171](https://github.com/rancher/rancher/issues/29171)
        - The new monitoring chart deploys a standard Prometheus installation which does not support project-level isolation.
- Istio
	- Installation for Istio fails when the ingress gateway is disabled [#29383](https://github.com/rancher/rancher/issues/29383)
- Longhorn
	- Longhorn has seen an issue where uninstallation may get stalled if there are daemonset changes occurring. [Longhorn#1820](https://github.com/longhorn/longhorn/issues/1820)
- OPA Gatekeeper (Experimental)
	- The first edition of OPA must be uninstalled before the new OPA features are installed [#29188](https://github.com/rancher/rancher/issues/29188)

### Air gap

- Deploying an EKS cluster in an air gap environment is not supported [#29070](https://github.com/rancher/rancher/issues/29070)
- Air gap has rarely seen an issue where the downstream cluster does not correctly get the registry setting, causing pods to fail. To workaround the issue, simply restart the agent [#28923](https://github.com/rancher/rancher/issues/28923)

## Versions

### Images
- rancher/rancher:v2.5.0
- rancher/rancher-agent:v2.5.0

### Tools
- cli - [v2.4.6](https://github.com/rancher/cli/releases/tag/v2.4.6)
- rke - [v1.2.0](https://github.com/rancher/rke/releases/tag/v1.2.0)

### Kubernetes

-  [1.19.2](https://github.com/rancher/hyperkube/releases/tag/v1.19.2-rancher1) (default)
-  [1.18.9](https://github.com/rancher/hyperkube/releases/tag/v1.18.9-rancher1)
-  [1.17.12](https://github.com/rancher/hyperkube/releases/tag/v1.17.12-rancher1)
-  [1.16.15](https://github.com/rancher/hyperkube/releases/tag/v1.16.15-rancher1) 

## Upgrades and Rollbacks

Rancher supports both upgrade and rollback. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or rollback to change the Rancher version. There are different rollback instructions for Rancher [versions 2.5.0 or newer](https://staging.rancher.com/docs/rancher/v2.x/en/backups/restoring-rancher/) and for [versions 2.4.x or earlier](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/).

**Important:** When rolling back, we are expecting you to rollback to the state at the time of your upgrade. Any changes post upgrade would not be reflected. 

-----
