| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.7.11](rancher-v2.7.md#release-v2711) | Mar 01 2024 | 03/01/24 | 2024-03-01 |
| [v2.7.10](rancher-v2.7.md#release-v2710) | Feb 08 2024 | 02/08/24 | 2024-02-08 |
| [v2.7.9](rancher-v2.7.md#release-v279) | Oct 26 2023 | 10/26/23 | 2023-10-26 |
| [v2.7.8](rancher-v2.7.md#release-v278) | Oct 05 2023 | 10/05/23 | 2023-10-05 |
| [v2.7.7](rancher-v2.7.md#release-v277) | Sep 28 2023 | 09/28/23 | 2023-09-28 |
| [v2.7.6](rancher-v2.7.md#release-v276) | Aug 30 2023 | 08/30/23 | 2023-08-30 |
| [v2.7.5](rancher-v2.7.md#release-v275) | Jun 29 2023 | 06/29/23 | 2023-06-29 |
| [v2.7.4](rancher-v2.7.md#release-v274) | May 31 2023 | 05/31/23 | 2023-05-31 |
| [v2.7.3](rancher-v2.7.md#release-v273) | Apr 24 2023 | 04/24/23 | 2023-04-24 |
| [v2.7.2](rancher-v2.7.md#release-v272) | Apr 12 2023 | 04/12/23 | 2023-04-12 |
| [v2.7.1](rancher-v2.7.md#release-v271) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v2.7.0](rancher-v2.7.md#release-v270) | Nov 16 2022 | 11/16/22 | 2022-11-16 |




-----
# Release v2.7.10

> Rancher v2.7.10 is considered a stable release and also designated as a Rancher Prime release. To learn more about Rancher Prime, visit https://www.rancher.com/products/rancher-platform.

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.7.10 is a security release to address the following issues:**

# Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Fixed an issue where the [Rancher Audit Log](https://ranchermanager.docs.rancher.com/how-to-guides/advanced-user-guides/enable-api-audit-log) was leaking sensitive data. For more information, see [CVE-2023-22649](https://github.com/rancher/rancher/security/advisories/GHSA-xfj7-qf8w-2gcr).
- Updated the versions of Norman and API Server to address CVEs [CVE-2023-32193](https://github.com/rancher/norman/security/advisories/GHSA-r8f4-hv23-6qp6) and [CVE-2023-32192](https://github.com/rancher/apiserver/security/advisories/GHSA-833m-37f7-jq55), respectively, that could lead to an unauthenticated cross-site scripting (XSS) in Rancher's APIs.
- Fixed an issue where users with permissions in custom API groups could manage namespaces in the core API group. For more information, see [CVE-2023-32194](https://github.com/rancher/rancher/security/advisories/GHSA-c85r-fwc7-45vc).
- Bumped `runc` to [v1.1.12](https://github.com/opencontainers/runc/releases/tag/v1.1.12) to fix [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626), see related [`runc` security advisory](https://github.com/opencontainers/runc/security/advisories/GHSA-xr7r-f8xq-vfvv).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

# Known Issues

- When you upgrade to Rancher v2.7.9 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).
- Scaling down etcd node pools on RKE2/K3s machine-provisioned clusters may result in unexpected behavior. To avoid this problem, define multiple machine pools for etcd nodes, each with a quantity of one. You can then scale down simply by deleting machine pools. As a further mitigation, have a robust backup strategy and store your etcd snapshots in a safe location. Restoring from an etcd snapshot allows you to return the cluster back to an operational state if you're affected by unexpected behaviors while scaling down etcd node pools. See [#42582](https://github.com/rancher/rancher/issues/42582) and [#43263](https://github.com/rancher/rancher/issues/43263).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Reverting the Active Directory Migration Delivered in v2.7.5

The following information *only* applies if you are upgrading from Rancher v2.7.5. It does *not* apply if you are upgrading directly to the latest Rancher version from v2.7.4 or earlier, or if you are upgrading to the latest Rancher version from v2.7.6.

Rancher v2.7.6 and later contain a reverse migration utility that runs at startup. Data migration is only triggered if you have been on Rancher v2.7.5.

Users will be corrected from the v2.7.5 data migration, which updated personalIDs to use GUIDs instead of Distinguished Names (DNs). Rancher v2.7.6 and later fix bugs related to the inability to login for various reasons. See [#41985](https://github.com/rancher/rancher/issues/41985) and [#42120](https://github.com/rancher/rancher/issues/42120). 

**Important:** If you disabled AD authentication while on v2.7.5, don't enable it after upgrading until after the utility is run. Doing so will cause the reverse migration to fail to clean up the remaining bad data.

We strongly recommend that you directly upgrade to the latest version of Rancher v2.7.x, especially if you're on a broken or partially downgraded Rancher setup after upgrading to v2.7.5. Allow the startup utility to revert the Active Directory changes to restore functionality to your setup. 

Even if you're currently on Rancher v2.7.5 and your setup wasn't broken by the Active Directory changes, you should still upgrade to v2.7.6 or later and allow the startup utility to revert the migration.

The reverse migration startup utility saves all relevant changes to Rancher if it finds GUID-based users in Active Directory. The users' data (including the user object, all bindings, and tokens) return a Distinguished Name as the principalID. If the LDAP connection permanently fails during execution of the utility, Rancher automatically retries the utility several times with exponential backoff. Missing users are left behind and reported to the local admin for manual review.

If you need to clean up any missing users following an upgrade to the latest Rancher version, contact support.

### Long-standing Rancher Behavior Changes

- The `cluster-api` core provider controllers are now run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094). <!-- team/area2 -->
- Changed the token hashing algorithm to generate new tokens using SHA3. Existing tokens will not be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Existing tokens which don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while Token Hashing is enabled, you should re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062). <!-- team/area1 --><!-- team/scaling -->
- If you use a version of backup restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).
- Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Note that restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions ideally need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
- The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).
- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.10

### Tools
- CLI - [v2.7.7](https://github.com/rancher/cli/releases/tag/v2.7.7)
- RKE - [v1.4.13](https://github.com/rancher/rke/releases/tag/v1.4.13)

### Kubernetes Versions for RKE
- v1.26.11 (Default)
- v1.25.16
- v1.24.17
- v1.23.16

### Kubernetes Versions for RKE2/K3s
- v1.26.11 (Default)
- v1.25.16
- v1.24.17
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Long-standing Known Major Issues

- The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
- Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259).
- Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - **Any distribution - Windows:**
    - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426). 
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **RKE2 and K3s:**
    - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. However, there is a [workaround](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) for fixing these node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
    - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
<!-- - **Infrastructures:** -->
  <!-- - **vSphere:**-->
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
      1. Refresh the `rancher-charts` catalog resource.
      1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
      1. Select the dot menu to select **Upgrade** to check if there is a newer Fleet version listed.
      1. Update the `fleet` chart. Fleet will automatically update the agents.
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and selectinging Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Removed legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.7.9

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

Rancher v2.7.9 is a mirror release of Rancher v2.7.8/v2.7.7. It includes a bug fix for a provisioning issue in RKE2 clusters.

FYI, Rancher v2.7.7/v2.7.8 are only available in the `latest` Helm repo. As as reminder, please only deploy from the `stable` Helm repo. [Read more details on our different versions of repos. ](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/resources/choose-a-rancher-version)

# Major Bug Fixes

- Fixed a bug where RKE2 clusters would become stuck in an `Updating` state after a change to the node pool. Instead of successfully rotating the node pool, the init node couldn't be deleted, which prevented the provisioning process from completing. See [#43142](https://github.com/rancher/rancher/issues/43142).
<!--
# Rancher Behavior Changes
-->

# Known Issues

- When you upgrade to Rancher v2.7.9 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).
- Scaling down etcd node pools on RKE2/K3s machine-provisioned clusters may result in unexpected behavior. To avoid this problem, define multiple machine pools for etcd nodes, each with a quantity of one. You can then scale down simply by deleting machine pools. As a further mitigation, have a robust backup strategy and store your etcd snapshots in a safe location. Restoring from an etcd snapshot allows you to return the cluster back to an operational state if you're affected by unexpected behaviors while scaling down etcd node pools. See [#42582](https://github.com/rancher/rancher/issues/42582) and [#43263](https://github.com/rancher/rancher/issues/43263).
- Attempting to restore etcd may fail on downstream RKE2 clusters that run `v1.26.9+rke2r1` or `v1.25.13+rke2r1`. You should *not* upgrade affected clusters at this time. An out-of-band RKE2 patch fixing this known issue is forthcoming. For information on when the patch will be released, track the associated [issue](https://github.com/rancher/rancher/issues/43228). See [#43228](https://github.com/rancher/rancher/issues/43228).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Reverting the Active Directory Migration Delivered in v2.7.5

The following information *only* applies if you are upgrading from Rancher v2.7.5. It does *not* apply if you are upgrading directly to the latest Rancher version from v2.7.4 or earlier, or if you are upgrading to the latest Rancher version from v2.7.6.

Rancher v2.7.6 and later contain a reverse migration utility that runs at startup. Data migration is only triggered if you have been on Rancher v2.7.5.

Users will be corrected from the v2.7.5 data migration, which updated personalIDs to use GUIDs instead of Distinguished Names (DNs). Rancher v2.7.6 and later fix bugs related to the inability to login for various reasons. See [#41985](https://github.com/rancher/rancher/issues/41985) and [#42120](https://github.com/rancher/rancher/issues/42120). 

**Important:** If you disabled AD authentication while on v2.7.5, don't enable it after upgrading until after the utility is run. Doing so will cause the reverse migration to fail to clean up the remaining bad data.

We strongly recommend that you directly upgrade to the latest version of Rancher v2.7.x, especially if you're on a broken or partially downgraded Rancher setup after upgrading to v2.7.5. Allow the startup utility to revert the Active Directory changes to restore functionality to your setup. 

Even if you're currently on Rancher v2.7.5 and your setup wasn't broken by the Active Directory changes, you should still upgrade to v2.7.6 or later and allow the startup utility to revert the migration.

The reverse migration startup utility saves all relevant changes to Rancher if it finds GUID-based users in Active Directory. The users' data (including the user object, all bindings, and tokens) return a Distinguished Name as the principalID. If the LDAP connection permanently fails during execution of the utility, Rancher automatically retries the utility several times with exponential backoff. Missing users are left behind and reported to the local admin for manual review.

If you need to clean up any missing users following an upgrade to the latest Rancher version, contact support.

### Long-standing Rancher Behavior Changes

- The `cluster-api` core provider controllers are now run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094). <!-- team/area2 -->
- Changed the token hashing algorithm to generate new tokens using SHA3. Existing tokens will not be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Existing tokens which don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while Token Hashing is enabled, you should re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062). <!-- team/area1 --><!-- team/scaling -->
- If you use a version of backup restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).
- Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Note that restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions ideally need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
- The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).
- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.9

### Tools
- CLI - [v2.7.7](https://github.com/rancher/cli/releases/tag/v2.7.7)
- RKE - [v1.4.10](https://github.com/rancher/rke/releases/tag/v1.4.10)

### Kubernetes Versions for RKE
- v1.26.8 (Default)
- v1.25.13
- v1.24.17
- v1.23.16

### Kubernetes Versions for RKE2/K3s
- v1.26.9 (Default)
- v1.25.14
- v1.24.17
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Long-standing Known Major Issues

- The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
- Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259).
- Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - **Any distribution - Windows:**
    - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426). 
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **RKE2 and K3s:**
    - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. However, there is a [workaround](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) for fixing these node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
    - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
<!-- - **Infrastructures:** -->
  <!-- - **vSphere:**-->
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
      1. Refresh the `rancher-charts` catalog resource.
      1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
      1. Select the dot menu to select **Upgrade** to check if there is a newer Fleet version listed.
      1. Update the `fleet` chart. Fleet will automatically update the agents.
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and selectinging Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Removed legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## All issues in v2.7.9 milestone

* [#43166](https://github.com/rancher/rancher/issues/43166) [Backport v2.7.9] [BUG] Rancher pods are in crash loop back off on a fresh install and upgrade and never recovers
* [#43142](https://github.com/rancher/rancher/issues/43142) [Backport release/v2.7] Init Node cannot be removed
-----
# Release v2.7.8

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.7.8 is a mirror release of [v2.7.7](https://github.com/rancher/rancher/releases/tag/v2.7.7) with one change to address a known issue in v2.7.7. This issue affected node-provisioned clusters for certain cloud infrastructure providers.**

# Major Bug Fixes

- Fixed an issue where Rancher failed to provision EC2/vSphere clusters. See [#43019](https://github.com/rancher/rancher/issues/43019) for details.

  > Note: If you were previously running a downstream vSphere cluster, installed or upgraded to Rancher v2.7.7, and, as a [workaround](https://github.com/rancher/rancher/issues/43019#issuecomment-1747670801), set the `rancher/machine` version to `0.15.0-rancher105` via the `CATTLE_MACHINE_PROVISION_IMAGE` environment variable, the vSphere downstream clusters will be provisioned again upon upgrade to Rancher v2.7.8.

<!--# Rancher Behavior Changes

# Known Issues-->

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Reverting the Active Directory Migration Delivered in v2.7.5

The following information *only* applies if you are upgrading from Rancher v2.7.5. It does *not* apply if you are upgrading directly to the latest Rancher version from v2.7.4 or earlier, or if you are upgrading to the latest Rancher version from v2.7.6.

Rancher v2.7.6 and later contain a reverse migration utility that runs at startup. Data migration is only triggered if you have been on Rancher v2.7.5.

Users will be corrected from the v2.7.5 data migration, which updated personalIDs to use GUIDs instead of Distinguished Names (DNs). Rancher v2.7.6 and later fix bugs related to the inability to login for various reasons. See [#41985](https://github.com/rancher/rancher/issues/41985) and [#42120](https://github.com/rancher/rancher/issues/42120). 

**Important:** If you disabled AD authentication while on v2.7.5, don't enable it after upgrading until after the utility is run. Doing so will cause the reverse migration to fail to clean up the remaining bad data.

We strongly recommend that you directly upgrade to the latest version of Rancher v2.7.x, especially if you're on a broken or partially downgraded Rancher setup after upgrading to v2.7.5. Allow the startup utility to revert the Active Directory changes to restore functionality to your setup. 

Even if you're currently on Rancher v2.7.5 and your setup wasn't broken by the Active Directory changes, you should still upgrade to v2.7.6 or later and allow the startup utility to revert the migration.

The reverse migration startup utility saves all relevant changes to Rancher if it finds GUID-based users in Active Directory. The users' data (including the user object, all bindings, and tokens) return a Distinguished Name as the principalID. If the LDAP connection permanently fails during execution of the utility, Rancher automatically retries the utility several times with exponential backoff. Missing users are left behind and reported to the local admin for manual review.

If you need to clean up any missing users following an upgrade to the latest Rancher version, contact support.

### Long-standing Rancher Behavior Changes

- The `cluster-api` core provider controllers are now run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094). <!-- team/area2 -->
- Changed the token hashing algorithm to generate new tokens using SHA3. Existing tokens will not be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Existing tokens which don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while Token Hashing is enabled, you should re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062). <!-- team/area1 --><!-- team/scaling -->
- If you use a version of backup restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).
- Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Note that restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions ideally need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
- The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).
- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.8

### Tools
- CLI - [v2.7.7](https://github.com/rancher/cli/releases/tag/v2.7.7)
- RKE - [v1.4.10](https://github.com/rancher/rke/releases/tag/v1.4.10)

### Kubernetes Versions for RKE
- v1.26.8 (Default)
- v1.25.13
- v1.24.17
- v1.23.16

### Kubernetes Versions for RKE2/K3s
- v1.26.9 (Default)
- v1.25.14
- v1.24.17
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Long-standing Known Major Issues

- The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
- Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).<!-- team/area2 -->
- Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259). <!-- team/area3 -->
- Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - **Any distribution - Windows:**
    - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426). 
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **RKE2 and K3s:**
    - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. However, there is a [workaround](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) for fixing these node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
    - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
<!-- - **Infrastructures:** -->
  <!-- - **vSphere:**-->
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
      1. Refresh the `rancher-charts` catalog resource.
      1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
      1. Select the dot menu to select **Upgrade** to check if there is a newer Fleet version listed.
      1. Update the `fleet` chart. Fleet will automatically update the agents.
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and selectinging Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Removed legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## All issues in v2.7.8 milestone

* [#43019](https://github.com/rancher/rancher/issues/43019) [Backport v2.7] [BUG] unable to provision EC2/vSphere clusters 
-----
> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> ### There is a known issue in this version that affects node-provisioned clusters for certain cloud infrastructure providers (including EC2 and vSphere).
> If you're affected by this issue it's recommended to use Rancher v2.7.6 instead until the fix is available.
>
> See [#43019](https://github.com/rancher/rancher/issues/43019) for more information.
> 
> For RKE2/K3s provisioning, there is a [workaround](https://github.com/rancher/rancher/issues/43019#issuecomment-1741564674) available.

Rancher v2.7.5 contained several major bugs. All users should skip upgrading to v2.7.5 and immediately upgrade to the latest Rancher version.

# Major Bug Fixes

- Fixed a bug where the `system-upgrade-controller` deployment might fail after Monitoring was enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646). <!-- team/area2 -->
- Fixed a bug where users newly added to a cluster or project would sometimes see an error relating to "impersonation", when making a request in Cluster Explorer or with kubectl. The error would contain the text, `error: timed out waiting for the condition`. See [#42020](https://github.com/rancher/rancher/issues/42020).<!-- team/area1 -->
- Fixed a bug where warnings about an "unknown field" appeared in the UI when updating any Kubernetes object for Kubernetes versions 1.25 and up. See [#41772](https://github.com/rancher/rancher/issues/41772). <!-- team/area1 -->
- Fixed a bug where the `fleet-agent` pod failed to deploy on an upgraded RKE2 Windows Custom cluster. See [#993](https://github.com/rancher/fleet/issues/993). <!-- team/fleet -->
- Fixed a bug where downstream private GKE clusters experienced issues when interacting with the resources that the webhook validates, such as namespaces. This could cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. See [#41142](https://github.com/rancher/rancher/issues/41142). <!-- team/area1 --><!-- team/highlander -->
- Fixed a bug where, if you edited RKE1 clusters with defined Cluster agent or Fleet agent configurations, removing those values and adding new ones to the same section resulted in the new values not being saved. You would need to edit the cluster and set the new values again to apply the change. See [#9003](https://github.com/rancher/dashboard/issues/9003). <!-- team/area2 -->
- Fixed a bug where a restore operation during a migration might fail with error messages such as the following: `error restoring rke2-ds of type cluster.x-k8s.io/v1alpha4`, `Resource=clusters: restoreResource: err getting resource conversion webhook for cluster.x-k8s.io/v1beta1`, `Kind=Cluster failed: Post "https://capi-webhook-service.cattle-provisioning-capi-system.svc:443/convert?timeout=30s": service "capi-webhook-service" not found `. These errors were caused by conversion webhooks, which were called by duplicated `cluster.x-k8s.io/v1alpha4` versioned resources erroneously included in the default backup resourceSet. As a fix, these unnecessary duplicated resources are removed from the default resourceSet used for backups. See [#42631](https://github.com/rancher/rancher/issues/42631). <!-- team/area2 --> <!-- team/area3 -->
  
  **NOTE**: If you use a previous version of backup-restore to backup Rancher v2.7.7, the migration will experience an `"capi-webhook-service" not found` error. Make sure that the 102.0.2+up3.1.2 version of Backup-Restore Operator (the version with `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet) is used for backups. If the latest chart version can't be used, then delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before performing a restore.

# Rancher Behavior Changes

- The `cluster-api` core provider controllers are now run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094). <!-- team/area2 -->
- Changed the token hashing algorithm to generate new tokens using SHA3. Existing tokens will not be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Existing tokens which don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while Token Hashing is enabled, you should re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062). <!-- team/area1 --><!-- team/scaling -->
- If you use a version of backup restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).

# Known Issues

- The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
- Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).<!-- team/area2 -->
- Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259). <!-- team/area3 -->

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Reverting the Active Directory Migration Delivered in v2.7.5

The following information *only* applies if you are upgrading from Rancher v2.7.5. It does *not* apply if you are upgrading directly to the latest Rancher version from v2.7.4 or earlier, or if you are upgrading to the latest Rancher version from v2.7.6.

Rancher v2.7.6 and later contain a reverse migration utility that runs at startup. Data migration is only triggered if you have been on Rancher v2.7.5.

Users will be corrected from the v2.7.5 data migration, which updated personalIDs to use GUIDs instead of Distinguished Names (DNs). Rancher v2.7.6 and later fix bugs related to the inability to login for various reasons. See [#41985](https://github.com/rancher/rancher/issues/41985) and [#42120](https://github.com/rancher/rancher/issues/42120). 

**Important:** If you disabled AD authentication while on v2.7.5, don't enable it after upgrading until after the utility is run. Doing so will cause the reverse migration to fail to clean up the remaining bad data.

We strongly recommend that you directly upgrade to the latest version of Rancher v2.7.x, especially if you're on a broken or partially downgraded Rancher setup after upgrading to v2.7.5. Allow the startup utility to revert the Active Directory changes to restore functionality to your setup. 

Even if you're currently on Rancher v2.7.5 and your setup wasn't broken by the Active Directory changes, you should still upgrade to v2.7.6 or later and allow the startup utility to revert the migration.

The reverse migration startup utility saves all relevant changes to Rancher if it finds GUID-based users in Active Directory. The users' data (including the user object, all bindings, and tokens) return a Distinguished Name as the principalID. If the LDAP connection permanently fails during execution of the utility, Rancher automatically retries the utility several times with exponential backoff. Missing users are left behind and reported to the local admin for manual review.

If you need to clean up any missing users following an upgrade to the latest Rancher version, contact support.

### Long-standing Rancher Behavior Changes

- Rancher installs the same pinned version of the rancher-webhook chart not only in the local cluster but also in all downstream clusters. Note that restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions ideally need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
- The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).
- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.7

### Tools
- CLI - [v2.7.7](https://github.com/rancher/cli/releases/tag/v2.7.7)
- RKE - [v1.4.10](https://github.com/rancher/rke/releases/tag/v1.4.10)

### Kubernetes Versions for RKE
- v1.26.8 (Default)
- v1.25.13
- v1.24.17
- v1.23.16

### Kubernetes Versions for RKE2/K3s
- v1.26.9 (Default)
- v1.25.14
- v1.24.17
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Long-standing Known Major Issues

- Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - **Any distribution - Windows:**
    - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426). 
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **RKE2 and K3s:**
    - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. However, there is a [workaround](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) for fixing these node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
    - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
<!-- - **Infrastructures:** -->
  <!-- - **vSphere:**-->
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
      1. Refresh the `rancher-charts` catalog resource.
      1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
      1. Select the dot menu to select **Upgrade** to check if there is a newer Fleet version listed.
      1. Update the `fleet` chart. Fleet will automatically update the agents.
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and selectinging Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Removed legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).


## All issues in v2.7.7 milestone

* [#42780](https://github.com/rancher/rancher/issues/42780) [BUG] Downstream clusters not coming up after migration on v2.7-head
* [#42756](https://github.com/rancher/rancher/issues/42756) [BUG] Upgrading from 102.0.1+up3.1.1 to 102.0.2+up3.1.2-rc2 doesn't actually apply update
* [#42734](https://github.com/rancher/rancher/issues/42734) [BUG] Upon upgrading to 2.7.6, uuid-unmigration can enter "Failure" state silently
* [#42725](https://github.com/rancher/rancher/issues/42725) [BUG][K3s][CIS-1.24 and CIS-1.7] All checks are failing on K3s clusters with the latest CIS chart 4.2.0-rc7
* [#42719](https://github.com/rancher/rancher/issues/42719) [BUG][CAPR] rancher-provisioning-capi-patch-sa job failing due to lack of exclusion from PSA enforcement
* [#42666](https://github.com/rancher/rancher/issues/42666) [Backport v2.7] [BUG] Global System Default Private Registry not being honored when pulling cattle-cluster-agent images, reverts back to docker.io
* [#42655](https://github.com/rancher/rancher/issues/42655) [BUG][RKE1][CIS-1.24] New failures observed on RKE1 permissive and hardened clusters with the latest CIS chart 4.2.0-rc6 
* [#42625](https://github.com/rancher/rancher/issues/42625) [BUG] Webhook 0.3 rejects a request that updates any PRTB that already has ServiceAccount field set
* [#42631](https://github.com/rancher/rancher/issues/42631) [v2.7.7 Regression] Service "capi-webhook-service" not found
* [#42592](https://github.com/rancher/rancher/issues/42592) [Backport v2.7] [BUG] Rancher pods panic on startup if cluster `.spec.rancherKubernetesEngineConfig` is null
* [#42577](https://github.com/rancher/rancher/issues/42577) [Backport v2.7] Update Nutanix node driver to version 3.4.0+
* [#42560](https://github.com/rancher/rancher/issues/42560) Port GUID fixes into 2.7-head
* [#42524](https://github.com/rancher/rancher/issues/42524) [BUG] Neo image CVEs
* [#42501](https://github.com/rancher/rancher/issues/42501) [BUG] Provisioning an RKE1 Custom Downstream Cluster Throws an error about unsupported Docker version 24.0.2
* [#42431](https://github.com/rancher/rancher/issues/42431) Feature charts: Need to add NeuVector chart 102.0.4+up2.6.2 in 2.7.x
* [#42391](https://github.com/rancher/rancher/issues/42391) flag provided but not defined: -format seen in docker-image-digests-linux pipeline on drone-publish
* [#42386](https://github.com/rancher/rancher/issues/42386) [BUG] Fix errors for specific checks in the RKE1 CIS 1.7 files
* [#42385](https://github.com/rancher/rancher/issues/42385) [BUG] Fix errors for specific checks in the RKE2 CIS 1.7 files 
* [#42384](https://github.com/rancher/rancher/issues/42384) [BUG] Fix errors for specific checks in the K3s CIS 1.7 files
* [#42496](https://github.com/rancher/rancher/issues/42496) EKS / AKS 2.7.7 Q3 Release testing
* [#42324](https://github.com/rancher/rancher/issues/42324) Add unit tests for LDAP authentication provider
* [#42255](https://github.com/rancher/rancher/issues/42255) [BUG]  Enabling ACE after cluster creation results in ACE endpoints access not working
* [#42241](https://github.com/rancher/rancher/issues/42241) Support for running `cattle-cluster-agent` with trace logging
* [#42222](https://github.com/rancher/rancher/issues/42222) [Forwardport v2.7] Create a migration code in rancher to revert any users back to DN if they were migrated to GUID
* [#42221](https://github.com/rancher/rancher/issues/42221) [Forwardport v2.7] Create pre-upgrade script to revert the GUID back to DN 
* [#42220](https://github.com/rancher/rancher/issues/42220) [Forwardport v2.7] Revert feature - GUID for the PrincipalID for Active Directory 
* [#42219](https://github.com/rancher/rancher/issues/42219) [Forwardport v2.7] Revert all GUID PRs - Revert the fixes attempted post v2.7.5
* [#42201](https://github.com/rancher/rancher/issues/42201) Node gets kicked out of Cluster after snapshots are restored.
* [#42196](https://github.com/rancher/rancher/issues/42196) Fix CVEs found by image scanning
* [#42171](https://github.com/rancher/rancher/issues/42171) [BUG] Test 3.2.1 in CIS scan fails on hardened RKE2 cluster
* [#42154](https://github.com/rancher/rancher/issues/42154) Update Hardening Guides to reflect removal of "protect-kernel-defaults" check in RKE/RKE2/K3S CIS 1.7 Profiles
* [#42140](https://github.com/rancher/rancher/issues/42140) Document expected failures for file permission issues on RKE, RKE2 and K3s Clusters when running CIS Scan
* [#42139](https://github.com/rancher/rancher/issues/42139) [BUG] Update the descriptions of role template in the roletemplate crd
* [#42138](https://github.com/rancher/rancher/issues/42138) [BUG] Test 4.2.6 in CIS scan fails on K3S cluster 
* [#42125](https://github.com/rancher/rancher/issues/42125) [BUG] Test 4.2.12 in CIS scan fails on RKE cluster
* [#42119](https://github.com/rancher/rancher/issues/42119) [BUG] CAPR machine-provisioned etcd nodes are never drained before deletion
* [#42114](https://github.com/rancher/rancher/issues/42114) User with the View Monitoring role is unable to view the list of Active Alerts in the Monitoring UI view
* [#42082](https://github.com/rancher/rancher/issues/42082) [BUG] Users are duplicated and cannot log in
* [#42068](https://github.com/rancher/rancher/issues/42068) [3rd Party Component Bump] Update Linode Node Driver to version 0.1.11+
* [#42034](https://github.com/rancher/rancher/issues/42034) [BUG] Deleting a master node breaks RKE2 cluster
* [#42020](https://github.com/rancher/rancher/issues/42020) [BUG] cattle-impersonation error preventing shell usage and kubectl usage
* [#42001](https://github.com/rancher/rancher/issues/42001) Fix flaky automated tests found during v2.7.5 release
* [#41998](https://github.com/rancher/rancher/issues/41998) [2.7] Update BCI versions in base images to `15.5`
* [#41959](https://github.com/rancher/rancher/issues/41959) Simplify image digests file creation in CI
* [#41942](https://github.com/rancher/rancher/issues/41942) Automate the Image Mirroring Process for KDM Releases 
* [#41917](https://github.com/rancher/rancher/issues/41917) [Bug] On rancher server upgrade and roll back, downstream clusters webhook version needs to be downgraded 
* [#41893](https://github.com/rancher/rancher/issues/41893) Kubewarden k8s 1.27 chart support
* [#41862](https://github.com/rancher/rancher/issues/41862) Forward port prometheus-federator 0.3.2
* [#41853](https://github.com/rancher/rancher/issues/41853) [flaky-test] TestCreateNamespaceProjectMember and TestCreateNamespaceProjectOwner
* [#41851](https://github.com/rancher/rancher/issues/41851) Add Docker 24.0.x version
* [#41808](https://github.com/rancher/rancher/issues/41808) [Flaky Tests] Address flaky tests preventing successful builds execution
* [#41772](https://github.com/rancher/rancher/issues/41772) [BUG] Allow Steve to handle generated fields.
* [#41757](https://github.com/rancher/rancher/issues/41757) [BUG] Panic: indexer conflict: map[byPod:{}] when upgrading rancher from 2.7.1 to 2.7.2  
* [#41736](https://github.com/rancher/rancher/issues/41736) [BUG] Agent crashed again and again when ingress backend is not a service, a resource for example.
* [#41729](https://github.com/rancher/rancher/issues/41729) [BUG] Broken Links in Rancher chart's README
* [#41727](https://github.com/rancher/rancher/issues/41727) [BUG] Project roles are associated to the Latest NameSpace only
* [#41689](https://github.com/rancher/rancher/issues/41689) Indentation error in rancher-gatekeeper 102.1.0+up3.12.0
* [#41669](https://github.com/rancher/rancher/issues/41669) [Research] Determine test coverage gaps in Team1 areas
* [#41631](https://github.com/rancher/rancher/issues/41631) [RFE] Add CIS-1.7 (1.25) Scan capability
* [#41602](https://github.com/rancher/rancher/issues/41602) Gatekeeper 100.3.0+up3.10.0 CRD unable to be cleaned up successfully, deinstall fail
* [#41493](https://github.com/rancher/rancher/issues/41493) [RFE] Docs for the Webhook Checks
* [#41394](https://github.com/rancher/rancher/issues/41394) [BUG] Machine pool names over 63 characters break CAPI machine deployments
* [#41292](https://github.com/rancher/rancher/issues/41292) [BUG] Can not upgrade RKE1 1.22 cluster via rancher 2.7.2+
* [#41180](https://github.com/rancher/rancher/issues/41180) [BUG] After Rancher 2.6.11 upgrade, rancher-v2.6.11-secret-migrator userAgent is constantly updating cluster resources
* [#41144](https://github.com/rancher/rancher/issues/41144) [BUG] rancher-cli v2.7.0 errors out trying to create an imported cluster
* [#41142](https://github.com/rancher/rancher/issues/41142) [BUG] Rancher v2.7.2: downstream Private GKE clusters are broken: "failed to call webhook: context deadline exceeded"
* [#41128](https://github.com/rancher/rancher/issues/41128) [BUG] disabling Harvester node driver should not remove its CRD and rke-machine-config
* [#41126](https://github.com/rancher/rancher/issues/41126) [BUG] Unable to delete etcd node from K3S cluster
* [#41886](https://github.com/rancher/rancher/issues/41886) Add CIS 1.24 benchmark support
* [#41094](https://github.com/rancher/rancher/issues/41094) Move embedded cluster-api controllers to more conventionally run controllers
* [#41036](https://github.com/rancher/rancher/issues/41036) [BUG] 2.7.2-rc7- monitoring/grafana - when users click some grafana links, a 404 is thrown. 
* [#41021](https://github.com/rancher/rancher/issues/41021) [BUG] Bootstrap secret lifecycle isn't respected
* [#40889](https://github.com/rancher/rancher/issues/40889) [BUG] etcd restore on an RKE1 cluster goes into `Updating` state with error `Backing off failure, delay: 30s` but the etcd restore finishes
* [#40416](https://github.com/rancher/rancher/issues/40416) [BUG] Rancher server startup gets stuck if KDM is blocked
* [#40396](https://github.com/rancher/rancher/issues/40396) Create QA documents for project monitoring
* [#40394](https://github.com/rancher/rancher/issues/40394) Create QA documents for monitoring
* [#39520](https://github.com/rancher/rancher/issues/39520) [BUG] RKE1 cluster does not successfully provision with ECR Private Registry configured and `cri-dockerd` enabled
* [#39335](https://github.com/rancher/rancher/issues/39335) [RFE] Rancher CRDs should support descriptions
* [#38728](https://github.com/rancher/rancher/issues/38728) [Tech Debt] Webhook Test Coverage
* [#38646](https://github.com/rancher/rancher/issues/38646) [BUG] `apply-system-agent-upgrader-windows` pod is in an error state in Windows RKE2 cluster
* [#38481](https://github.com/rancher/rancher/issues/38481) [BUG] RKE2 provisioning with custom NodeDriver fails when rancher has more than one replica
* [#37549](https://github.com/rancher/rancher/issues/37549) rke2/k3s encryption key rotation integration tests
* [#36319](https://github.com/rancher/rancher/issues/36319) Incorrect upgradable version shown on the helm v3 apps deployed from legacy partner apps
* [#36173](https://github.com/rancher/rancher/issues/36173) Fleet: Add Age and last modified metadata for resources
* [#36006](https://github.com/rancher/rancher/issues/36006) Job cattle-node-cleanup fails due to restrictive standard PSP
* [#35259](https://github.com/rancher/rancher/issues/35259) OpenLDAP: Result Code 32 "No Such Object"
* [#34518](https://github.com/rancher/rancher/issues/34518) Restoring rancher from a backup on a migrated rancher server fails with the error unable to create new content in namespace cluster-fleet-default-anupamapostbkp because it is being terminated error restoring
* [#33795](https://github.com/rancher/rancher/issues/33795) auto-generated Rolebinding label too long
* [#31163](https://github.com/rancher/rancher/issues/31163) SAML - Authentication pop up always show 404 on HA Rancher installs
-----
# Release v2.7.6

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

This is a minimal patch release dedicated to fixing a targeted set of regressions found in Rancher v2.7.5. All users should skip upgrading to 2.7.5 and immediately upgrade to 2.7.6.

# Major Bug Fixes
- Fixed a bug where attempted downloads of the Diagnostic Package would fail. See [#9471](https://github.com/rancher/dashboard/issues/9471) and [#9463](https://github.com/rancher/dashboard/issues/9463).
  
## Fixes in Fleet used for the provisioning framework
> - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
>  1. Go to **Apps**, select **All Workspaces** and note the versions of `fleet-crd` and `fleet-chart`.
>  1. Click the dot menu to select **Upgrade** to check if there is a newer Fleet version listed.
>  1. Update the `fleet` chart.
> Fleet will automatically update the fleet agents.

- Fixed a bug where fleet used for the provisioning framework created a large number of orphaned resources, which were then stored in etcd. This increased load on etcd, which caused timeouts. See [#1656](https://github.com/rancher/fleet/issues/1656) and [#1692](https://github.com/rancher/fleet/issues/1692).
- Fixed a bug where fleet used for the provisioning framework would periodically delete certain Kubernetes resources in bundles. Bundle IDs are trimmed to fit within the Helm release name length (53 chars) using the `<trimmed-release-name>-<6-char-hash>` format. When the 47th character of the original release name was already a dash (`-`), the generated release name would contain a double dash. This lead to discrepancies between the actual deployed release name, and the one Fleet expected to be deployed. This caused Fleet to delete and redeploy the corresponding bundle. See [#1660](https://github.com/rancher/fleet/issues/1660).

## RKE1 Provisioning Fixes

- Fixed a bug that prevented downstream RKE1 provisioned clusters with a K8s version of 1.22 or earlier to work within Rancher v2.7+. Now users can upgrade Rancher to v2.7.6 with older K8s version downstream clusters, but it is important to note that Rancher v2.7.0+ only supports K8s 1.23+. No compatibility testing is done with any K8s cluster that has a version of 1.22 or earlier. Rancher recommends upgrading all downstream clusters to 1.23+ before upgrading Rancher itself, but with this fix, Rancher setups that have failed to upgrade their downstream K8s cluster versions can still be managed after upgrading Rancher. See [#42127](https://github.com/rancher/rancher/issues/42127).

## RKE2/K3s Provisioning Fixes

- Fixed a bug where RKE2/K3s provisioned clusters would get stuck reconciling when the init etcd (master) node is deleted. See [#42121](https://github.com/rancher/rancher/issues/42121).
- Fixed a bug where performing subsequent snapshot restores on an RKE2/K3s provisioned cluster could cause a node to get deleted from the cluster. See [#42210](https://github.com/rancher/rancher/issues/42210).
- Fixed a bug where provisioning RKE2 nodes with a custom node driver may fail when there are multiple Rancher replicas running. See [#42128](https://github.com/rancher/rancher/issues/42128).
- Fixed a bug where, if you created a RKE2/K3s provisioned cluster with Harvester and set Harvester as the cloud provider, the name of the cluster wasn't passed as the name prefix for the load balancer. Instead, the name prepended to the load balancer was always `kubernetes`. See [#9472](https://github.com/rancher/dashboard/issues/9472) and [#4232](https://github.com/harvester/harvester/issues/4232).

## Active Directory Authentication Fixes

For any Rancher users running v2.7.4 or earlier, none of these fixes will apply to you as you will not have faced these specific bugs that were only created due to a 2.7.5 data migration for Active Directory. Upgrading directly to 2.7.6+ will bypass any changes as we are reverting the data migration. 

For any Rancher user running v2.7.5 with Active Directory authentication, the data migration introduced in v2.7.5 to move from Distinguished Names (DN) to GUIDs is being reverted and users will be corrected from the original data migration. Fixed bugs related to inability to login for various reasons. See [#41985](https://github.com/rancher/rancher/issues/41985), [#42120](https://github.com/rancher/rancher/issues/42120).

> Important Upgrade Note: Depending on the number of users and permissions granted to clusters and projects as well as the connection to your AD server, the script could take a couple of hours. Users will not be able to login during the migration, so please time your upgrades accordingly.

### Reverting the Active Directory Migration delivered in 2.7.5

Rancher v2.7.6 contains a reverse migration utility that runs at startup, but data migration is only triggered if you had been on Rancher v2.7.5. 

**Important:** If you disabled AD authentication while on v2.7.5, don't enable it after upgrading until after the utility is run. Doing so will cause the reverse migration to fail to clean up remaining bad data.

We strongly recommend that you directly upgrade to Rancher v2.7.6, especially if you're on a broken or partially downgraded Rancher setup after upgrading to v2.7.5. Allow the startup utility to revert the Active Directory changes to restore functionality to your setup. 

Even if you're currently on Rancher v2.7.5 and your setup wasn't broken by the Active Directory changes, you should still upgrade to v2.7.6 and allow the startup utility to revert the migration.

The reverse migration startup utility saves all relevant changes to Rancher if it finds GUID-based users in Active Directory and the users' data (including user object, and all bindings and tokens) return a Distinguished Name as the principalID. If the LDAP connection permanently fails during execution of the utility, Rancher automatically retries the utility several times with exponential backoff. Missing users are left behind and reported to the local admin for manual review.

If, following an upgrade to Rancher v2.7.6, you need to clean up any missing users, contact support.

The reverse migration utility fetches following resources and updates them back to using DN: 
- Tokens
- CRTBs
- PRTBs
- GRBs (global role bindings)
- User object

Thus admins should ideally check how much of the above objects are present in the setup and time the upgrade accordingly. 
Following is the overall estimate of how long the migration can take depending on the number of users and bindings/tokens present in the setup:
- About 10000 users took roughly 30 mins while testing on a single laptop, one pod rancher setup.
- QA has tested with 21093 cluster role bindings with 7000 CRTBs. It took 4minutes.
- So if a setup has large number of users and bindings, it can take longer upto ~1 hour depending on cpu/memory and actual scale of the data. 

<!--# Rancher Behavior Changes-->
# Known Issues
- Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [42582](https://github.com/rancher/rancher/issues/42582).
- Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. However, there is a [workaround](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) for fixing these node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426). 
- When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
  1. Refresh the `rancher-charts` catalog resource.
  1. Go to **Apps**, select **All Workspaces** and note the versions of `fleet-crd` and `fleet-chart`.
  1. Click the dot menu to select **Upgrade** to check if there is a newer Fleet version listed.
  1. Update the `fleet` chart.
Fleet will automatically update the agents.

- Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a Github repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or Github repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Long-standing Rancher Behavior Changes

- Rancher installs the same pinned version of the rancher-webhook chart not only in the local cluster but also in all downstream clusters. Note that restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions ideally need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
- The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).
- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.6

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.8](https://github.com/rancher/rke/releases/tag/v1.4.8)

### Kubernetes Versions for RKE
- v1.26.7 (Default)
- v1.25.12
- v1.24.16
- v1.23.16

### Kubernetes Versions for RKE2/K3s
- v1.26.7 (Default)
- v1.25.12
- v1.24.16
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Long-standing Known Major Issues

- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
    - The `fleet-agent` pod fails to deploy on an upgraded RKE2 Windows Custom cluster. See [#993](https://github.com/rancher/fleet/issues/993).
  - **RKE2 and K3s:**
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
    - If you have downstream private GKE clusters, you might experience issues when interacting with the resources that the webhook validates, such as namespaces. This can cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. As a [workaround](https://github.com/rancher/rancher/issues/41142#issuecomment-1505624756), add a firewall setting to allow traffic to the webhook. See [#41142](https://github.com/rancher/rancher/issues/41142).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
    - When you edit RKE1 clusters with defined Cluster agent or Fleet agent configurations, removing these values and adding new ones to the same section results in the new values not being saved. Editing the cluster and setting the new values again will correctly apply the change. See [#9003](https://github.com/rancher/dashboard/issues/9003).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Remove legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## All issues in v2.7.6 milestone

* [#42478](https://github.com/rancher/rancher/issues/42478) [BUG] AD Migration | Connection to LDAP lost during un-migration and users skipped and given empty DNs | cannot login
* [#42467](https://github.com/rancher/rancher/issues/42467) [BUG] AD migration script doesn't have proper start and end log messages in Rancher
* [#42466](https://github.com/rancher/rancher/issues/42466) [BUG] Post upgrade, AD user cluster owner cannot list anything on the cluster 
* [#42465](https://github.com/rancher/rancher/issues/42465) [BUG] AD admin users were allowed to log in while the migration runs
* [#42253](https://github.com/rancher/rancher/issues/42253) [2.7.6][BUG] Fleet v0.7.1-rc.1 is not in 2.7.6-head causing errors during docker install
* [#42210](https://github.com/rancher/rancher/issues/42210) [Backport v2.7.6] Node gets kicked out of Cluster after snapshots are restored.
* [#42174](https://github.com/rancher/rancher/issues/42174) [v2.7.6] Revert feature - GUID for the PrincipalID for Active Directory 
* [#42163](https://github.com/rancher/rancher/issues/42163) Create a migration code in rancher to revert any users back to DN if they were migrated to GUID
* [#42162](https://github.com/rancher/rancher/issues/42162) Create pre-upgrade script to revert the GUID back to DN 
* [#42161](https://github.com/rancher/rancher/issues/42161) Revert all GUID PRs - Revert the fixes attempted post v2.7.5
* [#42128](https://github.com/rancher/rancher/issues/42128) [Backport v2.7.6] [BUG] RKE2 provisioning with custom NodeDriver fails when rancher has more than one replica
* [#42127](https://github.com/rancher/rancher/issues/42127) [Backport v2.7.6] [BUG] Can not upgrade RKE1 1.22 cluster via rancher 2.7.2+
* [#42122](https://github.com/rancher/rancher/issues/42122) [Backport v2.7.6] [BUG] Rancher 2.7.5 Active Directory authentication fails completely in Rancher 2.7.5 due to wrong objectGUID escaping
* [#42121](https://github.com/rancher/rancher/issues/42121) [Backport v2.7.6] [BUG] Deleting a master node breaks RKE2 cluster
* [#42120](https://github.com/rancher/rancher/issues/42120) [BUG] Users are duplicated and cannot log in
* [#41985](https://github.com/rancher/rancher/issues/41985) [BUG] Rancher 2.7.5 Active Directory authentication fails completely in Rancher 2.7.5 due to wrong objectGUID escaping
-----
# Release v2.7.5

### There are known major issues in this release, please skip this release and upgrade directly to v2.7.6 or above.

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

This release is primarily focused on stability enhancements and bug fixes.

# Features and Enhancements

### Kubernetes v1.26 Support

Support for Kubernetes 1.26 has been added. See [#41113](https://github.com/rancher/rancher/issues/41113) for more details. See the upstream Kubernetes [changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md) for a full list of changes.

### Docker 23.0 Support

<!-- team/area2, team/infracloud -->
Support for Docker 23.0 has been added. See [#40731](https://github.com/rancher/rancher/issues/40731) for more details. See the upstream Docker [release notes](https://docs.docker.com/engine/release-notes/23.0/) for a full list of changes.

### Improved Install Process for Kubernetes v1.25 and Above

Rancher versions 2.7.2 through 2.7.4 require users to set `global.cattle.psp.enabled` to `false` to install on Kubernetes versions 1.25 and above. Rancher will now attempt to detect if a cluster is running a Kubernetes version where PSPs are not supported, and default usage of PSPs to `false` if it can determine that PSPs are not supported in the cluster. Users can still manually override this by explicitly providing `true` or `false` for this value. Rancher will still use PSPs by default in clusters which support PSPs, such as clusters running Kubernetes versions 1.24 or lower.

If you install Rancher with PSPs enabled on a cluster which doesn't support PSPs, such as by overriding this value to `true` when installing the chart, you may experience issues when attempting to uninstall Rancher, which can leave resources behind. In these cases, you should run the [Rancher cleanup tool](https://github.com/rancher/rancher-cleanup) to remove any left-over artifacts of Rancher, and complete the uninstall process. See [#41455](https://github.com/rancher/rancher/issues/41455) for more details.

### New in Rancher

<!-- team/mapps -->
- Increased the refresh time to 6 hours when updating the Rancher charts Helm repository. This mitigates timeout errors on git.rancher.io during Rancher releases. See [#40805](https://github.com/rancher/rancher/issues/40805).
- You can now select Okta groups from the **Member Roles** dropdown under **Cluster Settings**. See [#38029](https://github.com/rancher/rancher/issues/38029) for more details.
- Added customization support for scheduling fields and resource limits for the cluster agent, and for the cluster's Fleet agent. You can use this feature to modify cluster tolerations, affinity rules, and resource requirments. See [#41035](https://github.com/rancher/rancher/issues/41035) and the [Rancher documentation](https://ranchermanager.docs.rancher.com/pages-for-subheaders/rancher-server-configuration) (under *Cluster Agent Configuration and Fleet Agent Configuration* for your respective Kubernetes distribution).

### New in the Rancher UI

- The Advanced Worker now supports the `management` and `rancher` stores, and  handles socket management and event processing within a Web Worker . See [#8837](https://github.com/rancher/dashboard/issues/8837).
- You can view a list of resources for projects with a single request by filtering by one or more projects or namespaces. See [#7618](https://github.com/rancher/dashboard/issues/7618).

# Major Bug Fixes

<!-- team/area1 -->
- Disabled a feature that caused a significant memory increase in both Rancher and downstream clusters. See [#41379](https://github.com/rancher/rancher/issues/41379).
<!-- team/area2, area/harvester, area/provisioning-v2 -->
- Fixed an issue where, during an upgrade of RKE2 in a Harvester cluster, the first node would be upgraded while the remaining server nodes' scheduling was disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
<!-- team/area1, area/ingress, area/server-chart -->
- Added the `--set service.type: NodePort` Helm setting. This resolves an issue where clusters that used the default GKE ingress but didn't use VPC-native mode were incompatible with `cattle-system/rancher`. See [#16061](https://github.com/rancher/rancher/issues/16061).
- Fixed an issue where, when removing finalizers from a provisioning cluster object, there was a race condition between adding the finalizers back and the generating framework that deletes the generated `rkecluster`, `rkecontrolplane`, `cluster.cluster.x-k8s.io` and `machinedeployment`s. See [#41887](https://github.com/rancher/rancher/issues/41887).
<!-- team/area2, team/infracloud -->
- The `v1.24.14+k3s1`, `v1.25.10+k3s1`, and `v1.26.5+k3s1` K3s versions added in Rancher v2.7.5 fix an issue where Ingress wasn't working on certain K3s clusters following an upgrade. There is a [workaround](https://github.com/k3s-io/k3s/issues/7586#issuecomment-1555414626) for earlier Kubernetes versions. See [#41582](https://github.com/rancher/rancher/issues/41582). 

# Rancher Behavior Changes

<!-- team/area1 -->
- Rancher now installs the same pinned version of the rancher-webhook chart not only in the local cluster but also in all downstream clusters. Note that restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions ideally need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
- The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

# Known Issues

- After upgrading to Rancher v2.7.5, LDAP-based login using Active Directory integration fails due a change in the LDAP search scope. See [#42122](https://github.com/rancher/rancher/issues/42122).
- After upgrading to Rancher v2.7.5, a migration is performed due to the LDAP search scope update. During the migration, logging in with a user that hasn't been migrated yet will create a duplicate user. The initial login succeeds, but the user won't have the expected permissions and subsequent logins will fail due to duplicates of the user existing. See [#42120](https://github.com/rancher/rancher/issues/42120).
- When you try to upgrade an RKE1 v1.22 cluster on Rancher v2.7.2 or above, the upgrade fails with a "failure to validate" cluster error. See [#42127](https://github.com/rancher/rancher/issues/42127).
- When you try to provision an RKE2 node with a custom Docker machine driver and already have multiple Rancher replicas running, the provisioning job will fail, as it can not find the driver in `/assets`. See [#42128](https://github.com/rancher/rancher/issues/42128).
- Attempting to delete a master node breaks the ectd configuration on the former master node. Endpoints won't update correctly and the leader election process will fail. This breaks the Cluster API. See [#42121](https://github.com/rancher/rancher/issues/42121).
- Fleet periodically deletes certain Kubernetes resources in bundles. Bundle IDs are trimmed to fit within the Helm release name length (53 chars) using the `<trimmed-release-name>-<6-char-hash>` format. When the 47th character of the original release name is already a dash (`-`), the generated release name will contain a double dash. This leads to discrepancies between the actual deployed release name, and the one expected by Fleet to be deployed. Fleet deletes and redeploys the corresponding bundle. See [#1660](https://github.com/rancher/fleet/issues/1660).	
- The relationship between a given Rancher version and a given Fleet version is currently not defined, which may lead to inconsistent versions of Fleet being installed during  Rancher upgrades. See [#1590](https://github.com/rancher/fleet/issues/1590).
- Fleet is creating a large number of orphaned resources, which are then stored in etcd. This increased load on etcd is leading to timeouts. See [#1656](https://github.com/rancher/fleet/issues/1656).
- During an RKE2 snapshot restore of a custom cluster, Rancher might delete nodes from the cluster. <!-- SURE-6669 -->
- When you edit RKE1 clusters with defined Cluster agent or Fleet agent configurations, removing these values and adding new ones to the same section results in the new values not being saved. Editing the cluster and setting the new values again will correctly apply the change. See [#9003](https://github.com/rancher/dashboard/issues/9003).
<!-- dashboard, team/area2 -->
- When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
<!-- dashboard, team/area2 -->
- The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).
<!-- team/rke2 -->
- When you upgrade a Windows RKE2 cluster, the upgrade gets stuck on the Windows node and is unable to complete. Some logs indicate that RKE2 is unable to restart because the process is currently being used. See [#41868](https://github.com/rancher/rancher/issues/41868).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Long-standing Rancher Behavior Changes

- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.5

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.6](https://github.com/rancher/rke/releases/tag/v1.4.6)

### Kubernetes Versions for RKE

- v1.26.4 (Default)
- v1.25.9
- v1.24.13
- v1.23.16

### Kubernetes Versions for RKE2/K3s

- v1.26.5 (Default)
- v1.25.10
- v1.24.14
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Long-standing Known Major Issues
- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
    - The `fleet-agent` pod fails to deploy on an upgraded RKE2 Windows Custom cluster. See [#993](https://github.com/rancher/fleet/issues/993).
  - **RKE2 and K3s:**
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
    - If you have downstream private GKE clusters, you might experience issues when interacting with the resources that the webhook validates, such as namespaces. This can cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. As a [workaround](https://github.com/rancher/rancher/issues/41142#issuecomment-1505624756), add a firewall setting to allow traffic to the webhook. See [#41142](https://github.com/rancher/rancher/issues/41142).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Remove legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).


## All issues in v2.7.5 milestone

* [#41952](https://github.com/rancher/rancher/issues/41952) CI step `check-release-images-existing` fails on non-existing latest tag
* [#41915](https://github.com/rancher/rancher/issues/41915) [BUG] v2prov machine provisioned machines can get stuck in "Creating server * in infrastructure provider"
* [#41927](https://github.com/rancher/rancher/issues/41927) AKS: Unable to add new Nodepool without taints
* [#41887](https://github.com/rancher/rancher/issues/41887) [BUG] Do not delete CAPI cluster resources when finalizers are removed from provisioning cluster
* [#41804](https://github.com/rancher/rancher/issues/41804) [BUG] - machine v0.15.0-rancher100 is not in the Rancher image list
* [#41778](https://github.com/rancher/rancher/issues/41778) [BUG] - gitjob v0.1.54 is not in the Rancher image list 
* [#41762](https://github.com/rancher/rancher/issues/41762) Update ACI-CNI to 5.2.7.1
* [#41761](https://github.com/rancher/rancher/issues/41761) [Backport v2.6] Update ACI-CNI to 5.2.7.1
* [#41732](https://github.com/rancher/rancher/issues/41732) [BUG] Observing a panic on AKS clusters on a rancher server upgrade
* [#41730](https://github.com/rancher/rancher/issues/41730) Pin downstream cluster's webhook version
* [#41709](https://github.com/rancher/rancher/issues/41709) [BUG] CIS Benchmark App - TLS Issue
* [#41716](https://github.com/rancher/rancher/issues/41716) Can't create EKS cluster node pools `SignatureDoesNotMatch: Credential should be scoped to correct service: 'iam'.`
* [#41700](https://github.com/rancher/rancher/issues/41700) [BUG] RKE1, RKE2 fleet agent is not redeploying after upgrading from 2.7.3 -> 2.7-head
* [#41687](https://github.com/rancher/rancher/issues/41687) Add Hull tests to charts CI
* [#41656](https://github.com/rancher/rancher/issues/41656) [BUG] Force delete option on nodes is not working when the cluster deletion errors out
* [#41652](https://github.com/rancher/rancher/issues/41652) [BUG] okta user enters a bad state where can no longer login to rancher 
* [#41642](https://github.com/rancher/rancher/issues/41642) [BUG] Test 1.2.14 in CIS scan fails on k3s harden cluster. 
* [#41635](https://github.com/rancher/rancher/issues/41635) [BUG] Cluster deletion is stuck `Resource scheduled for deletion` on an rke2 node driver cluster
* [#41626](https://github.com/rancher/rancher/issues/41626) [RFE] vSphere CPI chart updates to upstream v1.25.2 / v1.24.5
* [#41625](https://github.com/rancher/rancher/issues/41625) Gatekepper 3.12 OOB release into 2.7
* [#41615](https://github.com/rancher/rancher/issues/41615) RKE2 and K3S - KDM Update for K8s May patch release for Rancher 2.7
* [#41614](https://github.com/rancher/rancher/issues/41614) RKE2 and K3S - KDM Update for K8s May patch release for Rancher 2.6
* [#41613](https://github.com/rancher/rancher/issues/41613) [BUG] rancher-webhook blocking CAPR operations/cluster operations in downstream cluster
* [#41612](https://github.com/rancher/rancher/issues/41612) [BUG] Change in socket behaviour leads to browser hang and unavailable Rancher (crash?)
* [#41589](https://github.com/rancher/rancher/issues/41589) [BUG] rke1 cluster agent customization is not restored when during a rancher (local cluster) restore
* [#41587](https://github.com/rancher/rancher/issues/41587) [CAPR] CAPR should deliver important instructions with idempotence
* [#41582](https://github.com/rancher/rancher/issues/41582) [BUG] Ingress related tests fails in post upgrade checks on k3s v1.26 after upgrade from v1.25.
* [#41565](https://github.com/rancher/rancher/issues/41565) [RFE] Bump Harvester node driver to v0.6.5
* [#41563](https://github.com/rancher/rancher/issues/41563) [CAPR] Keep any node that either has a matching machine UID label or matching machine status NodeRef during etcd restore
* [#41528](https://github.com/rancher/rancher/issues/41528) Update rancher/shell for Q2 milestone
* [#41526](https://github.com/rancher/rancher/issues/41526) Add RHEL 9 to docker automated tests in install-docker.
* [#41518](https://github.com/rancher/rancher/issues/41518) NeuVector k8s 1.26 chart support
* [#41517](https://github.com/rancher/rancher/issues/41517) Epinio: support of k8s 1.26
* [#41516](https://github.com/rancher/rancher/issues/41516) Longhorn  k8s 1.26 chart support
* [#41515](https://github.com/rancher/rancher/issues/41515) Harvester-csi-driver  k8s 1.26 chart support
* [#41514](https://github.com/rancher/rancher/issues/41514) Harvester  harvester-cloud-provider  k8s 1.26 chart support
* [#41513](https://github.com/rancher/rancher/issues/41513) k8s 1.26 support for rancher-vsphere-csi chart
* [#41512](https://github.com/rancher/rancher/issues/41512) k8s 1.26 support for rancher-vsphere-cpi chart
* [#41511](https://github.com/rancher/rancher/issues/41511) k8s 1.26 support for system-upgrade-controller chart
* [#41510](https://github.com/rancher/rancher/issues/41510) rancher -csp-adapter  k8s 1.26 chart support
* [#41509](https://github.com/rancher/rancher/issues/41509) rancher- rancher-webhook  k8s 1.26 chart support
* [#41508](https://github.com/rancher/rancher/issues/41508) rancher-monitoring  k8s 1.26 chart support
* [#41507](https://github.com/rancher/rancher/issues/41507) rancher-logging  k8s 1.26 chart support
* [#41506](https://github.com/rancher/rancher/issues/41506) rancher-cis-benchmark  k8s 1.26 chart support
* [#41505](https://github.com/rancher/rancher/issues/41505) rancher-backup  k8s 1.26 chart support
* [#41504](https://github.com/rancher/rancher/issues/41504) rancher-alerting-drivers  k8s 1.26 chart support
* [#41503](https://github.com/rancher/rancher/issues/41503) prometheus-federator  k8s 1.26 chart support
* [#41502](https://github.com/rancher/rancher/issues/41502) Detailed requirements for Fleet supporting k8s 1.26
* [#41501](https://github.com/rancher/rancher/issues/41501) ui-plugin-operator  k8s 1.26 chart support
* [#41499](https://github.com/rancher/rancher/issues/41499) [BUG] unable to provision rke1 node driver cluster
* [#41495](https://github.com/rancher/rancher/issues/41495) Add Unit Test for "managesystemagent" to ensure safe condition manipulation
* [#41486](https://github.com/rancher/rancher/issues/41486) rancher-gatekeeper  k8s 1.26 chart support
* [#41485](https://github.com/rancher/rancher/issues/41485) rancher-istio  k8s 1.26 chart support
* [#41467](https://github.com/rancher/rancher/issues/41467) Add Renovate bot to CIS-Scanning repo
* [#41458](https://github.com/rancher/rancher/issues/41458) [BUG][RKE2] - Reprovisioning all nodes in cluster causes nodes to get stuck in reprovisioning
* [#41457](https://github.com/rancher/rancher/issues/41457) [BUG] K3s cluster is stuck in `Updating` state on an etcd snapshot restore
* [#41455](https://github.com/rancher/rancher/issues/41455) [BUG] Improve Install Process for k8s 1.25 and above
* [#41454](https://github.com/rancher/rancher/issues/41454) Validate and add Docker 20.10.24, 23.0.3, 23.0.4, 23.0.5 & 23.0.6
* [#41416](https://github.com/rancher/rancher/issues/41416) Publishing the Regsync.yaml file for KDM releases
* [#41395](https://github.com/rancher/rancher/issues/41395) [Feature] k8s 1.26 support - apps and feature charts 
* [#41379](https://github.com/rancher/rancher/issues/41379) [BUG] Rancher agent's `CATTLE_REQUEST_CACHE_DISABLED` env var is false by default
* [#41376](https://github.com/rancher/rancher/issues/41376) RKE2 and K3S - 1.26 support in KDM
* [#41346](https://github.com/rancher/rancher/issues/41346) Move CAPR and provisioningv2 controllers into independent folders/packages
* [#41338](https://github.com/rancher/rancher/issues/41338) Bump Nginx Controller to 1.7.0 for RKE1 cluster version 1.24+ 
* [#41334](https://github.com/rancher/rancher/issues/41334) Enhance provisioning-tests to log more debug data
* [#41322](https://github.com/rancher/rancher/issues/41322) Documentation for OpenLDAP configuration
* [#41259](https://github.com/rancher/rancher/issues/41259) [Backport test] [BUG] custom cluster roles not available in downstream harvester cluster
* [#41256](https://github.com/rancher/rancher/issues/41256) [BUG] Rancher 2.7.2 Continually Logs 'Requesting kubelet certificate regeneration'
* [#41242](https://github.com/rancher/rancher/issues/41242) [BUG] Cannot enable localClusterAuthEndpoint on cluster created with Helm RKE2 template
* [#41229](https://github.com/rancher/rancher/issues/41229) Add docker 23.0 support to rancher tests.
* [#41225](https://github.com/rancher/rancher/issues/41225) [BUG] rancher v2.7.2 cattle-cluster-agent memory leak oom kill
* [#41218](https://github.com/rancher/rancher/issues/41218) Abstract v2prov KDM data
* [#41202](https://github.com/rancher/rancher/issues/41202) [BUG] `SystemUpgradeControllerReady` condition manipulation is causing unnecessary reconciliation of the rkecontrolplane object
* [#41200](https://github.com/rancher/rancher/issues/41200) [BUG] rancher-system-agent needs to stop attempting to reconcile plan/watching if the K8s API server is unhealthy/the secret changes 
* [#41192](https://github.com/rancher/rancher/issues/41192) [BUG] Docker installation script fails to install docker on RHEL 9
* [#41174](https://github.com/rancher/rancher/issues/41174) [BUG] helm-install-rke2-snapshot-controller jobs are in crashloop backoff post etcd snapshot/restore on an rke2 cluster 
* [#41167](https://github.com/rancher/rancher/issues/41167) Abstract system-agent-installer image resolution
* [#41145](https://github.com/rancher/rancher/issues/41145) [BUG] Rancher panics when provisioning rke2/k3s cluster without associated dynamic schema
* [#41140](https://github.com/rancher/rancher/issues/41140) [BUG] Cannot use asia-northeast3 (Seoul) GCP region for GKE
* [#41139](https://github.com/rancher/rancher/issues/41139) [BUG] Rancher deployed charts respect Rancher min/max version and k8s min/max version. (Webhook)
* [#41133](https://github.com/rancher/rancher/issues/41133) rancher-machine may not delete a vSphere VM if an error is encountered removing the cloud-init iso 
* [#41129](https://github.com/rancher/rancher/issues/41129) Deleting v2prov cluster leads to vague messaging
* [#41125](https://github.com/rancher/rancher/issues/41125) [BUG] Rancher managed RKE2 clusters stuck in "Waiting for probes: kube-controller-manager, kube-scheduler"
* [#41123](https://github.com/rancher/rancher/issues/41123) [BUG] Cannot create EKS cluster Field [nodeRole] cannot be nil for nodegroup [ng] in non-nil cluster [c-qm5db]
* [#41113](https://github.com/rancher/rancher/issues/41113) [Feature] K8s 1.26 support
* [#41107](https://github.com/rancher/rancher/issues/41107) [BUG] clusterprovisioner and health syncer controller conflict if status.Version is not set
* [#41098](https://github.com/rancher/rancher/issues/41098) [RFE] Fix vSphere CSI images installed by default
* [#41096](https://github.com/rancher/rancher/issues/41096) Add a link checker to verify links in install docker repo are pointing to the latest version of the script
* [#41093](https://github.com/rancher/rancher/issues/41093) Bump embedded cluster-api controllers to v1.4.x
* [#41080](https://github.com/rancher/rancher/issues/41080) [BUG] Unable to restore rke2/k3s provisioned clusters from etcd snapshot if cluster is completely down
* [#41073](https://github.com/rancher/rancher/issues/41073) Remove wrangler/pkg/git dependency 
* [#41070](https://github.com/rancher/rancher/issues/41070) [BUG] goroutine leak in  statsaggregator.go#callWithTimeout
* [#41046](https://github.com/rancher/rancher/issues/41046) [BUG] Unable to provision with private AWS ECR repository
* [#41035](https://github.com/rancher/rancher/issues/41035) [RFE] Agent Deployment Customization Support
* [#41027](https://github.com/rancher/rancher/issues/41027) Add Hull testing to Istio charts
* [#41025](https://github.com/rancher/rancher/issues/41025) Add Hull coverage to CIS Scanning charts
* [#41017](https://github.com/rancher/rancher/issues/41017) [RFE] vSphere CSI chart updates to upstream v3.0.0 / v2.6.3
* [#40994](https://github.com/rancher/rancher/issues/40994) [BUG] RKE2 etcd snapshot from S3 with private CA can not be restored
* [#40968](https://github.com/rancher/rancher/issues/40968) [BUG] Specifying CA Certificate Bundle in v2prov registry authentication leads to duplicate file definition in v2prov plan
* [#40959](https://github.com/rancher/rancher/issues/40959) Add Istio 1.16.x and 1.17.x to Rancher
* [#40946](https://github.com/rancher/rancher/issues/40946) Remove yq from build environment
* [#40908](https://github.com/rancher/rancher/issues/40908) vSphere CPI chart updates to upstream v1.26.0 / v1.25.1 / v1.24.4 / v1.23.4 / v1.22.8
* [#40901](https://github.com/rancher/rancher/issues/40901) [RFE] Rancher machine hostname truncation
* [#40887](https://github.com/rancher/rancher/issues/40887) [BUG] Error `error parsing azure-group-cache-size , skipping update strconv.Atoi: parsing "": invalid syntax` seen in Rancher server
* [#40837](https://github.com/rancher/rancher/issues/40837) Rancher2 Terraform provider doesn't add ldap groups with '-' or '_' in the name
* [#40836](https://github.com/rancher/rancher/issues/40836) Publishing Images to Prime Registry for Chart OOB releases
* [#40826](https://github.com/rancher/rancher/issues/40826) Update webhook patch logic
* [#40824](https://github.com/rancher/rancher/issues/40824) [BUG] Display webhook error logs when Rancher prov test
* [#40805](https://github.com/rancher/rancher/issues/40805) Lower charts refresh time
* [#40785](https://github.com/rancher/rancher/issues/40785) [Forwardport v2.7] [BUG] RKE1 Clusters taking hours to come back up after a migration via backup/restore operator
* [#40768](https://github.com/rancher/rancher/issues/40768) [BUG] Backup Taken With Rancher Backups Operator That Include RKE2 Downstream Clusters Should Be Able to Be Used For More Than One Migration
* [#40731](https://github.com/rancher/rancher/issues/40731) Validate and add Docker 23.0.x version
* [#40727](https://github.com/rancher/rancher/issues/40727) Add option to enable vSphere toplogy in rancher-vsphere RKE1/RKE2 charts
* [#40716](https://github.com/rancher/rancher/issues/40716) [BUG] deploying monitoring 102.0.0+up40.1.2  on a downstream cluster with restrictive psps in 2.7.2-rc3 results in critical alerts
* [#40655](https://github.com/rancher/rancher/issues/40655) rancher-logging kube-audit pods should only run on CP nodes
* [#40643](https://github.com/rancher/rancher/issues/40643) [BUG] unable to register multi-role (etcd + controlplane) using k3s node driver; `Error, could not get list of group versions for APIService`
* [#40617](https://github.com/rancher/rancher/issues/40617) Move to upstream helm-unittest
* [#40580](https://github.com/rancher/rancher/issues/40580) [BUG] ConfigMap for provisioning logs are not getting backed up by backup restore operator
* [#40558](https://github.com/rancher/rancher/issues/40558) [BUG] Creating/deleting management resources cause resources to be unsubscribed
* [#40469](https://github.com/rancher/rancher/issues/40469) Add Docker 20.10.22, 20.10.23
* [#40483](https://github.com/rancher/rancher/issues/40483) Alert Driver chart install not being registered by the UI
* [#40434](https://github.com/rancher/rancher/issues/40434) [BUG] Documentation for `Cleaning up Nodes` results in errors 
* [#40397](https://github.com/rancher/rancher/issues/40397) Monitoring V2 Introduction and Release Documents
* [#40296](https://github.com/rancher/rancher/issues/40296) [BUG] Rancher throws panic when viewing API paths with insufficient permissions in DEBUG mode
* [#40372](https://github.com/rancher/rancher/issues/40372) [rancher-pushprox] Deprecated PSPs in K8S v1.25
* [#40214](https://github.com/rancher/rancher/issues/40214) [RFE][AKS] Create AgentPools with Node Labels, Node Taints and MaxSurge
* [#40180](https://github.com/rancher/rancher/issues/40180) Clearing value of `fleetWorkspaceName` leads to cluster deletion
* [#40159](https://github.com/rancher/rancher/issues/40159) [BUG] Pin Installed Version for Rancher-Webhook
* [#40055](https://github.com/rancher/rancher/issues/40055) Several RKE2 provisioning tests are skipped, re-enable?
* [#39792](https://github.com/rancher/rancher/issues/39792) [BUG] app catalog does not list chart vershttps://github.com/rancher/rancher-docs/issues/512ions that follow semver2.0
* [#39786](https://github.com/rancher/rancher/issues/39786) [BUG] project monitoring page - details section - metrics are not displaying
* [#39658](https://github.com/rancher/rancher/issues/39658) [BUG] Windows machine on vSphere fails to reconnect after graceful restart via vmware tools
* [#39638](https://github.com/rancher/rancher/issues/39638) [BUG] Rancher helm chart doesnt work with latest nginx helm chart due to ingress spec
* [#39588](https://github.com/rancher/rancher/issues/39588) [BUG] etcdctl with high UID causes docker error during image extraction due to failed user id remapping
* [#39222](https://github.com/rancher/rancher/issues/39222) [BUG] OpenStack node driver fails to delete node if cacert is provided
* [#39192](https://github.com/rancher/rancher/issues/39192) Automated testing for Plug-In Operator
* [#39167](https://github.com/rancher/rancher/issues/39167) [BUG] Multiple server nodes pre-drains in an RKE2 upgrade
* [#39087](https://github.com/rancher/rancher/issues/39087) [CSP Adapter] Support for new test product skus
* [#38688](https://github.com/rancher/rancher/issues/38688) [BUG]  "old" versions of EKS/AKS/GKE do not show up in the new Dashboard
* [#38509](https://github.com/rancher/rancher/issues/38509) Create new packaged helm repos to support terraform installations for multiple release versions
* [#38468](https://github.com/rancher/rancher/issues/38468) [RFE] Steve: Improve the performance of resource fetch requests
* [#38029](https://github.com/rancher/rancher/issues/38029) [Feature] Select groups with Okta integration
* [#37128](https://github.com/rancher/rancher/issues/37128) After upgrade to Monitoring v2 cluster name is no longer included in alerts
* [#37000](https://github.com/rancher/rancher/issues/37000) bump govmomi in rancher/machine to match upstream vsphere cloud provider
* [#35971](https://github.com/rancher/rancher/issues/35971) Dirty data of helm release causes cluster-agent to crash
* [#33778](https://github.com/rancher/rancher/issues/33778) 404s in browser dev console when viewing "Apps & Marketplace" for local cluster
* [#16061](https://github.com/rancher/rancher/issues/16061) [server-chart] Error deploying chart on GKE (evaluating ingress spec)
-----
# Release v2.7.4

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.7.4 is a security release to address the following issues:**

# Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Fixed an issue where users with `update` privileges on a namespace could move that namespace into a project they didn't have access to. For more information, see [CVE-2020-10676](https://github.com/rancher/rancher/security/advisories/GHSA-8vhc-hwhc-cpj4).
- Fixed an issue where cross-site scripting (XSS) could allow a malicious user to inject code executed within another user's browser. This would allow an attacker to steal sensitive information, manipulate web content, or perform other malicious activities on behalf of the victim. For more information, see [CVE-2022-43760](https://github.com/rancher/rancher/security/advisories/GHSA-46v3-ggjg-qq3x).
- Fixed an issue that enabled [Standard users](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/manage-role-based-access-control-rbac/global-permissions) or above to elevate their permissions to Administrator in the `local` cluster. For more information, see [CVE-2023-22647](https://github.com/rancher/rancher/security/advisories/GHSA-p976-h52c-26p6).
- Fixed an issue where changing a user's permissions in Azure AD wasn't reflected for users while they were logged in to the Rancher UI. This caused users to retain their previous permissions in Rancher, even if they changed groups on Azure AD. For more information, see [CVE-2023-22648](https://github.com/rancher/rancher/security/advisories/GHSA-vf6j-6739-78m8).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's GitHub repo.

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.4

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.5](https://github.com/rancher/rke/releases/tag/v1.4.5)

### Kubernetes Versions

- v1.25.9 (Default)
- v1.24.13
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Known Major Issues
- **Kubernetes Cluster Distributions:**
  - Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816). 
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE and RKE2:**
    - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
    - The `fleet-agent` pod fails to deploy on an upgraded RKE2 Windows Custom cluster. See [#993](https://github.com/rancher/fleet/issues/993).
  - **RKE2 and K3s:**
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
    - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
        - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
        - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
    - If you have downstream private GKE clusters, you might experience issues when interacting with the resources that the webhook validates, such as namespaces. This can cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. As a [workaround](https://github.com/rancher/rancher/issues/41142#issuecomment-1505624756), add a firewall setting to allow traffic to the webhook. See [#41142](https://github.com/rancher/rancher/issues/41142).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
- **Cluster Tools:**
  - **Authentication:**
    - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - - When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Remove legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.7.3

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

<!-- This note will only be present on the 2.7.3 release notes -->
**v2.7.3 resolves CVE-2023-22651, a critical vulnerability, but is otherwise a mirror release of v2.7.2. Please upgrade to v2.7.3 as soon as possible. See the [advisory](https://github.com/rancher/rancher/security/advisories/GHSA-6m9f-pj6w-w87g) for more information.**

# Features and Enhancements

### Kubernetes v1.25 Support

Support for Kubernetes v1.25 has been added. See [#38701](https://github.com/rancher/rancher/issues/38701)

### Pod Security Policies, Pod Security Admissions, and Pod Security Standards

Kubernetes v1.25 [removes](https://kubernetes.io/blog/2022/08/23/kubernetes-v1-25-release/#pod-security-changes) Pod Security Policies (PSPs). Rancher v2.7.2 [adds support](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards) for their replacement, [Pod Security admission (PSAs)](https://kubernetes.io/docs/concepts/security/pod-security-admission/) and [Pod Security Standards (PSSs)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). To facilitate their usage, Rancher v2.7.2 also adds a new custom resource definition (CRD): [PSA configuration templates](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/psa-config-templates). These templates are pre-defined security configurations that you can apply to RKE and RKE2/K3s clusters.

### Rancher Webhook Now Deployed Downstream

Starting with Rancher v2.7.2, a webhook is now installed in all downstream clusters, to validate and enforce certain boundaries. There is a known issue with behavior during rollbacks, as well as with downstream GKE private clusters; see the [Known Issues](#known-issues) section of these release notes for advice and instructions. See [#40816](https://github.com/rancher/rancher/issues/40816) and [#41142](https://github.com/rancher/rancher/issues/41142).

### New in Rancher

- Added support for provisioning downstream K3s clusters on ARM64. See [#34658](https://github.com/rancher/rancher/issues/34658).
- Added a new `global.cattle.psp.enabled` value to the Rancher Helm chart, to allow disabling of PSPs from within Rancher. See [#40327](https://github.com/rancher/rancher/issues/40327).
- The Rancher chart now exposes the `startupProbe` value, along with its `failureThreshold` and `periodSeconds` sub-values. These values are off by default. The `startupProbe` value  defaults to `1` for `failureThreshold` and `30` for `periodSeconds`  if they are not set. See [#38177](https://github.com/rancher/rancher/issues/38177) and [#39841](https://github.com/rancher/rancher/issues/39841).
- Validation of cert-manager v1.11.0 compatibility. See [#40880](https://github.com/rancher/rancher/issues/40880).
- If you trigger an upgrade to Kubernetes v1.25 on a cluster with existing PSP resources but the PSP feature is disabled at the cluster level, the upgrade will still complete and the PSP resources will no longer be active or accessible on the cluster.

### New in the Rancher UI

- Added RBAC for Fleet users. See [#7315](https://github.com/rancher/dashboard/issues/7315).
- Updated the Azure driver to allow for more advanced configuration of Azure Node Driver Clusters for RKE2/K3s. **Important note:** These fields can only be configured on newly added node pools. See [#40609 (comment)](https://github.com/rancher/rancher/issues/40609#issuecomment-1501315519):
    - [Tags](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json) can be added to Azure nodes through the Rancher UI. See [#26955](https://github.com/rancher/rancher/issues/26955).
    - [Accelerated Networking](https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview) can be enabled on Azure nodes. This adds a dedicated NIC to each VM created by Rancher. See [#37847](https://github.com/rancher/rancher/issues/37847).
    - [Availability Zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview) can be selected when deploying nodes to Azure. Proper use of Availability Zones can result in a more resilient cluster. Each node can only exist in one Availability Zone. See [#39458](https://github.com/rancher/rancher/issues/39458).
- SSH and HTTPS protocols allowed for repos in Fleet. See [#7518](https://github.com/rancher/dashboard/issues/7518).
- Added support for the phoenixNAP (pnap) machine driver for node provisioning. See [#6695](https://github.com/rancher/dashboard/issues/6695).
- You can deploy node templates with Availability Zones in Azure, for both RKE and RKE2. See [#7180](https://github.com/rancher/dashboard/issues/7180) and [#7753](https://github.com/rancher/dashboard/issues/7753).
- You can assign custom instance roles for nodes in EKS groups. See [#4568](https://github.com/rancher/dashboard/issues/4568).
- You're prompted to select a namespace when there are a large number of resources. This is intended to help with performance. See [#6483](https://github.com/rancher/dashboard/issues/6483).
- The Service detail page always shows the external IP of the Load Balancer Service. See [#6245](https://github.com/rancher/dashboard/issues/6245).

# Major Bug Fixes

- Fixed an issue where etcd nodes can't be removed from RKE2/K3s clusters with dedicated nodes for control plane and etcd roles. Note: The downstream RKE2/K3s clusters must be upgraded to Kubernetes 1.23.7/1.24.11/1.25.7 or later for the fix to work. See [#40301](https://github.com/rancher/rancher/issues/40301).
- Fixed an issue where an RKE2/K3s cluster remains in an `Updating` state when performing a restore to Kubernetes v1.24, after it's been upgraded from Kubernetes v1.24 to Kubernetes v1.25. See [#40843](https://github.com/rancher/rancher/issues/40843).
- Fixed an issue where provisioning clusters with `--node-name` would fail with a `node not found` error if set to a value that doesn't match the default hostname. See [#40147](https://github.com/rancher/rancher/issues/40147).
- Fixed an issue where downstream K3s node driver clusters get stuck in an `Updating` state, when etcd and control plane roles share a node pool. The stuck clusters report, `Configuring bootstrap node(s): waiting for cluster agent to connect`. See [#40016](https://github.com/rancher/rancher/issues/40016).
- Fixed an issue where provisioning a downstream cluster with a `.` in its name prevents required Fleet components from deploying to the cluster. See [#39248](https://github.com/rancher/rancher/issues/39248).
- Fixed an issue where provisioning a hardened RKE2 cluster with the CIS 1.23 profile fails, if the cluster is on Kuberetes v1.25. See [#39148](https://github.com/rancher/rancher/issues/39148).
- Fixed an issue with unreachable nodes on downstream RKE2/K3s clusters. Setting `Auto Replace` didn't result in the clusters being deleted and replaced. See [#39139](https://github.com/rancher/rancher/issues/39139).
- Fixed an issue with faulty formation of Keycloak search URLs. Rancher used to form a search URL for Keycloak by splitting the string based on the presence of `/auth/`. Newer Keycloak versions using the Quarkus Distribution didn't include this value, causing a panic when users attempted to integrate Keycloak with Rancher. Rancher was updated to properly form this search URL for Quarkus Based distributions. Thank you to `@jamhed` for developing a fix for this issue. See [#38683](https://github.com/rancher/rancher/issues/38683).
- Fixed an issue where removing a resource quota limit from a project didn't remove the corresponding limit from the project's namespaces. See [#38010](https://github.com/rancher/rancher/issues/38010).
- Fixed an issue where high CPU usage was observed on RKE v1.24.x clusters. See [#38816](https://github.com/rancher/rancher/issues/38816).
- Fixed an issue where groups weren't being evaluated when determining a user's permission to Manage Cluster Members and Project Members. See [#196](https://github.com/rancher/webhook/pull/196).
- Fixed an issue where tokens were created with an invalid `GroupPrincipals` value, which prevents the token from being updated. See [#39107](https://github.com/rancher/rancher/issues/39107).
- Fixed an issue that prevented `pod_security_policy_template_id` from being removed using the Rancher Terraform provider. See [#40494](https://github.com/rancher/rancher/issues/40494).
- Fixed an issue that prevented authentication providers from being enabled again after they were previously disabled outside of the Rancher UI. See [#40878](https://github.com/rancher/rancher/issues/40878).
- Fixed an issue where provisioning new RKE clusters with a password-protected private registry may fail. See [#40321](https://github.com/rancher/rancher/issues/40321#issuecomment-1407095199) for a workaround and more information on the issue.
- Fixed an issue in RKE clusters on Kubernetes v1.24, where cAdvisor `container` labels and metric series would break Monitoring V2 dashboards. See [#38934](https://github.com/rancher/rancher/issues/38934).
- Fixed an issue where encryption keys may fail to rotate when there are a large number of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
- Fixed an issue with downstream K3s clusters not working in certain proxied environments. See [#39284](https://github.com/rancher/rancher/issues/39284).
- Fixed an issue preventing the creation of Digital Ocean Node Templates. See [#8476](https://github.com/rancher/dashboard/issues/8476).
- Project owners can now select Services for Ingress. See [#7194](https://github.com/rancher/dashboard/issues/7194).
- The UI properly displays the TLS expiration date on certificates. See [#7081](https://github.com/rancher/dashboard/issues/7081).
- Cloned namespaces are now created and put in the same project. See [#7231](https://github.com/rancher/dashboard/issues/7231).
- Adding a label to a pod through the Rancher UI no longer triggers an error. See [#8074](https://github.com/rancher/dashboard/issues/8074).
- Changing the vSphere CPU value no longer resets the CPU value to the default, when other values are changed. See [#7783](https://github.com/rancher/dashboard/issues/7783).
- Browsers no longer run out of memory when tailing log files. See [#7156](https://github.com/rancher/dashboard/issues/7156).
- The UI now shows the correct number of active pods, and the active pod percentage won't ever be erronously displayed as being over 100%. See [#7504](https://github.com/rancher/dashboard/issues/7504).

# Rancher Behavior Changes

- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).

# Known Issues

- Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
  - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - If you have downstream private GKE clusters, you might experience issues when interacting with the resources that the webhook validates, such as namespaces. This can cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. As a [workaround](https://github.com/rancher/rancher/issues/41142#issuecomment-1505624756), add a firewall setting to allow traffic to the webhook. See [#41142](https://github.com/rancher/rancher/issues/41142). 
   - The webhook may auto-upgrade to a 2.7.4 compatible version if you are on 2.7.2/2.7.3 for downstream clusters. This may lead to an error with namespace creation in projects for users who aren't cluster owners. Users are recommended to upgrade to 2.7.4 to resolve the issue. See https://github.com/rancher/webhook/issues/245#issuecomment-1574350024 for more details and a workaround
- When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
- If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
- Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034).:
  - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method)
  - [K3s uninstall script](https://docs.k3s.io/installation/uninstall)
- When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
- You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
- Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
- Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.2

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.4](https://github.com/rancher/rke/releases/tag/v1.4.4)

### Kubernetes Versions

> In this Rancher release, Kubernetes versions differ between RKE and RKE2/K3s.

#### Kubernetes Versions for RKE

- v1.25.6 (Default)
- v1.24.10
- v1.23.16

#### Kubernetes Versions for RKE2/K3s

- v1.25.7 (Default)
- v1.24.11
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
    - The `fleet-agent` pod fails to deploy on an upgraded RKE2 Windows Custom cluster. See [#993](https://github.com/rancher/fleet/issues/993).
  - **RKE2 and K3s:**
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Remove legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).
-----
# Release v2.7.2

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

<!-- This note will only be present on the 2.7.2 release notes -->
**Warning: v2.7.2 contains a critical vulnerability, CVE-2023-22651. Customers currently on v2.7.2 should upgrade to v2.7.3 as soon as possible. v2.7.3 resolves this issue but is otherwise a mirror release of v2.7.2. Please see the [advisory](https://github.com/rancher/rancher/security/advisories/GHSA-6m9f-pj6w-w87g) for more information.**

# Features and Enhancements

### Kubernetes v1.25 Support

Support for Kubernetes v1.25 has been added. See [#38701](https://github.com/rancher/rancher/issues/38701)

### Pod Security Policies, Pod Security Admissions, and Pod Security Standards

Kubernetes v1.25 [removes](https://kubernetes.io/blog/2022/08/23/kubernetes-v1-25-release/#pod-security-changes) Pod Security Policies (PSPs). Rancher v2.7.2 [adds support](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards) for their replacement, [Pod Security admission (PSAs)](https://kubernetes.io/docs/concepts/security/pod-security-admission/) and [Pod Security Standards (PSSs)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). To facilitate their usage, Rancher v2.7.2 also adds a new custom resource definition (CRD): [PSA configuration templates](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/psa-config-templates). These templates are pre-defined security configurations that you can apply to RKE and RKE2/K3s clusters.

### Rancher Webhook Now Deployed Downstream

Starting with Rancher v2.7.2, a webhook is now installed in all downstream clusters, to validate and enforce certain boundaries. There is a known issue with behavior during rollbacks, as well as with downstream GKE private clusters; see the [Known Issues](#known-issues) section of these release notes for advice and instructions. See [#40816](https://github.com/rancher/rancher/issues/40816) and [#41142](https://github.com/rancher/rancher/issues/41142).

### New in Rancher

- Added support for provisioning downstream K3s clusters on ARM64. See [#34658](https://github.com/rancher/rancher/issues/34658).
- Added a new `global.cattle.psp.enabled` value to the Rancher Helm chart, to allow disabling of PSPs from within Rancher. See [#40327](https://github.com/rancher/rancher/issues/40327).
- The Rancher chart now exposes the `startupProbe` value, along with its `failureThreshold` and `periodSeconds` sub-values. These values are off by default. The `startupProbe` value  defaults to `1` for `failureThreshold` and `30` for `periodSeconds`  if they are not set. See [#38177](https://github.com/rancher/rancher/issues/38177) and [#39841](https://github.com/rancher/rancher/issues/39841).
- Validation of cert-manager v1.11.0 compatibility. See [#40880](https://github.com/rancher/rancher/issues/40880).
- If you trigger an upgrade to Kubernetes v1.25 on a cluster with existing PSP resources but the PSP feature is disabled at the cluster level, the upgrade will still complete and the PSP resources will no longer be active or accessible on the cluster.

### New in the Rancher UI

- Added RBAC for Fleet users. See [#7315](https://github.com/rancher/dashboard/issues/7315).
- Updated the Azure driver to allow for more advanced configuration of Azure Node Driver Clusters for RKE2/K3s. **Important note:** These fields can only be configured on newly added node pools. See [#40609 (comment)](https://github.com/rancher/rancher/issues/40609#issuecomment-1501315519):
    - [Tags](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json) can be added to Azure nodes through the Rancher UI. See [#26955](https://github.com/rancher/rancher/issues/26955).
    - [Accelerated Networking](https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview) can be enabled on Azure nodes. This adds a dedicated NIC to each VM created by Rancher. See [#37847](https://github.com/rancher/rancher/issues/37847).
    - [Availability Zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview) can be selected when deploying nodes to Azure. Proper use of Availability Zones can result in a more resilient cluster. Each node can only exist in one Availability Zone. See [#39458](https://github.com/rancher/rancher/issues/39458).
- SSH and HTTPS protocols allowed for repos in Fleet. See [#7518](https://github.com/rancher/dashboard/issues/7518).
- Added support for the phoenixNAP (pnap) machine driver for node provisioning. See [#6695](https://github.com/rancher/dashboard/issues/6695).
- You can deploy node templates with Availability Zones in Azure, for both RKE and RKE2. See [#7180](https://github.com/rancher/dashboard/issues/7180) and [#7753](https://github.com/rancher/dashboard/issues/7753).
- You can assign custom instance roles for nodes in EKS groups. See [#4568](https://github.com/rancher/dashboard/issues/4568).
- You're prompted to select a namespace when there are a large number of resources. This is intended to help with performance. See [#6483](https://github.com/rancher/dashboard/issues/6483).
- The Service detail page always shows the external IP of the Load Balancer Service. See [#6245](https://github.com/rancher/dashboard/issues/6245).

# Major Bug Fixes

- Fixed an issue where etcd nodes can't be removed from RKE2/K3s clusters with dedicated nodes for control plane and etcd roles. Note: The downstream RKE2/K3s clusters must be upgraded to Kubernetes 1.23.7/1.24.11/1.25.7 or later for the fix to work. See [#40301](https://github.com/rancher/rancher/issues/40301).
- Fixed an issue where an RKE2/K3s cluster remains in an `Updating` state when performing a restore to Kubernetes v1.24, after it's been upgraded from Kubernetes v1.24 to Kubernetes v1.25. See [#40843](https://github.com/rancher/rancher/issues/40843).
- Fixed an issue where provisioning clusters with `--node-name` would fail with a `node not found` error if set to a value that doesn't match the default hostname. See [#40147](https://github.com/rancher/rancher/issues/40147).
- Fixed an issue where downstream K3s node driver clusters get stuck in an `Updating` state, when etcd and control plane roles share a node pool. The stuck clusters report, `Configuring bootstrap node(s): waiting for cluster agent to connect`. See [#40016](https://github.com/rancher/rancher/issues/40016).
- Fixed an issue where provisioning a downstream cluster with a `.` in its name prevents required Fleet components from deploying to the cluster. See [#39248](https://github.com/rancher/rancher/issues/39248).
- Fixed an issue where provisioning a hardened RKE2 cluster with the CIS 1.23 profile fails, if the cluster is on Kuberetes v1.25. See [#39148](https://github.com/rancher/rancher/issues/39148).
- Fixed an issue with unreachable nodes on downstream RKE2/K3s clusters. Setting `Auto Replace` didn't result in the clusters being deleted and replaced. See [#39139](https://github.com/rancher/rancher/issues/39139).
- Fixed an issue with faulty formation of Keycloak search URLs. Rancher used to form a search URL for Keycloak by splitting the string based on the presence of `/auth/`. Newer Keycloak versions using the Quarkus Distribution didn't include this value, causing a panic when users attempted to integrate Keycloak with Rancher. Rancher was updated to properly form this search URL for Quarkus Based distributions. Thank you to `@jamhed` for developing a fix for this issue. See [#38683](https://github.com/rancher/rancher/issues/38683).
- Fixed an issue where removing a resource quota limit from a project didn't remove the corresponding limit from the project's namespaces. See [#38010](https://github.com/rancher/rancher/issues/38010).
- Fixed an issue where high CPU usage was observed on RKE v1.24.x clusters. See [#38816](https://github.com/rancher/rancher/issues/38816).
- Fixed an issue where groups weren't being evaluated when determining a user's permission to Manage Cluster Members and Project Members. See [#196](https://github.com/rancher/webhook/pull/196).
- Fixed an issue where tokens were created with an invalid `GroupPrincipals` value, which prevents the token from being updated. See [#39107](https://github.com/rancher/rancher/issues/39107).
- Fixed an issue that prevented `pod_security_policy_template_id` from being removed using the Rancher Terraform provider. See [#40494](https://github.com/rancher/rancher/issues/40494).
- Fixed an issue that prevented authentication providers from being enabled again after they were previously disabled outside of the Rancher UI. See [#40878](https://github.com/rancher/rancher/issues/40878).
- Fixed an issue where provisioning new RKE clusters with a password-protected private registry may fail. See [#40321](https://github.com/rancher/rancher/issues/40321#issuecomment-1407095199) for a workaround and more information on the issue.
- Fixed an issue in RKE clusters on Kubernetes v1.24, where cAdvisor `container` labels and metric series would break Monitoring V2 dashboards. See [#38934](https://github.com/rancher/rancher/issues/38934).
- Fixed an issue where encryption keys may fail to rotate when there are a large number of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
- Fixed an issue with downstream K3s clusters not working in certain proxied environments. See [#39284](https://github.com/rancher/rancher/issues/39284).
- Fixed an issue preventing the creation of Digital Ocean Node Templates. See [#8476](https://github.com/rancher/dashboard/issues/8476).
- Project owners can now select Services for Ingress. See [#7194](https://github.com/rancher/dashboard/issues/7194).
- The UI properly displays the TLS expiration date on certificates. See [#7081](https://github.com/rancher/dashboard/issues/7081).
- Cloned namespaces are now created and put in the same project. See [#7231](https://github.com/rancher/dashboard/issues/7231).
- Adding a label to a pod through the Rancher UI no longer triggers an error. See [#8074](https://github.com/rancher/dashboard/issues/8074).
- Changing the vSphere CPU value no longer resets the CPU value to the default, when other values are changed. See [#7783](https://github.com/rancher/dashboard/issues/7783).
- Browsers no longer run out of memory when tailing log files. See [#7156](https://github.com/rancher/dashboard/issues/7156).
- The UI now shows the correct number of active pods, and the active pod percentage won't ever be erronously displayed as being over 100%. See [#7504](https://github.com/rancher/dashboard/issues/7504).

# Rancher Behavior Changes

- You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).
- The Helm Controller in RKE2/K3s now respects the `managedBy` annotation. Project Monitoring V2 required a workaround in its initial release to set `helmProjectOperator.helmController.enabled: false` since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- Privilege escalation is now disabled by default when creating deployments. See [#7165](https://github.com/rancher/dashboard/issues/7165).
- Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
  - Rancher now aggregates the changed counts and only send a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
  - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, causing significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).
- When provisioning downstream clusters, the cluster name must now conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).

# Known Issues

- Starting with Rancher v2.7.2, a webhook will now be installed in all downstream clusters. There are several issues that users may encounter with this functionality:
  - If you rollback from a version of Rancher >= v2.7.2 to a version < v2.7.2, you'll experience an issue where the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after Rancher version < v2.7.2 is running) to remove the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).
  - If you have downstream private GKE clusters, you might experience issues when interacting with the resources that the webhook validates, such as namespaces. This can cause problems with activities where Rancher needs to interact with those resources, such as when you install charts. As a [workaround](https://github.com/rancher/rancher/issues/41142#issuecomment-1505624756), add a firewall setting to allow traffic to the webhook. See [#41142](https://github.com/rancher/rancher/issues/41142). 
- When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
- If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
- Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034).:
  - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method)
  - [K3s uninstall script](https://docs.k3s.io/installation/uninstall)
- When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. During an upgrade, this is a benign error and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
- You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
- Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
- Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
- Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after configuring another auth provider. To manually trigger cleanup for a disabled auth provider, add the management.cattle.io/auth-provider-cleanup annotation with the unlocked value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).
- When enabling some custom node drivers, the Cloud Credential creation page does not show the correct default fields and has an uneditable foo key. See [#8563](https://github.com/rancher/dashboard/issues/8563).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter (such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later), upgrade to RKE v1.19.2 or later to get Flannel version v0.13.0, which supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When installing or upgrading Rancher in an air gapped environment, add the flag `--no-hooks` to the `helm template` command, to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, you must use the privileged flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- In previous versions, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for sidecar audit logging, instead of Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some  necessary actions within Azure AD. This will cause errors.
- Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters. The default behavior has been changed, so that if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.2

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.4](https://github.com/rancher/rke/releases/tag/v1.4.4)

### Kubernetes Versions

> In this Rancher release, Kubernetes versions differ between RKE and RKE2/K3s.

#### Kubernetes Versions for RKE

- v1.25.6 (Default)
- v1.24.10
- v1.23.16

#### Kubernetes Versions for RKE2/K3s

- v1.25.7 (Default)
- v1.24.11
- v1.23.17

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
    - The `fleet-agent` pod fails to deploy on an upgraded RKE2 Windows Custom cluster. See [#993](https://github.com/rancher/fleet/issues/993).
  - **RKE2 and K3s:**
    - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).
  - **K3s:**
    - Clusters are in an `Updating` state even when it contains nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
  - Remove legacy feature multi-cluster app. See [#39525](https://github.com/rancher/rancher/issues/39525).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## All issues in v2.7.2 milestone

* [#41042](https://github.com/rancher/rancher/issues/41042) [BUG] Monitoring Chart - Upgrade fails from v100.2.0+up40.1.2 -> v101.0.0+up19.0.3
* [#41034](https://github.com/rancher/rancher/issues/41034) [Known Issue] Custom RKE2/K3s cluster nodes may go `NotReady` when deleting controlplane nodes
* [#41018](https://github.com/rancher/rancher/issues/41018) [BUG] Unable to install/upgrade v102 charts on hardened rke2 cluster
* [#41016](https://github.com/rancher/rancher/issues/41016) [BUG] 2.7.2-rc7 airgapped cluster throws error when attempting to install monitoring 
* [#41015](https://github.com/rancher/rancher/issues/41015) [BUG] 2.7.2-rc7 airgapped cluster throws error when attempting to install opa gatekeeper
* [#41006](https://github.com/rancher/rancher/issues/41006) Update image for canalFlannel to `rancher/mirrored-flannelcni-flannel:v0.19.2` for rke1 k8s 1.24.x
* [#40993](https://github.com/rancher/rancher/issues/40993) Update Etcd Version For k8s 1.25 in KDM
* [#40990](https://github.com/rancher/rancher/issues/40990) [BUG]chart repo pointing to release-v2.7 on downstream clusters when upgraded from rancher 2.7.1 to 2.7.2-rc7
* [#40988](https://github.com/rancher/rancher/issues/40988) [BUG] EKS hosted cluster removed through rancher is not cleaned up in AWS backend
* [#40983](https://github.com/rancher/rancher/issues/40983) [BUG] GKE hosted cluster upgrade options involving `upgrade node version` produce inconsistent results
* [#40982](https://github.com/rancher/rancher/issues/40982) [BUG] Windows rke2 custom cluster - nodes stop displaying metrics after upgrading to 1.25
* [#40981](https://github.com/rancher/rancher/issues/40981) [BUG] PSPs not removed in rke2 (custom) cluster when upgrading to 1.25
* [#40970](https://github.com/rancher/rancher/issues/40970) Cert manager not in resource set, version not reverted in backup/restore
* [#40941](https://github.com/rancher/rancher/issues/40941) [BUG] [rancher-monitoring] Unable to upgrade Rancher Monitoring from v101.0.0+up19.0.3 to 102.0.0+up40.1.2
* [#40936](https://github.com/rancher/rancher/issues/40936) [BUG] Incorrect node IP reported in certain setups
* [#40929](https://github.com/rancher/rancher/issues/40929) [BUG] RKE2 v1.24 downstream cluster is unable to successfully provision with a custom PSACT and PSP set
* [#40924](https://github.com/rancher/rancher/issues/40924) RKE2 Downstream Custom Cluster gets stuck in Updating State after rancher server upgrade
* [#40922](https://github.com/rancher/rancher/issues/40922) [BUG] Istio test worker nodes refusing to connect to demo book service after k8s upgrade 1.24.10 -> 1.25.6 
* [#40921](https://github.com/rancher/rancher/issues/40921) [BUG] Rocky87 2.7.2-RC6- error thrown blocking users from installing charts
* [#40920](https://github.com/rancher/rancher/issues/40920) [BUG] Rocky87 2.7.2-RC6- error thrown blocking users from installing charts without choosing a namespace
* [#40916](https://github.com/rancher/rancher/issues/40916) [BUG] Hosted AKS cluster created from rancher fails to get External/Public IP.
* [#40913](https://github.com/rancher/rancher/issues/40913) [BUG] Unable to disable PSPs for Istio chart on k8s 1.24.10
* [#40899](https://github.com/rancher/rancher/issues/40899) [BUG] The `Default Pod Security Policy` value is not restored after restoring the snapshot
* [#40886](https://github.com/rancher/rancher/issues/40886) [BUG] Error `waiting for dynamic schema to be populated for machine pool` is seen initially when creating an RKE2 cluster, before the cluster proceeds provisioning
* [#40885](https://github.com/rancher/rancher/issues/40885) [BUG] Fleet controller deployment won't come up active for a few minutes with prirority class not found error on rancher server migration 
* [#40878](https://github.com/rancher/rancher/issues/40878) [BUG] Can't re-enable auth provider after setting "enabled" to false in auth config
* [#40863](https://github.com/rancher/rancher/issues/40863) [BUG] Logging install on k8s 1.25 possible to have different versions when install fails due to psps
* [#40859](https://github.com/rancher/rancher/issues/40859) [BUG] In-Place k8s Upgrade of Local Cluster results in RKE2 Cluster staying stuck in `Updating` state
* [#40880](https://github.com/rancher/rancher/issues/40880) cert-manager `v1.7.1` not properly applying resources to standalone RKE1 clusters with PSACT, but `v1.11.0` does
* [#40853](https://github.com/rancher/rancher/issues/40853) [BUG] Not all charts have validate-psp-install.yaml available
* [#40843](https://github.com/rancher/rancher/issues/40843) [BUG] Restoring a v1.25 RKE2/K3s cluster back to its original v1.24 K8s version with 1 etcd/cp and 3 worker nodes causes cluster to be stuck in `Updating`
* [#40842](https://github.com/rancher/rancher/issues/40842) [BUG] cis chart version v3.0.0 upgrade path is broken when user tries to upgrade to 4.00-rc3 with existing PSPs in the cluster
* [#40838](https://github.com/rancher/rancher/issues/40838) [BUG] rancher-vsphere-cpi generates broken YAML configuration, fails to update
* [#40828](https://github.com/rancher/rancher/issues/40828) [forwardport 2.7] RKE2/K3s v1.24 Kubernetes versions incorrectly appear as experimental verions
* [#40820](https://github.com/rancher/rancher/issues/40820) [BUG] cis chart version v4.0.0-rc3 but getting an error in one of the pods container has runAsNonRoot and image will run as root
* [#40819](https://github.com/rancher/rancher/issues/40819) [BUG] RKE2 clusters stay in updating state post rancher backup/restore and a roll back 
* [#40818](https://github.com/rancher/rancher/issues/40818) [BUG] CIS scan 5.7.4 fails on RKE1 custom hardened cluster
* [#40817](https://github.com/rancher/rancher/issues/40817) [BUG] CIS scan 5.1.5 fails on RKE1/RKE2 custom hardened cluster
* [#40816](https://github.com/rancher/rancher/issues/40816) [BUG] Webhook is installed in the downstream cluster post rancher backup/restore roll back on a migrated cluster 
* [#40814](https://github.com/rancher/rancher/issues/40814) [RFE] Bump Harvester node driver to v0.6.3
* [#40807](https://github.com/rancher/rancher/issues/40807) [BUG] Un importing an rke1 cluster from rancher floods rancher logs with errors
* [#40788](https://github.com/rancher/rancher/issues/40788) [BUG][monitoring] global.cattle.psp.enabled=true in crd yaml but value=false in chart yaml
* [#40761](https://github.com/rancher/rancher/issues/40761) [RFE] Make the description of built-in PSACT templates more specific
* [#40755](https://github.com/rancher/rancher/issues/40755) Downstream RKE2 Node driver `v1.24.10` w/ PSP set to `default` and PSA set to `rancher-restricted` or `rancher-privileged`, fails to upgrade to k8s `v1.25.5` on Rancher: v2.7-head
* [#40741](https://github.com/rancher/rancher/issues/40741) [BUG] Updating internal server URL, internal server CA, and user token invalidates CAPI kubeconfig secret
* [#40739](https://github.com/rancher/rancher/issues/40739) Validate and document Hardened Imported k3s Cluster upgrade from 1.24 to 1.25
* [#40738](https://github.com/rancher/rancher/issues/40738) Validate and document Hardened Imported RKE2 Cluster upgrade from 1.24 to 1.25
* [#40737](https://github.com/rancher/rancher/issues/40737) Validate and document Hardened Provisioned k3s Cluster upgrade from 1.24 to 1.25
* [#40736](https://github.com/rancher/rancher/issues/40736) Validate and document Hardened Provisioned RKE2 Cluster upgrade from 1.24 to 1.25
* [#40718](https://github.com/rancher/rancher/issues/40718) [BUG] CIS scan with a v1.24 RKE2 custom cluster PSP set to `restricted` fails due to `global-restricted-psp` not being created
* [#40735](https://github.com/rancher/rancher/issues/40735) Alerting Drivers Installation fails without selecting driver type which is not shown on install screen by default
* [#40710](https://github.com/rancher/rancher/issues/40710) [Forwardport v2.7] [BUG] Fleet-Agent bundle errors out depending on Cluster Name
* [#40688](https://github.com/rancher/rancher/issues/40688) [v2.7.2] Add v1.24.10-rancher4-1 and v1.25.6-rancher4-1
* [#40685](https://github.com/rancher/rancher/issues/40685) [BUG] `rancher-webhook` and `rancher/shell` are not using the system default registry images in downstream clusters, instead they are using Docker images
* [#40676](https://github.com/rancher/rancher/issues/40676) Forward-port dev-v2.6 charts to dev-v2.7
* [#40664](https://github.com/rancher/rancher/issues/40664) [BUG] Docker install of Rancher instance on Digital Ocean for 2.7-head on restart loop
* [#40658](https://github.com/rancher/rancher/issues/40658) [Forwardport v2.7] Unable to Delete Custom Clusters from Rancher UI
* [#40656](https://github.com/rancher/rancher/issues/40656) Cannot set proxy environment variables for fluentd in rancher-logging chart
* [#40654](https://github.com/rancher/rancher/issues/40654) Logging v2 does not work in CSI profile enabled RKE2 cluster
* [#40652](https://github.com/rancher/rancher/issues/40652) [BUG] status report is incorrect when upgrading an rke1 cluster to 1.25+ with existing PSPs
* [#40651](https://github.com/rancher/rancher/issues/40651) [BUG] rke2 upgrade from 1.24 -> 1.25 `helm-install-calico-rke2` job is in `unavailable` state with `Upgrading rke2-calico Error: UPGRADE FAILED: unable to build kubernetes objects from current release manifest: resource mapping not found for name: "tigera-operator" namespace: "" from "": no matches for kind "PodSecurityPolicy" in version "policy/v1beta1"`
* [#40648](https://github.com/rancher/rancher/issues/40648) [BUG] CIS scan 5.3.2 fails on rke1 custom hardened cluster
* [#40628](https://github.com/rancher/rancher/issues/40628) [v2.7] Azure rke2/k3s node driver clusters have etcd nodes stuck in deleting state post rancher upgrade
* [#40609](https://github.com/rancher/rancher/issues/40609) [v2.7] Azure node driver rke2/k3s nodes get recreated post rancher server upgrade
* [#40575](https://github.com/rancher/rancher/issues/40575) [DOCS] Add documentation around PSP -> PSS upgrades and management
* [#40565](https://github.com/rancher/rancher/issues/40565) [BUG] System-Upgrade-Controller bundle errors out depending on Cluster Name
* [#40550](https://github.com/rancher/rancher/issues/40550) [Forwardport v2.7] [BUG] System Default Private Registry not being used to pull images
* [#40502](https://github.com/rancher/rancher/issues/40502) RKE2 and K3S - KDM Update for K8s February patch release for Rancher 2.7
* [#40494](https://github.com/rancher/rancher/issues/40494) [BUG] Rancher Terraform Provider: Unable to remove pod_security_policy from projects
* [#40492](https://github.com/rancher/rancher/issues/40492) Check release images using skopeo instead of docker manifest inspect
* [#40478](https://github.com/rancher/rancher/issues/40478) Rename Rancher's builtin PSACTs
* [#40472](https://github.com/rancher/rancher/issues/40472) Remove rancher-runtime references
* [#40464](https://github.com/rancher/rancher/issues/40464) Increment major version for rancher/charts to indicate k8s 1.25 support in Rancher v2.7.2
* [#40441](https://github.com/rancher/rancher/issues/40441) apply-system-agent-upgrader is intermittently stuck in error/unavailable pod creation loop
* [#40433](https://github.com/rancher/rancher/issues/40433) [BUG] When taking a snapshot of an RKE1 cluster with no PSACT value defined, editing the cluster's configuration to have a PSACT value and restoring the snapshot causes the PSACT value to persist when it shouldn't
* [#40408](https://github.com/rancher/rancher/issues/40408) [Forwardport v2.7] [BUG][monitoring] rancher-monitoring-prometheus-node exporter is healthy in UI but unhealthyin prometheus targets
* [#40405](https://github.com/rancher/rancher/issues/40405) [BUG] CIS Benchmark chart fails to upgrade
* [#40385](https://github.com/rancher/rancher/issues/40385) Support for updated PSP handling for `rancher-k3s-upgrader` (`system-upgrade-controller` (SUC)) from `system-charts`
* [#40384](https://github.com/rancher/rancher/issues/40384) Support for updated PSP handling for `system-upgrade-controller` (SUC) from `charts`
* [#40435](https://github.com/rancher/rancher/issues/40435) Update CIS Profiles for RKE2
* [#40354](https://github.com/rancher/rancher/issues/40354) [BUG] Logging in to rancher as an auth user throws 500 error after logging out of rancher
* [#40351](https://github.com/rancher/rancher/issues/40351) Update rancher-charts/ui-plugin-operator chart to support updated approach for PSPs
* [#40350](https://github.com/rancher/rancher/issues/40350) Update rancher-charts/rancher-monitoring chart to support updated approach for PSPs
* [#40349](https://github.com/rancher/rancher/issues/40349) Update rancher-charts/rancher-logging chart to support updated approach for PSPs
* [#40348](https://github.com/rancher/rancher/issues/40348) Update rancher-charts/rancher-backup chart to support updated approach for PSPs
* [#40347](https://github.com/rancher/rancher/issues/40347) Update rancher-charts/rancher-alerting-drivers chart to support updated approach for PSPs
* [#40346](https://github.com/rancher/rancher/issues/40346) Update rancher-charts/rancher-istio chart to support updated approach for PSPs
* [#40345](https://github.com/rancher/rancher/issues/40345) Update rancher-charts/rancher-cis-benchmark chart to support updated approach for PSPs
* [#40344](https://github.com/rancher/rancher/issues/40344) Update rancher-charts/rancher-gatekeeper chart to support updated approach for PSPs
* [#40343](https://github.com/rancher/rancher/issues/40343) Update rancher-charts/neuvector chart to support updated approach for PSPs
* [#40342](https://github.com/rancher/rancher/issues/40342) Update rancher-charts/longhorn chart to support updated approach for PSPs
* [#40338](https://github.com/rancher/rancher/issues/40338) Update rancher-charts/epinio chart to support updated approach for PSPs
* [#40335](https://github.com/rancher/rancher/issues/40335) [BUG] Can't warm restart docker installed Rancher due to webhook conflicts
* [#40331](https://github.com/rancher/rancher/issues/40331) Update feature charts to support updated approach for PSPs
* [#40328](https://github.com/rancher/rancher/issues/40328) Update Rancher to pass PSP setting to the webhook
* [#40327](https://github.com/rancher/rancher/issues/40327) Update Rancher's chart to support updated approach for PSPs
* [#40326](https://github.com/rancher/rancher/issues/40326) Update Webhook chart to support updated approach for PSPs
* [#40325](https://github.com/rancher/rancher/issues/40325) [BUG] `default_pod_security_admission_configuration_template_name` is not persisting while provisioning an RKE1 cluster
* [#40324](https://github.com/rancher/rancher/issues/40324) Update versions of Oracle OCI node driver and OKE cluster driver
* [#40321](https://github.com/rancher/rancher/issues/40321) [BUG] Creating new clusters with v2.6.10 with private credentials fails to pull rke-tools
* [#40318](https://github.com/rancher/rancher/issues/40318) [Forwardport v2.7] [BUG] `useInstanceMetadataHostname` not present in cluster.yml after initial provisioning of downstream RKE1 Custom cluster w/ cloud provider enabled
* [#40307](https://github.com/rancher/rancher/issues/40307) Monitoring - Alertmanager is not working when TLS enabled
* [#40306](https://github.com/rancher/rancher/issues/40306) Update Rancher's default restricted PSACT to support RKE2 profile cis-1.23
* [#40305](https://github.com/rancher/rancher/issues/40305) [BUG] Provisioning log config map is empty
* [#40301](https://github.com/rancher/rancher/issues/40301) [BUG] Cannot remove etcd nodes from K3s/RKE2 clusters if the cluster is architected with split controlplane/etcd roles
* [#40299](https://github.com/rancher/rancher/issues/40299) [BUG] Monitoring v2 chart fails to upgrade on a hardened K3s or RKE2 cluster
* [#40289](https://github.com/rancher/rancher/issues/40289) [RFE] `Manage PSACTs` global role should be implemented to ensure non-admin users can properly use PSACT during cluster provisioning
* [#40267](https://github.com/rancher/rancher/issues/40267) Drain provisioning test is flaky due to not forcing naked pods eviction
* [#40259](https://github.com/rancher/rancher/issues/40259) [BUG] Panic during etcd restore
* [#40247](https://github.com/rancher/rancher/issues/40247) [BUG] spike in CPU and memory in local cluster after upgrade to 2.6.9 from 2.6.6
* [#40332](https://github.com/rancher/rancher/issues/40332) Events table has empty columns
* [#40237](https://github.com/rancher/rancher/issues/40237) Add CIS hardening guide for rancher provisioned RKE2/K3S clusters on k8s 1.25
* [#40288](https://github.com/rancher/rancher/issues/40288) Standard users are unable to provision RKE1/RKE2 clusters with PSACT due to being unable to view global PSACTs
* [#40232](https://github.com/rancher/rancher/issues/40232) [BUG][RKE2] `node auto-replace` does not work on RKE2/k3s etcd nodes
* [#40230](https://github.com/rancher/rancher/issues/40230) [BUG] Hardened cluster should not have CIS "Fails"
* [#40229](https://github.com/rancher/rancher/issues/40229) Rancher security-scan-runner-scan runs on an etcd node, would like to run on a worker node
* [#40215](https://github.com/rancher/rancher/issues/40215) Release and update `system-agent` in Rancher
* [#40196](https://github.com/rancher/rancher/issues/40196) [BUG] resource.start event in websockets does not include namespace parameter
* [#40183](https://github.com/rancher/rancher/issues/40183) [BUG] VmwarevsphereMachine showing error state in vSphere provisioned RKE2 Cluster
* [#40173](https://github.com/rancher/rancher/issues/40173) [RFE] Bump Harvester node driver to v0.6.1
* [#40166](https://github.com/rancher/rancher/issues/40166) Rancher Webhook should allow omitted fields when validating PodSecurityAdmissionConfigurationTemplates
* [#40164](https://github.com/rancher/rancher/issues/40164) [BUG] Re-importing a cluster fails due to webhook not being fully deleted
* [#40149](https://github.com/rancher/rancher/issues/40149) [Docs] Document how to setup a PSA restricted-by-default local cluster
* [#40147](https://github.com/rancher/rancher/issues/40147) [Forwardport v2.7] node upgrade failed with 'node not found' in v2.6.4
* [#40143](https://github.com/rancher/rancher/issues/40143) Unable to provisioning RKE2/K3s Downstream Node Driver cluster with 63 characters in the name
* [#40139](https://github.com/rancher/rancher/issues/40139) Unable to provision RKE1 downstream cluster with multiple node pools on Linode
* [#40133](https://github.com/rancher/rancher/issues/40133) Errors in the local cluster when informer tries to list resources whose kind no longer exists
* [#40131](https://github.com/rancher/rancher/issues/40131) [BUG] Regression: Format of `resource.error` socket message is incorrect
* [#40127](https://github.com/rancher/rancher/issues/40127) [BUG] Fleet agents bundle in ErrApplied state post rancher upgrade from 2.5.16
* [#40110](https://github.com/rancher/rancher/issues/40110) Downstream Node Driver Cluster gets stuck in Updating State after rancher server upgrade
* [#40108](https://github.com/rancher/rancher/issues/40108) [BUG] Cannot install latest opa-gatekeeper verison 101.1.0+up3.10.0 - timeout
* [#40094](https://github.com/rancher/rancher/issues/40094) [BUG] Add CIS hardening guide for RKE1 standalone clusters on k8s 1.25 
* [#40087](https://github.com/rancher/rancher/issues/40087) [BUG] AKS Updating AgentPools with custom route table is not allowed
* [#40080](https://github.com/rancher/rancher/issues/40080) [BUG] RKE2 Downstream Clusters Not Coming Up After Rancher Migration
* [#40054](https://github.com/rancher/rancher/issues/40054) RKE2/k3s Provisioning Tests are stuck on k8s version 1.22.x; need to be running on the latest instead
* [#40030](https://github.com/rancher/rancher/issues/40030) [System Upgrade Controller (SUC)] Check for PSP compatibility in target cluster
* [#40021](https://github.com/rancher/rancher/issues/40021) [Forwardport] v2.7: Add user agent to handlers requests
* [#40016](https://github.com/rancher/rancher/issues/40016) [BUG] Downstream k3s Node driver clusters fail to provision when etcd and controlplane roles are shared by a nodepool
* [#40009](https://github.com/rancher/rancher/issues/40009) [BUG] Panic Error Caused by Rancher-Webhook
* [#40005](https://github.com/rancher/rancher/issues/40005) [BUG] Etcd restore does not work on an RKE2 cluster after upgrade to 1.25.5
* [#39997](https://github.com/rancher/rancher/issues/39997) Monitoring Charts are failing to install on any cluster
* [#39996](https://github.com/rancher/rancher/issues/39996) Add feature Apps' Namespaces to the list of Exemptions.Namespaces of the Built-in "Restricted" PSACT
* [#39995](https://github.com/rancher/rancher/issues/39995) Prevent Upgrading RKE1 Cluster to 1.25 if PSP resources are detected in the cluster
* [#39994](https://github.com/rancher/rancher/issues/39994) Support the use of PSACT and explicit PSA configuration passing for RKE2/K3S 1.23 - 1.25 cluster
* [#39992](https://github.com/rancher/rancher/issues/39992) Support the use of PSACT in RKE1 1.25 cluster 
* [#39988](https://github.com/rancher/rancher/issues/39988) [BUG] Unable to provision downstream k8s v1.25.2-rancher1-1 cluster using Oracle Linux 8.6
* [#39972](https://github.com/rancher/rancher/issues/39972) [BUG] failed to parse constraint version >= 2.7.0.0 < 2.8.0-0: improper constraint: >= 2.7.0.0 < 2.8.0-0
* [#39968](https://github.com/rancher/rancher/issues/39968) vSphere CPI chart updates to upstream v1.24.3 / v1.23.3 / v1.22.7
* [#39960](https://github.com/rancher/rancher/issues/39960) Add 1.25.5 Support + Make 1.25 default
* [#39954](https://github.com/rancher/rancher/issues/39954) [Monitoring] Update monitoring charts to declare k8s 1.25 support
* [#39951](https://github.com/rancher/rancher/issues/39951) Update SR-IOV chart to declare k8s 1.25 support
* [#39940](https://github.com/rancher/rancher/issues/39940) [CSP]  Check for PSP compatibility in target cluster
* [#39929](https://github.com/rancher/rancher/issues/39929) Update KEv2 Operators to declare k8s 1.25 support
* [#39923](https://github.com/rancher/rancher/issues/39923) [BUG] `rancher-webhook` pod erring out in k8s v1.25.2-rancher1-1 cluster and gets stuck into ContainerCreating state
* [#39916](https://github.com/rancher/rancher/issues/39916) [Forwardport 2.7] kubernetes 1.22 conflicts with system-library-rancher-monitoring, cluster is in error state
* [#39913](https://github.com/rancher/rancher/issues/39913) [rancher-gatekeeper-crd] Check for PSP compatibility in target cluster
* [#39912](https://github.com/rancher/rancher/issues/39912) [BUG] Error when upgrading logging in k8s 1.25 - upgrade failed
* [#39908](https://github.com/rancher/rancher/issues/39908) [Azure AD] Rancher does not handle an error when getting groups - leading to panic
* [#39907](https://github.com/rancher/rancher/issues/39907) [BUG] Monitoring install fails on k8s v 1.25
* [#39895](https://github.com/rancher/rancher/issues/39895) [2.7] Unable to RollBack cattle-token to the previous one
* [#39894](https://github.com/rancher/rancher/issues/39894) Add CIS hardening guide for rancher provisioned RKE1 clusters on k8s 1.25
* [#39891](https://github.com/rancher/rancher/issues/39891) [RFE] Add validation for podSecurityAdmissionConfigrationTemplate 
* [#39882](https://github.com/rancher/rancher/issues/39882) Validate CSP Adapter support for EKS 1.24
* [#39859](https://github.com/rancher/rancher/issues/39859) [Harvester] Check for PSP compatibility in target cluster
* [#39858](https://github.com/rancher/rancher/issues/39858) [Epinio] Check for PSP compatibility in target cluster
* [#39857](https://github.com/rancher/rancher/issues/39857) [Fleet] Check for PSP compatibility in target cluster
* [#39856](https://github.com/rancher/rancher/issues/39856) [Neuvector] Check for PSP compatibility in target cluster
* [#39855](https://github.com/rancher/rancher/issues/39855) [Longhorn] Check for PSP compatibility in target cluster
* [#39854](https://github.com/rancher/rancher/issues/39854) [Webhook] Check for PSP compatibility in target cluster
* [#39853](https://github.com/rancher/rancher/issues/39853) [Extensions] Check for PSP compatibility in target cluster
* [#39852](https://github.com/rancher/rancher/issues/39852) [Windows] Check for PSP compatibility in target cluster
* [#39851](https://github.com/rancher/rancher/issues/39851) [CIS] Check for PSP compatibility in target cluster
* [#39850](https://github.com/rancher/rancher/issues/39850) [Backup] Check for PSP compatibility in target cluster
* [#39849](https://github.com/rancher/rancher/issues/39849) [prom2teams ] Check for PSP compatibility in target cluster
* [#39848](https://github.com/rancher/rancher/issues/39848) [alerting-drivers] Check for PSP compatibility in target cluster 
* [#39847](https://github.com/rancher/rancher/issues/39847)  [Istio] Check for PSP compatibility in target cluster
* [#39846](https://github.com/rancher/rancher/issues/39846) [Monitoring] Check for PSP compatibility in target cluster 
* [#39841](https://github.com/rancher/rancher/issues/39841) [Enhancement] add probe customization to the Rancher chart
* [#39829](https://github.com/rancher/rancher/issues/39829) k3s exits during `make test` due to cgroups v2 issue
* [#39805](https://github.com/rancher/rancher/issues/39805) [RFE] Add/update docs in KEv2 operator repos
* [#39804](https://github.com/rancher/rancher/issues/39804) [BUG] [QA Automaton] Skip PSP-related test on cluster 1.25 and above 
* [#39802](https://github.com/rancher/rancher/issues/39802) Upgrade Logging to 3.17.9
* [#39801](https://github.com/rancher/rancher/issues/39801) Upgrade "Backup and Restore" chart version to 3.0.1
* [#39795](https://github.com/rancher/rancher/issues/39795) 1.25 RKE2 and K3s version in Rancher KDM
* [#39784](https://github.com/rancher/rancher/issues/39784) Upgrade "Alerting drivers " chart version to the newest version
* [#39734](https://github.com/rancher/rancher/issues/39734) [Feature] Adjust Rancher helm chart to allow disabling of PSPs
* [#39733](https://github.com/rancher/rancher/issues/39733) [Feature] Gracefully handle PSPs in 1.25
* [#39725](https://github.com/rancher/rancher/issues/39725) [Forward Port 2.7, Monitoring V2] Rebase Monitoring V2 to upstream kube-prometheus-stack 35.x.x
* [#39724](https://github.com/rancher/rancher/issues/39724) [Project Monitoring V2] Rebase Project Monitoring against 40.x.x Rancher Monitoring
* [#39706](https://github.com/rancher/rancher/issues/39706) Logs not shipping to Splunk - failed to load secret for field hec_token failed to get kubernetes secret cattle-logging-system Secret not found
* [#39680](https://github.com/rancher/rancher/issues/39680) [BUG] rancher-istio 100.3.0+up1.13.3: Remove istiod-remote chart to align with upstream, istiodRemote.enabled: true causes installation failure
* [#39673](https://github.com/rancher/rancher/issues/39673) CIS Benchmark cannot be installed in airgapped env
* [#39672](https://github.com/rancher/rancher/issues/39672) Enhance `/meta/aksVMSizes` API with SKU details 
* [#39634](https://github.com/rancher/rancher/issues/39634) Able to add the same user members multiple times to a given project / cluster
* [#39632](https://github.com/rancher/rancher/issues/39632) [BUG] Rancher charts fail to be downloaded on a fresh install of Rancher 2.6.9
* [#39611](https://github.com/rancher/rancher/issues/39611) [RFE] Improve details available for Azure credentials issues troubleshooting
* [#39564](https://github.com/rancher/rancher/issues/39564) Flaky test test_writing_config_to_disk
* [#39559](https://github.com/rancher/rancher/issues/39559) Update embedded k3s version for Rancher to 1.24.8+
* [#39557](https://github.com/rancher/rancher/issues/39557) [BUG] Some nodes are not deleted upon node-pool deletion
* [#39527](https://github.com/rancher/rancher/issues/39527) Feature Charts: Add Longhorn 1.2.7 Chart in 2.7.x
* [#39510](https://github.com/rancher/rancher/issues/39510) [Issue] Windows OCI images are part of rancher-images.txt / assets
* [#39506](https://github.com/rancher/rancher/issues/39506) [RFE] Wrangler: allow attaching a debugger - make leader election last longer
* [#39491](https://github.com/rancher/rancher/issues/39491) [RFE] Optionally build with debugger-friendly compile settings
* [#39464](https://github.com/rancher/rancher/issues/39464) [BUG] Error `roletemplatebinding doesn't have any subject fields set` is seen while adding a cluster role to a user
* [#39458](https://github.com/rancher/rancher/issues/39458) Support Azure Availability Zones
* [#39469](https://github.com/rancher/rancher/issues/39469) Scale and Performance testing for 1.25 k8s clusters
* [#39438](https://github.com/rancher/rancher/issues/39438) Upgrade OPA Gatekeeper 3.10.0
* [#39413](https://github.com/rancher/rancher/issues/39413) [BUG] Steve does not pass through the warning HTTP response header for Pod creation requests
* [#39399](https://github.com/rancher/rancher/issues/39399) [BUG] Norman V3 Cloud Credential Schema omits AWS config even though EKS driver is enabled
* [#39377](https://github.com/rancher/rancher/issues/39377) [BUG] loglevel trace are not set inside rke2 rancher-machine job
* [#39366](https://github.com/rancher/rancher/issues/39366) [Feature] k8s 1.25 Support - Apps
* [#39365](https://github.com/rancher/rancher/issues/39365) [Feature]  k8s 1.25 Support - RBAC 
* [#39362](https://github.com/rancher/rancher/issues/39362) [BUG] Users are unable to create RKE2 vSphere Node Driver clusters with more than 1 Windows worker node
* [#39345](https://github.com/rancher/rancher/issues/39345) Add Docker 20.10.18, 20.10.19, 20.10.20 and 20.10.21
* [#39333](https://github.com/rancher/rancher/issues/39333) Update Nutanix Node Driver to 3.3.0+
* [#39300](https://github.com/rancher/rancher/issues/39300) [BUG] Non-user friendly/inaccurate message when attempting to delete Cloud Credentials being used
* [#39298](https://github.com/rancher/rancher/issues/39298) [BUG] New project creation with restricted or unrestricted PSP fails on k3s cluster
* [#39291](https://github.com/rancher/rancher/issues/39291) [BUG] backup-restore-operator yaml file causes install error when including value for imagePullSecrets
* [#39284](https://github.com/rancher/rancher/issues/39284) [BUG] k3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1
* [#39259](https://github.com/rancher/rancher/issues/39259) [BUG] getting a panic: runtime.boundsError
* [#39249](https://github.com/rancher/rancher/issues/39249) [Forwardport v2.7] [Monitoring V2] Rebase Monitoring V2 to upstream kube-prometheus-stack 40.x.x
* [#39248](https://github.com/rancher/rancher/issues/39248) [BUG] - Provisioning allows clusters to include names with dot "." when all is lowercase this breaks fleet agent
* [#39242](https://github.com/rancher/rancher/issues/39242) [BUG] Monitoring v2 - serviceMonitor/kube-system/rancher-monitoring-kubelet down after installing monitoring
* [#39227](https://github.com/rancher/rancher/issues/39227) [BUG] rancher-monitoring-ingress-nginx showing down on prom targets page but pod is healthy in rancher ui
* [#39148](https://github.com/rancher/rancher/issues/39148) [BUG] RKE2 hardened cluster fails to provision for k8s 1.25.5
* [#39144](https://github.com/rancher/rancher/issues/39144) Upgrade Istio versions to 1.15.3
* [#39139](https://github.com/rancher/rancher/issues/39139) [BUG] [RKE2] `node auto-replace` does not work on RKE2/k3s rancher provisioned clusters
* [#39109](https://github.com/rancher/rancher/issues/39109) [BUG] Errors in k3s clusters during provisioning but cluster comes up Active
* [#39108](https://github.com/rancher/rancher/issues/39108) [BUG] Erroneous "Operation cannot be fulfilled" Error in RKE2 Provisioning Logs
* [#39107](https://github.com/rancher/rancher/issues/39107) [BUG] Invalid groupPrincipals in token objects after 2.6.2 to 2.6.6 upgrade
* [#39094](https://github.com/rancher/rancher/issues/39094) [BUG] Rancher keeps closing web sockets
* [#39084](https://github.com/rancher/rancher/issues/39084) [CSP Adapter] Update AWS Marketplace listing for version 2.0.0
* [#39053](https://github.com/rancher/rancher/issues/39053) Remove auto-generated deepcopy functions for v1 cis-benchmark
* [#38941](https://github.com/rancher/rancher/issues/38941) [BUG] Unable to provision K3s Custom Clusters on Ubuntu 18.04
* [#38875](https://github.com/rancher/rancher/issues/38875) [RFE] Need a way to upgrade or warn users when upgrading hardened k3s/rke2 to v1.25
* [#38849](https://github.com/rancher/rancher/issues/38849) [BUG] Istio with CNI install fails on k3s hardened cluster
* [#39462](https://github.com/rancher/rancher/issues/39462) vSphere CPI/CSI options omitted when selecting `vsphere` cloud provider in Rancher 2.6.7 or newer
* [#38804](https://github.com/rancher/rancher/issues/38804) [BUG] Constant refreshes of userAttributes with Active Directory provider
* [#38701](https://github.com/rancher/rancher/issues/38701) [Feature] k8s 1.25 Support
* [#38683](https://github.com/rancher/rancher/issues/38683) [BUG] Potential panic in keycloakoidc client caused by uncaught error
* [#38530](https://github.com/rancher/rancher/issues/38530) [BUG]Cluster roles not working properly with LDAP
* [#38516](https://github.com/rancher/rancher/issues/38516) Rancher Cleanup Scripts Not Removing a Large Number of Rancher Resources After Upgrade from 2.6.6 to 2.6.7-rc5
* [#38467](https://github.com/rancher/rancher/issues/38467) [RFE] Steve should only send schema updates when schemas change
* [#38463](https://github.com/rancher/rancher/issues/38463) Feature charts: Add Longhorn 1.3.1 chart in 2.7
* [#38427](https://github.com/rancher/rancher/issues/38427) [RFE] Steve should support pagination with sorting and filtering - Step 1
* [#38414](https://github.com/rancher/rancher/issues/38414) vSphere CSI chart not available on k8s v1.24 cluster due to kube-version annotation
* [#38302](https://github.com/rancher/rancher/issues/38302) RKE2 cluster - Local etcd snapshots is taken on a cluster where S3 etcd snapshots are enabled
* [#38293](https://github.com/rancher/rancher/issues/38293) Multinode vSphere Hardened custom cluster unable to register nodes
* [#38283](https://github.com/rancher/rancher/issues/38283) [RKE2] Unable to rotate encryption keys for large number of secrets
* [#38188](https://github.com/rancher/rancher/issues/38188) vSphere CSI chart updates to upstream v2.7.0 / v2.6.2 / v2.5.4 / v2.4.3
* [#38187](https://github.com/rancher/rancher/issues/38187) vSphere CPI chart updates to upstream v1.25.0 / v1.24.2
* [#38177](https://github.com/rancher/rancher/issues/38177) Rancher 2.6.5/2.6.6 liveness crashes the pod and restarts infinitely
* [#38168](https://github.com/rancher/rancher/issues/38168) helm job(helm-install-cattle-project-$Projectid-monitoring pod)got stuck after enabling project monitoring in air gap env
* [#38035](https://github.com/rancher/rancher/issues/38035) The Rancher package Summary's private field may cause dead loop when it is used as a part of Status
* [#38010](https://github.com/rancher/rancher/issues/38010) Project resource quota deletion not propagating to namespaces
* [#37998](https://github.com/rancher/rancher/issues/37998) Once setting is configured with an env var, it only be changed with env var and configuring setting env var to be "" string changes value in rancher api but not in kubernetes
* [#37983](https://github.com/rancher/rancher/issues/37983) Update Recommendations around Scale
* [#37847](https://github.com/rancher/rancher/issues/37847) [RFE] Enable Azure accelerated networking in node templates
* [#37657](https://github.com/rancher/rancher/issues/37657) [Monitoring V2, Project Monitoring V2] Grafana logs error "Failed to look up user based on cookie"
* [#37461](https://github.com/rancher/rancher/issues/37461) CoreDNS pod is not getting scheduled after the cluster upgrade
* [#37402](https://github.com/rancher/rancher/issues/37402) Kube-apiserver consumes a lot of RAM
* [#36682](https://github.com/rancher/rancher/issues/36682) Steve should throttle sending of count metadata
* [#36681](https://github.com/rancher/rancher/issues/36681) Steve should only send back metadata for counts that have changed
* [#36025](https://github.com/rancher/rancher/issues/36025) RKE(1) unnecessarily causes DOS when generate_serving_certificate is set to true for the kubelet
* [#36107](https://github.com/rancher/rancher/issues/36107) Variable queries in the Rancher / Pod (Containers) query all container metrics, resulting in a very large response and slow loading/timeout of Metrics tab on Pod view in Rancher UI
* [#34913](https://github.com/rancher/rancher/issues/34913) Remove initial RancherD code and build process
* [#34658](https://github.com/rancher/rancher/issues/34658) K3S provisioning support for arm64
* [#33690](https://github.com/rancher/rancher/issues/33690) Deletion of downstream RKE2 cluster with CIS1.6 profile - cattle-cleanup-c5s6d-g44cr stuck in CreateContainerConfigError
* [#31090](https://github.com/rancher/rancher/issues/31090) Show Site Access form when re-configuring an Authentication Provider
* [#30395](https://github.com/rancher/rancher/issues/30395) Incorrect verb "read" versus "get" in clusterscan resource RBAC prevents correctly granting clusterscan permissions
* [#30082](https://github.com/rancher/rancher/issues/30082) Nodes can not be drained if Istio is enabled
* [#29071](https://github.com/rancher/rancher/issues/29071) [EKS] Support custom instance roles for node groups
* [#26955](https://github.com/rancher/rancher/issues/26955) Azure Node Template Tags
* [#21637](https://github.com/rancher/rancher/issues/21637) feature request to add/tag clustername/id to rancher server logs
-----
# Release v2.7.1

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

**Rancher v2.7.1 is a security release to address the following issues:**

# Security Fixes for Rancher Vulnerabilities

This release addresses **04 security issues** found in Rancher:

- Fixed an issue in Rancher's Git package that could potentially lead to command injection. For more information, see [CVE-2022-43758](https://github.com/rancher/rancher/security/advisories/GHSA-34p5-jp77-fcrc).

- Fixed an issue where sensitive fields and credentials like secret tokens, encryption keys, and SSH keys were stored as plaintext on Kubernetes objects. This is a follow-up security fix to address the fields missed in [CVE-2021-36782](https://github.com/rancher/rancher/security/advisories/GHSA-g7j7-h4q8-8w2f). For more information, see [CVE-2022-43757](https://github.com/rancher/rancher/security/advisories/GHSA-cq4p-vp5q-4522).

- Improved the generation process of Rancher's `cattle-token` to make the token random. Before, `cattle-token` did not use any random value in its composition, which caused the token to be always predictable. For more information, see [CVE-2022-43755](https://github.com/rancher/rancher/security/advisories/GHSA-8c69-r38j-rpfj).

- Fixed an authorization logic flaw that allowed an authenticated user on any downstream cluster to (1) open a shell pod in the Rancher local cluster and (2) have limited kubectl access to the local cluster. For more information, see [CVE-2022-21953](https://github.com/rancher/rancher/security/advisories/GHSA-g25r-gvq3-wrq7).

Additionally, the following security related updates were performed in this release to address security issues:

- Fixed a validation check issue where Rancher generated tokens are not revoked after modifications are made to a configured authentication provider. This issue is only applicable if external authentication providers were configured in Rancher. For more information, see security advisory [GHSA-c45c-39f6-6gw9](https://github.com/rancher/rancher/security/advisories/GHSA-c45c-39f6-6gw9).

- Updated the version of Rancher's Fleet chart to `101.0.1+up0.5.1` to address two security issues in [`rancher/wrangler`](https://github.com/rancher/wrangler) dependency:

  - The high severity [CVE-2022-31249](https://github.com/rancher/wrangler/security/advisories/GHSA-qrg7-hfx7-95c5) that could lead to a command injection vulnerability in Rancher's Continuous Delivery feature through Fleet's GitJob pod.

  - The medium severity [CVE-2022-43756](https://github.com/rancher/wrangler/security/advisories/GHSA-8fcj-gf77-47mg) that could cause a denial of service (DoS) attack in Fleet's GitJob pod.

- Updated the version of [`crewjam/saml`](https://github.com/crewjam/saml) SAML library to address the critical severity [CVE-2022-41912](https://github.com/crewjam/saml/security/advisories/GHSA-j2jp-wvqg-wc2g).

- Updated the base image version of Rancher `rancher/rancher` and Rancher Agent `rancher/rancher-agent` images from SUSE's SLE BCI Base 15 SP3 to 15 SP4 [`registry.suse.com/bci/bci-base:15.4`](https://registry.suse.com/bci/bci-base-15sp4/index.html) due to 15 SP3 reaching its end-of-life (EOL).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

# Major Bug Fixes

- Fixed issue where handlers would infinitely loop if a user had no tokens, or the user only had tokens that did not have their ExtraByProvider field set. See [#39401](https://github.com/rancher/rancher/issues/39401).

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

- Pods critical to running Rancher did not use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for its sidecar audit logging instead of busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. Rancher recommends admins to add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not be able to perform some of the actions within Azure AD if the permissions are insufficient, so you may encounter errors.
- For RKE2/K3s node driver clusters, when installing or upgrading an official Rancher Helm chart app, the behavior has changed for pulling images. Previously, only the global container registry was used. As of this release, by default, if a private registry exists in the cluster config, that registry will be used for pulling images. If no cluster scoped registry is found, the global container registry will be used. To change the default registry, a custom registry can be specified during the Helm chart install/upgrade workflow.
- Beginning with Rancher 2.6.9, Rancher was built using go version 1.19. As part of this upgrade, Rancher's clients will only communicate with servers running tls version 1.2 or higher. Ensure that any servers integrated with rancher are upgraded to use this tls version or higher before upgrading to this version of rancher.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.1

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.0](https://github.com/rancher/rke/releases/tag/v1.4.0)

### Kubernetes Versions
- v1.24.6 (Default)
- v1.23.12

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Provisioning new RKE1 clusters with a password-protected private registry may fail. See [#40321](https://github.com/rancher/rancher/issues/40321#issuecomment-1407095199) for a workaround and more information on the issue.
    - In RKE1 clusters on Kubernetes v1.24, cadvisor `container` labels and metric series break Monitoring V2 dashboards. See [#38934](https://github.com/rancher/rancher/issues/38934#issuecomment-1294585708) for a workaround and more details on the issue.
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - Kubernetes RKE1 1.24.x clusters fail to reach an `Active` state using Oracle Linux 8.4; high CPU usage is also observed. Cluster could be a fresh installation or upgraded to v1.24.x. See [#38816](https://github.com/rancher/rancher/issues/38816).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - Encryption keys may fail to rotate when there are a large number (> 2000) of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **K3s:**
    - The K3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1. See [#39284](https://github.com/rancher/rancher/issues/39284).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
  - **EKS:**
    - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).


## All issues in v2.7.1 milestone

* [#39888](https://github.com/rancher/rancher/issues/39888) [Forwardport] v2.7: After -- upgrade, high CPU/load on nodes and database, nodes flapping between ready/unready, excessive "refresh processing" logs
* [#38892](https://github.com/rancher/rancher/issues/38892) Kubectl SHELL is not working for user
-----
# Release v2.7.0

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

> With the release of Rancher v2.7.0, several legacy features have been removed. See the Removed Legacy Features section below for details.

# Features and Enhancements

### Extensions

Rancher v2.7.0 introduces **extensions**. Admins may now make changes and enhancements to their UI functionality as desired independent of Rancher Manager releases. Using the Extensions catalog, which can be found at **≡ > Extensions**, the admin can view the list of installed extensions, update or roll back existing extensions, and install new extensions as desired. For more information on how to use Rancher extensions, please see the [docs](https://docs.ranchermanager.rancher.io/integrations-in-rancher/rancher-extensions).

### K3s Provisioning is GA (x86 Only)

Provisioning K3s clusters on x86 clusters has graduated to GA! The fully compliant Kubernetes distribution is simplified, secure and at less than 60mb is perfect for Edge.

### New in Rancher

- Support has ended for Kubernetes v1.20, v1.21, and v1.22.
- The `Manage Cluster Members` and `Manage Project Members` roles have been updated to better align with common expectations regarding privilege escalation. Users in this role must now have any privilege they wish to assign to others. See [#122](https://github.com/rancher/webhook/pull/122).

### New in the Rancher UI

- Cluster events are now displayed more prominently. See [#5816](https://github.com/rancher/dashboard/issues/5816).
- Added the ability to customize documentation links in the Rancher UI. See [#6294](https://github.com/rancher/dashboard/issues/6294).
- The Diagnostics page now shows more detailed information for troubleshooting performance issues. See [#6739](https://github.com/rancher/dashboard/issues/6739).

### New in Fleet

Authentication for OCI-based registries is now supported. Note that the structure of the [fleet.yaml](https://github.com/rancher/fleet-examples/blob/master/single-cluster/helm-oci/fleet.yaml) is the same, and the credentials are provided as a Kubernetes secret which is described in the `Private Helm Repo` box in the [Repo Structure docs](https://fleet.rancher.io/gitrepo-structure/).

# Major Bug Fixes

- When deploying a RKE2/K3s custom cluster that uses a proxy, the registration now completes as expected. See [#39066](https://github.com/rancher/rancher/issues/39066).
- When navigating to the Continuous Delivery page from the Cluster Management page or Home page, the clusters now show up per the selected namespace as expected. See [#7213](https://github.com/rancher/dashboard/issues/7213).
- Kubernetes versions 1.24.x are no longer appearing as "experimental" when provisioning AKS clusters, as 1.24.x versions are fully supported for AKS clusters. See [#7217](https://github.com/rancher/dashboard/issues/7217).
- RKE v1.3.10-v1.3.13 in Rancher v2.6.7-v2.6.8 no longer removes user addons during an upgrade before redeploying them, which would cause issues with RKE1 cluster upgrades if user addons template has cattle-* or other system namespaces. See [#38749](https://github.com/rancher/rancher/issues/38749).
- Fixed an issue where user-defined EKS security groups were configured as the only node group security groups rather than being appended to the cluster default security group. See [#38014](https://github.com/rancher/rancher/issues/38014).
- Fixed issue in which OPA Gatekeeper became stuck when uninstalled. See [#37029](https://github.com/rancher/rancher/issues/37029).
- Web socket disconnections no longer result in too many notifications. See [#6992](https://github.com/rancher/dashboard/issues/6992).
- CPU and memory usage are now displayed properly for EKS nodes. See [#4956](https://github.com/rancher/dashboard/issues/4956).

# Rancher Behavior Changes

- Pods critical to running Rancher did not use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. A configurable priorityClass has been added to the Rancher pod and its feature charts. See [#37927](https://github.com/rancher/rancher/issues/37927).
- Rancher now defaults to using the bci-micro image for its sidecar audit logging instead of busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).
- Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. Rancher recommends admins to add `Directory.Read.All` permissions of type Application. If you configure a different set of permissions, Rancher may not be able to perform some of the actions within Azure AD, if the permissions are insufficient, so you may encounter errors.
- For RKE2/K3s node driver clusters, when installing or upgrading an official Rancher Helm chart app, the behavior has changed for pulling images. Previously, only the global container registry was used. As of this release, by default, if a private registry exists in the cluster config, that registry will be used for pulling images. If no cluster scoped registry is found, the global container registry will be used. To change the default registry, a custom registry can be specified during the Helm chart install/upgrade workflow.
- Beginning with Rancher 2.6.9, Rancher was built using go version 1.19. As part of this upgrade, Rancher's clients will only communicate with servers running tls version 1.2 or higher. Ensure that any servers integrated with rancher are upgraded to use this tls version or higher before upgrading to this version of rancher.

# Known Issues

- EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. To see more detail about this issue and the workaround, please see this [comment](https://github.com/rancher/rancher/issues/39392#issue-1421180024).
- In RKE1 clusters on Kubernetes v1.24, cadvisor `container` labels and metric series break Monitoring V2 dashboards. See [#38934](https://github.com/rancher/rancher/issues/38934#issuecomment-1294585708) for a workaround and more details on the issue.

# Install/Upgrade Notes

> - If you are installing Rancher for the first time, your environment must fulfill the [installation requirements.](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements)

### Upgrade Requirements

- **Creating backups:** We strongly recommend creating a backup before upgrading Rancher. To roll back Rancher after an upgrade, you must back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to its state when a backup was created, any changes post upgrade will not be included after the restore. For more information, see the [documentation on backing up Rancher.](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher)
- **Helm version:** Rancher install or upgrade must occur with Helm 3.2.x+ due to the changes with the latest cert-manager release. See [#29213](https://github.com/rancher/rancher/issues/29213).
- **CNI requirements:**
  - For Kubernetes v1.19 and newer, we recommend disabling firewalld as it has been found to be incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - If upgrading or installing to a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or newer, users should upgrade to RKE1 v1.19.2 or later to get Flannel version v0.13.0 that supports nf_tables. See [Flannel #1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - For installing or upgrading Rancher in an air gapped environment, please add the flag `--no-hooks` to the `helm template` command to skip rendering files for Helm's hooks. See [#3226](https://github.com/rancher/docs/issues/3226).
  - If using a proxy in front of an air gapped Rancher, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and related issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
- **Requirements for Docker installs:**
  - When starting the Rancher Docker container, the privileged flag must be used. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When installing in an air gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you will need to also supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container comes up and is working as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

### Rancher Behavior Changes

See the [Rancher v2.6.9 release notes](https://github.com/rancher/rancher/releases/tag/v2.6.9) for previous behavior changes.

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for latest and stable versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

### Images
- rancher/rancher:v2.7.0

### Tools
- CLI - [v2.7.0](https://github.com/rancher/cli/releases/tag/v2.7.0)
- RKE - [v1.4.0](https://github.com/rancher/rke/releases/tag/v1.4.0)

### Kubernetes Versions
- v1.24.6 (Default)
- v1.23.12

### Rancher Helm Chart Versions

Starting in 2.6.0, many of the Rancher Helm charts available in the Apps & Marketplace will start with a major version of 100. This was done to avoid simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also brings us into compliance with semver, which is a requirement for newer versions of Helm. You can now see the upstream version of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

### Experimental Features

- Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI will be experimental starting in v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

### Deprecated Upstream Projects

- Microsoft has deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. A configuration update is necessary to make sure users can still use Rancher with Azure AD. See [the docs](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and [#29306](https://github.com/rancher/rancher/issues/29306) for details.

### Removed Legacy Features

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features were announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global) - Apps within Multicluster Apps section

### Known Major Issues

- **Kubernetes Cluster Distributions:**
  - **RKE:**
    - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).
    - Kubernetes RKE1 1.24.x clusters fail to reach an `Active` state using Oracle Linux 8.4; high CPU usage is also observed. Cluster could be a fresh installation or upgraded to v1.24.x. See [#38816](https://github.com/rancher/rancher/issues/38816).
  - **RKE2:**
    - Amazon ECR Private Registries are not functional. See [#33920](https://github.com/rancher/rancher/issues/33920).
    - When provisioning using an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners does not currently take an integer when it should, and an error is thrown. To work around this issue, wrap the EC2 `rootSize` in quotes. See Dashboard [#3689](https://github.com/rancher/dashboard/issues/3689).
    - The communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
    - Encryption keys may fail to rotate when there are a large number (> 2000) of secrets. See [#38283](https://github.com/rancher/rancher/issues/38283).
    - The `system-upgrade-controller` Deployment may fail after Monitoring is enabled on an RKE2 v1.23 or v1.24 cluster with Windows nodes. See [#38646](https://github.com/rancher/rancher/issues/38646).
  - **RKE2 - Windows:**
    - CSI Proxy for Windows will now work in an air-gapped environment.
    - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).
    - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes will require a reboot after the upgrade is completed. See [#37645](https://github.com/rancher/rancher/issues/37645).
  - **K3s:**
    - The K3s proxied downstream cluster does not work on v1.24.4+k3s1 but does work on v1.24.6+k3s1. See [#39284](https://github.com/rancher/rancher/issues/39284).
  - **AKS:**
    - When editing or upgrading the AKS cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).
    - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).
    - Azure Container Registry-based Helm charts cannot be added in Cluster Explorer, but do work in the Apps feature of Cluster Manager. Note that when using a Helm chart repository, the `disableSameOriginCheck` setting controls when credentials are attached to requests. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/helm-charts-in-rancher#repositories) and [#34584](https://github.com/rancher/rancher/issues/34584) for more information.
  - **GKE:**
    - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to 1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).
- **Infrastructures:**
  - **vSphere:**
    - `PersistentVolumes` are unable to mount to custom vSphere hardened clusters using CSI charts. See [#35173](https://github.com/rancher/rancher/issues/35173).
- **Harvester:**
  - Upgrades from Harvester v0.3.0 are not supported.
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the Continuous Delivery page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - When upgrading RKE2 in a Harvester cluster, the result may be that the first node will be upgraded while the remaining server nodes' scheduling is disabled. See [#39167](https://github.com/rancher/rancher/issues/39167).
- **Cluster Tools:**
  - **Fleet:**
    - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment; rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).
  - **Hardened clusters:**
    - Not all cluster tools can currently be installed on a hardened cluster.
  - **Rancher Backup:**
    - When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.
    - When running a newer version of the rancher-backup app to restore a backup made with an older version of the app, the `resourceSet` named `rancher-resource-set` will be restored to an older version that might be different from the one defined in the current running rancher-backup app. The workaround is to edit the rancher-backup app to trigger a reconciliation. See [#34495](https://github.com/rancher/rancher/issues/34495).
    - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail because the backup file contains CRDs with the apiVersion v1beta1. There are two options to work around this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).
  - **Monitoring:**
    - Deploying Monitoring on a Windows cluster with win_prefix_path set requires users to deploy Rancher Wins Upgrader to restart wins on the hosts to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
  - **Logging:**
    - Windows nodeAgents are not deleted when performing helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - **Istio Versions:**
    - Istio 1.12 and below do not work on Kubernetes 1.23 clusters. To use the Istio charts, please do not update to Kubernetes 1.23 until the next charts' release.
    - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).
    - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).
- **Docker Installations:**
  - UI issues may occur due to a longer startup time. User will receive an error message when launching Docker for the first time [#28800](https://github.com/rancher/rancher/issues/28800), and user is directed to username/password screen when accessing the UI after a Docker install of Rancher. See [#28798](https://github.com/rancher/rancher/issues/28798).
  - On a Docker install upgrade and rollback, Rancher logs will repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).
  - Rancher single node wont start on Apple M1 devices with Docker Desktop 4.3.0 or newer. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher UI:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).
  - In some instances under Users and Authentication, no users are listed and clicking Create to create a new user does not display the entire form. To work around this when encountered, perform a hard refresh to be able to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).
  - Deployment securityContext section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy Support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).
- **Legacy UI:**
  - When using the Rancher UI to add a new port of type ClusterIP to an existing Deployment created using the legacy UI, the new port will not be created upon saving. To work around this issue, repeat the procedure to add the port again. Users will notice the Service Type field will display as `Do not create a service`. Change this to ClusterIP and upon saving, the new port will be created successfully during this subsequent attempt. See [#4280](https://github.com/rancher/dashboard/issues/4280).


## All issues in v2.7.0 milestone

* [#39561](https://github.com/rancher/rancher/issues/39561) [BUG] .ps1 rancher-save-images and rancher-load-images specifies windows version in manifest tag, leads to missing versions/manifests in users registry
* [#39554](https://github.com/rancher/rancher/issues/39554) [BUG] allow source registry in rancher-save and rancher-load scripts
* [#39507](https://github.com/rancher/rancher/issues/39507) Introduce RKE2/k3s October 2022 Releases to KDM
* [#39484](https://github.com/rancher/rancher/issues/39484) [release/v2.7] Provisioning tests failing due to cgroups remediation miss and bad published RKE2 version
* [#39475](https://github.com/rancher/rancher/issues/39475) Need to add NeuVector upstream chart version 2.2.4 to Rancher version 2.7.0  
* [#39474](https://github.com/rancher/rancher/issues/39474) [BUG] non-community version of rancher does not have correct setting in `/rancherversion`
* [#39468](https://github.com/rancher/rancher/issues/39468) [BUG] The cluster specific registry is not internally synced between v3 & v1 which blocks fleet from using it
* [#39456](https://github.com/rancher/rancher/issues/39456) [BUG] Upgrade from non-community version -> community version of rancher does not reset branding / `ui-brand` persists after upgrade
* [#39446](https://github.com/rancher/rancher/issues/39446) [BUG] When MCM is disabled, the webhook won't start
* [#39409](https://github.com/rancher/rancher/issues/39409) [BUG] Istio - upgrade to lastest version paths all lead to a blank page - can't upgrade via UI
* [#39408](https://github.com/rancher/rancher/issues/39408) [BUG]OPA Gatekeeper - error in logs 'unable to process a request with an unknown content type
* [#39395](https://github.com/rancher/rancher/issues/39395) [BUG] Unable to upgrade k8s version from 1.22 to 1.24 on AKS clusters after upgrading Rancher
* [#39364](https://github.com/rancher/rancher/issues/39364) [BUG] -  Airgap - Rancher Monitoring v2 install job rancher-monitoring-crd-create has image pull error of rancher/shell:v0.1.18
* [#39350](https://github.com/rancher/rancher/issues/39350) [BUG] Rancher api schema missing causes workload deployment to fail
* [#39323](https://github.com/rancher/rancher/issues/39323) [feature testing bug] UI extensions install failure on a hardened cluster. pod stuck in Createcontainer state
* [#39316](https://github.com/rancher/rancher/issues/39316) CIS scan shows failure after kube-apiserver restart
* [#39283](https://github.com/rancher/rancher/issues/39283) [Forwardport v2.7] [BUG] Rancher fails to install on 22.04 Ubuntu with error - `mkdir: cannot create directory '/sys/fs/cgroup/init': Read-only file system`
* [#39266](https://github.com/rancher/rancher/issues/39266) RKE2 and K3S - KDM Update for K8s September patch release for Rancher 2.7
* [#39239](https://github.com/rancher/rancher/issues/39239) Supporting K8s v1.23 -v1.24
* [#39236](https://github.com/rancher/rancher/issues/39236) [RFE] Update EULA & T&C  in Rancher Helm Chart README
* [#39213](https://github.com/rancher/rancher/issues/39213) [RFE] Rancher Helm Chart ingress hardcoded to port 80
* [#39188](https://github.com/rancher/rancher/issues/39188) [BUG] metric-server pod remains in crashloop back off on k8s cluster v1.22.15
* [#39170](https://github.com/rancher/rancher/issues/39170) [BUG] CIS scan failures on RKE2 hardened clusters
* [#39162](https://github.com/rancher/rancher/issues/39162) [RFE]  Build and Push Image rancher/rancher to a different registry rather than Dockerhub
* [#39160](https://github.com/rancher/rancher/issues/39160) [Forwardport] v2.7: Add options to lasso that improve performance
* [#39159](https://github.com/rancher/rancher/issues/39159) Confirm that all images in rancher-images.txt come from the Rancher repo.
* [#39150](https://github.com/rancher/rancher/issues/39150) [BUG] Unable to provision clusters on 2.7
* [#39135](https://github.com/rancher/rancher/issues/39135) Remove Istio versions prior to 1.14.x
* [#39112](https://github.com/rancher/rancher/issues/39112) [BUG] harvester storage class does not respect PVC volume value. All volumes are created with 10Gi size
* [#39106](https://github.com/rancher/rancher/issues/39106) [BUG] v2prov is broken on `v2.7.0-rc1`
* [#39073](https://github.com/rancher/rancher/issues/39073) [BUG] Rancher container unable to resolve due to chart version for rancher-webhook
* [#39066](https://github.com/rancher/rancher/issues/39066) [BUG] rke2/k3s proxied custom cluster unable to finish rancher-system-agent with ` Main process exited, code=exited, status=2/INVALIDARGUMENT`
* [#39048](https://github.com/rancher/rancher/issues/39048) [Forwardport v2.7] SUC doesn't appear to be installed in long-named v2prov clusters 
* [#39046](https://github.com/rancher/rancher/issues/39046) [BUG][project monitoring v2]helm-install-cattle-project-p- pod error state due to missing key
* [#39038](https://github.com/rancher/rancher/issues/39038) [BUG] Linode Node driver RKE2/K3s fails to register worker node + successfully provision
* [#39031](https://github.com/rancher/rancher/issues/39031) [BUG][k3s] Unable to upgrade k8s version of imported cluster
* [#39020](https://github.com/rancher/rancher/issues/39020) [BUG] K3s cluster goes into a full reconcile when upgrade strategy on the cluster is changed
* [#39014](https://github.com/rancher/rancher/issues/39014) [BUG] Certs for some individual services are not being rotated correctly on RKE2 and K3s clusters
* [#39000](https://github.com/rancher/rancher/issues/39000) [BUG] Editing the azure AD auth provider config before updating the endpoints result in failed to parse the 'roles' field in JWT 
* [#38998](https://github.com/rancher/rancher/issues/38998) [BUG] vSphere node driver cluster fails to provision when the nodes are cloned from a VM
* [#38989](https://github.com/rancher/rancher/issues/38989) [Forwardport v2.7] [BUG] Timeout received when waiting for rancher connection info
* [#38983](https://github.com/rancher/rancher/issues/38983) Prepare rancher-backup chart for 2.7.0
* [#38982](https://github.com/rancher/rancher/issues/38982) Prepare rancher-alerting-driver chart for 2.7.0
* [#38981](https://github.com/rancher/rancher/issues/38981) Prepare rancher-monitoring chart for 2.7.0
* [#38980](https://github.com/rancher/rancher/issues/38980) Prepare rancher-project-monitoring chart for 2.7.0 
* [#38979](https://github.com/rancher/rancher/issues/38979) Prepare prometheus-federator chart for 2.7.0
* [#38978](https://github.com/rancher/rancher/issues/38978) Prepare rancher-logging chart for 2.7.0
* [#38977](https://github.com/rancher/rancher/issues/38977) Prepare rancher-sriov chart for 2.7.0
* [#38976](https://github.com/rancher/rancher/issues/38976) Prepare harvester-csi-driver chart for 2.7.0
* [#38975](https://github.com/rancher/rancher/issues/38975) Prepare harvester-cloud-provider chart for 2.7.0
* [#38974](https://github.com/rancher/rancher/issues/38974) Implement management.cattle.io schema just Go Automation Framework 
* [#38971](https://github.com/rancher/rancher/issues/38971) Prepare neuvector chart for 2.7.0 
* [#38970](https://github.com/rancher/rancher/issues/38970) Prepare rancher-gatekeeper chart for 2.7.0
* [#38969](https://github.com/rancher/rancher/issues/38969) Prepare rancher-cis-benchmark chart for 2.7.0
* [#38968](https://github.com/rancher/rancher/issues/38968) Prepare rancher-istio chart for 2.7.0
* [#38967](https://github.com/rancher/rancher/issues/38967) Prepare fleet-agent chart for 2.7.0
* [#38966](https://github.com/rancher/rancher/issues/38966) Prepare fleet chart for 2.7.0
* [#38965](https://github.com/rancher/rancher/issues/38965) Prepare rancher-wins-upgrader chart for 2.7.0
* [#38964](https://github.com/rancher/rancher/issues/38964) Prepare rancher-windows-gmsa chart for 2.7.0
* [#38963](https://github.com/rancher/rancher/issues/38963) Prepare rancher-vsphere-csi chart for 2.7.0
* [#38962](https://github.com/rancher/rancher/issues/38962) Prepare rancher-vsphere-cpi chart for 2.7.0
* [#38958](https://github.com/rancher/rancher/issues/38958) Prepare system-upgrade-controller chart for 2.7.0
* [#38957](https://github.com/rancher/rancher/issues/38957)   Prepare rancher-gke-operator chart for 2.7.0
* [#38956](https://github.com/rancher/rancher/issues/38956) Prepare rancher-eks-operator chart for 2.7.0
* [#38955](https://github.com/rancher/rancher/issues/38955)  Prepare rancher-aks-operator chart for 2.7.0
* [#38954](https://github.com/rancher/rancher/issues/38954) Prepare rancher-external-ip-webhook chart for 2.7.0
* [#38953](https://github.com/rancher/rancher/issues/38953) Prepare rancher-csp-adapter chart for 2.7.0
* [#38952](https://github.com/rancher/rancher/issues/38952) [Forwardport v2.7] [BUG] Local cluster v2prov non-functional when feature flag multi-cluster-management=false
* [#38943](https://github.com/rancher/rancher/issues/38943) Prepare rancher-webhook chart for 2.7.0
* [#38905](https://github.com/rancher/rancher/issues/38905) [2.7] Update hyperkube base to using iptables >1.8.5
* [#38903](https://github.com/rancher/rancher/issues/38903) [Forwardport v2.7] [BUG] NodePool controller is racy
* [#38898](https://github.com/rancher/rancher/issues/38898) [release/v2.7] Forwardport of Add 1.23 for EKS
* [#38897](https://github.com/rancher/rancher/issues/38897) [BUG] Cluster Level Private Registry Isn't Respected When Creating `dashboard-Shell` container
* [#38896](https://github.com/rancher/rancher/issues/38896) [BUG, RKE2] cluster with windows node fails to deploy System Upgrade Controller to windows node, `Write-EventLog : The source name "rancher-wins" does not exist on computer "localhost".` on pods using `rancher-wins` image
* [#38890](https://github.com/rancher/rancher/issues/38890) [BUG] RKE2 System Images Are Not Pulled From Cluster Level Registry 
* [#38880](https://github.com/rancher/rancher/issues/38880) [Azure AD] Always check access token from Microsoft
* [#38854](https://github.com/rancher/rancher/issues/38854) [BUG] Panic encountered with managementapi/dynamicschema concurrent map read/write
* [#38851](https://github.com/rancher/rancher/issues/38851) [Logging v2] Windows RKE2 	rancher-logging-root-win-agent-fluentbit pod is in Imagepullbackoff
* [#38834](https://github.com/rancher/rancher/issues/38834) [BUG] proxy container of the helm-operation pod is not terminated and it becomes NotReady
* [#38828](https://github.com/rancher/rancher/issues/38828) [2.7] KDM Update for K8s 2022 September patch release
* [#38808](https://github.com/rancher/rancher/issues/38808) [RFE] Rancher can get all images from a non-Docker registry
* [#38749](https://github.com/rancher/rancher/issues/38749) RKE deletes user addons on reconcile and redeploys before rke up 
* [#38733](https://github.com/rancher/rancher/issues/38733) [BUG] Docker installed airgap env, fails to provision downstream rke2/k3s custom clusters
* [#38703](https://github.com/rancher/rancher/issues/38703) [BUG] Upgrading Kubernetes Version does not retain RKE User Addons
* [#38681](https://github.com/rancher/rancher/issues/38681) [BUG] k3s provisioned clusters from Rancher do not have taints on etcd/cp nodes
* [#38679](https://github.com/rancher/rancher/issues/38679) [BUG] k3s node driver cluster stuck in updating state after k3s version upgrade
* [#38668](https://github.com/rancher/rancher/issues/38668) Hide CIS 1.5 scan profiles from cis benchmark charts
* [#38664](https://github.com/rancher/rancher/issues/38664) [BUG] CIS scan runs indefinitely and never completes. windows RKE2 clusters
* [#38648](https://github.com/rancher/rancher/issues/38648) [BUG][Windows] pushprox-kube-etcd-client is failing due to copy-certs failure
* [#38573](https://github.com/rancher/rancher/issues/38573) [BUG] Error seen when creating a project as cluster owner and assigning another stand user as project member to the project
* [#38600](https://github.com/rancher/rancher/issues/38600) [BUG] seLinux Being Disabled by Default Causing Logging Upgrade to Fail
* [#38562](https://github.com/rancher/rancher/issues/38562) [RFE] Ensure charts are update to use alternate registry
* [#38554](https://github.com/rancher/rancher/issues/38554) [RFE] Dashboard UI request for detecting feature flag
* [#38551](https://github.com/rancher/rancher/issues/38551) [RFE] Updating the Rancher server helm chart publishing to publish into the new repo for builds
* [#38550](https://github.com/rancher/rancher/issues/38550) [RFE] Add Env var setting to swap registry
* [#38549](https://github.com/rancher/rancher/issues/38549) [RFE] Update PrefixPrivateRegistry func to pull shell from right place
* [#38544](https://github.com/rancher/rancher/issues/38544) [BUG] NeuVector: `cache.syncCheck: Detected sync error` errors seen in the controller pod of Neuvector on RKE2 clusters 
* [#38536](https://github.com/rancher/rancher/issues/38536) [BUG]The`impersonatedUser` field in K8s audit logs is missing sometimes
* [#38533](https://github.com/rancher/rancher/issues/38533) Write a Terraform release checklist into the readme.md
* [#38528](https://github.com/rancher/rancher/issues/38528) [BUG] [2.7] Circular RoleTemplate reference causes high CPU usage or crash
* [#38512](https://github.com/rancher/rancher/issues/38512) [BUG] When logged into the Rancher CLI as a standard user, you are unable to view an admin user's name when running `rancher clusters list-members`
* [#38510](https://github.com/rancher/rancher/issues/38510) CIS	rke2-cis-1.5-profile-permissive scan results in 1 failure on downstream rke2 RHEL cluster
* [#38511](https://github.com/rancher/rancher/issues/38511) Rancher 2.6.head - CIS permissive chart 1.6 runs result in 9 failures on downstream Rhel rke1 clusters
* [#38460](https://github.com/rancher/rancher/issues/38460) [BUG] Taking multiple s3 etcd snapshots at once take more time to get activated
* [#38451](https://github.com/rancher/rancher/issues/38451) Upgrade Istio versions to 1.14.3
* [#38446](https://github.com/rancher/rancher/issues/38446) [BUG] Upgrading Kubernetes Version does not retain RKE User Addons
* [#38442](https://github.com/rancher/rancher/issues/38442) [BUG] `user-node-remove` finalizer not being properly cleaned up.
* [#38439](https://github.com/rancher/rancher/issues/38439) Update CIS benchmark scans to work on specific kubernetes versions that it supports
* [#38405](https://github.com/rancher/rancher/issues/38405) [BUG] RKE2 EC2 Node Driver provisioning fails in EC2 environments with IMDSv2 enforced on instance creation
* [#38380](https://github.com/rancher/rancher/issues/38380) [BUG][AKS] - Unable to reach Rancher Dashboard after deploying Rancher on AKS 1.24.0 cluster
* [#38379](https://github.com/rancher/rancher/issues/38379) [BUG][RKE2] Workload endpoint times out when setting public port
* [#38330](https://github.com/rancher/rancher/issues/38330) [BUG] Memory leak in cluster provisioning/deletion process
* [#38313](https://github.com/rancher/rancher/issues/38313) When provisioning a downstream RKE2 node driver cluster, Rancher logs show `Secret name is empty` at the WARNING/INFO log level
* [#38167](https://github.com/rancher/rancher/issues/38167) Files changed by go fmt do not cause build failure
* [#38142](https://github.com/rancher/rancher/issues/38142) Observed a panic: "invalid memory address or nil pointer dereference"
* [#38132](https://github.com/rancher/rancher/issues/38132) Research Pod Security Policy (PSP) deprecation
* [#38048](https://github.com/rancher/rancher/issues/38048) [2.6] Provisioning-tests pipeline phase is failing due to KDM bug
* [#38014](https://github.com/rancher/rancher/issues/38014) User defined EKS security groups are configured as the only node group security groups, versus being appended to the cluster default security group
* [#37993](https://github.com/rancher/rancher/issues/37993) User-supplied bootstrap password not observed in air-gapped Rancher v2.6.5 installation
* [#37927](https://github.com/rancher/rancher/issues/37927) Adds priority Class to Rancher helm chart
* [#37818](https://github.com/rancher/rancher/issues/37818) KEv2 unit/integration tests
* [#37816](https://github.com/rancher/rancher/issues/37816) Cert rotation integration tests for RKE2 
* [#37707](https://github.com/rancher/rancher/issues/37707) Proxied kubectl commands hanging
* [#37631](https://github.com/rancher/rancher/issues/37631) metrics server 0.5.0 failing due to docker CIS hardening
* [#37493](https://github.com/rancher/rancher/issues/37493) Add CIS hardening guide for rancher provisioned k3s clusters
* [#37412](https://github.com/rancher/rancher/issues/37412) wrong hostname for vsphere rke2 clusternodes in 2.6.4
* [#37327](https://github.com/rancher/rancher/issues/37327) Remove Istio v1
* [#37324](https://github.com/rancher/rancher/issues/37324) Remove Pipelines
* [#37322](https://github.com/rancher/rancher/issues/37322) Remove CIS 1.4 Scanner
* [#37318](https://github.com/rancher/rancher/issues/37318) Remove Logging v1
* [#37029](https://github.com/rancher/rancher/issues/37029) OPA gatekeeper 100.0.1+up3.6.0 stuck uninstalling CRDs in RKE1/RKE2 Windows clusters
* [#36972](https://github.com/rancher/rancher/issues/36972) Add backend support for UI plugins
* [#36846](https://github.com/rancher/rancher/issues/36846) Rancher-Gatekeeper app fails in a hardened cluster
* [#36810](https://github.com/rancher/rancher/issues/36810) Shared Label Causes Pods to Show Under Another Deployment in the Cluster Explorer UI 
* [#36273](https://github.com/rancher/rancher/issues/36273) Validate updated SG with existing automated test cases.
* [#36238](https://github.com/rancher/rancher/issues/36238) Rancher container is restarting every 15 seconds on Ubuntu 22.04
* [#39090](https://github.com/rancher/rancher/issues/39090) Error when disabling grafana rancher-monitoring
* [#35587](https://github.com/rancher/rancher/issues/35587) Rancher rancher-images.txt includes docker.io/busybox which can not be downloaded due to "too many requests"
* [#32935](https://github.com/rancher/rancher/issues/32935) rancher-cis-benchmark scan mis-matches as master any non-master node on which a running process has an argument containing the phrase kube-apiserver
* [#31324](https://github.com/rancher/rancher/issues/31324) Cluster agent fails with error "socket: too many open files"
* [#29939](https://github.com/rancher/rancher/issues/29939) Weird etcdHighNumberOfFailedGRPCRequests prometheus rule in v2.5 rancher-monitoring
* [#29372](https://github.com/rancher/rancher/issues/29372) [Logging v2] Support for Hardened Cluster: Ensure CIS hardened profile scan passes
* [#28620](https://github.com/rancher/rancher/issues/28620) [Logging v2] Support hardened cluster
-----
