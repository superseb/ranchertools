| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.5.17](rancher-v2.5.md#release-v2517) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v2.5.16](rancher-v2.5.md#release-v2516) | Aug 18 2022 | 08/18/22 | 2022-08-18 |
| [v2.5.15](rancher-v2.5.md#release-v2515) | Jun 30 2022 | 06/30/22 | 2022-06-30 |
| [v2.5.14](rancher-v2.5.md#release-v2514) | May 24 2022 | 05/24/22 | 2022-05-24 |
| [v2.5.13](rancher-v2.5.md#release-v2513) | Apr 15 2022 | 04/15/22 | 2022-04-15 |
| [v2.5.12-patch1](rancher-v2.5.md#release-v2512-patch1) | Mar 14 2022 | 03/14/22 | 2022-03-14 |
| [v2.5.12-debug1](rancher-v2.5.md#release-v2512-debug1) | Feb 11 2022 | 02/11/22 | 2022-02-11 |
| [v2.5.12](rancher-v2.5.md#release-v2512) | Jan 25 2022 | 01/25/22 | 2022-01-25 |
| [v2.5.11-patch1](rancher-v2.5.md#release-v2511-patch1) | Nov 22 2021 | 11/22/21 | 2021-11-22 |
| [v2.5.11](rancher-v2.5.md#release-v2511) | Nov 03 2021 | 11/03/21 | 2021-11-03 |
| [v2.5.10](rancher-v2.5.md#release-v2510) | Oct 14 2021 | 10/14/21 | 2021-10-14 |
| [v2.5.9](rancher-v2.5.md#release-v259) | Jul 15 2021 | 07/15/21 | 2021-07-15 |
| [v2.5.8-patch1](rancher-v2.5.md#release-v258-patch1) | May 26 2021 | 05/26/21 | 2021-05-26 |
| [v2.5.8](rancher-v2.5.md#release-v258) | May 06 2021 | 05/06/21 | 2021-05-06 |
| [v2.5.7-patch1](rancher-v2.5.md#release-v257-patch1) | May 05 2021 | 05/05/21 | 2021-05-05 |
| [v2.5.7](rancher-v2.5.md#release-v257) | Mar 13 2021 | 03/13/21 | 2021-03-13 |
| [v2.5.6](rancher-v2.5.md#release-v256) | Mar 04 2021 | 03/04/21 | 2021-03-04 |
| [v2.5.5](rancher-v2.5.md#release-v255) | Jan 09 2021 | 01/09/21 | 2021-01-09 |
| [v2.5.4](rancher-v2.5.md#release-v254) | Jan 07 2021 | 01/07/21 | 2021-01-07 |
| [v2.5.3](rancher-v2.5.md#release-v253) | Nov 30 2020 | 11/30/20 | 2020-11-30 |
| [v2.5.2](rancher-v2.5.md#release-v252) | Nov 10 2020 | 11/10/20 | 2020-11-10 |
| [v2.5.1](rancher-v2.5.md#release-v251) | Oct 08 2020 | 10/08/20 | 2020-10-08 |
| [v2.5.0](rancher-v2.5.md#release-v250) | Oct 06 2020 | 10/06/20 | 2020-10-06 |



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


## All issues in v2.5.17 milestone

* [#38815](https://github.com/rancher/rancher/issues/38815) [2.5] [BUG] Unable to interact with downstream clusters after upgrading from 2.5.15 to 2.5.16
* [#38345](https://github.com/rancher/rancher/issues/38345) [BUG] [2.5]Rancher API Audit Log fails to capture API calls at Audit Level 3
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

## All issues in v2.5.16 milestone

* [#38596](https://github.com/rancher/rancher/issues/38596) [BUG] - Cluster Unavailable after moving a fleet cluster from a fleet workspace to other workspace
* [#38581](https://github.com/rancher/rancher/issues/38581) [2.5] Unable to view cluster's YAML when logged in as a non-administrative user
* [#38441](https://github.com/rancher/rancher/issues/38441) [BUG] 2.5.x backport of Splunk unable to handle arguments for <buffer ...> section 
* [#38406](https://github.com/rancher/rancher/issues/38406) No valid AKS k8s versions on rancher 2.5 
* [#38397](https://github.com/rancher/rancher/issues/38397) [Backport v2.5] Cannot update s3 credentials after cluster has been created.
* [#37986](https://github.com/rancher/rancher/issues/37986) [2.5] Cluster Explorer caused denial of service in downstream cluster
* [#37965](https://github.com/rancher/rancher/issues/37965) fix gouroutine leak when sharedcontroller has been started
* [#37859](https://github.com/rancher/rancher/issues/37859) Upgrade from rancher 2.5.13 to 2.5.14 fails...
* [#37655](https://github.com/rancher/rancher/issues/37655) [Backport v2.5] Update hyperkube base to Ubuntu 22.04
* [#37228](https://github.com/rancher/rancher/issues/37228) [Backport 2.5] Update Azure AD API from ADAL to MSAL
-----
**Rancher v2.5.15 is a mirror release of [v2.5.14](https://github.com/rancher/rancher/releases/tag/v2.5.14) with one change to address the following issue:**

- A major performance issue was occurring when Rancher was attempting to control large volumes of traffic from downstream clusters. This mechanism was not handling disconnects properly and would result in indefinite locks. See [#38097](https://github.com/rancher/rancher/issues/38097).

## All issues in v2.5.15 milestone

* [#38097](https://github.com/rancher/rancher/issues/38097) [2.5] Clusters become unreachable via UI and kubectl after some times
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


## All issues in v2.5.14 milestone

* [#37515](https://github.com/rancher/rancher/issues/37515) [Backport v2.5] Unable to create a VMware vSphere cluster with private registry 
* [#37360](https://github.com/rancher/rancher/issues/37360) [2.5] Add options to lasso that improve performance
* [#36584](https://github.com/rancher/rancher/issues/36584)  buffer exceeded errors
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


## All issues in v2.5.13 milestone

* [#37353](https://github.com/rancher/rancher/issues/37353) [Backport v2.5] Panic in steve when `summary.Relationship` is changed
* [#37266](https://github.com/rancher/rancher/issues/37266) [Backport v2.5] Airgap - unexpected end of JSON input when provisioning RKE1 Custom clusters
* [#37257](https://github.com/rancher/rancher/issues/37257) [Backport] v2.5: Reset remotedialer buffer to reduce memory allocation
* [#37254](https://github.com/rancher/rancher/issues/37254) Fleet - Upgrade to 2.5.13-rc1 doesn't upgrade the fleet controller and agents as expected
* [#37251](https://github.com/rancher/rancher/issues/37251) Allow lasso resync time to be configured via env var
* [#36954](https://github.com/rancher/rancher/issues/36954) [2.5 Backport] Backport Steve API Fix
* [#36621](https://github.com/rancher/rancher/issues/36621) [2.5] Rancher logs spammed with RoleBinding.rbac.authorization.k8s.io is invalid: when any auth group is assigned restricted admin global role
* [#36599](https://github.com/rancher/rancher/issues/36599) [Backport v2.5] Pass container limits from project in a new namespace if it does not override them
* [#36267](https://github.com/rancher/rancher/issues/36267) Alerts (v1) do not display alert category or description
* [#35758](https://github.com/rancher/rancher/issues/35758) [Backport v2.5] Cluster agent fails with error "socket: too many open files"
* [#35066](https://github.com/rancher/rancher/issues/35066) 2.5.9 -> 2.5.10-rc2 rancher upgrade | Newly added windows 2004 worker node does not get deleted after the upgrade 
* [#34742](https://github.com/rancher/rancher/issues/34742) [Backport] update driver version to the new version for equinix metal
* [#33654](https://github.com/rancher/rancher/issues/33654) Cannot create backup in Cluster Explorer after switching to Simplified Chinese
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


## All issues in v2.5.12 milestone

* [#36184](https://github.com/rancher/rancher/issues/36184) New Charts in v2.5.12
* [#36120](https://github.com/rancher/rancher/issues/36120) [2.5.12] Adding https://git.rancher.io/helm3-charts does not result in any charts being returned
* [#36091](https://github.com/rancher/rancher/issues/36091) Can't configure S3-compatible storage using the Rancher Backups chart in the local cluster during chart install
* [#36040](https://github.com/rancher/rancher/issues/36040) [Backport v2.5] Metrics-server v0.4.1 timeout - already fixed in upstream
* [#36038](https://github.com/rancher/rancher/issues/36038) [Backport v2.5] s3 etcd backups taking longer than 5 minutes cause backup loop
* [#36037](https://github.com/rancher/rancher/issues/36037) [Backport v2.5] Rancher reports cluster as active even though the add-on's are not upgraded as part of k8s version upgrade
* [#36027](https://github.com/rancher/rancher/issues/36027) Inconsistency between CSI chart versions and app readme
* [#36021](https://github.com/rancher/rancher/issues/36021) [Backport v2.5] Update hyperkube base to using iptables >1.8.5
* [#35995](https://github.com/rancher/rancher/issues/35995) Issue in Monitoring v1 graphs - All metrics show the same graph and CPU/Memory usage is incorrect
* [#35994](https://github.com/rancher/rancher/issues/35994) Monitoring v1 is not available in a downstream cluster on Tenant Rancher server 
* [#35961](https://github.com/rancher/rancher/issues/35961) Rancher logging 3.15.0 fluentd pods go into crashloop with 2.5-head
* [#35948](https://github.com/rancher/rancher/issues/35948) [Backport] Installing the same helm3 chart in the ember UI after its deleted is updating the existing migrated chart in the explorer UI
* [#35940](https://github.com/rancher/rancher/issues/35940) [Backport v2.5] Cluster Explorer Apps: Cannot download catalog that responds with a redirect
* [#35860](https://github.com/rancher/rancher/issues/35860) Verify Rancher Webhook Rotation workaround and Certificate Renewal
* [#35820](https://github.com/rancher/rancher/issues/35820) Chart Repositories are not showing up on Rancher v2.5-head
* [#35809](https://github.com/rancher/rancher/issues/35809) [Backport v2.5.12] EKS Node Group deletion piloted by Rancher
* [#35791](https://github.com/rancher/rancher/issues/35791) [2.5] Kubectl error "You must be logged in to the server"
* [#35734](https://github.com/rancher/rancher/issues/35734) [Backport v2.5.12] Rancher logging atomatically detect docker root
* [#35725](https://github.com/rancher/rancher/issues/35725) [2.5] EKS upgrades loop without a default AMI list for v1.19 onwards
* [#35677](https://github.com/rancher/rancher/issues/35677) [2.5 Back-port] Add functionality to specify limit of app revisions stored 
* [#35572](https://github.com/rancher/rancher/issues/35572) CSI chart 2.1.1 on k8s version 1.17 fails
* [#35515](https://github.com/rancher/rancher/issues/35515) [Backport] v2.5: Remove EKS deprecated k8s version 1.17
* [#35488](https://github.com/rancher/rancher/issues/35488) [Backport] 2.5x - Convert ServerVersion to downstream env var
* [#35478](https://github.com/rancher/rancher/issues/35478) vsphere CSI charts show incompatible version of chart for clusters on k8s 1.18.20
* [#35476](https://github.com/rancher/rancher/issues/35476) [2.5] Fix vSphere charts upgrade path
* [#35410](https://github.com/rancher/rancher/issues/35410) [Backport] v2.5: Add support for annotation that prevents helm install and v1 App deletion when deleting v3 App
* [#35407](https://github.com/rancher/rancher/issues/35407) [Backport] v2.5: Cannot upgrade apps with deployments that were created in ember
* [#35393](https://github.com/rancher/rancher/issues/35393) [Backport 2.5][Logging v2] Add option to disable automation JSON parsing
* [#35377](https://github.com/rancher/rancher/issues/35377) [2.5] Backport: Listing many large resources can be slow on the ember UI
* [#35341](https://github.com/rancher/rancher/issues/35341) [Backport 2.5][Istio] k8s IP service is set to default IP which does not work for all environments
* [#35158](https://github.com/rancher/rancher/issues/35158) [Backport 2.5] Include labels on global secret create in Cluster Manager for default namespace
* [#35102](https://github.com/rancher/rancher/issues/35102) [csi migration] node is unable to upgrade k8s after csi migration -> cpi/csi charts are restarting 
* [#35068](https://github.com/rancher/rancher/issues/35068) How to rotate cattle-webhook-tls certificate when it has expired?
* [#35216](https://github.com/rancher/rancher/issues/35216) [rancher-pushprox] duplicate label in ServiceMonitor resource
* [#35058](https://github.com/rancher/rancher/issues/35058) [2.5] Update fluentbit to the latest version
* [#35009](https://github.com/rancher/rancher/issues/35009) [Backport 2.5] Unable to update istio configuration in air-gapped environment in Rancher v2.5.x
* [#34832](https://github.com/rancher/rancher/issues/34832) [Backport 2.5] Cannot upgrade apps with deployments that were created in ember 
* [#34831](https://github.com/rancher/rancher/issues/34831) [Backport 2.5] Add support for annotation that prevents helm install and v1 App deletion when deleting v3 App
* [#34819](https://github.com/rancher/rancher/issues/34819) Intermittent health check failure causes unreachable downstream clusters
* [#34772](https://github.com/rancher/rancher/issues/34772) Logging v2 - fluentbit pods fail to reach the fluentd service 3.14.0
* [#34770](https://github.com/rancher/rancher/issues/34770) [Logging v1] Backport v2.6.0 fixes to v2.5.10
* [#34757](https://github.com/rancher/rancher/issues/34757) [backport] [rancher-alerting-drivers] bump prom2teams and sachet
* [#34669](https://github.com/rancher/rancher/issues/34669) [2.5] Backport Missing Permissions in catalogs-manage GlobalRole
* [#34625](https://github.com/rancher/rancher/issues/34625) [2.5] Rancher Logging backports
* [#34604](https://github.com/rancher/rancher/issues/34604) Rancher 2.5.9 uses flannel:v0.13.0 which causes iptables segfault in RHEL 8.4
* [#33851](https://github.com/rancher/rancher/issues/33851) [Monitoring V2, Backport 2.5] Prometheus -> Classic UI is not working (404 errors) -> proxyURL is added twice to the request URL
* [#33826](https://github.com/rancher/rancher/issues/33826) [Backport] Remove EKS deprecated k8s version 1.17
* [#33824](https://github.com/rancher/rancher/issues/33824) [Backport 2.5] Istio 1.10.4
* [#33724](https://github.com/rancher/rancher/issues/33724) Rancher 2.5.9 uninstall via helm on RKE2 cluster with CIS profile active does not honor podSecurityPolicies for uninstall job
* [#33038](https://github.com/rancher/rancher/issues/33038) [2.5 backport] Update rancher-images generator to support feature and system charts min/max version constraint
* [#32934](https://github.com/rancher/rancher/issues/32934) Cluster explorer and websocket connection broken after upgrading to rancher 2.5.8 (fine with 2.5.7)
* [#32898](https://github.com/rancher/rancher/issues/32898) rancher operator is created rancher-operator-system which is not installed in System project 
* [#32045](https://github.com/rancher/rancher/issues/32045) Access control cache sees issue when adding namespaces
* [#31810](https://github.com/rancher/rancher/issues/31810) [CatalogV2] rancher-logging helm chart - Splunk certificate issue
* [#31982](https://github.com/rancher/rancher/issues/31982) RBAC project role (caching?) issue in Rancher v2.5 Cluster Explorer
* [#30959](https://github.com/rancher/rancher/issues/30959) Cluster goes to unavailable because failed to communicate with API server: i/o timeout
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


## All issues in v2.5.10 milestone

* [#35131](https://github.com/rancher/rancher/issues/35131) Validate Rocky Linux 8.4
* [#35130](https://github.com/rancher/rancher/issues/35130) Validate Open SUSE Leap 15.3
* [#35093](https://github.com/rancher/rancher/issues/35093) [vsphere csi] chart will not install on multi-node setup -> taints are not being removed by cpi chart
* [#35079](https://github.com/rancher/rancher/issues/35079) Fleet - can't assign clusters to other workspaces after upgrade to v2.5.10-rc4
* [#35050](https://github.com/rancher/rancher/issues/35050) [Backup-restore] error syncing 'c-89d82/m-4067aa68dd78' is seen for every few minutes upon a restore when a cluster with a finalizer added to a node is removed before backup 
* [#34980](https://github.com/rancher/rancher/issues/34980) Rancher stuck in Fatal Error (crashing) loop after a harvester cluster is imported  `[FATAL] k3s exited with: exit status 1`
* [#34977](https://github.com/rancher/rancher/issues/34977) [2.5] Update vSphere CPI
* [#34961](https://github.com/rancher/rancher/issues/34961) Errors seen after hosted rancher is upgraded to 2.6 and is managing a 2.5 rancher setup
* [#34952](https://github.com/rancher/rancher/issues/34952) [Backport] Hosted clusters are not deployed on Rancher Hosted setup after upgrade
* [#34912](https://github.com/rancher/rancher/issues/34912) [Backport 2.5] Rancher crashes after adding a catalog containing a chart with missing name and version
* [#34877](https://github.com/rancher/rancher/issues/34877) [v2.5.10] Backport: '"unable to create impersonator account ... serviceaccounts not found" error after upgrade from 2.5.9 to 2.6.0'
* [#34828](https://github.com/rancher/rancher/issues/34828) [v2.5.10] Backport: "helm upgrade/delete intermittently fails with errors like "unable to create impersonator account: error setting up impersonation for user u-xxxxx..Operation cannot be fulfilled on clusterroles.rbac.authorization.k8s.io \"cattle-impersonation-u-8j72f\": the object has been modified; please apply your changes to the latest version and try again.""
* [#34797](https://github.com/rancher/rancher/issues/34797) vSphere provider CSI should allow setting volume expansion
* [#34751](https://github.com/rancher/rancher/issues/34751) [vsphere-csi] Allow controller to recover if underlying node becomes unavailable
* [#34632](https://github.com/rancher/rancher/issues/34632) [v2.5] KDM Update for K8s September patch release
* [#34630](https://github.com/rancher/rancher/issues/34630) [2.5] Update vSphere CSI to latest upstream
* [#34627](https://github.com/rancher/rancher/issues/34627) [2.5] back port multiple fixes for rancher-backup
* [#34554](https://github.com/rancher/rancher/issues/34554) [2.5]Corrupted Backup - No Restore Rancher Management Cluster / Rancher Server
* [#34553](https://github.com/rancher/rancher/issues/34553) [2.5] [backport] rke2 downstream clusters fail to come active when we perform restore with migration to a new rancher server
* [#34467](https://github.com/rancher/rancher/issues/34467) [2.5] [Backport] Rancher backup charts backs up rancher deployment
* [#34466](https://github.com/rancher/rancher/issues/34466) [2.5] [backport] [rancher-backup]  Restore fails on a rollback in the same rancher setup with error "Failed to find system chart fleet will try again in 5 seconds" and Rancher UI is not accessible
* [#34454](https://github.com/rancher/rancher/issues/34454) [v2.5.10] Backport: "unable to create impersonator account: error getting service account token: serviceaccounts \"cattle-impersonation-system/cattle-impersonation-user-dxx4g\" not found - Error seen for Monitoring and Istio v1 charts and when using downloaded kubeconfig
* [#34453](https://github.com/rancher/rancher/issues/34453) [2.5] [Backport] service "rancher-webhook" not found error when helm install rancher 
* [#34383](https://github.com/rancher/rancher/issues/34383) [Backport - 2.5] Validate the latest cert-manager in Rancher server helm chart to the latest version
* [#34320](https://github.com/rancher/rancher/issues/34320) [2.5] [Backport] [Rancher-webhook] Add support for hardened cluster
* [#34214](https://github.com/rancher/rancher/issues/34214) [2.5.x] Update xip.io to sslip.io
* [#34150](https://github.com/rancher/rancher/issues/34150) [release task] Feature charts 2.5 branch
* [#34141](https://github.com/rancher/rancher/issues/34141) [v2.5.10] Backport: Not able to deploy clusters when external auth provider is enabled
* [#34140](https://github.com/rancher/rancher/issues/34140) [v2.5.10] Backport: Warnings "will not create impersonation account on cluster" seen on rancher startup
* [#34084](https://github.com/rancher/rancher/issues/34084) [Backport - v2.5.10]: RKE1 with calico and project network isolation breaks ingress controller to pod communication
* [#34074](https://github.com/rancher/rancher/issues/34074) rancher-images.txt for rancher 2.5.8 and 2.5.9 is missing docker.io/rancher/kubectl:v1.18.6 -> uninstall crd job fails in image pull due to that
* [#34026](https://github.com/rancher/rancher/issues/34026) [v2.5] KDM Update for K8s August patch release
* [#33958](https://github.com/rancher/rancher/issues/33958) [2.5] Backport: Unable to view resources in downstream clusters when my user is associated with a group from an external auth provider
* [#33940](https://github.com/rancher/rancher/issues/33940) [v2.5.10] Backport: [Logging v2] Ensure Windows paths match internal standards
* [#33939](https://github.com/rancher/rancher/issues/33939) [v2.5.10] Backport: [Logging v2] - win-agent-rke invalid volume specification when using a non default win_prefix_path
* [#33938](https://github.com/rancher/rancher/issues/33938) [v2.5.10] Backport: Switch K3S to Journald login plugin for control plane logs.
* [#33937](https://github.com/rancher/rancher/issues/33937) [v2.5.10] Backport: [Logging v2] Make strip underscores optional in journald logging config
* [#33936](https://github.com/rancher/rancher/issues/33936) [v2.5.10] Backport: K3S logs don't always have timestamps
* [#33935](https://github.com/rancher/rancher/issues/33935) [v2.5.10] Backport: RKE2 cluster control plane log do not have metadata fields such as "time" and "pod id"
* [#33934](https://github.com/rancher/rancher/issues/33934) [v2.5.10] Backport: Collect k3s-agent.service logs in addition to k3s.service
* [#33933](https://github.com/rancher/rancher/issues/33933) [v2.5.10] Backport: Support configuration of multiple replicas for Rancher-logging chart components such as fluentd
* [#33876](https://github.com/rancher/rancher/issues/33876) [backport] Downstream clusters on an upgrade to master-head are going into updating state 
* [#33814](https://github.com/rancher/rancher/issues/33814) RoleBinding creation logs not outputting binding namespace
* [#33780](https://github.com/rancher/rancher/issues/33780) [v2.5] RKE v1.2.10 defaults to kubernetes v1.20.8
* [#33762](https://github.com/rancher/rancher/issues/33762) [Backport] Rancher 2.5 (Single Install) not starting after nf_conntrack_max value adjustment
* [#33697](https://github.com/rancher/rancher/issues/33697) [Backport] Nodes fail to update, with cluster stuck in Upgrading state when attempting to update private registry details in Rancher provisioned cluster
* [#33682](https://github.com/rancher/rancher/issues/33682) [v2.5 Backport] Manually created duplicate rolebindings are not cleaned up when Rancher is upgraded to 2.5.8
* [#33673](https://github.com/rancher/rancher/issues/33673) [v2.5] KDM release: k8s july patches
* [#33659](https://github.com/rancher/rancher/issues/33659) [2.5] Rancher deployed Apps incorrectly add io.cattle.field/appId to NetworkPolicy selector specification 
* [#33624](https://github.com/rancher/rancher/issues/33624) [Backport] Worker requirement logging not seen on custom cluster
* [#33596](https://github.com/rancher/rancher/issues/33596) [2.5] Global DNS app gets uninstalled/removed immediately after install due to OwnerReferences cleanup in k8s v1.20
* [#33528](https://github.com/rancher/rancher/issues/33528) New charts in v2.5.10
* [#33497](https://github.com/rancher/rancher/issues/33497) [Backport] v2.5: Adding label to EKS managed node group results in continual error
* [#33458](https://github.com/rancher/rancher/issues/33458) [Backport 2.5] Ability to specify network tags for node pools in GKE cluster
* [#33442](https://github.com/rancher/rancher/issues/33442) [Backport 2.5, Monitoring V2] Remove pre-install job in favor of Helm annotations
* [#33420](https://github.com/rancher/rancher/issues/33420) [Backport 2.5, Monitoring V2] Add pushprox for kubelet and node-exporter
* [#33415](https://github.com/rancher/rancher/issues/33415) [backport 2.5] Ability to specify network tags for node pools in GKE cluster
* [#33412](https://github.com/rancher/rancher/issues/33412) Validate CentOS 8.4 in v2.5.x
* [#33411](https://github.com/rancher/rancher/issues/33411) Validate Oracle Linux 8.4 in v2.5.x
* [#33410](https://github.com/rancher/rancher/issues/33410) Validate RHEL 8.4 in v2.5.x
* [#33357](https://github.com/rancher/rancher/issues/33357) [Backport 2.5] Add EKS v1.19 
* [#33351](https://github.com/rancher/rancher/issues/33351) [Backport Monitoring V2] Rebase to kube-prometheus-stack 16.x.x
* [#33348](https://github.com/rancher/rancher/issues/33348) [2.5.10][Backport] Rancher chart post-delete hook fails on hardened cluster
* [#33172](https://github.com/rancher/rancher/issues/33172) [2.5 backport] KEv2 - Support Install on Hardened Cluster
* [#33171](https://github.com/rancher/rancher/issues/33171) [2.5 backport] KEv2- Ensure CIS hardened profile scan passes
* [#33156](https://github.com/rancher/rancher/issues/33156) [2.5.10] Reduce size of v3.Catalog objects
* [#33154](https://github.com/rancher/rancher/issues/33154) [2.5] GKEv2 Access scopes for NP: "access to all Cloud APIs" & "Set access for each API"- not getting enabled
* [#33153](https://github.com/rancher/rancher/issues/33153) [2.5] GKE and EKS, some fields not working fine using rancher go cli
* [#33152](https://github.com/rancher/rancher/issues/33152) [2.5] GKE Operator Only Issues
* [#33068](https://github.com/rancher/rancher/issues/33068) [2.5][Backport] Rancher chart post-delete hook fails on hardened cluster
* [#33053](https://github.com/rancher/rancher/issues/33053) Unable to deploy EKS or GKE on hosted Rancher
* [#33039](https://github.com/rancher/rancher/issues/33039) [backport 2.5.10] share-mnt container keep restarting
* [#33015](https://github.com/rancher/rancher/issues/33015) Backport 2.5: [monitoring v2] sometimes unable to upgrade from 9.4.202 -> 14.5.100, workaround to upgrade a 2nd time
* [#33014](https://github.com/rancher/rancher/issues/33014) Backport 2.5: Rancher-monitoring installation fails on fresh cluster with crd error
* [#33013](https://github.com/rancher/rancher/issues/33013) Backport Grafana PV validation to 2.5
* [#32905](https://github.com/rancher/rancher/issues/32905) [2.5 Backport]  Upstream Kubernetes Deprecation: Controller Manager & Scheduler show as Unhealthy in clusters that do not have component status for them (Azure, Tectonic among others)
* [#32903](https://github.com/rancher/rancher/issues/32903) [Backport] KEv2 operators should get the same ca-additional as the Rancher deployment
* [#32879](https://github.com/rancher/rancher/issues/32879) [Backport] 2.5.x pushprox-kube-etcd-client does not tolerate node-role.kubernetes.io/master:NoSchedule taint
* [#32842](https://github.com/rancher/rancher/issues/32842) [Release task] Feature charts release tasks
* [#32691](https://github.com/rancher/rancher/issues/32691) [Backport] - TTL Token values not respected on External SAML Auth 
* [#32683](https://github.com/rancher/rancher/issues/32683) [Backport] Enhance agent logging on worker requirement
* [#32682](https://github.com/rancher/rancher/issues/32682) [Backport] Rancher keeps stale data in /var/lib/rancher/management-state/rke
* [#32665](https://github.com/rancher/rancher/issues/32665) [Back port] [Rancher Alerting Drivers] Support Hardened Cluster
* [#32609](https://github.com/rancher/rancher/issues/32609) [backport] gke and eks operators api *string type doesn't match at generated rancher go cli
* [#32607](https://github.com/rancher/rancher/issues/32607) [2.5] Backport Kubernetes component status filter
* [#32606](https://github.com/rancher/rancher/issues/32606) [Backport] ingress-nginx in Prometheus Targets of a cluster are down when port 10254 is not open monitoring v2 is enabled 
* [#32585](https://github.com/rancher/rancher/issues/32585) Setting MaxPodsConstraint for GKE operator fails
* [#32547](https://github.com/rancher/rancher/issues/32547) Rancher operator fails to deploy on CIS hardened RKE cluster
* [#32149](https://github.com/rancher/rancher/issues/32149) Global/restricted admin unable to create an EKS cluster in hosted Rancher tenant
* [#32111](https://github.com/rancher/rancher/issues/32111) Update rancher-images generator to support feature charts min/max
* [#33128](https://github.com/rancher/rancher/issues/33128) [Backport] Kubernetes components are not restarted after updating cloud provider config file
* [#31154](https://github.com/rancher/rancher/issues/31154) AKS spinup in switzerlandnorth fails
* [#30126](https://github.com/rancher/rancher/issues/30126) Deploy ingress-nginx ServiceMonitor in Rancher v2.5 for scraping by Monitoring v2
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


## All issues in v2.5.9 milestone

* [#33590](https://github.com/rancher/rancher/issues/33590) CVE-2021-25318 - ApiGroup not properly specified when creating Kubernetes RBAC resources
* [#33589](https://github.com/rancher/rancher/issues/33589) CVE-2021-25320 - Cloud credentials can be used through Rancher's proxy by users without access
* [#33588](https://github.com/rancher/rancher/issues/33588) CVE-2021-31999 - Privilege escalation vulnerability via malicious "Connection" header in Rancher v2.5.8
* [#33557](https://github.com/rancher/rancher/issues/33557) New charts in v2.5.9
* [#33523](https://github.com/rancher/rancher/issues/33523) [2.5] gke v1/v2 - getting error 500 for us-central1 region
* [#33475](https://github.com/rancher/rancher/issues/33475) Add k8s 1.20 as an option for EKS
* [#33429](https://github.com/rancher/rancher/issues/33429) GlobalRoleBinding deletion by garbagecollector causing panic in rancher-webhook
* [#33286](https://github.com/rancher/rancher/issues/33286) Backport: RoleTemplates allowed to be created with no verbs
* [#33277](https://github.com/rancher/rancher/issues/33277) GKE v1/v2: Backport to 2.5.9 - privateClusterConfig defaults
* [#33256](https://github.com/rancher/rancher/issues/33256) [2.5.9] Reduce size of v3.Catalog objects
* [#33180](https://github.com/rancher/rancher/issues/33180) [backport] Services not removed after deleting workload
* [#32873](https://github.com/rancher/rancher/issues/32873) [Backport 2.5] CleanupDuplicateBindings blocks rancher startup
* [#32826](https://github.com/rancher/rancher/issues/32826) [Backport] Audit etcd backup logs
* [#32681](https://github.com/rancher/rancher/issues/32681) [Backport] Creating cluster with multiple nodes, some of the nodes remain in Active until the other nodes provision
* [#32154](https://github.com/rancher/rancher/issues/32154) Error while registering new clusters to Rancher (ClusterRoleBinding.rbac.authorization.k8s.io "globaladmin-u-tmzgkab7gh" is invalid: subjects[0].name: Required value )
* [#31999](https://github.com/rancher/rancher/issues/31999) After Rancher upgrade new clusters are up but the nodes will be stuck at "waiting to register"
* [#27306](https://github.com/rancher/rancher/issues/27306) Removing in-tree vSphere vCenter server entries does not propagate
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


## All issues in v2.5.8 milestone

* [#32538](https://github.com/rancher/rancher/issues/32538) Validate fleet and logging work after deploying wins_upgrader
* [#32530](https://github.com/rancher/rancher/issues/32530) [monitoring v2] Windows-exporter deploys on linux clusters when installing monitoring
* [#32522](https://github.com/rancher/rancher/issues/32522) Registration command for windows nodes is not available when edit cluster --> and select Edit as Yaml
* [#32521](https://github.com/rancher/rancher/issues/32521) Edit as Form/Yaml button seen in Custom cluster in the registration page
* [#32499](https://github.com/rancher/rancher/issues/32499) monitoring v2 fails too deploy after disabling monitoring v1 on a cluster
* [#32493](https://github.com/rancher/rancher/issues/32493) GKE V2 - No API error when adding second node pool with duplicate name
* [#32473](https://github.com/rancher/rancher/issues/32473) Better message to be displayed when a GKEv2 cluster is upgrading
* [#32467](https://github.com/rancher/rancher/issues/32467) No error displayed when no nodepool name is entered during an Edit of a GKEv2 cluster 
* [#32460](https://github.com/rancher/rancher/issues/32460) Drop old Logging v2 charts
* [#32447](https://github.com/rancher/rancher/issues/32447) Error when editing an RKE cluster as a cluster owner.
* [#32446](https://github.com/rancher/rancher/issues/32446) [GKE] Added cluster owner cannot edit cluster without providing cloud credential.
* [#32441](https://github.com/rancher/rancher/issues/32441) Added cluster owner for GKEv2 and EKSv2 clusters cannot make edits
* [#32439](https://github.com/rancher/rancher/issues/32439) Default Location type selected for GKEv2 is different for a hosted vs imported cluster
* [#32436](https://github.com/rancher/rancher/issues/32436) rancher-post-delete workload missing `/` in image, causes fail to pull image
* [#32435](https://github.com/rancher/rancher/issues/32435) GKEv2- NP labels not getting set
* [#32433](https://github.com/rancher/rancher/issues/32433) gkeV2- Labels field at cluster level, is missing 
* [#32430](https://github.com/rancher/rancher/issues/32430) gkev2UI- description field missing
* [#32428](https://github.com/rancher/rancher/issues/32428) v2 CIS Benchmark stuck when creating security-scan-runner pod after triggering a scan
* [#32409](https://github.com/rancher/rancher/issues/32409) [GKE] Rancher cannot connect to GKE cluster created using Terraform
* [#32404](https://github.com/rancher/rancher/issues/32404) [ui] Make message for custom cluster requiring all three roles more visible 
* [#32402](https://github.com/rancher/rancher/issues/32402) rancher/wins:v0.1.0 missing for the wins-upgrader chart in v2.5.8-rc10
* [#32369](https://github.com/rancher/rancher/issues/32369) Longhorn charts 1.1.1
* [#32360](https://github.com/rancher/rancher/issues/32360) Error seen - "Error 400: Current master version can only be set to one of "REGULAR" channel supported versions [1.18.16-gke.502, 1.18.16-gke.2100, 1.19.8-gke.1600]" on k8s upgrade of a GKEv2 cluster
* [#32359](https://github.com/rancher/rancher/issues/32359) Incorrect maxNodeCount and minNodeCount seen for an import GKEv2 cluster
* [#32357](https://github.com/rancher/rancher/issues/32357) [monitoring v2] grafana workloads dashboard shows memory in GiB, should be MiB
* [#32351](https://github.com/rancher/rancher/issues/32351) GKEv2UI: should not show Subnetwork Name as mandatory
* [#32350](https://github.com/rancher/rancher/issues/32350) Missing Images in rancher-images.txt on 2.5.8-rc10 when using image list for use with rancher HA AG setup
* [#32347](https://github.com/rancher/rancher/issues/32347) GKEv2UI: support for 1.20 k8s version 
* [#32346](https://github.com/rancher/rancher/issues/32346) GKEv2UI- will be nice to match Secondary CIDER Range names with that used in GCP
* [#32344](https://github.com/rancher/rancher/issues/32344) [Logging v2] - container miss security context after daemonset re-deploy from Rancher
* [#32339](https://github.com/rancher/rancher/issues/32339) All k8s versions for GKEv2 to be shown in dropdown for an edit cluster
* [#32328](https://github.com/rancher/rancher/issues/32328) [Logging v2] - dockerRootDirectory is applied to Linux workloads make possible to setup this for Windows nodes
* [#32323](https://github.com/rancher/rancher/issues/32323) rancher/mirrored-fluent-fluent-bit:1.6.10 missing in rancher-images.txt in v2.5.8-rc9
* [#32321](https://github.com/rancher/rancher/issues/32321) [monitoring v2] windows exporter fails to come up: json error on check-wins-version pod
* [#32320](https://github.com/rancher/rancher/issues/32320) [Logging v2] fails to install/upgrade to 3.9.400 on non-Windows clusters
* [#32318](https://github.com/rancher/rancher/issues/32318) New catalogs do not log `downloading` new charts
* [#32317](https://github.com/rancher/rancher/issues/32317) Fleet agents bundle on ErrApplied state after upgrade to `v2.5.8-rc9`
* [#32312](https://github.com/rancher/rancher/issues/32312) [GKE] Error when upgrading GKEv1 cluster to 1.19
* [#32303](https://github.com/rancher/rancher/issues/32303) GKEv2UI- for private clusters, we should make cluster registration command easily available  
* [#32298](https://github.com/rancher/rancher/issues/32298) Cannot import k3s v1.21
* [#32296](https://github.com/rancher/rancher/issues/32296) [rancher alerting drivers]  add links to the upstream examples
* [#32292](https://github.com/rancher/rancher/issues/32292) [GKE] Cannot get out of error when cluster is provisioned with the same name
* [#32290](https://github.com/rancher/rancher/issues/32290) Feature charts with Windows images do not have those included in rancher-windows-images.txt
* [#32286](https://github.com/rancher/rancher/issues/32286) ISTIO kiali graph for egress gateway are not displayed when workloads are created from dashboard
* [#32282](https://github.com/rancher/rancher/issues/32282) Enable "Auto upgrade" and "Auto repair" for imported GKE by default and add documentation
* [#32280](https://github.com/rancher/rancher/issues/32280) [rancher-wins-upgrader] rancher/wins image doesn't show up in air gapped setups
* [#32274](https://github.com/rancher/rancher/issues/32274) [Monitoring V2] Provide a way to prevent deploying Windows components on Windows clusters
* [#32265](https://github.com/rancher/rancher/issues/32265) rancher/windows_exporter-package missing from rancher-windows-images.txt
* [#32264](https://github.com/rancher/rancher/issues/32264) [Logging v2] Provide option to only collect Linux node logs on Windows Clusters
* [#32252](https://github.com/rancher/rancher/issues/32252) Istio after successful installation is not showing istio in the dropdown 
* [#32251](https://github.com/rancher/rancher/issues/32251) gkev2 UI- User should not be able to "disable Master authorized networks", if private endpoint is enabled
* [#32249](https://github.com/rancher/rancher/issues/32249) [rancher alerting drivers] Upgrading chart does not deploy configmap for newly selected provider
* [#32242](https://github.com/rancher/rancher/issues/32242) [UI] Import cluster doesn't show registration command after specifying additional environment variables
* [#32241](https://github.com/rancher/rancher/issues/32241) gkev2- setting enablePrivateEndpoint=false, results in enablePrivateEndpoint=true
* [#32225](https://github.com/rancher/rancher/issues/32225) [Monitoring v2] prometheus rules reset on upgrade
* [#32216](https://github.com/rancher/rancher/issues/32216) RKE Cluster gets Upgraded after upgrade from Rancher v2.4.8 
* [#32211](https://github.com/rancher/rancher/issues/32211) Unable to deploy v1 logging on hosted GKEv2 - log-aggregator unable to mkdir on read-only file system
* [#32207](https://github.com/rancher/rancher/issues/32207) "Services CIDR range is smaller than minimum (14 < 16)" error seen on GKEv2 cluster
* [#32201](https://github.com/rancher/rancher/issues/32201) [monitoring v2] can't install monitoring on hosted eks/gks/aks cluster
* [#32196](https://github.com/rancher/rancher/issues/32196) [GKE] Cannot switch cloud credentials for imported cluster
* [#32195](https://github.com/rancher/rancher/issues/32195) GKEv2UI- sets createSubnetwork to true for shared vpc
* [#32194](https://github.com/rancher/rancher/issues/32194) rancher-monitoring-windows-exporter fails to deploy on a windows cluster with win_prefix_path set
* [#32190](https://github.com/rancher/rancher/issues/32190) [GKE] Logging and monitoring are automatically enabled
* [#32184](https://github.com/rancher/rancher/issues/32184) Add Docker 20.10.6
* [#32176](https://github.com/rancher/rancher/issues/32176) [KEv2][UI] Node autoscaling is mislabeled
* [#32173](https://github.com/rancher/rancher/issues/32173) [v2.5] KDM release: k8s april patches
* [#32172](https://github.com/rancher/rancher/issues/32172) [GKE] Adding a node pool with the same name locks naming field
* [#32169](https://github.com/rancher/rancher/issues/32169) [GKE] Horizonatal Pod Autoscaling defaults to 0 nodes
* [#32167](https://github.com/rancher/rancher/issues/32167) [GKEv2] [UI] Cannot update image types in node pools independently
* [#32161](https://github.com/rancher/rancher/issues/32161) GKEv2UI- can have a better way to handle updates to a cluster with wrong parameters 
* [#32152](https://github.com/rancher/rancher/issues/32152) Not able to install rancher-backup chart
* [#32150](https://github.com/rancher/rancher/issues/32150) [GKE] Editing cluster during provisioning should not show register command
* [#32148](https://github.com/rancher/rancher/issues/32148) [GKE] Logging and monitoring cannot be set independently
* [#32146](https://github.com/rancher/rancher/issues/32146) [rancher/charts] Modify released/ directory to contain release-v2.5 + dev-v2.5 contents and drop old RCs
* [#32145](https://github.com/rancher/rancher/issues/32145) [monitoring v2] not installing correctly on RKE2 -- ingress-nginx not deploying
* [#32143](https://github.com/rancher/rancher/issues/32143) [GKE] Node pool k8s version does not change with the cluster k8s version during cluster create
* [#32141](https://github.com/rancher/rancher/issues/32141) GKEv2- cannot upgrade k8version of CP and NP at the same time
* [#32136](https://github.com/rancher/rancher/issues/32136) GKEv2UI - it will be nice if by default, Network and Subnet is set to default
* [#32135](https://github.com/rancher/rancher/issues/32135) gkev2 UI shows Kubernetes Version as Can't Downgrade even before saving a version
* [#32131](https://github.com/rancher/rancher/issues/32131) rancher-wins-upgrader app is available on Linux clusters
* [#32124](https://github.com/rancher/rancher/issues/32124) Unable to provision GKE cluster from Rancher UI on upgraded upstream cluster
* [#32116](https://github.com/rancher/rancher/issues/32116) Rancher pod restarts on 2.5.8-rc3 with ""chart-default-branch" already exists" and "secrets "tls-rancher-internal-ca" already exists"
* [#32112](https://github.com/rancher/rancher/issues/32112) Etcd logs are not being shipped over from RKE1 cluster to endpoint.
* [#32106](https://github.com/rancher/rancher/issues/32106) Change Network Provider Dropdown to indicate PNI is available for additional RKE CNIs
* [#32105](https://github.com/rancher/rancher/issues/32105) Duplicate crb seen on the server after upgrading from 2.4.15 to 2.5-head
* [#32102](https://github.com/rancher/rancher/issues/32102) GKEv2 UI should allow to select Node Pool's k8s version
* [#32101](https://github.com/rancher/rancher/issues/32101) [Monitoring V2] Set security.allow_embedding to true
* [#32098](https://github.com/rancher/rancher/issues/32098) GKEv2 UI should have Zonal Location type as default, instead of Regional
* [#32092](https://github.com/rancher/rancher/issues/32092) Workload test hits rate limit for Dockerhub
* [#32087](https://github.com/rancher/rancher/issues/32087) GKEv2 cluster in error state in GCE console, switches between Provisioning state and Error state in Rancher.
* [#32084](https://github.com/rancher/rancher/issues/32084) [log] View log repeat output
* [#32082](https://github.com/rancher/rancher/issues/32082) createSubnetwork is set to true by default when deploying a hosted GKEv2 cluster
* [#32081](https://github.com/rancher/rancher/issues/32081) system project pod restarts in a HA rancher server setup
* [#32068](https://github.com/rancher/rancher/issues/32068) GKE v2 UI, cannot Edit a registred cluster 
* [#32065](https://github.com/rancher/rancher/issues/32065) [GKE v2] Deleting registered clusters in Rancher may delete the cluster from GKE
* [#32060](https://github.com/rancher/rancher/issues/32060) GKEv2 UI, Doesn't show node pools for registered clusters
* [#32059](https://github.com/rancher/rancher/issues/32059) GKEv2 UI, shows old k8s version on Edit Cluster page when registering an existing GKE v2 cluster
* [#32058](https://github.com/rancher/rancher/issues/32058) Google Account Access requires Google Project Id, even though CC already contains Project ID
* [#32057](https://github.com/rancher/rancher/issues/32057) [EKS] Cannot change launch template version
* [#32046](https://github.com/rancher/rancher/issues/32046) servicesSecondaryRangeName and clusterSecondaryRangeName fields values are set during GKE v2 cluster creation
* [#32044](https://github.com/rancher/rancher/issues/32044) Not able to select a region other than the default for an Imported GKE v2 cluster
* [#32032](https://github.com/rancher/rancher/issues/32032) [GKE v2] Cluster Provisioning Fails with masterIpv4CidrBlock unset
* [#32031](https://github.com/rancher/rancher/issues/32031) [Cluster-Manager] No Access to Cluster Registration Command After Adding First Node
* [#32030](https://github.com/rancher/rancher/issues/32030) [gke v2] Update Translations Links to Private Custer Provisioning Docs
* [#32024](https://github.com/rancher/rancher/issues/32024) Monitoring v2 14.5.100-rcx fails to install with error "Error: configmaps "rancher-monitoring-etcd" already exists" 
* [#32021](https://github.com/rancher/rancher/issues/32021) [Logging v2] Collect RKE node logs on Windows
* [#32020](https://github.com/rancher/rancher/issues/32020) GKEv2 CC creation gets stuck on validation, when an invalid json used
* [#32016](https://github.com/rancher/rancher/issues/32016) Manifest unknown when pulling fluent-bit Windows image and missing from rancher-windows-images.txt
* [#32010](https://github.com/rancher/rancher/issues/32010) Back-off pulling image "rancher/library-nginx:1.19.9-alpine"
* [#32004](https://github.com/rancher/rancher/issues/32004) Wrong UI in EKS cluster edit
* [#32002](https://github.com/rancher/rancher/issues/32002) cluster goes into updating state after rancher upgrade
* [#31998](https://github.com/rancher/rancher/issues/31998) kubectl launch fails on a downstream cluster
* [#31995](https://github.com/rancher/rancher/issues/31995) Longhorn images not included in rancher-images.txt
* [#31994](https://github.com/rancher/rancher/issues/31994) [monitoring v2] windows monitoring-windows-exporter pods in crashloopback: failed to connect to proxy
* [#31993](https://github.com/rancher/rancher/issues/31993) [monitoring v2] windows rancher-monitoring-crd-create in crashloopback on clean install of 14.5.100-rcX
* [#31991](https://github.com/rancher/rancher/issues/31991) [monitoring v2] cannot install newest version 14.5.100-rcXX
* [#31990](https://github.com/rancher/rancher/issues/31990) Grafana graphs showing `value`, but should show instance
* [#31986](https://github.com/rancher/rancher/issues/31986) [GKE V2] Cluster stuck in updating state "Waiting for nodes"
* [#31983](https://github.com/rancher/rancher/issues/31983) Google cloud credential not available on v2.5
* [#31980](https://github.com/rancher/rancher/issues/31980) Can't launch machine in AWS ME region 
* [#31979](https://github.com/rancher/rancher/issues/31979) Update Kiali to 1.32.0
* [#31974](https://github.com/rancher/rancher/issues/31974) tag rancher webhook as non-alpha 
* [#31972](https://github.com/rancher/rancher/issues/31972) [monitoring v2] when PV template is used with grafana, upgrade should default to use the PVC already created from said tempate
* [#31958](https://github.com/rancher/rancher/issues/31958) "Unexpected end of JSON input" error seen when deploying a GKE v2 cluster through API
* [#31953](https://github.com/rancher/rancher/issues/31953) [monitoring v2] instance reported to prometheus is using pod IP, should use node IP
* [#31952](https://github.com/rancher/rancher/issues/31952) [GKE V2] Importing Cluster Fails with Duplicate Secret Message
* [#31950](https://github.com/rancher/rancher/issues/31950) EKS cluster cannot recover from error state
* [#31945](https://github.com/rancher/rancher/issues/31945) Validate v1 and v2 charts for SLES 15 SP1
* [#31942](https://github.com/rancher/rancher/issues/31942) [Monitoring V2] Use global.cattle.windows.enabled for windowsExporter
* [#31925](https://github.com/rancher/rancher/issues/31925) Logging v2 chart fails to deploy
* [#31923](https://github.com/rancher/rancher/issues/31923) Monitoring V2 on windows can't upgrade to include windowsExporter.enabled=true
* [#31921](https://github.com/rancher/rancher/issues/31921) [Monitoring V2] Persist dashboards for Rancher Cluster Overview in Grafana
* [#31920](https://github.com/rancher/rancher/issues/31920) [CIS Benchmark] CRD chart for 1.0.400 is missing
* [#31919](https://github.com/rancher/rancher/issues/31919) Can't deploy the v2 charts as cluster owner on an SELinux enabled cluster
* [#31909](https://github.com/rancher/rancher/issues/31909) Error after a k8s upgrade of the eksv2 cluster from EKS console
* [#31908](https://github.com/rancher/rancher/issues/31908) Instance type is set for a nodegroup when Spot instances is set in a launch template in eksv2
* [#31896](https://github.com/rancher/rancher/issues/31896) After creating a node group from EKS console, node group is not seen on cluster edit
* [#31895](https://github.com/rancher/rancher/issues/31895) GKE: private endpoints
* [#31888](https://github.com/rancher/rancher/issues/31888) Create Rancher SELinux RPM
* [#31887](https://github.com/rancher/rancher/issues/31887) Upgrade of v2 monitoring helm chart is failing on windows cluster
* [#31876](https://github.com/rancher/rancher/issues/31876) Given prefixPath of wins-upgrader is not considered
* [#31874](https://github.com/rancher/rancher/issues/31874) Auth redirect logic change
* [#31869](https://github.com/rancher/rancher/issues/31869) GKEv2 should support multi-arch
* [#31860](https://github.com/rancher/rancher/issues/31860) Docs hyperlink on Rancher UI points to Archived docs
* [#31858](https://github.com/rancher/rancher/issues/31858) Google node driver cluster creation option available
* [#31844](https://github.com/rancher/rancher/issues/31844) Uninstall and re-install, wins-upgrader with disabled masquerade all windows-exporter pods are failing
* [#31842](https://github.com/rancher/rancher/issues/31842) windows-exporter pods keep restarting until wins-upgrader is fully deployed on new 2.5.7 win node
* [#31839](https://github.com/rancher/rancher/issues/31839) Validate vSphere Out Of Tree on an RKE Local cluster
* [#31832](https://github.com/rancher/rancher/issues/31832) [Monitoring V2] Job label for windows-exporter should be windows-exporter, not kube-windows
* [#31831](https://github.com/rancher/rancher/issues/31831) [Monitoring V2] Remove PrometheusRules translating windows-exporter to node-exporter
* [#31827](https://github.com/rancher/rancher/issues/31827) windows_exporter upgrade fails on rancher/windows_exporter-package:v0.0.1 image already present
* [#31927](https://github.com/rancher/rancher/issues/31927) rancher-wins-upgrader chart offers new install instead of upgrade
* [#31811](https://github.com/rancher/rancher/issues/31811) Istio 1.7.8
* [#31789](https://github.com/rancher/rancher/issues/31789) Rewrite GKEv2 cluster refresher
* [#31784](https://github.com/rancher/rancher/issues/31784) unable to use kubectl, x509: certificate is valid for 127.0.0.1, 172.17.0.2, not rancher server ip errors
* [#31772](https://github.com/rancher/rancher/issues/31772) Node stuck in unavailable state but the node pool is seen deleted
* [#31770](https://github.com/rancher/rancher/issues/31770) Scale down does not delete the node from the backend - DO
* [#31769](https://github.com/rancher/rancher/issues/31769) [Monitoring V2] Non-Helm dashboards in cattle-dashboards get cleaned up on an uninstall
* [#31765](https://github.com/rancher/rancher/issues/31765) [2.5.7] Deleting a node pool does not delete all of the backend nodes
* [#31761](https://github.com/rancher/rancher/issues/31761) Istio 1.8.4
* [#31758](https://github.com/rancher/rancher/issues/31758) rancher-images.txt is missing ToolsSystemImages
* [#31750](https://github.com/rancher/rancher/issues/31750) GKE operator can have "Enable auto-upgrade" flag for Node Pools
* [#31742](https://github.com/rancher/rancher/issues/31742) Grafana graphs are not seen for Windows nodes
* [#31740](https://github.com/rancher/rancher/issues/31740) rancher-windows-exporter is available in feature charts for a windows cluster
* [#31733](https://github.com/rancher/rancher/issues/31733) [Forwardport]Private Registry authentication with no credentials fails 
* [#31732](https://github.com/rancher/rancher/issues/31732) Monitoring V2 Grafana root_url not specified
* [#31731](https://github.com/rancher/rancher/issues/31731) Logging v2 - rke logs not seen in Elasticsearch after upgrading to latest 3.9.x RC
* [#31729](https://github.com/rancher/rancher/issues/31729) Rancher/rancher-agent out of date (latest available release is v2.4.8)
* [#31726](https://github.com/rancher/rancher/issues/31726) Private registry not applied to all ACI network provider system images
* [#31845](https://github.com/rancher/rancher/issues/31845) Rename Aliyun to Alicloud in Node Driver
* [#31708](https://github.com/rancher/rancher/issues/31708) Bump EC2 AMI
* [#31704](https://github.com/rancher/rancher/issues/31704) gke operator throws error after cluster creation if k8s version is not provided
* [#31703](https://github.com/rancher/rancher/issues/31703) [cli] update CLI dependencies
* [#31678](https://github.com/rancher/rancher/issues/31678) GKE operator: Update proxy calls
* [#31667](https://github.com/rancher/rancher/issues/31667) use helm template to reduce the redundant label section in Rancher Helm chart
* [#31663](https://github.com/rancher/rancher/issues/31663) Generate an images sources text file
* [#31662](https://github.com/rancher/rancher/issues/31662) GKE Operator lets me create 2 clusters with the same subnetwork
* [#31644](https://github.com/rancher/rancher/issues/31644) Update logging chart to 3.9.4
* [#31635](https://github.com/rancher/rancher/issues/31635) "error while applying agent YAML for cluster" seen on a cluster edit when "agentEnvVars: []" 
* [#31617](https://github.com/rancher/rancher/issues/31617) Rancher deployed Fleet doesn't persist workspace changes
* [#31612](https://github.com/rancher/rancher/issues/31612) EKS Cluster Launch Failure - Invalid Base 64 User Encoding of user data.
* [#31608](https://github.com/rancher/rancher/issues/31608) Editing EKS cluster during provisioning will cause cluster to stay in provisioning state
* [#31607](https://github.com/rancher/rancher/issues/31607) [Monitoring V2] Add Rancher RoleTemplate with Project scope that links to monitoring-ui-view from chart
* [#31630](https://github.com/rancher/rancher/issues/31630) Support providing restricted permissions to Monitoring UIs for a non-System Project member via native K8s
* [#31594](https://github.com/rancher/rancher/issues/31594) New charts in v2.5.8
* [#31579](https://github.com/rancher/rancher/issues/31579) New charts in 2.5.7
* [#31550](https://github.com/rancher/rancher/issues/31550) vSphere CSI Chart - Out of tree cloud provider - Add an option to deploy `csi-resizer`
* [#31539](https://github.com/rancher/rancher/issues/31539) Add Docker 20.10.4/20.10.5
* [#31529](https://github.com/rancher/rancher/issues/31529) Custom Cluster edits do not update in registration command before clicking save
* [#31514](https://github.com/rancher/rancher/issues/31514) Warning: CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+
* [#31507](https://github.com/rancher/rancher/issues/31507) scaleDownTime set in future does not scale down the node
* [#31504](https://github.com/rancher/rancher/issues/31504) Add rancher-wins-upgrader on rancher/charts
* [#31503](https://github.com/rancher/rancher/issues/31503) Validate PostgreSQL 13.1 as a K3s backend
* [#31499](https://github.com/rancher/rancher/issues/31499) Update Windows bootstrapping to support wins v0.1.x
* [#31498](https://github.com/rancher/rancher/issues/31498) [Monitoring V2] Add Linux node-selectors / tolerations
* [#31497](https://github.com/rancher/rancher/issues/31497) [Monitoring V2] Add rancher-windows-exporter
* [#31493](https://github.com/rancher/rancher/issues/31493) Investigate how to setup and document Rancher integration with new PingFederate server
* [#31461](https://github.com/rancher/rancher/issues/31461) GKE v2 Provisioner: add Register Cluster option
* [#31431](https://github.com/rancher/rancher/issues/31431) Rancher "Error connecting to WebSocket" on login when using rke2 as local management cluster
* [#31430](https://github.com/rancher/rancher/issues/31430) [cli] Cannot add groups as project roles using CLI
* [#31422](https://github.com/rancher/rancher/issues/31422) agentEnvVars are being applied outside of the cluster they were added to
* [#31412](https://github.com/rancher/rancher/issues/31412) [Monitoring V2] Support Grafana Dashboards in multiple namespaces across cluster
* [#31411](https://github.com/rancher/rancher/issues/31411) [Monitoring V2] Create default Role for monitoring UI components + relevant Rancher RBAC pointing to it
* [#31404](https://github.com/rancher/rancher/issues/31404) [2.4.x 2.5.x] After the certificate expires, the certificate cannot be automatically updated
* [#31375](https://github.com/rancher/rancher/issues/31375) [rancherd] Bump RKE2 version - 1.20
* [#31346](https://github.com/rancher/rancher/issues/31346) Add GCP cloud credentials in UI
* [#31338](https://github.com/rancher/rancher/issues/31338) Project network isolation can be enabled if RKE network plugin supports network policies
* [#31311](https://github.com/rancher/rancher/issues/31311) [Epic]: Logging and Rancher SELinux RPM
* [#31309](https://github.com/rancher/rancher/issues/31309) Logging v2 aggregator should not write to the host for rke and rke2
* [#31286](https://github.com/rancher/rancher/issues/31286) ReplicaSets deployed by Argo don't show their pods
* [#31281](https://github.com/rancher/rancher/issues/31281) Add GKE to the resourceset for the rancher backup operator
* [#31265](https://github.com/rancher/rancher/issues/31265) Istio 1.9.2
* [#31264](https://github.com/rancher/rancher/issues/31264) Feature charts should have rancher min/max version
* [#31221](https://github.com/rancher/rancher/issues/31221) [UI][KEv2] UI for GKE v2 Provisioner
* [#31216](https://github.com/rancher/rancher/issues/31216) The default docker engine script 20.10.sh is not available in the drop down to select from
* [#31501](https://github.com/rancher/rancher/issues/31501) Switch rke2charts to using new charts build scripts
* [#31172](https://github.com/rancher/rancher/issues/31172) Unable to attach a persistent volume in vsphere in-tree cluster's workload in k8s 1.20
* [#31158](https://github.com/rancher/rancher/issues/31158) Validate Postgresql 12.5 as a K3s backend
* [#31148](https://github.com/rancher/rancher/issues/31148) [Monitoring] Fork wmi_exporter-package to windows_exporter-pkg
* [#31132](https://github.com/rancher/rancher/issues/31132) Rancher docker install scripts are not working anymore on RHEL 7.x
* [#31120](https://github.com/rancher/rancher/issues/31120) rancher-operator should not overwrite v3 cluster objects
* [#31110](https://github.com/rancher/rancher/issues/31110) GKE Provisioner: set number of pods per node
* [#31517](https://github.com/rancher/rancher/issues/31517) kev2: eks-operator arm64 support
* [#31055](https://github.com/rancher/rancher/issues/31055) [UI] Refer to docs for Windows Server versioning
* [#31043](https://github.com/rancher/rancher/issues/31043) EPIC: GKE Provisioner 
* [#31011](https://github.com/rancher/rancher/issues/31011) GKE Provisioner: Handler
* [#31010](https://github.com/rancher/rancher/issues/31010) GKE Provisioner: Sync
* [#31009](https://github.com/rancher/rancher/issues/31009) GKE Provisioner: Cloud Credentials
* [#31042](https://github.com/rancher/rancher/issues/31042) GKE Provisioner: Operator
* [#30981](https://github.com/rancher/rancher/issues/30981) Add GCP cloud credential option
* [#30977](https://github.com/rancher/rancher/issues/30977) Local k3s upgrade should not be allowed on single node install
* [#30949](https://github.com/rancher/rancher/issues/30949) Logging is not working on Selinux enabled setups
* [#30924](https://github.com/rancher/rancher/issues/30924) helm uninstall rancher leaves fleet, rancher operator, rancher webhook and helm operation remnants 
* [#30864](https://github.com/rancher/rancher/issues/30864) Google Cloud Platform UI to be able to work with Shared VPC
* [#30744](https://github.com/rancher/rancher/issues/30744) rancher-istio installation fails when clusters uses PodSecurityPolicies
* [#30735](https://github.com/rancher/rancher/issues/30735) Launching kubectl/shell for the cluster doesn't use a private registry for the image
* [#30608](https://github.com/rancher/rancher/issues/30608) Flannel Backend and Project Network Isolation input fields do NOT seem to have any value selected in Dark mode.
* [#30565](https://github.com/rancher/rancher/issues/30565) The number of etcd snapshots saved in GCS exceeds the retention of backup_config
* [#30471](https://github.com/rancher/rancher/issues/30471) Allow toleration customization of Fleet agent
* [#30427](https://github.com/rancher/rancher/issues/30427) RKE cluster can not be accessed via UI if cni is set to none
* [#30413](https://github.com/rancher/rancher/issues/30413) Am not getting relationship data back from api for Secrets & Configmaps
* [#30401](https://github.com/rancher/rancher/issues/30401) Can't select groups with Okta integration
* [#30383](https://github.com/rancher/rancher/issues/30383) [Logging v2] Handle log rotating kubelet logs in cloud providers GKE/AKS/EKS
* [#30306](https://github.com/rancher/rancher/issues/30306) ADFS Auth fails with Invalid SAML Attributes
* [#30211](https://github.com/rancher/rancher/issues/30211) CIS scan downstream cluster with project network isolation activated fails at 5.3.2 Hardended:
* [#30172](https://github.com/rancher/rancher/issues/30172) git-remote-http defunct processes from cluster-register_cattle-cluster-agent
* [#30234](https://github.com/rancher/rancher/issues/30234) Automate release Docker image digests using Drone plugin
* [#30135](https://github.com/rancher/rancher/issues/30135) User created network policies are deleted when disabling Network project isolation on the cluster
* [#29993](https://github.com/rancher/rancher/issues/29993) [Continuous Delivery] Fleet agent should work when running behind proxy
* [#29973](https://github.com/rancher/rancher/issues/29973) [rancher/charts] assumeOwnershipOfCRDs fails when the ConfigMap is too big
* [#29968](https://github.com/rancher/rancher/issues/29968) [Monitoring V2] Provide a way to send Rancher Proxy based external URLs
* [#29951](https://github.com/rancher/rancher/issues/29951) [Monitoring V2] Add rancher-alerting-drivers
* [#29932](https://github.com/rancher/rancher/issues/29932) Duplicate roleBindings being created
* [#29871](https://github.com/rancher/rancher/issues/29871) [Monitoring V2] Rebase rancher-monitoring to kube-prometheus-stack 14.x.x
* [#29821](https://github.com/rancher/rancher/issues/29821) Add validation for generated changes in ci script
* [#29666](https://github.com/rancher/rancher/issues/29666) Not able to edit cluster for AWS CN
* [#29247](https://github.com/rancher/rancher/issues/29247) Istio custom answers don't stay visible in UI and don't persist subsequent saves
* [#29234](https://github.com/rancher/rancher/issues/29234) Cluster monitoring link takes the user to a 503 ClusterUnavailable page when the cluster is still provisioning.
* [#28721](https://github.com/rancher/rancher/issues/28721) [Logging V2] Windows Support
* [#28527](https://github.com/rancher/rancher/issues/28527) GKE Service Account is not updated
* [#31451](https://github.com/rancher/rancher/issues/31451) [Monitoring V2] RFE: Ingress Controller Metrics
* [#28327](https://github.com/rancher/rancher/issues/28327) EPIC [Monitoring V2] RFE: Windows Node Metrics
* [#27696](https://github.com/rancher/rancher/issues/27696) GKE Cluster Provisioning - Secondary Range Name dropdowns do not update after changing Node Subnet
* [#27519](https://github.com/rancher/rancher/issues/27519) Panic in kube-apiserver when there are 10k secrets created in the cluster
* [#26668](https://github.com/rancher/rancher/issues/26668) Unable to enable external authentication when switching to new ADFS server
* [#26190](https://github.com/rancher/rancher/issues/26190) Coredns/metrics server pods are not getting evicted when a worker node is powered off
* [#25222](https://github.com/rancher/rancher/issues/25222) Include Windows image digests with releases
* [#23256](https://github.com/rancher/rancher/issues/23256) catalog refreshes constantly
* [#22093](https://github.com/rancher/rancher/issues/22093) Annotations on Rancher defined Pod Security Policies are not applied on Kubernetes cluster PSP
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


## All issues in v2.5.7 milestone

* [#31600](https://github.com/rancher/rancher/issues/31600) Using Private Registry without Authentication fails
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

## All issues in v2.5.6 milestone

* [#31583](https://github.com/rancher/rancher/issues/31583) XSS script execution vulnerability 
* [#31547](https://github.com/rancher/rancher/issues/31547) [UI] Unable to edit import cluster through UI
* [#31545](https://github.com/rancher/rancher/issues/31545) [UI] Unable to edit Environment Variables on imported k3s cluster
* [#31540](https://github.com/rancher/rancher/issues/31540) Can't delete istio after kiali is removed
* [#31532](https://github.com/rancher/rancher/issues/31532) Variable Name for agent Env variables is not marked mandatory which cause error while creating cluster
* [#31531](https://github.com/rancher/rancher/issues/31531) Secrets listed are incorrect in the UI on cluster create
* [#31528](https://github.com/rancher/rancher/issues/31528) custom cluster/node driver environment variable types other than key/value pairs should be disabled when creating a cluster
* [#31513](https://github.com/rancher/rancher/issues/31513) Can't uninstall istio when monitoring is not installed
* [#31505](https://github.com/rancher/rancher/issues/31505) [UI] show agent env vars on cluster page - Imported Clusters
* [#31484](https://github.com/rancher/rancher/issues/31484) Drain on delete node does not drain when the node has Pods with emptyDir volumes
* [#31467](https://github.com/rancher/rancher/issues/31467) View Edit/Yaml for workloads fails for a k8s 1.20 cluster
* [#31455](https://github.com/rancher/rancher/issues/31455) Drain on delete for nodes in Rancher provisioned clusters fails when node is running Pods with emptyDir volumes
* [#31452](https://github.com/rancher/rancher/issues/31452) Cannot access custom cluster's details page
* [#31435](https://github.com/rancher/rancher/issues/31435) Creating resources from YAML in a non-default namespace errors
* [#31434](https://github.com/rancher/rancher/issues/31434) exec shell on GKE cluster fails with 1006 error
* [#31427](https://github.com/rancher/rancher/issues/31427) Nodes stuck in Removing state after upgrade to 2.5.6-rc5
* [#31424](https://github.com/rancher/rancher/issues/31424) Scale down option should be greyed out if there is only 1 etcd node
* [#31421](https://github.com/rancher/rancher/issues/31421) [Monitoring V2] Missing Linux annotation in 9.4.203 rc versions
* [#31415](https://github.com/rancher/rancher/issues/31415) Cannot edit node volume size in hosted EKS
* [#31406](https://github.com/rancher/rancher/issues/31406) Global Role `Create RKE Templates` is broken 
* [#31405](https://github.com/rancher/rancher/issues/31405) [Fleet] - Windows 1809 SAC agent gets properly in sync with the fleet controller but bundles fail to install with the example webapp
* [#31394](https://github.com/rancher/rancher/issues/31394) Monitoring v1 - v0.2.1 failed to install on an airgap setup 
* [#31393](https://github.com/rancher/rancher/issues/31393) [Fleet] - Windows 2004 issues
* [#31372](https://github.com/rancher/rancher/issues/31372) [Logging v2] RKE2 additional logging enabled fails to install
* [#31370](https://github.com/rancher/rancher/issues/31370) Extend agentEnvVars support to rancher agents across all cluster types, including the node run command for cluster and node driver clusters
* [#31367](https://github.com/rancher/rancher/issues/31367) View/Edit Yaml does not work for a k8s 1.20 cluster
* [#31365](https://github.com/rancher/rancher/issues/31365) Alerting v1 not triggering/sending notifications on 2.5-head
* [#31364](https://github.com/rancher/rancher/issues/31364) Get "Cannot validate kube version for template" when trying to create a cluster with v0.2.0 monitoring
* [#31361](https://github.com/rancher/rancher/issues/31361) [EKSv2] Disk size creates another disk instead of increasing root disk size
* [#31343](https://github.com/rancher/rancher/issues/31343) UI: Needs to hide the benchmark version rke-cis-1.6 and onwards for CIS v1 
* [#31342](https://github.com/rancher/rancher/issues/31342) saving agentEnvVars through v3 api only saves schema type Error: Invalid Value: spec.template.spec.containers[0].env
* [#31341](https://github.com/rancher/rancher/issues/31341) EKS V2 - Rename Image Input
* [#31340](https://github.com/rancher/rancher/issues/31340) Enhancement: remove unsupported 1.13 Docker version from Docker Install URL list
* [#31337](https://github.com/rancher/rancher/issues/31337) monitoring v1 does not work on windows server 20h2 and 2004
* [#31322](https://github.com/rancher/rancher/issues/31322) Issue with Spot instance type field in the UI
* [#31321](https://github.com/rancher/rancher/issues/31321) imageID, userdata values from pre existing AWS Launch templates do not sync back to Rancher
* [#31316](https://github.com/rancher/rancher/issues/31316) cattle-node-agent-windows on Windows cloud provider enabled setup fails to come up
* [#31308](https://github.com/rancher/rancher/issues/31308) nodepool drain before delete checkbox ui
* [#31305](https://github.com/rancher/rancher/issues/31305) [Monitoring V1] Support k8s 1.20 (exporter-kubelets-cluster-monitoring is down)
* [#31304](https://github.com/rancher/rancher/issues/31304) [Monitoring V2] Support k8s 1.20 (rancher-monitoring-kubelet is down)
* [#31292](https://github.com/rancher/rancher/issues/31292) User data field in EKS v2 cluster creation is not scrollable 
* [#31288](https://github.com/rancher/rancher/issues/31288) Additional spot instance types disappear on cluster create
* [#31287](https://github.com/rancher/rancher/issues/31287) SAML Ping Auth - Add a field to accept Entity ID
* [#31285](https://github.com/rancher/rancher/issues/31285) During creating node template in vSphere  the tag/attributes are not available to select from. 
* [#31284](https://github.com/rancher/rancher/issues/31284) Docker install scripts are not working for v17.06 and below
* [#31279](https://github.com/rancher/rancher/issues/31279) Launch template selection locked after selecting preexisting template
* [#31277](https://github.com/rancher/rancher/issues/31277) User data is not synced with preexisting launch template
* [#31275](https://github.com/rancher/rancher/issues/31275) cattle-node-agent-windows for Windows 2004 fails to come up using k8s 1.20
* [#31269](https://github.com/rancher/rancher/issues/31269) Cluster repo - failed to clone a private git repo with ssh key
* [#31263](https://github.com/rancher/rancher/issues/31263) [EKSv2] Clean up launch template versions on error
* [#31258](https://github.com/rancher/rancher/issues/31258) Rancher UI freezes when posting any edit to cluster through v3 api
* [#31257](https://github.com/rancher/rancher/issues/31257) Fleet, rancher webhook and rancher operator helm pods fail to deploy
* [#31252](https://github.com/rancher/rancher/issues/31252) Cluster import yaml has incorrect document break end of file
* [#31244](https://github.com/rancher/rancher/issues/31244) cattle-cluster-agent fails to become ready without a worker role/node present due to coredns dependency
* [#31242](https://github.com/rancher/rancher/issues/31242) Custom cluster with Scheduled CIS scan enabled creation fails at 2.5.6-rc4
* [#31236](https://github.com/rancher/rancher/issues/31236) RKE network config is not correctly applied when creating custom cluster
* [#31232](https://github.com/rancher/rancher/issues/31232) Cluster provisioning is failing error "Error while applying agent YAML, it will be retried automatically: exit status 1"
* [#31230](https://github.com/rancher/rancher/issues/31230) [UI] Fix DNS options YAML/JSON conversion on cluster creation
* [#31222](https://github.com/rancher/rancher/issues/31222) [v2.5] KDM release: k8s feb patches
* [#31213](https://github.com/rancher/rancher/issues/31213) [EKSv2] Make spot instance types more obvious
* [#31205](https://github.com/rancher/rancher/issues/31205) Incorrect Launch Template name shown on an EKS v2 cluster in an upgraded rancher setup
* [#31204](https://github.com/rancher/rancher/issues/31204) OPA Gatekeeper - Update to v3.3.0
* [#31203](https://github.com/rancher/rancher/issues/31203) OPA Gatekeeper - Remove experimental tag
* [#31197](https://github.com/rancher/rancher/issues/31197) No scroll bar in EKS User Data field
* [#31194](https://github.com/rancher/rancher/issues/31194) Unable to use spot instances in EKS clusters
* [#31191](https://github.com/rancher/rancher/issues/31191) Unable to use EKS launch template with empty fields
* [#31190](https://github.com/rancher/rancher/issues/31190) EKS Launch Template fields editable when using preexisting launch template
* [#31187](https://github.com/rancher/rancher/issues/31187) Istio 1.8.3
* [#31170](https://github.com/rancher/rancher/issues/31170) Import EKS v2 cluster is stuck in Waiting state with message "Cluster must have at least one managed nodegroup."
* [#31168](https://github.com/rancher/rancher/issues/31168) Cluster goes into Updating state when no action is performed on the cluster
* [#31167](https://github.com/rancher/rancher/issues/31167) Monitoring V1/V2 targets rancher-monitoring-kubelet/exporter-kubelets-cluster-monitoring are down on OL 8.3
* [#31162](https://github.com/rancher/rancher/issues/31162) [UI] vSphere cluster provisioning
* [#31152](https://github.com/rancher/rancher/issues/31152) monitoring v1 does not work on windows 2004 and 20h2
* [#31151](https://github.com/rancher/rancher/issues/31151) Unable to deploy DO/Linode cluster with docker 20.10.x
* [#31149](https://github.com/rancher/rancher/issues/31149) Logging V1 'edit as file' -> `dry run` option resets file entry to default
* [#31147](https://github.com/rancher/rancher/issues/31147) GPU instances not set in hosted EKS
* [#31146](https://github.com/rancher/rancher/issues/31146) EKS v2 launch template version shown on the UI is incorrect
* [#31144](https://github.com/rancher/rancher/issues/31144) nonexistent tag used in image pull: rancher/fluentd:v0.1.24 -- Logging v1
* [#31137](https://github.com/rancher/rancher/issues/31137) unable to install default chart option for rancher-backups and cis-benchmark RC00 
* [#31129](https://github.com/rancher/rancher/issues/31129) rke-network-plugin-deploy-job fails to deploy after k8s upgrade to 1.20.2-rancher2-1
* [#31126](https://github.com/rancher/rancher/issues/31126) Fail to deploy a downstream cluster
* [#31107](https://github.com/rancher/rancher/issues/31107) Feature-Chart Branching Swap in 2.5.6
* [#31103](https://github.com/rancher/rancher/issues/31103) Istio 1.8.3
* [#31099](https://github.com/rancher/rancher/issues/31099) [rancher-logging] Missing ability to configure resource settings for fluentd statefulset
* [#31098](https://github.com/rancher/rancher/issues/31098) Validate Windows 2004 SAC
* [#31097](https://github.com/rancher/rancher/issues/31097) Validate Ubuntu 20.04 with docker 20.10.2
* [#31096](https://github.com/rancher/rancher/issues/31096) Validate SLES 15SP2 with docker 20.10.x
* [#31095](https://github.com/rancher/rancher/issues/31095) Validate RancherOS 1.5.7 with Docker 20.10.2
* [#31094](https://github.com/rancher/rancher/issues/31094) Validate Oracle Linux 8.3 with Docker 20.10.x
* [#31093](https://github.com/rancher/rancher/issues/31093) Validate CentOS 8.3 with Docker 20.10.x
* [#31087](https://github.com/rancher/rancher/issues/31087) EKS - Error Field [subnets] cannot be nil for nodegroup [xxx-xx] in non-nil cluster [c-xxxxx]
* [#31082](https://github.com/rancher/rancher/issues/31082) Run Conformance Testing for k8s 1.20
* [#31081](https://github.com/rancher/rancher/issues/31081) Panic seen intermittently while logging in with SAML
* [#31078](https://github.com/rancher/rancher/issues/31078) "nodegroupName cannot be an empty" Error seen while creating an EKS v2 cluster
* [#31077](https://github.com/rancher/rancher/issues/31077) No warning when a use selects a launch template which specifies instance type and enables spot instance
* [#31064](https://github.com/rancher/rancher/issues/31064) Launch template values persist when switched between different Launch templates in EKS v2
* [#31063](https://github.com/rancher/rancher/issues/31063) Add nodegroup during an edit EKS v2 cluster, does not let user select a Launch template
* [#31062](https://github.com/rancher/rancher/issues/31062) Ensure eks-operator doesn't auto-upgrade without rancher-upgrade
* [#31061](https://github.com/rancher/rancher/issues/31061) Includes k3s upgrade images when uses image export script in dev, master, or non semver tag that is equal to kd.RancherVersionDev
* [#31049](https://github.com/rancher/rancher/issues/31049) Instance type field should not be available when Spot instances are used in EKS v2
* [#31048](https://github.com/rancher/rancher/issues/31048) Not able to create a hosted EKS cluster
* [#31046](https://github.com/rancher/rancher/issues/31046) Istio dashboard - kiali and jaeger should not be active after disabling in v2 charts
* [#31033](https://github.com/rancher/rancher/issues/31033) User is not able to edit userData on an EKS cluster edit
* [#31032](https://github.com/rancher/rancher/issues/31032) [EKSv2] Add help text for custom AMI box
* [#31029](https://github.com/rancher/rancher/issues/31029) EKS v2 cluster fails to come up when using a Rancher Managed Launch Template
* [#31023](https://github.com/rancher/rancher/issues/31023) [UI] show agent env vars on cluster page 
* [#31013](https://github.com/rancher/rancher/issues/31013) Edit cluster of a hosted EKS shows commands for importing a cluster
* [#31012](https://github.com/rancher/rancher/issues/31012) On Rhel8.2 hitting lstio init fail error during deploying a bookservice in lstio,
* [#31008](https://github.com/rancher/rancher/issues/31008) User is not able to add a nodegroup in EKS
* [#31007](https://github.com/rancher/rancher/issues/31007) EKS provisioning errors with: [resourceTags] cannot be nil
* [#31006](https://github.com/rancher/rancher/issues/31006) [Logging v2] - Chart version 3.9.000-rc01 fails to install with invalid metadata error
* [#30997](https://github.com/rancher/rancher/issues/30997) Add helm notation to CRD generation in eks-operator
* [#30995](https://github.com/rancher/rancher/issues/30995) Unable to provision custom cluster while provider cluster is provisioning
* [#30988](https://github.com/rancher/rancher/issues/30988) Cannot set win_prefix_path in a windows cluster
* [#30966](https://github.com/rancher/rancher/issues/30966) [Forwardport] Windows nodes fail to create the RKE log directory if the prefixPath is not set on a Windows cluster 
* [#30964](https://github.com/rancher/rancher/issues/30964) [Forwardport] Istio sidecar injection - workload deployment failed with error in sidecar injector
* [#31184](https://github.com/rancher/rancher/issues/31184) Error when switching from "Edit as File" and back to "Edit as Form" in v1 Logging
* [#30938](https://github.com/rancher/rancher/issues/30938) Uninstall monitoring sometimes delete "rancher-monitoring-crd" before "rancher-monitoring" which cause an error.
* [#30935](https://github.com/rancher/rancher/issues/30935) Downstream cluster using Oracle Linux 8.2 fails health check and is in Error state
* [#30934](https://github.com/rancher/rancher/issues/30934) Add minFleetVersion to rancher
* [#30932](https://github.com/rancher/rancher/issues/30932) Verify postgreSQL as a k3s backend
* [#30930](https://github.com/rancher/rancher/issues/30930) [v2.5.5] CA certificate box not active in OpenLDAP StartTLS authentication page
* [#30920](https://github.com/rancher/rancher/issues/30920) "Add Host" Action for an import cluster
* [#30917](https://github.com/rancher/rancher/issues/30917) [Logging v2] Add logging upstream 3.9.0 chart
* [#30904](https://github.com/rancher/rancher/issues/30904) Incorrect info message is seen while "Adding hosts" to an import cluster 
* [#30903](https://github.com/rancher/rancher/issues/30903) Incorrect node roles selected on the UI for a windows node registration command
* [#30901](https://github.com/rancher/rancher/issues/30901) Feature chart links to components fails to load using custom CIDR in the cluster.
* [#30900](https://github.com/rancher/rancher/issues/30900) Validate v1 and v2 charts for RHEL 8.2
* [#30899](https://github.com/rancher/rancher/issues/30899) Validate v1 and v2 charts for Oracle linux 8.2
* [#30895](https://github.com/rancher/rancher/issues/30895) [UI] Add option in node template to skip Docker installation
* [#30892](https://github.com/rancher/rancher/issues/30892) Validate v1 and v2 charts for SLES 15 SP2
* [#30888](https://github.com/rancher/rancher/issues/30888) New charts in 2.5.6
* [#30887](https://github.com/rancher/rancher/issues/30887) Validate v1 and v2 charts for  RHEL 7.9
* [#30869](https://github.com/rancher/rancher/issues/30869) Can not login as a standard user (who is part of 1000 groups) with AD auth without trying many times. 
* [#30846](https://github.com/rancher/rancher/issues/30846) cattle-cluster-agent behind proxy: can't add Chart Repository
* [#30840](https://github.com/rancher/rancher/issues/30840) Cisco ACI (noiro) images exist in rancher-images.txt release artifact
* [#30828](https://github.com/rancher/rancher/issues/30828) [2.5] k8s 1.20
* [#30809](https://github.com/rancher/rancher/issues/30809) Logging v2 - Error installing rancher logging chart in v2.5-head for RKE clusters
* [#30808](https://github.com/rancher/rancher/issues/30808) [Logging v1] Add Windows 2004 and 20H2 to logging
* [#30792](https://github.com/rancher/rancher/issues/30792) [Continuous Delivery] Adding Git repository fails when path contains uppercase characters
* [#30781](https://github.com/rancher/rancher/issues/30781) New Nodes Are Incomplete, Unable to Delete - Rancher 2.5.4 - RKE Custom - Baremetal
* [#30771](https://github.com/rancher/rancher/issues/30771) rancher-logging installation fails when clusters uses PodSecurityPolicies
* [#30752](https://github.com/rancher/rancher/issues/30752) Kiali unable to acquire traces
* [#30750](https://github.com/rancher/rancher/issues/30750) [Logging v2] Add logging upstream 3.8.4 chart
* [#30717](https://github.com/rancher/rancher/issues/30717) Provisioning fails with node template and SLES15 AMI
* [#30712](https://github.com/rancher/rancher/issues/30712) [Monitoring v2] failed to install when Prometheus is disabled
* [#30710](https://github.com/rancher/rancher/issues/30710) Panic serving api request during Okta authentication integration
* [#30707](https://github.com/rancher/rancher/issues/30707) Fleet and webhook do not come back to older version after a backup restore from 2.5.4-rc to 2.5.3
* [#30701](https://github.com/rancher/rancher/issues/30701) [v2.5] Windows 20H2 Builds
* [#30700](https://github.com/rancher/rancher/issues/30700) [v2.5] Additional flag to encrypt all ebs volumes associated with ami
* [#30696](https://github.com/rancher/rancher/issues/30696) [Continous Delivery] GitRepo and cluster stuck in Modified state indefinitely
* [#30690](https://github.com/rancher/rancher/issues/30690) During edit of a vSphere node template some fields don't get populated with the previously set values
* [#30684](https://github.com/rancher/rancher/issues/30684) [Monitoring V2] Warn if cluster does not have minimum CPU / memory limits to deploy chart
* [#30680](https://github.com/rancher/rancher/issues/30680) [Monitoring v2] Show metrics from nodes where etcd runs on the Nodes dashboard in Grafana
* [#30666](https://github.com/rancher/rancher/issues/30666) default-token secrets created and deleted when encryption is enabled/disabled on a cluster
* [#30663](https://github.com/rancher/rancher/issues/30663) Make etcd snapshot job timeout tunable
* [#30629](https://github.com/rancher/rancher/issues/30629) When rotate encryption is in progress or when a cluster is in "Updating" state, user is able to perform rotateEncryptionKey action from the API
* [#30613](https://github.com/rancher/rancher/issues/30613) Launch template support in Rancher UI
* [#30606](https://github.com/rancher/rancher/issues/30606) forwardport: Removing in-tree vSphere vCenter server entries does not propagate
* [#30605](https://github.com/rancher/rancher/issues/30605) forwardport: Cluster Private Registry setting not adhered to when pulling rancher-agent image during Node Driver cluster provisioning
* [#30604](https://github.com/rancher/rancher/issues/30604) forward port: Rancher Istio chart injection-template is behind Istio master
* [#30602](https://github.com/rancher/rancher/issues/30602) forwardport: registry for workload cluster - let RancherUI freeze
* [#30601](https://github.com/rancher/rancher/issues/30601) forward port: Node template values not changing while switching cloud credentials for vSphere 
* [#30595](https://github.com/rancher/rancher/issues/30595) [Logging v2] Parser and tail-db paths are not always accessible on RKE fluent-bit
* [#30594](https://github.com/rancher/rancher/issues/30594) [Catalog v2] can not change the url or branch of the builtin catalog `Rancher`
* [#30582](https://github.com/rancher/rancher/issues/30582) Default to IfNotPresent for the rancher-audit-log container
* [#30560](https://github.com/rancher/rancher/issues/30560) Secrets encryption are not set by the UI when attempting to enable after a cluster is created throught he API
* [#30558](https://github.com/rancher/rancher/issues/30558) No default values set for secretsEncryptionConfig in a cluster created from API
* [#30556](https://github.com/rancher/rancher/issues/30556) On the Cluster Explorer View State of Deployments is shown as unknown for k8s 1.20 clusters
* [#30535](https://github.com/rancher/rancher/issues/30535) Allow Helm installation without ingress 
* [#30526](https://github.com/rancher/rancher/issues/30526) Deleted nodes showing up in rancher UI with delete option disabled
* [#30523](https://github.com/rancher/rancher/issues/30523) Differentiate the "docker run" cluster driver type in telemetry
* [#30516](https://github.com/rancher/rancher/issues/30516) [Fleet] Ensure Windows clusters run agents
* [#30506](https://github.com/rancher/rancher/issues/30506) Location column is incorrect in node template 
* [#30502](https://github.com/rancher/rancher/issues/30502) helm3-library charts are not bundled with system charts
* [#30492](https://github.com/rancher/rancher/issues/30492) [rancherd] Bump RKE2 version - 1.18.16
* [#30499](https://github.com/rancher/rancher/issues/30499) favicon is missing on explorer
* [#30470](https://github.com/rancher/rancher/issues/30470) Update Kiali to 1.29.0
* [#30425](https://github.com/rancher/rancher/issues/30425) V1 Logging on recently upgraded/created AKS clusters fails with "Connection reset by peer"
* [#30410](https://github.com/rancher/rancher/issues/30410) Istio 1.8.x
* [#30406](https://github.com/rancher/rancher/issues/30406) Validate Docker 20.10.x
* [#30402](https://github.com/rancher/rancher/issues/30402) Rancher 2.5 Shell size (columns) limited to 80 
* [#30386](https://github.com/rancher/rancher/issues/30386) [UI] In k8s v1.20 "delete local data" for drain has been renamed to "delete empty dir data."
* [#30329](https://github.com/rancher/rancher/issues/30329) [Logging v2] Docker Root Dir not exposed for Rancher 2.5.2 logging
* [#30315](https://github.com/rancher/rancher/issues/30315) rancher-logging-fluentd-windows workload fails to come up in a windows cluster
* [#30300](https://github.com/rancher/rancher/issues/30300) CIS 1.5 v1 permissive scan fails on a flatcar linux machine cluster
* [#30299](https://github.com/rancher/rancher/issues/30299) Validate flatcar-linux-stable-2605.6.0
* [#30277](https://github.com/rancher/rancher/issues/30277) Can not create secrets with dot in the name using Rancher UI.
* [#30191](https://github.com/rancher/rancher/issues/30191) Prometheus fails with cluster_domain other then cluster.local: proxyconnect tcp: dial tcp: lookup pushprox-kube-controller-manager-proxy.cattle-monitoring-system.svc.cluster.local  no such host
* [#30168](https://github.com/rancher/rancher/issues/30168) ETCD high traffic, RAM + timeouts after migration to 2.5.2 
* [#30144](https://github.com/rancher/rancher/issues/30144) Istio chart should set minimum cpu/memory request
* [#30136](https://github.com/rancher/rancher/issues/30136) Cluster monitoring in Error state after 2.5.2 upgrade
* [#30134](https://github.com/rancher/rancher/issues/30134) Support k8s 1.20
* [#30068](https://github.com/rancher/rancher/issues/30068) Installing Helm chart from Azure Blob Storage repository fails
* [#30049](https://github.com/rancher/rancher/issues/30049) Cluster stuck "currently Upgrading, updating worker node" on Cordoned workers
* [#30047](https://github.com/rancher/rancher/issues/30047) Set PriorityClass for kube-flannel, kube-dns, kube-dns-autoscaler, metrics-server to system-node-critical
* [#30043](https://github.com/rancher/rancher/issues/30043) ClusterRoleBinding is deprecated warning when importing a k3s 1.19.3 cluster
* [#30041](https://github.com/rancher/rancher/issues/30041) [EKSv2]: no nodegroup message is confusing
* [#30021](https://github.com/rancher/rancher/issues/30021) Update EKSClusterConfig syncing to include launch template information
* [#30020](https://github.com/rancher/rancher/issues/30020) Use launch template provided by user
* [#30019](https://github.com/rancher/rancher/issues/30019) Create/Update launch templates for EKS managed node groups
* [#29961](https://github.com/rancher/rancher/issues/29961) Public Helm Repo's (marketplace) not pulled in anymore due to proxy issues.
* [#29926](https://github.com/rancher/rancher/issues/29926) Failed to find system chart fleet-crd will try again in 5 seconds: configmaps "rancher-charts-plx5s" not found
* [#29812](https://github.com/rancher/rancher/issues/29812) Istio 1.7.6
* [#29784](https://github.com/rancher/rancher/issues/29784) Support mounting certs on fluentd
* [#29724](https://github.com/rancher/rancher/issues/29724) OKE Cluster driver: Add support for specifying a custom boot volume size on nodes
* [#29700](https://github.com/rancher/rancher/issues/29700) Deployment fails when namespace has istio-injection=enabled
* [#29676](https://github.com/rancher/rancher/issues/29676) [2.5] u.replaceWith is not a function
* [#29633](https://github.com/rancher/rancher/issues/29633) deployments.apps "cattle-cluster-agent" not found ... dial tcp 127.0.0.1:6080: connect: connection refused seen after provisioning cluster
* [#30291](https://github.com/rancher/rancher/issues/30291) Switch to using the upstream saml library directly instead of rancher's fork of it
* [#29328](https://github.com/rancher/rancher/issues/29328) v1 monitoring chart does not deploy on local k3 cluster.
* [#29648](https://github.com/rancher/rancher/issues/29648) Lock down feature chart's release branch
* [#29286](https://github.com/rancher/rancher/issues/29286) Error detecting OS: Too many retries waiting for SSH to be available when creating a cluster on vSphere behind NAT
* [#29176](https://github.com/rancher/rancher/issues/29176) Monitoring - uninstall the monitoring v2 app causes cattle-cluster-agent restarts 
* [#29168](https://github.com/rancher/rancher/issues/29168) [Logging V2] Update user roles
* [#29124](https://github.com/rancher/rancher/issues/29124) OKE Cluster driver: Add support for flexible compute shapes such as VM.Standard.E3
* [#28836](https://github.com/rancher/rancher/issues/28836) "Cluster health check failed: cluster agent is not ready" error seen during cluster provisioning after which it proceeds to succeed.
* [#28803](https://github.com/rancher/rancher/issues/28803) [feature] Launch template support
* [#28788](https://github.com/rancher/rancher/issues/28788) Docs hyperlink opens page in the same window as rancher
* [#28730](https://github.com/rancher/rancher/issues/28730) Rewrite charts build scripts
* [#28673](https://github.com/rancher/rancher/issues/28673) k8s 1.19 removes basic auth but it's in use by kontainer-engine
* [#28664](https://github.com/rancher/rancher/issues/28664) [Logging v2] - rancher-logging logging operator fails to deploy on Windows cluster
* [#28360](https://github.com/rancher/rancher/issues/28360) Sporadic driver error during K8s upgrade: listen tcp 127.0.0.1:0: bind: address already in use
* [#27946](https://github.com/rancher/rancher/issues/27946) Monitoring v2 - Service for Prometheus is broken 
* [#27911](https://github.com/rancher/rancher/issues/27911) Monitoring does not work for Windows Server Core worker nodes
* [#27873](https://github.com/rancher/rancher/issues/27873) Rancher v2.4.5 UI display name for nodes incorrect when nodes in a single cluster have FQDN hostnames under multiple different subdomains
* [#27870](https://github.com/rancher/rancher/issues/27870) Enabling telemetry causing multiple issues due to socket leak
* [#27646](https://github.com/rancher/rancher/issues/27646) Ability to prevent `yum -y update` execution during node driver provisioning of RHEL/CentOS hosts
* [#27458](https://github.com/rancher/rancher/issues/27458) Add [aggressive] drain on delete option in node delete form and node pool configuration
* [#27451](https://github.com/rancher/rancher/issues/27451) Add Windows 2004 agent build
* [#27165](https://github.com/rancher/rancher/issues/27165) [UI Bug] CA Cert field text area is too wide.
* [#26396](https://github.com/rancher/rancher/issues/26396) Bunch of CIS Failures for /etc/kubernetes on RancherOS
* [#25412](https://github.com/rancher/rancher/issues/25412) Rancher re-applys cluster import yaml, causing loss of env vars set in original import yaml
* [#25346](https://github.com/rancher/rancher/issues/25346) UI for RHEL 8 Support with Docker CE
* [#24876](https://github.com/rancher/rancher/issues/24876) Rancher agent  does not use proxy environment in callback to  rancher
* [#23357](https://github.com/rancher/rancher/issues/23357) Support for out-of-tree vSphere Cloud Provider Interface (CPI) and Cloud Storage Interface (CSI)
* [#22871](https://github.com/rancher/rancher/issues/22871) Choose which node to delete when scaling down
* [#20131](https://github.com/rancher/rancher/issues/20131) Better UX for External Cloud provider vSphere
* [#15172](https://github.com/rancher/rancher/issues/15172) Rancher returns 404 from agent when cluster is not built by RKE
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


## All issues in v2.5.5 milestone

* [#30766](https://github.com/rancher/rancher/issues/30766) Fail to upgrade rancher to 2.5.5
* [#30745](https://github.com/rancher/rancher/issues/30745) Update Rancher server helm chart to limit k8s versions based on support matrix
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


## All issues in v2.5.4 milestone

* [#30652](https://github.com/rancher/rancher/issues/30652) CPU, load, and memory increase after upgrading from v2.5.3 to v2.5.4-rc8
* [#30598](https://github.com/rancher/rancher/issues/30598) v2 Istio - Combine 1.7.301 & 1.7.302 charts
* [#30568](https://github.com/rancher/rancher/issues/30568) Update logging v1 to 0.2.3
* [#30555](https://github.com/rancher/rancher/issues/30555) [ui] Edit as yaml not respecting case of keys
* [#30553](https://github.com/rancher/rancher/issues/30553) Last backup is not shown on encryption key rotation
* [#30552](https://github.com/rancher/rancher/issues/30552) Rotate encryption not shown in dropdown
* [#30542](https://github.com/rancher/rancher/issues/30542) Add annotation to all old feature charts
* [#30541](https://github.com/rancher/rancher/issues/30541) Throttling seen when secrets are encrypted
* [#30537](https://github.com/rancher/rancher/issues/30537) [Monitoring v1] 0.2.0 cannot be installed into the local cluster in Rancher HA setup 
* [#30531](https://github.com/rancher/rancher/issues/30531) Number of secrets rewritten during encryption process is seen incorrect
* [#30518](https://github.com/rancher/rancher/issues/30518) Launching eks v2 using 1.14 gives error "unsupported Kubernetes version" 
* [#30507](https://github.com/rancher/rancher/issues/30507) [Monitoring V1] [Istio V1] hide the old version in Rancher v2.5.4
* [#30503](https://github.com/rancher/rancher/issues/30503) Fleet - fleet is not getting the latest chart version after upgrade Rancher to 2.5.4-rc5
* [#30501](https://github.com/rancher/rancher/issues/30501) Rancherd initial password login failure
* [#30496](https://github.com/rancher/rancher/issues/30496) Images missing from release artificat images.txt
* [#30476](https://github.com/rancher/rancher/issues/30476) [Rancher] New Longhorn chart for 2.5.4
* [#30455](https://github.com/rancher/rancher/issues/30455) [Monitoring V1] can not upgrade from 0.1.4 to v0.2.0
* [#30453](https://github.com/rancher/rancher/issues/30453) [Monitoring V1] v0.2.0 should not show on 1.15 cluster and rancher v2.5.3
* [#30452](https://github.com/rancher/rancher/issues/30452) "rejected by webhook" warnings messages seen in rancher logs
* [#30450](https://github.com/rancher/rancher/issues/30450) Add catalog.cattle.io/os=linux
* [#30447](https://github.com/rancher/rancher/issues/30447) Add Host option is seen for an EKS v2 cluster
* [#30446](https://github.com/rancher/rancher/issues/30446) rancher-externalip-webhook new version in 2.5.4
* [#30445](https://github.com/rancher/rancher/issues/30445) Exclude cattle.io/cluster-agent from the ignored node labels
* [#30434](https://github.com/rancher/rancher/issues/30434) Panics in Rancher server and it crashes after an upgrade
* [#30433](https://github.com/rancher/rancher/issues/30433) OPA GA
* [#30430](https://github.com/rancher/rancher/issues/30430) Rancher server panics and crashes when deleting a node when in provisioning state
* [#30424](https://github.com/rancher/rancher/issues/30424) rancher-externalip-webhook chart enhancements
* [#30405](https://github.com/rancher/rancher/issues/30405) No ingress when using RKE v1.2.4-rc2 and Rancher v2.5-head on HA infrastructure
* [#30403](https://github.com/rancher/rancher/issues/30403) Private EKS import command should not be needed when Rancher is in the same VPC
* [#30399](https://github.com/rancher/rancher/issues/30399) Errors in console while deploying a workload
* [#30373](https://github.com/rancher/rancher/issues/30373) invalid memory address or nil pointer dereference"
* [#30359](https://github.com/rancher/rancher/issues/30359) Add the StartTLS setting in the configuration summary of OpenLDAP
* [#30354](https://github.com/rancher/rancher/issues/30354) Missing save/cancel button on the screen for edit cluster when the cluster is imported (including local cluster)
* [#30347](https://github.com/rancher/rancher/issues/30347) Nodes remain in Active state for sometime before going to Provisioning state when a cluster is deployed
* [#30338](https://github.com/rancher/rancher/issues/30338) First Cluster in Error with "cattle-cluster-agent" not found and doesn't recover. Other clusters with same config come up Active
* [#30337](https://github.com/rancher/rancher/issues/30337) Update import command display for EKS clusters
* [#30332](https://github.com/rancher/rancher/issues/30332) EKS import command should only display if private network is selected and public is not
* [#30326](https://github.com/rancher/rancher/issues/30326) Node driver cluster using flatcar fails to deploy successfully
* [#30325](https://github.com/rancher/rancher/issues/30325) "Cluster health check failed: deployments.apps "cattle-cluster-agent" not found" error seen while deploying clusters
* [#30324](https://github.com/rancher/rancher/issues/30324) Severe Regression in 3.16.1 Calico - Fixed in 3.16.5
* [#30319](https://github.com/rancher/rancher/issues/30319) PVC seen Active when status shows "Resizing"
* [#30316](https://github.com/rancher/rancher/issues/30316) UI issues in "Resize" of PVC
* [#30301](https://github.com/rancher/rancher/issues/30301) Security group section is blank while creating an EKS v2 cluster
* [#30297](https://github.com/rancher/rancher/issues/30297) Add built-in OTC CCE driver
* [#30292](https://github.com/rancher/rancher/issues/30292) GKE - Errors after some time Cluster health check failed: Failed to communicate with API server: Unauthorized
* [#30293](https://github.com/rancher/rancher/issues/30293) [Backup/Restore] Chart version 1.0.3
* [#30283](https://github.com/rancher/rancher/issues/30283) Add flag to enable startTLS
* [#30272](https://github.com/rancher/rancher/issues/30272) Add DefaultBackend bool to RKE provisioning
* [#30262](https://github.com/rancher/rancher/issues/30262) Registering an EKS cluster defaults to manually entered name
* [#30261](https://github.com/rancher/rancher/issues/30261) Validate CentOS 7.9
* [#30238](https://github.com/rancher/rancher/issues/30238) [2.5] "fatal error: concurrent map read and map write issue" - causes a panic in Rancher server
* [#30221](https://github.com/rancher/rancher/issues/30221) k8s version update - Dec Patches
* [#30208](https://github.com/rancher/rancher/issues/30208) Forward port for ingress controller label issues
* [#30198](https://github.com/rancher/rancher/issues/30198) [2.5] Joining node to cluster fails on windows with docker 19.03.13
* [#30188](https://github.com/rancher/rancher/issues/30188) Enabling monitoring on new cluster gives intermittent 500 errors and object has been modified error
* [#30184](https://github.com/rancher/rancher/issues/30184) Add options to Global DNS
* [#30183](https://github.com/rancher/rancher/issues/30183) [2.5 - new chart] global dns / rancher-external-dns 0.1.2
* [#30179](https://github.com/rancher/rancher/issues/30179) [OPA Gatekeeper] rancher-gatekeeper: v3.2.1
* [#30159](https://github.com/rancher/rancher/issues/30159) [2.5] Joining node to cluster fails on windows with docker 19.03.13
* [#30157](https://github.com/rancher/rancher/issues/30157) Fleet changes in 2.5.3
* [#30152](https://github.com/rancher/rancher/issues/30152) [2.5] Nanoseconds in projectlogging
* [#30151](https://github.com/rancher/rancher/issues/30151) [2.5] Support for UAE in AKS
* [#30143](https://github.com/rancher/rancher/issues/30143) Panic in latest 2.5-head manager.go
* [#30142](https://github.com/rancher/rancher/issues/30142) [EKSv2] eks-operator: 1.0.5
* [#30139](https://github.com/rancher/rancher/issues/30139) [Logging v2] rancher-charts 3.8.001
* [#30138](https://github.com/rancher/rancher/issues/30138) [Monitoring V1] rancher-monitoring: v0.2.0
* [#30137](https://github.com/rancher/rancher/issues/30137) [Monitoring V2] rancher-monitoring: 9.4.202
* [#30123](https://github.com/rancher/rancher/issues/30123) CIS v2/rancher-cis-benchmark: 1.0.300
* [#30111](https://github.com/rancher/rancher/issues/30111) Windows worker registration command is not available
* [#30092](https://github.com/rancher/rancher/issues/30092) [cli] Configure kubernetes token cache dir
* [#30083](https://github.com/rancher/rancher/issues/30083) [EKS] Selecting security groups should be optional when selecting custom VPC
* [#30077](https://github.com/rancher/rancher/issues/30077) [UI] Add "Rotate Encryption Key" to Cluster Actions Dropdown
* [#30067](https://github.com/rancher/rancher/issues/30067) Drone build failed due to "manifest unknown"
* [#30065](https://github.com/rancher/rancher/issues/30065) "Failed to load Clusters from Amazon:" error seenn while importing EKS clusters on changing cloud credentials
* [#30063](https://github.com/rancher/rancher/issues/30063) [Monitoring V2] Remove deprecated references to kubernetes-charts.storage.googleapis.com
* [#30048](https://github.com/rancher/rancher/issues/30048) Upgrade to Rancher 2.5.2 and 2.4.10: cattle-cluster-agent hammers apiserver, very high CPU usage
* [#30046](https://github.com/rancher/rancher/issues/30046) [UI] rke.windows should show as Windows
* [#30042](https://github.com/rancher/rancher/issues/30042) Add HTTP proxy support for Continuous Delivery (Fleet)
* [#30018](https://github.com/rancher/rancher/issues/30018) OPA GA: Update OPA to the latest version
* [#30013](https://github.com/rancher/rancher/issues/30013) Validate rancherd upgrades
* [#30012](https://github.com/rancher/rancher/issues/30012) Validate Airgap configuration using Rancherd
* [#30011](https://github.com/rancher/rancher/issues/30011) Validate RHEL8 with SELinux set to Enforcing with cis-1.5 enabled using Rancherd
* [#30015](https://github.com/rancher/rancher/issues/30015) promote-stable drone job always says it fails
* [#29981](https://github.com/rancher/rancher/issues/29981) KDM Release - k8s patches for Nov
* [#29980](https://github.com/rancher/rancher/issues/29980) Monitoring v2 installation in a hardened cluster fails when no project is chosen
* [#29907](https://github.com/rancher/rancher/issues/29907) [EKSv2]: Rancher should be able to fully communicate with private EKS clusters
* [#29905](https://github.com/rancher/rancher/issues/29905) [Monitoring / Alerting] Create scripts for auditing what needs to be disabled to remove Monitoring / Alerting V1
* [#29903](https://github.com/rancher/rancher/issues/29903) Istio v2: Jaeger
* [#29898](https://github.com/rancher/rancher/issues/29898) Invalid kiali WEB_ROOT in 2.5 rancher-kiali-server charts
* [#29892](https://github.com/rancher/rancher/issues/29892) [Logging] Support syslog
* [#29872](https://github.com/rancher/rancher/issues/29872) Ability to support default nginx backend instead of our deployed pod
* [#29841](https://github.com/rancher/rancher/issues/29841) Cluster does not come up in Rancher when flatcar-linux-stable-2605.6.0 nodes are used
* [#29840](https://github.com/rancher/rancher/issues/29840) Add support for deploying Monitoring onto an RKE cluster with some or all etcd nodes using RancherOS
* [#29826](https://github.com/rancher/rancher/issues/29826) [EKSv2]: Additional security groups should not be automatically generated.
* [#29825](https://github.com/rancher/rancher/issues/29825) [rancherd] Bump RKE2 version
* [#29813](https://github.com/rancher/rancher/issues/29813) [Dashboard] RFE Support specifying UI images path in Rancher Helm Chart
* [#29774](https://github.com/rancher/rancher/issues/29774) [UI] pass cluster name on template request via query parameter
* [#29773](https://github.com/rancher/rancher/issues/29773) Add filter option for template GET request
* [#29714](https://github.com/rancher/rancher/issues/29714) [Master] Ingress Status Load Balancer IPs Not Being Updated
* [#29696](https://github.com/rancher/rancher/issues/29696) chart 2.5.1:  Has no PodSecurityPolicy , causing failed pods in new namespaces
* [#29668](https://github.com/rancher/rancher/issues/29668) Exec to Pod via kubectl shell fails with error: unable to upgrade connection: Forbidden
* [#29667](https://github.com/rancher/rancher/issues/29667) Process started in UI container shell stays even after closing the UI
* [#29665](https://github.com/rancher/rancher/issues/29665) UI warning when deleting a node in a 2 node cluster
* [#29651](https://github.com/rancher/rancher/issues/29651) Rancher Webhook - installable on hardened cluster
* [#29642](https://github.com/rancher/rancher/issues/29642) Upgrade Logging Operator to 3.7.3
* [#29565](https://github.com/rancher/rancher/issues/29565) rancherd reset-password can panic on startup
* [#29554](https://github.com/rancher/rancher/issues/29554) Switch to the upstream saml library from rancher's fork of it
* [#29549](https://github.com/rancher/rancher/issues/29549) Error "secrets c-f64cl already exists" while creating a hosted EKS v2 cluster when the cluster already exists in EKS
* [#29530](https://github.com/rancher/rancher/issues/29530) add user and password options to Rancherd
* [#29550](https://github.com/rancher/rancher/issues/29550) Unable to install Prometheus Operator on Rancher 2.5.1 - Cluster Dashboard
* [#29482](https://github.com/rancher/rancher/issues/29482) client-go needs updated due to deprecated resources
* [#29446](https://github.com/rancher/rancher/issues/29446) [rancher/charts] PRs to dev branch should ensure that packageVersion is updated
* [#29431](https://github.com/rancher/rancher/issues/29431) [UI][EKSv2]: cannot add SSH key to new nodegroups
* [#29429](https://github.com/rancher/rancher/issues/29429) Rancher 2.4.8 Memory Leak
* [#29797](https://github.com/rancher/rancher/issues/29797) Rancherd GA
* [#29338](https://github.com/rancher/rancher/issues/29338) [rancher/charts] Changes to the requirements.lock pushes unnecessary changes to the generated branch
* [#29318](https://github.com/rancher/rancher/issues/29318) Alerts - rule deployer errors when enabling alerts
* [#29315](https://github.com/rancher/rancher/issues/29315) Admission webhook error when restricted admin attempts to create an Administrator user
* [#29294](https://github.com/rancher/rancher/issues/29294) [KEv2]: add check to CI and update generated files
* [#29275](https://github.com/rancher/rancher/issues/29275) Pod startup fails when  /var/lib/docker/containers is a separate file system
* [#29239](https://github.com/rancher/rancher/issues/29239) Local cluster showing and stuck in provisioning when rancher manages rancher cluster
* [#29235](https://github.com/rancher/rancher/issues/29235) Migrating alerts/dashboards from monitoring v1 to v2
* [#29250](https://github.com/rancher/rancher/issues/29250) [Logging v2] - Can't access the Logging Overview as Cluster Member
* [#29587](https://github.com/rancher/rancher/issues/29587) k8s 1.19 removes basic auth but it's in use by kontainer-engine
* [#29188](https://github.com/rancher/rancher/issues/29188) OPA gatekeeper - Can't install rancher-gatekeeper-operator v2 due to v1's CRDs not deleted after uninstalling
* [#29162](https://github.com/rancher/rancher/issues/29162) [rancherd] URL from reset-admin is always the private ip
* [#29153](https://github.com/rancher/rancher/issues/29153) Auth configuration of OpenLDAP fails with error "Error creating ssl connection: LDAP Result Code 200 "": EOF"
* [#29149](https://github.com/rancher/rancher/issues/29149) Request to add disableMountSubPath option in Prometheus operator (monitoring system chart)
* [#29144](https://github.com/rancher/rancher/issues/29144) extensions/v1beta1 Ingress in Rancher chart is deprecated
* [#29292](https://github.com/rancher/rancher/issues/29292) High system load alert fails to trigger on 1.19.2
* [#29183](https://github.com/rancher/rancher/issues/29183) Change events don't work reliably in general
* [#29104](https://github.com/rancher/rancher/issues/29104) Error displayed when credentials are changed in an EKS cluster can be made better
* [#29103](https://github.com/rancher/rancher/issues/29103) Creating a hosted EKS cluster with a clustername that already exists in AWS console, results in the existing cluster in AWS console being updated
* [#29077](https://github.com/rancher/rancher/issues/29077) Unit tests - EKS
* [#29064](https://github.com/rancher/rancher/issues/29064) [rancher/charts] Running make charts on packages with overlay leaves resources behind
* [#29037](https://github.com/rancher/rancher/issues/29037) Helm install of rancher for kubeAdm and miniKube clusters
* [#29649](https://github.com/rancher/rancher/issues/29649) Support CIS 1.6
* [#28954](https://github.com/rancher/rancher/issues/28954) When alerts only configured notifiers that are not webhook forwarded, rancher server returns secrets "Webhook -receiver" not found error
* [#28947](https://github.com/rancher/rancher/issues/28947) Cluster Provider Detection- Windows vs. Linux RKE clusters
* [#28943](https://github.com/rancher/rancher/issues/28943) rancher logs show a constant "v1 ComponentStatus is deprecated in v1.19+" logs
* [#28753](https://github.com/rancher/rancher/issues/28753) Enhancement for rke etcd encryption rewrite process - batch
* [#28752](https://github.com/rancher/rancher/issues/28752) Enhancement for rke etcd encryption rewrite process - client timeout
* [#28746](https://github.com/rancher/rancher/issues/28746) Enhancement for rke etcd encryption rewrite process - logging 
* [#28720](https://github.com/rancher/rancher/issues/28720) [Logging V2] Windows node taints and tolerations.
* [#28711](https://github.com/rancher/rancher/issues/28711) Add validation in CI to check no multiple new versions of the same chart in a given release
* [#28651](https://github.com/rancher/rancher/issues/28651) [UI] Recognize rancherd clusters as "rancherd"
* [#28574](https://github.com/rancher/rancher/issues/28574) [Logging v2] Control Plane logs - GKE
* [#28573](https://github.com/rancher/rancher/issues/28573) [Logging v2] Control Plane logs - AKS
* [#28548](https://github.com/rancher/rancher/issues/28548) Add button to be show import cluster command when no cluster has been registered or add hosts to a custom cluster if no hosts have been added
* [#28532](https://github.com/rancher/rancher/issues/28532) For clusters provisioned with rancher2 TF provider, nginx ingress comments are injected into cluster yaml when editing via the UI
* [#28400](https://github.com/rancher/rancher/issues/28400) Rancher provisioned cluster becomes unavailable after enabling secret encryption, if secrets are deleted during the secret rewriting
* [#28391](https://github.com/rancher/rancher/issues/28391) FR: GlobalDNS/externaldns Allow setting of '--aws-batch-change-size' via Rancher UI
* [#28358](https://github.com/rancher/rancher/issues/28358) When adding node to cluster receive 'Use of Closed Connection' error
* [#28356](https://github.com/rancher/rancher/issues/28356) [UI] EKSv2: display import command on create if cluster only has private access enabled
* [#28077](https://github.com/rancher/rancher/issues/28077) Can't use LDAP auth when LDAP Server has objectClass attribute in lowercase
* [#28040](https://github.com/rancher/rancher/issues/28040) Bug: Global user role null verb causes interface to become uneditable
* [#27746](https://github.com/rancher/rancher/issues/27746) AWS EBS volume expansion via PVC not working in UI.
* [#27735](https://github.com/rancher/rancher/issues/27735) Add rotateEncryption to Rancher API
* [#27377](https://github.com/rancher/rancher/issues/27377) Istio V2: CNI plugin
* [#27080](https://github.com/rancher/rancher/issues/27080) Add support for GovCloud regions for EKS
* [#29588](https://github.com/rancher/rancher/issues/29588) Steve bug: "Update" is not working for dynamic RBAC
* [#26080](https://github.com/rancher/rancher/issues/26080) Possible to create node pools without a role
* [#25590](https://github.com/rancher/rancher/issues/25590) Scaling/design of default-http-backend Deployment
* [#24636](https://github.com/rancher/rancher/issues/24636) `tolerations: [{operator: Exists}]` specification for cattle-cluster-agent prevents Pod re-scheduling in the event host node is Unavailable
* [#22487](https://github.com/rancher/rancher/issues/22487) Ensure rancher-server chart works with k8s because of removed API in k8s 1.20
* [#21648](https://github.com/rancher/rancher/issues/21648) Bug: ec2 cluster with Amazon Linux images fail to start
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


## All issues in v2.5.3 milestone

* [#30045](https://github.com/rancher/rancher/issues/30045) Ingress controller has labels in pods
* [#30044](https://github.com/rancher/rancher/issues/30044) Ingress is stuck in Initializing state in an upgraded rancher setup
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


## All issues in v2.5.2 milestone

* [#29990](https://github.com/rancher/rancher/issues/29990) Clicking on Download CLI does not download rancher cli
* [#29949](https://github.com/rancher/rancher/issues/29949) [EKSv2]: enabling GPU in Rancher does not enable it on the cluster in AWS console and enabling GPU for an EKS cluster should result in the correct AMI being used
* [#29934](https://github.com/rancher/rancher/issues/29934) Set display-name in charts for UI 
* [#29923](https://github.com/rancher/rancher/issues/29923) EKS Cluster must specify public endpoint 
* [#29921](https://github.com/rancher/rancher/issues/29921) Disable the ability to uncheck the "Public Access" checkbox
* [#29883](https://github.com/rancher/rancher/issues/29883) airgap - no fleet agents in downstream clusters after upgrading from 2.4.8 to 2.5.2-rc5
* [#29881](https://github.com/rancher/rancher/issues/29881) Clusters go into Error and Updating state on an upgrade from 2.4.8 to 2.5.2-rc5
* [#29875](https://github.com/rancher/rancher/issues/29875) Panic in Rancher on upgrade from 2.5.1 to 2.5.2-rc4 
* [#29874](https://github.com/rancher/rancher/issues/29874) Helm error on Rancher upgrade from 2.5.1 to 2.5.2-rc4 and also on fresh install of 2.5.2-rc4
* [#29852](https://github.com/rancher/rancher/issues/29852) [Forwardport] Can't delete nodes from cluster in updating/error stat
* [#29839](https://github.com/rancher/rancher/issues/29839) Monitoring v2 - failed to create pv for prometheus when using longhorn as the storage class 
* [#29815](https://github.com/rancher/rancher/issues/29815) [v2.5] After enabling monitoring , Pod pushprox-kube-etcd-client is in Init:CrashLoopBackOff on RancherOS
* [#29800](https://github.com/rancher/rancher/issues/29800) Validate SLES 15SP2
* [#29799](https://github.com/rancher/rancher/issues/29799) Validate RHEL 7.9 and 8.2
* [#29798](https://github.com/rancher/rancher/issues/29798) Validate Oracle Linux 7.9 and 8.2
* [#29796](https://github.com/rancher/rancher/issues/29796) Validate CentOS 8.2
* [#29791](https://github.com/rancher/rancher/issues/29791) [Forward port] With a Cloud Provider enabled, Windows worker nodes cannot join cluster due to DNS suffixes being passed to kubelet as commands
* [#29754](https://github.com/rancher/rancher/issues/29754) Auto Replace does not work (v2.5.1 on rke)
* [#29751](https://github.com/rancher/rancher/issues/29751) User is not able to login to Rancher after logging out
* [#29706](https://github.com/rancher/rancher/issues/29706) [UI] Support for limiting k8s versions on charts
* [#29702](https://github.com/rancher/rancher/issues/29702) User is not able to create clusters
* [#29690](https://github.com/rancher/rancher/issues/29690) Hosted Rancher is not able to manage downstream cluster
* [#29685](https://github.com/rancher/rancher/issues/29685) User cannot select cloud provider option while creating a cluster
* [#29652](https://github.com/rancher/rancher/issues/29652) Error Provisioning Cluster - Cluster health check failed: cluster agent is not ready
* [#29646](https://github.com/rancher/rancher/issues/29646) GKE - Create cluster throwing invalid projectID with json key
* [#29639](https://github.com/rancher/rancher/issues/29639) Monitoring V2 Grafana storage causes "breaks non-root policy" error
* [#29636](https://github.com/rancher/rancher/issues/29636) Error in console when a standard user navigates to MCAPP page
* [#29624](https://github.com/rancher/rancher/issues/29624) Default k8s version for EKS clusters should be 1.18
* [#29599](https://github.com/rancher/rancher/issues/29599) airgap - rancher/rancher-operator:v0.1.0 is used but rancher/rancher-operator:v0.1.0-alpha8 is in the images.txt file
* [#29591](https://github.com/rancher/rancher/issues/29591) airgap - rancher/fleet:v0.3.0 is used but rancher/fleet:v0.3.0-rc3 is in the images.txt file
* [#29583](https://github.com/rancher/rancher/issues/29583) Bump rke2 version in rancherd 
* [#29561](https://github.com/rancher/rancher/issues/29561) rancher-webhook server No compatible with k8s v1.16.x
* [#29557](https://github.com/rancher/rancher/issues/29557) Installing Loki chart from URL, "Error: gzip: invalid header"
* [#29553](https://github.com/rancher/rancher/issues/29553) [UI] Add a field to accept Entity ID for Keycloak
* [#29518](https://github.com/rancher/rancher/issues/29518) Panic seen in isAlertRuleMatching after upgrading to v2.5.2
* [#29514](https://github.com/rancher/rancher/issues/29514) Hide embedded cluster update in the UI
* [#29511](https://github.com/rancher/rancher/issues/29511) [v2.5.1] Launch `kubectl` Issues since update to Rancher 2.5.1
* [#29495](https://github.com/rancher/rancher/issues/29495) Helm upgrade should work behind proxy
* [#29484](https://github.com/rancher/rancher/issues/29484) UI - PVs of longhorn always show the default volume attributes in edit/display mode.
* [#29461](https://github.com/rancher/rancher/issues/29461) Continuous updates in nginx-ingress-controller pods in a HA set up where local cluster is created on single-node rancher
* [#29460](https://github.com/rancher/rancher/issues/29460) OnConfigMapChange panic seen in agent when not being able to process helm configmap/secrets properly
* [#29457](https://github.com/rancher/rancher/issues/29457) [Monitoring V2] Using the same PV as Monitoring V1
* [#29445](https://github.com/rancher/rancher/issues/29445) [Monitoring V2] Switch to using a single PushProx for k3s by default
* [#29424](https://github.com/rancher/rancher/issues/29424) image rancher/rancher-agent:v2.5.0
* [#29422](https://github.com/rancher/rancher/issues/29422) config.yaml not functional in rancherd
* [#29420](https://github.com/rancher/rancher/issues/29420) rancher-webhook fails to deploy in a local cluster of HA setup with k8s v1.16
* [#29419](https://github.com/rancher/rancher/issues/29419) RFE Support specifying UI images path in Rancher Helm Chart
* [#29412](https://github.com/rancher/rancher/issues/29412) local k3s cluster should not be upgradable in Rancher single install mode 
* [#29410](https://github.com/rancher/rancher/issues/29410) [Logging V2]  Logs should include data about their source
* [#29418](https://github.com/rancher/rancher/issues/29418) Cannot upgrade v2 Istio after deleting v2 Monitoring/CRDs
* [#29408](https://github.com/rancher/rancher/issues/29408) Update Kiali to 1.24.0
* [#29403](https://github.com/rancher/rancher/issues/29403) Rancher not starting - "Observed a panic: "assignment to entry in nil map" [v2.5.0]
* [#29397](https://github.com/rancher/rancher/issues/29397) Cattle Cluster and node agent of local cluster are present when upgraded to 2.5.0
* [#29395](https://github.com/rancher/rancher/issues/29395) Monitoring v2 - failed to install in k8s 1.16 cluster 
* [#29383](https://github.com/rancher/rancher/issues/29383) v2 Istio fails to completely install/upgrade when Ingress Gateway is not installed
* [#29379](https://github.com/rancher/rancher/issues/29379) restrictedAdmin - cannot assign global role to users
* [#29373](https://github.com/rancher/rancher/issues/29373) Update k8s versions-10/14
* [#29364](https://github.com/rancher/rancher/issues/29364) Elevated CPU, load, network utilization after 2.4.8 to 2.5.0-rc7 upgrade
* [#29362](https://github.com/rancher/rancher/issues/29362) ui-offline-preferred as "dynamic" does not work does not work in 2.5-head
* [#29434](https://github.com/rancher/rancher/issues/29434) If I click on radio button on Welcome to Rancher screen, it unselects both
* [#29357](https://github.com/rancher/rancher/issues/29357) "Unauthorized 401 must authenticate" error seen on login page sometimes
* [#29353](https://github.com/rancher/rancher/issues/29353) "display-name" is not mapped to the cluster name when EKS v2 cluster name is corrected
* [#29347](https://github.com/rancher/rancher/issues/29347) Need to update wrangler library to latest in rancher/webhook
* [#29415](https://github.com/rancher/rancher/issues/29415) User Interface version is incorrect
* [#29340](https://github.com/rancher/rancher/issues/29340) Testing restrictedAdmin
* [#29327](https://github.com/rancher/rancher/issues/29327) Fleet agent doesn't deploy in downstream cluster when Rancher is behind proxy
* [#29325](https://github.com/rancher/rancher/issues/29325) Disable local cluster dashboard access to restricted admin
* [#29317](https://github.com/rancher/rancher/issues/29317) When Global default registry to `reg1` and cluster level to `reg2`,  helm-operation pod and fleet agent get deployed using images from reg1
* [#29307](https://github.com/rancher/rancher/issues/29307) In rc builds , ui-index and ui-dashboard-index does not stick to a UI tag.
* [#29249](https://github.com/rancher/rancher/issues/29249) [ Istio ] Update to version 1.7.3 
* [#29238](https://github.com/rancher/rancher/issues/29238) What's New in 2.5 showing in v2.4.8 when rancher manages rancher cluster
* [#29219](https://github.com/rancher/rancher/issues/29219) Hyperlink is broken in all charts' CRD Readme
* [#29212](https://github.com/rancher/rancher/issues/29212) Unable to integrate Keycloak SAML SSO when Client ID field is reserved
* [#29201](https://github.com/rancher/rancher/issues/29201) Not able to log in rancher server after a while - 404 errors seen on v3/settings , v3/preferences,v3/users 
* [#29346](https://github.com/rancher/rancher/issues/29346) Add in support to limit k8s versions for system-charts
* [#29127](https://github.com/rancher/rancher/issues/29127) [EKSv2] If eks-operator deploy fails, it is not retried
* [#29070](https://github.com/rancher/rancher/issues/29070) EKS cluster fails to come up in an air gapped proxy setup
* [#29059](https://github.com/rancher/rancher/issues/29059) [Monitoring V2] Support Hardened Cluster - Hardened Scan
* [#29058](https://github.com/rancher/rancher/issues/29058) update upgrade_strategy.drain to fix bug in terraform-provider-rancher2
* [#28953](https://github.com/rancher/rancher/issues/28953) Version shown for an EKS cluster is incorrect
* [#28923](https://github.com/rancher/rancher/issues/28923) Airgap - helm-operation pod in downstream cluster does not use the private registry 
* [#28688](https://github.com/rancher/rancher/issues/28688) Run Conformance Testing for 1.19
* [#28657](https://github.com/rancher/rancher/issues/28657) [Logging V2] Mirror debug fluentbit and fluentd images
* [#28605](https://github.com/rancher/rancher/issues/28605) Can't provision clusters in Rancher single node docker install with bring your own valid certs 
* [#28536](https://github.com/rancher/rancher/issues/28536) Monitoring v2 - failed to install in harden clusters
* [#28468](https://github.com/rancher/rancher/issues/28468) Istio v2: Grafana Addon
* [#29139](https://github.com/rancher/rancher/issues/29139) Reserved/Used resources are not updated when k3s cluster is local
* [#27450](https://github.com/rancher/rancher/issues/27450) monitoring - volume is used by existing pod after upgrading cluster monitoring
* [#26488](https://github.com/rancher/rancher/issues/26488) CPU, RAM missing for k3s cluster in cluster view
* [#23045](https://github.com/rancher/rancher/issues/23045) RHEL 8 Support with Docker CE
* [#22790](https://github.com/rancher/rancher/issues/22790) Ability to restrict user to deploy only from catalog
* [#18044](https://github.com/rancher/rancher/issues/18044) Rancher-monitoring prometheus can't scrape node-exporter, etcd, scheduler and controller-manager endpoints in hardened cluster
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
