| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.8.2](rancher-v2.8.md#release-v282) | Feb 08 2024 | 02/08/24 | 2024-02-08 |
| [v2.8.1](rancher-v2.8.md#release-v281) | Jan 22 2024 | 01/22/24 | 2024-01-22 |
| [v2.8.0](rancher-v2.8.md#release-v280) | Dec 06 2023 | 12/06/23 | 2023-12-06 |



# Release v2.8.2

>After testing and observation in the community, Rancher v2.8.1 is now considered a stable release and also designated as a Rancher Prime release. To learn more about Rancher Prime, visit https://www.rancher.com/products/rancher-platform.

> **Important:** Review the [Install/Upgrade](#installupgrade-notes) notes before upgrading to any Rancher version.

Rancher v2.8.2 is a security release to address the following issues:

# Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Fixed an issue where the [Rancher Audit Log](https://ranchermanager.docs.rancher.com/how-to-guides/advanced-user-guides/enable-api-audit-log) was leaking sensitive data. For more information, see [CVE-2023-22649](https://github.com/rancher/rancher/security/advisories/GHSA-xfj7-qf8w-2gcr).
- Updated the versions of Norman and API Server to address CVEs [CVE-2023-32193](https://github.com/rancher/norman/security/advisories/GHSA-r8f4-hv23-6qp6) and [CVE-2023-32192](https://github.com/rancher/apiserver/security/advisories/GHSA-833m-37f7-jq55), respectively, that could lead to an unauthenticated cross-site scripting (XSS) in Rancher's public API.
- Fixed an issue where users with permissions in custom API groups could manage namespaces in the core API group. For more information, see [CVE-2023-32194](https://github.com/rancher/rancher/security/advisories/GHSA-c85r-fwc7-45vc).
- Bumped `runc` to [v1.1.12](https://github.com/opencontainers/runc/releases/tag/v1.1.12) to fix [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626), see related [`runc` security advisory](https://github.com/opencontainers/runc/security/advisories/GHSA-xr7r-f8xq-vfvv).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/reference-guides/rancher-security/security-advisories-and-cves) page or in Rancher's [GitHub repo](https://github.com/rancher/rancher/security/advisories).

## Rancher General

### Features and Enhancements

- Rancher now supports Kubernetes v1.27. See [#41840](https://github.com/rancher/rancher/issues/41840).
- Rancher's new [Rancher Kubernetes API (RK-API)](https://ranchermanager.docs.rancher.com/v2.8/api/api-reference) lets you manage Rancher in the same way you manage Kubernetes. You can now use the Rancher Kubernetes API to interact with Rancher CRDs via Kubernetes tooling. This includes convenient documentation via the kubectl `explain` command. A limited set of our most widely-used CRDs will be available in Rancher v2.8.0. More are on the way.
- Custom Global Role configuration is now more flexible. Additional fields are being added to the Global Role CRD, starting with the `inheritedClusterRoles` field, which allows users to give permissions for all downstream clusters with a single GlobalRole and GlobalRoleBinding. This lets you easily define and apply roles tailored to specific use cases, creating a level of flexibility not present in built-in global roles, such as Restricted Admin.

### Major Bug Fixes

- Rancher no longer rapidly requests unnecessary upgrade operations from `helm-operation` pods. See [#41746](https://github.com/rancher/rancher/issues/41746).
- Importing a generic cluster with `system-default-registry` uses registry images, and the registration.yaml file no longer contains docker.io images when the `system-default-registry` is defined. See [#42048](https://github.com/rancher/rancher/issues/42048).
- Fetching images for ui-extensions from a GitHub URL no longer fails, allowing Rancher to start in air-gapped environments. See [#43910](https://github.com/rancher/rancher/issues/43910) and [#43892](https://github.com/rancher/rancher/issues/43892).

### Behavior Changes

- Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
- Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Cluster Provisioning

### Features and Enhancements

- The new `imagePolicyPull` global setting allows you to configure the image pull policy for `machine-provision-image`. The default value is `Always`, which preserves the default behavior in previous Rancher versions. You can set this value during Rancher initialization, with the `CATTLE_MACHINE_PROVISION_IMAGE_PULL_POLICY` environment variable. See [#42294](https://github.com/rancher/rancher/issues/42294). 

### Major Bug Fixes

- Rancher no longer requires you to force-refresh the UI to accept a web certificate during initial setup. See [#7867](https://github.com/rancher/dashboard/issues/7867).

### Behavior Changes

- Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.

## RKE Provisioning

### Behavior Changes

- Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
- The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

### Known Issues

- Scaling up etcd nodes on RKE may fail, with nodes stuck waiting to register with Kubernetes. This causes the cluster to hang. There are two workarounds available, depending on whether the cluster is active or hanging. See [#43356](https://github.com/rancher/rancher/issues/43356).
  
  - Workaround for active clusters:

    - Add one etcd node, wait for the cluster to become active again, then repeat as needed.

  - Workaround for hanging clusters:

    1. Delete the stuck etcd nodes.
    1. Find the leader pod: `kubectl -n kube-system get configmap cattle-controller`
    1. Restart the leader pod. This terminates the GRPC goroutine.
    1. Wait for the stuck nodes to be removed.
    1. Add one etcd node, wait for the cluster to become active again, then repeat as needed.

## RKE2 Provisioning

### Major Bug Fixes

- You can use IPv6 to provision RKE2 clusters. In previous Rancher versions, attempting to provision a new cluster with IPv6 would fail. See [#42411](https://github.com/rancher/rancher/issues/42411).  
- RKE2 clusters no longer become stuck in an `Updating` state after a change to the node pool. Instead of successfully rotating the node pool, the init node couldn't be deleted, which prevented the provisioning process from completing. See [#42709](https://github.com/rancher/rancher/issues/42709).

### Behavior Changes

- Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).
- Similar to Rancher v2.7.9, when you upgrade to Rancher v2.8.0 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).

### Known Issues

- Scaling down etcd node pools on RKE2/K3s machine-provisioned clusters may cause unexpected behavior. To avoid this, define multiple machine pools for etcd nodes, each with a quantity of one. You can then scale down simply by deleting machine pools. As a further mitigation, have a robust backup strategy and store your etcd snapshots in a safe location. Restoring from an etcd snapshot allows you to return the cluster to an operational state if you're affected by unexpected behaviors. See [#42582](https://github.com/rancher/rancher/issues/42582) and [#43097](https://github.com/rancher/rancher/issues/43097).

## Rancher App (Global UI)

### Features and Enhancements

- The Rancher UI sidebar has been updated, to facilitate switching between clusters and navigating to global areas of the UI. The new sidebar menu includes a filterable search for finding clusters by name. You can customize cluster icons with colors and letters by giving them a badge through the Cluster Dashboard. See [#9407](https://github.com/rancher/dashboard/issues/9407).

### Behavior Changes

The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->

- Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
- The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

### Known Issues

Legacy Custom Banner settings can cause the top left Menu to disappear. See [#10140](https://github.com/rancher/dashboard/issues/10140).

As a workaround:

1. Go to `<rancher url>/v3/settings/ui-banners`.
1. Press `Edit`, change the value to `{}`, press `Show Request` and then `Send Request` (Note - this will remove custom banners).
1. Go back to the UI and refresh the browser.
1. The nav should be back, and re-applying custom banners should not result in the bug again.

## Role-Based Access Control (RBAC) Framework

### Features and Enhancements

- A new optional field is now available in Global Roles. The  `inheritedClusterRoles` field grants cluster-level permissions on all downstream clusters and lets you create custom global roles. See [#42213](https://github.com/rancher/rancher/issues/42213).

## Pod Security Standards (PSS) & Pod Security Admissions (PSA) <!-- neo --> 

### Known Issues

- After an upgrade from Rancher v2.7.2 - v2.7.6, Rancher doesn't update the PSA configuration template, `rancher-restricted`, to include `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. As a workaround, [manually update](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/psa-config-templates#add-or-edit-a-pod-security-admissions-psa-configuration-template) `rancher-restricted` to add `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. See [#43150](https://github.com/rancher/rancher/issues/43150).

## Security

### Features and Enhancements

- TLS v1.3 is now supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

### Behavior Changes

- TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Authentication

### Major Bug Fixes

- Changing your vSphere credentials, such as your account password, no longer causes node deletion to fail. See [#40608](https://github.com/rancher/rancher/issues/40608).

### Behavior Changes

- The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
- [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).

## Rancher Webhook <!-- neo -->

### Features and Enhancements

- You can now configure the webhook to authenticate requests. This ensures that requests come from the `kube-apiserver` and not from illegitimate sources. By default, the webhook can accept traffic from any source. See [Hardening the Rancher Webhook](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/rancher-security/rancher-webhook-hardening) for advice on using authentication or network policy resources to protect your clusters. <!-- security #1252 -->

### Behavior Changes

- Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade. <!-- Security 1254 -->

## Continuous Delivery

### Features and Enhancements

- All clusters can now be assigned to Fleet workspaces even if they aren't running RKE, via setting the experimental `provisioningv2-fleet-workspace-back-population` feature. See [#36132](https://github.com/rancher/rancher/issues/36132).

## UI Plug-in Operator <!-- mapps -->

### Features and Enhancements

- The UI plugin operator can be installed in air-gapped mode. See [#42092](https://github.com/rancher/rancher/issues/42092).

## Apps & Marketplace <!-- mapps -->

### Major Bug Fixes

- Helm repositories will successfully access the Internet even if the Rancher chart contains `--set useBundledSystemChart=true`. See [#39532](https://github.com/rancher/rancher/issues/39532).

### Behavior Changes

- Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

  - `rancher-cis-benchmark`
  - `rancher-gatekeeper-operator`
  - `rancher-istio`
  - `rancher-logging`
  - `rancher-monitoring`
  
  The code for these charts will remain available for previous versions of Rancher.
  
- Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.

## OPA Gatekeeper <!-- mapps -->

### Behavior Changes

- OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

## Monitoring <!-- opni-->

### Major Bug Fixes

- Some components in Rancher Monitoring no longer ignore `SystemDefaultRegistry`, allowing for successful setup in air-gapped environments. See [#44006](https://github.com/rancher/rancher/issues/44006).

### Known Issues

- Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

  1. If you haven't already, install Monitoring on the project.
  1. Move the `cattle-monitoring-system` namespace into the project.
  1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

  See [#4466](https://github.com/rancher/dashboard/issues/4466).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

## Images

- rancher/rancher:v2.8.2

<!-- TODO verify -->
## Tools

- CLI - [v2.8.0](https://github.com/rancher/cli/releases/tag/v2.8.0)
- RKE - [v1.5.2](https://github.com/rancher/rke/releases/tag/v1.5.2)

## Kubernetes Versions

- v1.27.8 (Default)
- v1.26.11
- v1.25.16

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI has been experimental since v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

## Deprecated Upstream Projects

In June 2023, Microsoft deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. When updating Rancher, update the configuration to make sure that users can still use Rancher with Azure AD. See [the documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and issue [#29306](https://github.com/rancher/rancher/issues/29306) for details.

## Removed Legacy Features

Apps functionality in the cluster manager has been deprecated as of the Rancher v2.7 line. This functionality has been replaced by the **Apps & Marketplace** section of the Rancher UI.

Also, `rancher-external-dns` and `rancher-global-dns` have been deprecated as of the Rancher v2.7 line.

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features was announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**

- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**

- Multiclusterapps (Global): Apps within the **Multicluster Apps** section of the Rancher UI.

# Previous Rancher Behavior Changes

<!-- Apply same headers as "Major Bug Fixes" but with "Previous Rancher Behavior Changes" suffix instead -->

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094).
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062).

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Feature Charts

- **Rancher v2.7.0:**
  - A configurable `priorityClass` is available in the Rancher pod and its feature charts. Previously, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. See [#37927](https://github.com/rancher/rancher/issues/37927).

## Previous Rancher Behavior Changes - Backup/Restore <!-- night's watch -->

- **Rancher v2.7.7:** 
  - If you use a version of backup-restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).

## Previous Rancher Behavior Changes - Logging <!-- opni -->

- **Rancher v2.7.0:**
  - Rancher defaults to using the bci-micro image for sidecar audit logging. Previously, the default image was Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).

## Previous Rancher Behavior Changes - Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
    - Rancher aggregates the changed counts and only sends a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
    - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, with a significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).

## Previous Rancher Behavior Changes - Project Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - The Helm Controller in RKE2/K3s respects the `managedBy` annotation. In its initial release, Project Monitoring V2 required a workaround to set `helmProjectOperator.helmController.enabled: false`, since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.7.2:**
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).<!-- issue mentions v2.5.12 but first added to RN in https://github.com/rancher/rancher/releases/tag/v2.7.2 -->

- **Rancher 2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.6.1 -->

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).

- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Cloud Credentials <!-- hostbusters -->

- **Rancher v2.7.2:**
  - When enabling some custom node drivers, the **Cloud Credential** creation page does not show the correct default fields and has an uneditable `foo` key. See [#8563](https://github.com/rancher/dashboard/issues/8563).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.5.0 -->

- **Rancher v2.6.4:**
  - In certain cases, no users are listed in **Users and Authentication**, and selecting **Create** does not display the entire new user creation form. As a workaround, perform a hard refresh to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).<!-- first proposed as release note in https://github.com/rancher/rancher/issues/37531#ref-pullrequest-1140380350 -->
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).

  - **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426).

- **Rancher v2.6.7:**
  - CSI Proxy for Windows will now work in an air-gapped environment.<!-- no issue number--><!-- seems to first appear in https://github.com/rancher/rancher/releases/tag/v2.6.7. v2.6.6 has brief release notes. v2.6.5 doesn't mention it -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## Long-standing Known Issues - RKE

- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).

- **Rancher 2.7.4:**
  - RKE clusters may be unable to restore from an etcd snapshot. See [#41547](https://github.com/rancher/rancher/issues/41547).
  
    There is a workaround available to re-start the kubelet container on affected worker nodes. This approach recreates the kubelet container on all nodes, not just the worker nodes. Rancher handles the process to ensure zero downtime, just like for any other modification of the cluster. If you prefer to use the `extra_args` blob, be sure both the arg and its value are valid. See the [Kubernetes documentation](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) for available options:
    1. On the Cluster Management page, select **Edit config** on the target cluster.
    1. In the "Cluster Options" section, select **Edit as YAML**.
    1. Modify any value under the `etra_args` or `extra_env` section under `rancher_kubernetes_engine_config.services.kubelet`.
    1. Save the change to trigger a cluster upgrade.

    It may take a few moments for the upgrade to finish.

    - When this problem is triggered, containers from previous pods will become orphaned on downstream nodes. To remove the orphaned nodes, run `docker restart kubelet` on every affected worker node. 

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).

## Long-standing Known Issues - RKE2

- **Rancher v2.7.7:**
 - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.7.6:**
  - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).

- **Rancher v2.7.4:**

  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).

- **Rancher v2.6.x:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).

- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.5:**
  - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes must reboot after the upgrade completes. See [#3376457645](https://github.com/rancher/rancher/issues/).

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - K3s

- **Rancher v2.7.7:**
 - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.7.6:**
  - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).

- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).

- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).

- **Rancher v2.6.x:**
  - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).<!-- no mention of patch version in issue thread, milestone is simply v2.6, already appear as a longstanding issue in https://github.com/rancher/rancher/releases/tag/v2.6.0 -->

- **Rancher v2.6.0:**
  - When editing or upgrading an Azure Kubernetes Service (AKS) cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).<!-- first proposed as a release note for https://github.com/rancher/rancher/issues/33561#issuecomment-879272354 -->

## Long-standing Known Issues - EKS

- **Rancher v2.7.0:**
  - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. See [#39392](https://github.com/rancher/rancher/issues/39392).

## Long-standing Known Issues - GKE

- **Rancher v2.5.8:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to Kubernetes v1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).

## Long-standing Known Issues - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo --> 

- **Rancher v2.6.4:**
  - The deployment's `securityContext` section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy (PSP) support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).<!-- https://github.com/rancher/dashboard/issues/4815#issuecomment-1074184973 -->

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.6.2:**
  - Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259).

## Long-standing Known Issues - Encryption

- **Rancher v2.5.4:**
  - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).

## Long-standing Known Issues - Rancher Webhook <!-- neo -->

- **Rancher v2.7.2:**
  - A webhook is installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher v2.7.2 or later, to a Rancher version earlier than v2.7.2, the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after a Rancher version earlier than v2.7.2 is running). This removes the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).

## Long-standing Known Issues - Harvester

- Upgrades from Harvester v0.3.0 are not supported.<!-- no issue number -->

- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).

- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
  - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
    1. Refresh the `rancher-charts` catalog resource.
    1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
    1. Click **⋮** and select **Upgrade** to check if there is a newer Fleet version listed.
    1. Update the `fleet` chart. Fleet will automatically update the agents.

- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Apps & Marketplace <!-- mapps -->

- **Rancher v2.7.0** 
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).

## Long-standing Known Issues - Backup/Restore <!-- night's watch -->

- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.<!-- no issue number -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.6.3:**
  - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail. The backup file contains CRDs with the apiVersion `v1beta1`. There are two workarounds for this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See the [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).

## Long-standing Known Issues - Istio <!-- mapps -->

- Istio v1.12 and below do not work on Kubernetes v1.23 clusters. To use the Istio charts, please do not update to Kubernetes v1.23 until the next charts' release.<!-- no issue number -->

- **Rancher v2.6.4:**
  - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).

- **Rancher v2.6.1:**
  - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).

## Long-standing Known Issues - Logging <!-- opni -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).

## Long-standing Known Issues - Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).
-----
# Release v2.8.1

> After testing and observation in the community, Rancher v2.8.1 is now considered a stable release and also designated as a Rancher Prime release. To learn more about Rancher Prime, visit https://www.rancher.com/products/rancher-platform.

> **Important:** Review the [Install/Upgrade](#installupgrade-notes) notes before upgrading to any Rancher version.

Rancher v2.8.1 is a mirror release of [v2.8.0](https://github.com/rancher/rancher/releases/tag/v2.8.0). It addresses issues for air-gapped Rancher installations.

All users should skip upgrading to or installing v2.8.0 and immediately upgrade to or install v2.8.1.

> *The following topics received updates in this Rancher release. Topics which had no reported changes are omitted.*

## v2.8.1 Highlights

- Fetching images for ui-extensions from a GitHub URL no longer fails, allowing Rancher to start in air-gapped environments. See [#43910](https://github.com/rancher/rancher/issues/43910) and [#43892](https://github.com/rancher/rancher/issues/43892).
- Some components in Rancher Monitoring no longer ignore `SystemDefaultRegistry`, allowing for successful setup in air-gapped environments. See [#44006](https://github.com/rancher/rancher/issues/44006).

---

**Rancher Kubernetes API**

Our new [Rancher Kubernetes API (RK-API)](https://ranchermanager.docs.rancher.com/v2.8/api/api-reference) lets you manage Rancher in the same way you manage Kubernetes. You can now use the Rancher Kubernetes API to interact with Rancher CRDs via Kubernetes tooling. This includes convenient documentation via the kubectl `explain` command. A limited set of our most widely-used CRDs will be available in Rancher v2.8.0. More are on the way.

**Custom Global Roles**

Global Role configuration is now more flexible. Additional fields are being added to the Global Role CRD, starting with the `inheritedClusterRoles` field, which allows users to give permissions for all downstream clusters with a single GlobalRole and GlobalRoleBinding. This lets you easily define and apply roles tailored to specific use cases, creating a level of flexibility not present in built-in global roles, such as Restricted Admin.

## Rancher General

### Features and Enhancements

- Rancher now supports Kubernetes v1.27. See [#41840](https://github.com/rancher/rancher/issues/41840).

### Major Bug Fixes

- Rancher no longer rapidly requests unnecessary upgrade operations from `helm-operation` pods. See [#41746](https://github.com/rancher/rancher/issues/41746).
- Importing a generic cluster with `system-default-registry` uses registry images, and the registration.yaml file no longer contains docker.io images when the `system-default-registry` is defined. See [#42048](https://github.com/rancher/rancher/issues/42048).

### Behavior Changes

- Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
- Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Cluster Provisioning

### Features and Enhancements

- The new `imagePolicyPull` global setting allows you to configure the image pull policy for `machine-provision-image`. The default value is `Always`, which preserves the default behavior in previous Rancher versions. You can set this value during Rancher initialization, with the `CATTLE_MACHINE_PROVISION_IMAGE_PULL_POLICY` environment variable. See [#42294](https://github.com/rancher/rancher/issues/42294). 

### Major Bug Fixes

- Rancher no longer requires you to force-refresh the UI to accept a web certificate during initial setup. See [#7867](https://github.com/rancher/dashboard/issues/7867).

### Behavior Changes

- Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.

## RKE Provisioning

### Behavior Changes

- Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
- The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

### Known Issues

- Scaling up etcd nodes on RKE may fail, with nodes stuck waiting to register with Kubernetes. This causes the cluster to hang. There are two workarounds available, depending on whether the cluster is active or hanging. See [#43356](https://github.com/rancher/rancher/issues/43356).
  
  - Workaround for active clusters:

    - Add one etcd node, wait for the cluster to become active again, then repeat as needed.

  - Workaround for hanging clusters:

    1. Delete the stuck etcd nodes.
    1. Find the leader pod: `kubectl -n kube-system get configmap cattle-controller`
    1. Restart the leader pod. This terminates the GRPC goroutine.
    1. Wait for the stuck nodes to be removed.
    1. Add one etcd node, wait for the cluster to become active again, then repeat as needed.

## RKE2 Provisioning

### Major Bug Fixes

- You can use IPv6 to provision RKE2 clusters. In previous Rancher versions, attempting to provision a new cluster with IPv6 would fail. See [#42411](https://github.com/rancher/rancher/issues/42411).  
- RKE2 clusters no longer become stuck in an `Updating` state after a change to the node pool. Instead of successfully rotating the node pool, the init node couldn't be deleted, which prevented the provisioning process from completing. See [#42709](https://github.com/rancher/rancher/issues/42709).

### Behavior Changes

- Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).
- Similar to Rancher v2.7.9, when you upgrade to Rancher v2.8.0 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).

### Known Issues

- Scaling down etcd node pools on RKE2/K3s machine-provisioned clusters may cause unexpected behavior. To avoid this, define multiple machine pools for etcd nodes, each with a quantity of one. You can then scale down simply by deleting machine pools. As a further mitigation, have a robust backup strategy and store your etcd snapshots in a safe location. Restoring from an etcd snapshot allows you to return the cluster to an operational state if you're affected by unexpected behaviors. See [#42582](https://github.com/rancher/rancher/issues/42582) and [#43097](https://github.com/rancher/rancher/issues/43097).

## Rancher App (Global UI)

### Features and Enhancements

- The Rancher UI sidebar has been updated, to facilitate switching between clusters and navigating to global areas of the UI. The new sidebar menu includes a filterable search for finding clusters by name. You can customize cluster icons with colors and letters by giving them a badge through the Cluster Dashboard. See [#9407](https://github.com/rancher/dashboard/issues/9407).

### Behavior Changes

The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->

- Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
- The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

### Known Issues

Legacy Custom Banner settings can cause the top left Menu to disappear. See [#10140](https://github.com/rancher/dashboard/issues/10140).

As a workaround:

1. Go to `<rancher url>/v3/settings/ui-banners`.
1. Press `Edit`, change the value to `{}`, press `Show Request` and then `Send Request` (Note - this will remove custom banners).
1. Go back to the UI and refresh the browser.
1. The nav should be back, and re-applying custom banners should not result in the bug again.

## Role-Based Access Control (RBAC) Framework

### Features and Enhancements

- A new optional field is now available in Global Roles. The  `inheritedClusterRoles` field grants cluster-level permissions on all downstream clusters and lets you create custom global roles. See [#42213](https://github.com/rancher/rancher/issues/42213).

## Pod Security Standards (PSS) & Pod Security Admissions (PSA) <!-- neo --> 

### Known Issues

- After an upgrade from Rancher v2.7.2 - v2.7.6, Rancher doesn't update the PSA configuration template, `rancher-restricted`, to include `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. As a workaround, [manually update](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/psa-config-templates#add-or-edit-a-pod-security-admissions-psa-configuration-template) `rancher-restricted` to add `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. See [#43150](https://github.com/rancher/rancher/issues/43150).

## Security

### Features and Enhancements

- TLS v1.3 is now supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

### Behavior Changes

- TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Authentication

### Major Bug Fixes

- Changing your vSphere credentials, such as your account password, no longer causes node deletion to fail. See [#40608](https://github.com/rancher/rancher/issues/40608).

### Behavior Changes

- The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
- [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).

## Rancher Webhook <!-- neo -->

### Features and Enhancements

- You can now configure the webhook to authenticate requests. This ensures that requests come from the `kube-apiserver` and not from illegitimate sources. By default, the webhook can accept traffic from any source. See [Hardening the Rancher Webhook](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/rancher-security/rancher-webhook-hardening) for advice on using authentication or network policy resources to protect your clusters. <!-- security #1252 -->

### Behavior Changes

- Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade. <!-- Security 1254 -->

## Continuous Delivery

### Features and Enhancements

- All clusters can now be assigned to Fleet workspaces even if they aren't running RKE, via setting the experimental `provisioningv2-fleet-workspace-back-population` feature. See [#36132](https://github.com/rancher/rancher/issues/36132).

## UI Plug-in Operator <!-- mapps -->

### Features and Enhancements

- The UI plugin operator can be installed in air-gapped mode. See [#42092](https://github.com/rancher/rancher/issues/42092).

## Apps & Marketplace <!-- mapps -->

### Major Bug Fixes

- Helm repositories will successfully access the Internet even if the Rancher chart contains `--set useBundledSystemChart=true`. See [#39532](https://github.com/rancher/rancher/issues/39532).

### Behavior Changes

- Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

  - `rancher-cis-benchmark`
  - `rancher-gatekeeper-operator`
  - `rancher-istio`
  - `rancher-logging`
  - `rancher-monitoring`
  
  The code for these charts will remain available for previous versions of Rancher.
  
- Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.

## OPA Gatekeeper <!-- mapps -->

### Behavior Changes

- OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

## Monitoring <!-- opni-->

### Known Issues

- Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

  1. If you haven't already, install Monitoring on the project.
  1. Move the `cattle-monitoring-system` namespace into the project.
  1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

  See [#4466](https://github.com/rancher/dashboard/issues/4466).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

## Images

- rancher/rancher:v2.8.1

<!-- TODO verify -->
## Tools

- CLI - [v2.8.0](https://github.com/rancher/cli/releases/tag/v2.8.0)
- RKE - [v1.5.2](https://github.com/rancher/rke/releases/tag/v1.5.2)

## Kubernetes Versions

- v1.27.8 (Default)
- v1.26.11
- v1.25.16

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI has been experimental since v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

## Deprecated Upstream Projects

In June 2023, Microsoft deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. When updating Rancher, update the configuration to make sure that users can still use Rancher with Azure AD. See [the documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and issue [#29306](https://github.com/rancher/rancher/issues/29306) for details.

## Removed Legacy Features

Apps functionality in the cluster manager has been deprecated as of the Rancher v2.7 line. This functionality has been replaced by the **Apps & Marketplace** section of the Rancher UI.

Also, `rancher-external-dns` and `rancher-global-dns` have been deprecated as of the Rancher v2.7 line.

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features was announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**

- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**

- Multiclusterapps (Global): Apps within the **Multicluster Apps** section of the Rancher UI.

# Previous Rancher Behavior Changes

<!-- Apply same headers as "Major Bug Fixes" but with "Previous Rancher Behavior Changes" suffix instead -->

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094).
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062).

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Feature Charts

- **Rancher v2.7.0:**
  - A configurable `priorityClass` is available in the Rancher pod and its feature charts. Previously, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. See [#37927](https://github.com/rancher/rancher/issues/37927).

## Previous Rancher Behavior Changes - Backup/Restore <!-- night's watch -->

- **Rancher v2.7.7:** 
  - If you use a version of backup-restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).

## Previous Rancher Behavior Changes - Logging <!-- opni -->

- **Rancher v2.7.0:**
  - Rancher defaults to using the bci-micro image for sidecar audit logging. Previously, the default image was Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).

## Previous Rancher Behavior Changes - Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
    - Rancher aggregates the changed counts and only sends a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
    - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, with a significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).

## Previous Rancher Behavior Changes - Project Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - The Helm Controller in RKE2/K3s respects the `managedBy` annotation. In its initial release, Project Monitoring V2 required a workaround to set `helmProjectOperator.helmController.enabled: false`, since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.7.2:**
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).<!-- issue mentions v2.5.12 but first added to RN in https://github.com/rancher/rancher/releases/tag/v2.7.2 -->

- **Rancher 2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.6.1 -->

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).

- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Cloud Credentials <!-- hostbusters -->

- **Rancher v2.7.2:**
  - When enabling some custom node drivers, the **Cloud Credential** creation page does not show the correct default fields and has an uneditable `foo` key. See [#8563](https://github.com/rancher/dashboard/issues/8563).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.5.0 -->

- **Rancher v2.6.4:**
  - In certain cases, no users are listed in **Users and Authentication**, and selecting **Create** does not display the entire new user creation form. As a workaround, perform a hard refresh to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).<!-- first proposed as release note in https://github.com/rancher/rancher/issues/37531#ref-pullrequest-1140380350 -->
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).

  - **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426).

- **Rancher v2.6.7:**
  - CSI Proxy for Windows will now work in an air-gapped environment.<!-- no issue number--><!-- seems to first appear in https://github.com/rancher/rancher/releases/tag/v2.6.7. v2.6.6 has brief release notes. v2.6.5 doesn't mention it -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## Long-standing Known Issues - RKE

- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).

- **Rancher 2.7.4:**
  - RKE clusters may be unable to restore from an etcd snapshot. See [#41547](https://github.com/rancher/rancher/issues/41547).
  
    There is a workaround available to re-start the kubelet container on affected worker nodes. This approach recreates the kubelet container on all nodes, not just the worker nodes. Rancher handles the process to ensure zero downtime, just like for any other modification of the cluster. If you prefer to use the `extra_args` blob, be sure both the arg and its value are valid. See the [Kubernetes documentation](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) for available options:
    1. On the Cluster Management page, select **Edit config** on the target cluster.
    1. In the "Cluster Options" section, select **Edit as YAML**.
    1. Modify any value under the `etra_args` or `extra_env` section under `rancher_kubernetes_engine_config.services.kubelet`.
    1. Save the change to trigger a cluster upgrade.

    It may take a few moments for the upgrade to finish.

    - When this problem is triggered, containers from previous pods will become orphaned on downstream nodes. To remove the orphaned nodes, run `docker restart kubelet` on every affected worker node. 

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).

## Long-standing Known Issues - RKE2

- **Rancher v2.7.7:**
 - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.7.6:**
  - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).

- **Rancher v2.7.4:**

  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).

- **Rancher v2.6.x:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).

- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.5:**
  - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes must reboot after the upgrade completes. See [#3376457645](https://github.com/rancher/rancher/issues/).

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - K3s

- **Rancher v2.7.7:**
 - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.7.6:**
  - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).

- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).

- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).

- **Rancher v2.6.x:**
  - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).<!-- no mention of patch version in issue thread, milestone is simply v2.6, already appear as a longstanding issue in https://github.com/rancher/rancher/releases/tag/v2.6.0 -->

- **Rancher v2.6.0:**
  - When editing or upgrading an Azure Kubernetes Service (AKS) cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).<!-- first proposed as a release note for https://github.com/rancher/rancher/issues/33561#issuecomment-879272354 -->

## Long-standing Known Issues - EKS

- **Rancher v2.7.0:**
  - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. See [#39392](https://github.com/rancher/rancher/issues/39392).

## Long-standing Known Issues - GKE

- **Rancher v2.5.8:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to Kubernetes v1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).

## Long-standing Known Issues - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo --> 

- **Rancher v2.6.4:**
  - The deployment's `securityContext` section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy (PSP) support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).<!-- https://github.com/rancher/dashboard/issues/4815#issuecomment-1074184973 -->

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.6.2:**
  - Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259).

## Long-standing Known Issues - Encryption

- **Rancher v2.5.4:**
  - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).

## Long-standing Known Issues - Rancher Webhook <!-- neo -->

- **Rancher v2.7.2:**
  - A webhook is installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher v2.7.2 or later, to a Rancher version earlier than v2.7.2, the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after a Rancher version earlier than v2.7.2 is running). This removes the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).

## Long-standing Known Issues - Harvester

- Upgrades from Harvester v0.3.0 are not supported.<!-- no issue number -->

- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).

- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
  - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
    1. Refresh the `rancher-charts` catalog resource.
    1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
    1. Click **⋮** and select **Upgrade** to check if there is a newer Fleet version listed.
    1. Update the `fleet` chart. Fleet will automatically update the agents.

- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Apps & Marketplace <!-- mapps -->

- **Rancher v2.7.0** 
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).

## Long-standing Known Issues - Backup/Restore <!-- night's watch -->

- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.<!-- no issue number -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.6.3:**
  - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail. The backup file contains CRDs with the apiVersion `v1beta1`. There are two workarounds for this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See the [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).

## Long-standing Known Issues - Istio <!-- mapps -->

- Istio v1.12 and below do not work on Kubernetes v1.23 clusters. To use the Istio charts, please do not update to Kubernetes v1.23 until the next charts' release.<!-- no issue number -->

- **Rancher v2.6.4:**
  - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).

- **Rancher v2.6.1:**
  - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).

## Long-standing Known Issues - Logging <!-- opni -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).

## Long-standing Known Issues - Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).


## All issues in v2.8.1 milestone

* [#44006](https://github.com/rancher/rancher/issues/44006) [BUG] Rancher Monitoring components ignore configured image pull registry (failing on air-gapped environments)
* [#43910](https://github.com/rancher/rancher/issues/43910) [Backport - v2.8.1] [BUG] Rancher can't start on air-gapped environments
* [#43893](https://github.com/rancher/rancher/issues/43893) ACI CNI 6.0.3.1 changes for RKE1 v1.5.x
* [#43892](https://github.com/rancher/rancher/issues/43892) Unable to import existing downstream cluster in Rancher 2.8.0 - UI plugin issue
-----
# Release v2.8.0

> **Important:** Review the [Install/Upgrade](#installupgrade-notes) notes before upgrading to any Rancher version.

Rancher v2.8.0 is the latest minor release of Rancher. This version introduces two major new features and enhancements, and numerous other improvements.

> *The following topics received updates in this Rancher release. Topics which had no reported changes are omitted.*

## Highlights

**Rancher Kubernetes API**

Our new [Rancher Kubernetes API (RK-API)](https://ranchermanager.docs.rancher.com/v2.8/api/api-reference) lets you manage Rancher in the same way you manage Kubernetes. You can now use the Rancher Kubernetes API to interact with Rancher CRDs via Kubernetes tooling. This includes convenient documentation via the kubectl `explain` command. A limited set of our most widely-used CRDs will be available in Rancher v2.8.0. More are on the way. 

**Custom Global Roles**

Global Role configuration is now more flexible. Additional fields are being added to the Global Role CRD, starting with the `inheritedClusterRoles` field, which allows users to give permissions for all downstream clusters with a single GlobalRole and GlobalRoleBinding. This lets you easily define and apply roles tailored to specific use cases, creating a level of flexibility not present in built-in global roles, such as Restricted Admin.

## Rancher General

### Features and Enhancements

- Rancher now supports Kubernetes v1.27. See [#41840](https://github.com/rancher/rancher/issues/41840).

### Major Bug Fixes

- Rancher no longer rapidly requests unnecessary upgrade operations from `helm-operation` pods. See [#41746](https://github.com/rancher/rancher/issues/41746).
- Importing a generic cluster with `system-default-registry` uses registry images, and the registration.yaml file no longer contains docker.io images when the `system-default-registry` is defined. See [#42048](https://github.com/rancher/rancher/issues/42048).

### Behavior Changes

- Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
- Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Cluster Provisioning

### Features and Enhancements

- The new `imagePolicyPull` global setting allows you to configure the image pull policy for `machine-provision-image`. The default value is `Always`, which preserves the default behavior in previous Rancher versions. You can set this value during Rancher initialization, with the `CATTLE_MACHINE_PROVISION_IMAGE_PULL_POLICY` environment variable. See [#42294](https://github.com/rancher/rancher/issues/42294). 

### Major Bug Fixes

- Rancher no longer requires you to force-refresh the UI to accept a web certificate during initial setup. See [#7867](https://github.com/rancher/dashboard/issues/7867).

### Behavior Changes

- Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.

## RKE Provisioning

### Behavior Changes

- Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
- The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

### Known Issues

- Scaling up etcd nodes on RKE may fail, with nodes stuck waiting to register with Kubernetes. This causes the cluster to hang. There are two workarounds available, depending on whether the cluster is active or hanging. See [#43356](https://github.com/rancher/rancher/issues/43356).
  
  - Workaround for active clusters:
    
    - Add one etcd node, wait for the cluster to become active again, then repeat as needed.

  - Workaround for hanging clusters:
    
    1. Delete the stuck etcd nodes.
    1. Find the leader pod: `kubectl -n kube-system get configmap cattle-controller`
    1. Restart the leader pod. This terminates the GRPC goroutine.
    1. Wait for the stuck nodes to be removed.
    1. Add one etcd node, wait for the cluster to become active again, then repeat as needed.

## RKE2 Provisioning

### Major Bug Fixes

- You can use IPv6 to provision RKE2 clusters. In previous Rancher versions, attempting to provision a new cluster with IPv6 would fail. See [#42411](https://github.com/rancher/rancher/issues/42411).  
- RKE2 clusters no longer become stuck in an `Updating` state after a change to the node pool. Instead of successfully rotating the node pool, the init node couldn't be deleted, which prevented the provisioning process from completing. See [#42709](https://github.com/rancher/rancher/issues/42709).

### Behavior Changes

- Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).
- Similar to Rancher v2.7.9, when you upgrade to Rancher v2.8.0 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).

### Known Issues

- Scaling down etcd node pools on RKE2/K3s machine-provisioned clusters may cause unexpected behavior. To avoid this, define multiple machine pools for etcd nodes, each with a quantity of one. You can then scale down simply by deleting machine pools. As a further mitigation, have a robust backup strategy and store your etcd snapshots in a safe location. Restoring from an etcd snapshot allows you to return the cluster to an operational state if you're affected by unexpected behaviors. See [#42582](https://github.com/rancher/rancher/issues/42582) and [#43097](https://github.com/rancher/rancher/issues/43097).

## Rancher App (Global UI)

### Features and Enhancements

- The Rancher UI sidebar has been updated, to facilitate switching between clusters and navigating to global areas of the UI. The new sidebar menu includes a filterable search for finding clusters by name. You can customize cluster icons with colors and letters by giving them a badge through the Cluster Dashboard. See [#9407](https://github.com/rancher/dashboard/issues/9407).

### Behavior Changes

The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->
- Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
- The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

### Known Issues

Legacy Custom Banner settings can cause the top left Menu to disappear. See [#10140](https://github.com/rancher/dashboard/issues/10140).

As a workaround:

1. Go to `<rancher url>/v3/settings/ui-banners`.
1. Press `Edit`, change the value to `{}`, press `Show Request` and then `Send Request` (Note - this will remove custom banners).
1. Go back to the UI and refresh the browser.
1. The nav should be back, and re-applying custom banners should not result in the bug again.

## Role-Based Access Control (RBAC) Framework

### Features and Enhancements

- A new optional field is now available in Global Roles. The  `inheritedClusterRoles` field grants cluster-level permissions on all downstream clusters and lets you create custom global roles. See [#42213](https://github.com/rancher/rancher/issues/42213).

## Pod Security Standards (PSS) & Pod Security Admissions (PSA) <!-- neo --> 

### Known Issues

- After an upgrade from Rancher v2.7.2 - v2.7.6, Rancher doesn't update the PSA configuration template, `rancher-restricted`, to include `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. As a workaround, [manually update](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/psa-config-templates#add-or-edit-a-pod-security-admissions-psa-configuration-template) `rancher-restricted` to add `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. See [#43150](https://github.com/rancher/rancher/issues/43150).

## Security

### Features and Enhancements

- TLS v1.3 is now supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

### Behavior Changes

- TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Authentication

### Major Bug Fixes

- Changing your vSphere credentials, such as your account password, no longer causes node deletion to fail. See [#40608](https://github.com/rancher/rancher/issues/40608).

### Behavior Changes

- The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
- [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).

## Rancher Webhook <!-- neo -->

### Features and Enhancements

- You can now configure the webhook to authenticate requests. This ensures that requests come from the `kube-apiserver` and not from illegitimate sources. By default, the webhook can accept traffic from any source. See [Hardening the Rancher Webhook](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/rancher-security/rancher-webhook-hardening) for advice on using authentication or network policy resources to protect your clusters. <!-- security #1252 -->

### Behavior Changes

- Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade. <!-- Security 1254 -->

## Continuous Delivery

### Features and Enhancements

- All clusters can now be assigned to Fleet workspaces even if they aren't running RKE, via setting the experimental `provisioningv2-fleet-workspace-back-population` feature. See [#36132](https://github.com/rancher/rancher/issues/36132).

## UI Plug-in Operator <!-- mapps -->

### Features and Enhancements

- The UI plugin operator can be installed in air-gapped mode. See [#42092](https://github.com/rancher/rancher/issues/42092).

## Apps & Marketplace <!-- mapps -->

### Major Bug Fixes

- Helm repositories will successfully access the Internet even if the Rancher chart contains `--set useBundledSystemChart=true`. See [#39532](https://github.com/rancher/rancher/issues/39532).

### Behavior Changes

- Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

  - `rancher-cis-benchmark`
  - `rancher-gatekeeper-operator`
  - `rancher-istio`
  - `rancher-logging`
  - `rancher-monitoring`
  
  The code for these charts will remain available for previous versions of Rancher. 
  
- Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.

## OPA Gatekeeper <!-- mapps -->

### Behavior Changes

- OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

## Monitoring <!-- opni-->

### Known Issues

- Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

  1. If you haven't already, install Monitoring on the project.
  1. Move the `cattle-monitoring-system` namespace into the project.
  1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

  See [#4466](https://github.com/rancher/dashboard/issues/4466).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution which uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

## Images
- rancher/rancher:v2.8.0

<!-- TODO verify -->
## Tools
- CLI - [v2.8.0](https://github.com/rancher/cli/releases/tag/v2.8.0)
- RKE - [v1.5.0](https://github.com/rancher/rke/releases/tag/v1.5.0)

## Kubernetes Versions for RKE

- v1.27.6 (Default)
- v1.26.9
- v1.25.14

## Kubernetes Versions for RKE2/K3s

- v1.27.7 (Default)
- v1.26.10
- v1.25.15

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Dual-stack and IPv6-only support for RKE1 clusters using the Flannel CNI has been experimental since v1.23.x. See the [upstream Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/dual-stack/). Dual-stack is not currently supported on Windows. See [#165](https://github.com/rancher/windows/issues/165).

## Deprecated Upstream Projects

In June 2023, Microsoft deprecated the Azure AD Graph API that Rancher had been using for authentication via Azure AD. When updating Rancher, update the configuration to make sure that users can still use Rancher with Azure AD. See [the documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#migrating-from-azure-ad-graph-api-to-microsoft-graph-api) and issue [#29306](https://github.com/rancher/rancher/issues/29306) for details.

## Removed Legacy Features

Apps functionality in the cluster manager has been deprecated as of the Rancher v2.7 line. This functionality has been replaced by the **Apps & Marketplace** section of the Rancher UI.

Also, `rancher-external-dns` and `rancher-global-dns` have been deprecated as of the Rancher v2.7 line.

The following legacy features have been removed as of Rancher v2.7.0. The deprecation and removal of these features was announced in previous releases. See [#6864](https://github.com/rancher/dashboard/issues/6864).

**UI and Backend**
- CIS Scans v1 (Cluster)
- Pipelines (Project)
- Istio v1 (Project)
- Logging v1 (Project)
- RancherD

**UI**
- Multiclusterapps (Global): Apps within the **Multicluster Apps** section of the Rancher UI.

# Previous Rancher Behavior Changes

<!-- Apply same headers as "Major Bug Fixes" but with "Previous Rancher Behavior Changes" suffix instead -->

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094). 
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062). 

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Feature Charts

- **Rancher v2.7.0:**
  - A configurable `priorityClass` is available in the Rancher pod and its feature charts. Previously, pods critical to running Rancher didn't use a priority class. This could cause a cluster with limited resources to evict Rancher pods before other noncritical pods. See [#37927](https://github.com/rancher/rancher/issues/37927).

## Previous Rancher Behavior Changes - Backup/Restore <!-- night's watch -->

- **Rancher v2.7.7:** 
  - If you use a version of backup-restore older than v102.0.2+up3.1.2 to take a backup of Rancher v2.7.7, the migration will encounter a `capi-webhook` error. Make sure that the chart version used for backups is v102.0.2+up3.1.2, which has `cluster.x-k8s.io/v1alpha4` resources removed from the resourceSet. If you can't use v102.0.2+up3.1.2 for backups, delete all `cluster.x-k8s.io/v1alpha4` resources from the backup tar before using it. See [#382](https://github.com/rancher/backup-restore-operator/pull/382).

## Previous Rancher Behavior Changes - Logging <!-- opni -->

- **Rancher v2.7.0:**
  - Rancher defaults to using the bci-micro image for sidecar audit logging. Previously, the default image was Busybox. See [#35587](https://github.com/rancher/rancher/issues/35587).

## Previous Rancher Behavior Changes - Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - Rancher maintains a `/v1/counts` endpoint that the UI uses to display resource counts. The UI subscribes to changes to the counts for all resources through a websocket to receive the new counts for resources.
    - Rancher aggregates the changed counts and only sends a message every 5 seconds. This, in turn, requires the UI to update the counts at most once every 5 seconds, improving UI performance. Previously, Rancher would send a message each time the resource counts changed for a resource type. This lead to the UI needing to constantly stop other areas of processing to update the resource counts. See [#36682](https://github.com/rancher/rancher/issues/36682).
    - Rancher now only sends back a count for a resource type if the count has changed from the previously known number, improving UI performance. Previously, each message from this socket would include all counts for every resource type in the cluster, even if the counts only changed for one specific resource type. This would cause the UI to need to re-update resource counts for every resource type at a high frequency, with a significant performance impact. See [#36681](https://github.com/rancher/rancher/issues/36681).

## Previous Rancher Behavior Changes - Project Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - The Helm Controller in RKE2/K3s respects the `managedBy` annotation. In its initial release, Project Monitoring V2 required a workaround to set `helmProjectOperator.helmController.enabled: false`, since the Helm Controller operated on a cluster-wide level and ignored the `managedBy` annotation. See [#39724](https://github.com/rancher/rancher/issues/39724).

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.7.2:**
  - You need to force-refresh the Rancher UI after initial Rancher setup, to trigger the prompt to accept the self-signed certificate. As a workaround, visit the Rancher portal, accept the self-signed certificate, and go through the setup process. Once done, go to the address bar of your browser and click the lock icon. Select the option to allow you to receive certificate errors for the Rancher website. You'll then be prompted again to accept the new certificate. See [#7867](https://github.com/rancher/dashboard/issues/7867).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).<!-- issue mentions v2.5.12 but first added to RN in https://github.com/rancher/rancher/releases/tag/v2.7.2 -->

- **Rancher 2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.6.1 -->

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).

- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Cloud Credentials <!-- hostbusters -->

- **Rancher v2.7.2:**
  - When enabling some custom node drivers, the **Cloud Credential** creation page does not show the correct default fields and has an uneditable `foo` key. See [#8563](https://github.com/rancher/dashboard/issues/8563).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.5.0 -->

- **Rancher v2.6.4:**
  - In certain cases, no users are listed in **Users and Authentication**, and selecting **Create** does not display the entire new user creation form. As a workaround, perform a hard refresh to log back in. See [#37531](https://github.com/rancher/rancher/issues/37531).<!-- first proposed as release note in https://github.com/rancher/rancher/issues/37531#ref-pullrequest-1140380350 -->
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).

  - **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Downstream Windows clusters get stuck after a Rancher upgrade. Windows nodes become stuck in an unavailable state, with an `failed to list *v1.ConfigMap: configmaps "kube-root-ca.crt" is forbidden` error message. As a workaround, reboot the node. See [#42426](https://github.com/rancher/rancher/issues/42426).

- **Rancher v2.6.7:**
  - CSI Proxy for Windows will now work in an air-gapped environment.<!-- no issue number--><!-- seems to first appear in https://github.com/rancher/rancher/releases/tag/v2.6.7. v2.6.6 has brief release notes. v2.6.5 doesn't mention it -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## Long-standing Known Issues - RKE

- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).

- **Rancher 2.7.4:**
  - RKE clusters may be unable to restore from an etcd snapshot. See [#41547](https://github.com/rancher/rancher/issues/41547).
  
    There is a workaround available to re-start the kubelet container on affected worker nodes. This approach recreates the kubelet container on all nodes, not just the worker nodes. Rancher handles the process to ensure zero downtime, just like for any other modification of the cluster. If you prefer to use the `extra_args` blob, be sure both the arg and its value are valid. See the [Kubernetes documentation](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) for available options:
    1. On the Cluster Management page, select **Edit config** on the target cluster.
    1. In the "Cluster Options" section, select **Edit as YAML**.
    1. Modify any value under the `etra_args` or `extra_env` section under `rancher_kubernetes_engine_config.services.kubelet`.
    1. Save the change to trigger a cluster upgrade.
    
    It may take a few moments for the upgrade to finish.

    - When this problem is triggered, containers from previous pods will become orphaned on downstream nodes. To remove the orphaned nodes, run `docker restart kubelet` on every affected worker node. 

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).

## Long-standing Known Issues - RKE2

- **Rancher v2.7.7:**
 - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.7.6:**
  - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).

- **Rancher v2.7.4:**

  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).

- **Rancher v2.6.x:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).

- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.5:**
  - When upgrading Windows nodes in RKE2 clusters via the Rancher UI, Windows worker nodes must reboot after the upgrade completes. See [#3376457645](https://github.com/rancher/rancher/issues/).

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - K3s

- **Rancher v2.7.7:**
 - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.7.6:**
  - Scaling down etcd nodes on K3s/RKE2 machine-provisioned clusters may inadvertently delete all etcd nodes in the pool. This is linked to an [upstream cluster-api bug](https://github.com/kubernetes-sigs/cluster-api/issues/9334) that causes the controllers to delete more than the desired quantity of etcd nodes when reconciling an RKE Machine Pool. This issue affects etcd node scale-down operations on K3s/RKE2 machine-provisioned clusters. To help mitigate the issue, have a robust backup strategy and store your etcd snapshots in a safe location. See [#42582](https://github.com/rancher/rancher/issues/42582).

- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).

- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).

- **Rancher v2.6.x:**
  - Windows node pools are not currently supported. See [#32586](https://github.com/rancher/rancher/issues/32586).<!-- no mention of patch version in issue thread, milestone is simply v2.6, already appear as a longstanding issue in https://github.com/rancher/rancher/releases/tag/v2.6.0 -->

- **Rancher v2.6.0:**
  - When editing or upgrading an Azure Kubernetes Service (AKS) cluster, do not make changes from the Azure console or CLI at the same time. These actions must be done separately. See [#33561](https://github.com/rancher/rancher/issues/33561).<!-- first proposed as a release note for https://github.com/rancher/rancher/issues/33561#issuecomment-879272354 -->

## Long-standing Known Issues - EKS

- **Rancher v2.7.0:**
  - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. See [#39392](https://github.com/rancher/rancher/issues/39392).

## Long-standing Known Issues - GKE

- **Rancher v2.5.8:**
  - Basic authentication must be explicitly disabled in GCP before upgrading a GKE cluster to Kubernetes v1.19+ in Rancher. See [#32312](https://github.com/rancher/rancher/issues/32312).

## Long-standing Known Issues - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo --> 

- **Rancher v2.6.4:**
  - The deployment's `securityContext` section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy (PSP) support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).<!-- https://github.com/rancher/dashboard/issues/4815#issuecomment-1074184973 -->

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.6.2:**
  - Users on certain LDAP setups don't have permission to search LDAP. When they attempt to perform a search, they receive the error message, `Result Code 32 "No Such Object"`. See [#35259](https://github.com/rancher/rancher/issues/35259).

## Long-standing Known Issues - Encryption

- **Rancher v2.5.4:**
  - Rotating encryption keys with a custom encryption provider is not supported. See [#30539](https://github.com/rancher/rancher/issues/30539).

## Long-standing Known Issues - Rancher Webhook <!-- neo -->

- **Rancher v2.7.2:**
  - A webhook is installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher v2.7.2 or later, to a Rancher version earlier than v2.7.2, the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after a Rancher version earlier than v2.7.2 is running). This removes the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).

## Long-standing Known Issues - Harvester

- Upgrades from Harvester v0.3.0 are not supported.<!-- no issue number -->

- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).

- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
  - When updating Rancher, sometimes Fleet is not upgraded to the latest version. See [#1590](https://github.com/rancher/fleet/issues/1590). To ensure you upgrade Fleet:
    1. Refresh the `rancher-charts` catalog resource.
    1. Go to **Apps**, select **All Workspaces**, and note the versions of `fleet-crd` and `fleet-chart`.
    1. Click **⋮** and select **Upgrade** to check if there is a newer Fleet version listed.
    1. Update the `fleet` chart. Fleet will automatically update the agents.

- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Apps & Marketplace <!-- mapps -->

- **Rancher v2.7.0** 
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.7.2:**
  - When running CIS scans on RKE and RKE2 clusters on Kubernetes v1.25, some tests will fail if the `rke-profile-hardened-1.23` or the `rke2-profile-hardened-1.23` profile is used. These [RKE](https://github.com/rancher/rancher/issues/39851#issuecomment-1368903719) and [RKE2](https://github.com/rancher/rancher/issues/39851#issuecomment-1430941043) test cases failing is expected as they rely on PSPs, which have been removed in Kubernetes v1.25. See [#39851](https://github.com/rancher/rancher/issues/39851).

## Long-standing Known Issues - Backup/Restore <!-- night's watch -->

- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.<!-- no issue number -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

- **Rancher v2.6.3:**
  - Because Kubernetes v1.22 drops the apiVersion `apiextensions.k8s.io/v1beta1`, trying to restore an existing backup file into a v1.22+ cluster will fail. The backup file contains CRDs with the apiVersion `v1beta1`. There are two workarounds for this issue: update the default `resourceSet` to collect the CRDs with the apiVersion v1, or update the default `resourceSet` and the client to use the new APIs internally. See the [documentation](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/migrate-rancher-to-new-cluster#2-restore-from-backup-using-a-restore-custom-resource) and [#34154](https://github.com/rancher/rancher/issues/34154).

## Long-standing Known Issues - Istio <!-- mapps -->

- Istio v1.12 and below do not work on Kubernetes v1.23 clusters. To use the Istio charts, please do not update to Kubernetes v1.23 until the next charts' release.<!-- no issue number -->

- **Rancher v2.6.4:**
  - Applications injecting Istio sidecars, fail on SELinux RHEL 8.4 enabled clusters. A temporary workaround for this issue is to run the following command on each cluster node before creating a cluster: `mkdir -p /var/run/istio-cni && semanage fcontext -a -t container_file_t /var/run/istio-cni && restorecon -v /var/run/istio-cni`. See [#33291](https://github.com/rancher/rancher/issues/33291).

- **Rancher v2.6.1:**
  - Deprecated resources are not automatically removed and will cause errors during upgrades. Manual steps must be taken to migrate and/or cleanup resources before an upgrade is performed. See [#34699](https://github.com/rancher/rancher/issues/34699).

## Long-standing Known Issues - Logging <!-- opni -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).

## Long-standing Known Issues - Monitoring <!-- opni-->

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://www.suse.com/support/kb/doc/?id=000020029) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## All issues in v2.8.0 milestone

* [#43624](https://github.com/rancher/rancher/issues/43624) [RKE1] Bug in node lookup for external aws cloud provider 
* [#43623](https://github.com/rancher/rancher/issues/43623) Can not add a custom node driver
* [#43287](https://github.com/rancher/rancher/issues/43287) [BUG] v2.8.0 - rke-tools v0.1.95 not included in rancher-images - blocks RKE1 provisioning with private registries.
* [#43232](https://github.com/rancher/rancher/issues/43232) RKE2 and K3S - KDM Update for K8s October patch release for Rancher 2.8
* [#43222](https://github.com/rancher/rancher/issues/43222) [BUG] Snapshot restore after an upgrade the cluster gets stuck in an error state 
* [#43221](https://github.com/rancher/rancher/issues/43221) Feature charts: Need to add NeuVector chart 103.0.0+up2.6.4 in 2.8.x
* [#43197](https://github.com/rancher/rancher/issues/43197) [BUG] helm-operation panics while installing charts on hosted clusters
* [#43183](https://github.com/rancher/rancher/issues/43183) [BUG] v2.8.0-rc1 helm-operation error
* [#43175](https://github.com/rancher/rancher/issues/43175) [BUG] RKE1 node driver clusters don't work with external AWS cloud provider
* [#43115](https://github.com/rancher/rancher/issues/43115) [BUG] Rancher pods are in crash loop back off on a fresh install and upgrade and never recovers
* [#43070](https://github.com/rancher/rancher/issues/43070) [BUG] RKE2/K3s cluster nodes get recreated on a rollback using backup/restore operator
* [#43043](https://github.com/rancher/rancher/issues/43043) [BUG] Rancher cleanup script to be updated to remove the podsecuritypolicy references
* [#43032](https://github.com/rancher/rancher/issues/43032) [BUG] When we download a kubeconfig file by setting kubeconfig-generate-token to false, tokens are not created
* [#43030](https://github.com/rancher/rancher/issues/43030) [BUG]Requests to /v1/endpoints return 500 and cause the cluster to enter 'updating' state when monitoring is installed
* [#43021](https://github.com/rancher/rancher/issues/43021) [BUG] CIS benchmark chart 5.0.0-rc3 fails to install on upgraded Rancher server
* [#43015](https://github.com/rancher/rancher/issues/43015) Update Documentation to Reflect Support for cert-manager.io/v1
* [#43012](https://github.com/rancher/rancher/issues/43012) [BUG] Fleet-agent panics on k3s node driver cluster and doesn't recover 
* [#43003](https://github.com/rancher/rancher/issues/43003) [BUG] Rancher pods in panic loop after downstream cluster nodes were deleted
* [#42999](https://github.com/rancher/rancher/issues/42999) Logs keep generating with errors on Cluster Deletion
* [#42972](https://github.com/rancher/rancher/issues/42972) [BUG] unable to provision node driver clusters 
* [#42965](https://github.com/rancher/rancher/issues/42965) [BUG] Remove reference to "NamespacedRules" field in "kubectl explain globalroles"
* [#42961](https://github.com/rancher/rancher/issues/42961) [BUG] Race Condition issue in dynamic listener
* [#42950](https://github.com/rancher/rancher/issues/42950) [BUG] Mismatch in kube-version annotation for rancher-cis-benchmark
* [#42949](https://github.com/rancher/rancher/issues/42949) [BUG] Mismatch in kube-version annotation for rancher-webhook
* [#42930](https://github.com/rancher/rancher/issues/42930) [BUG] [Team-1] Rancher logs are consistently generating warnings every few seconds for k8s 1.27 downstream clusters
* [#42928](https://github.com/rancher/rancher/issues/42928) CRTB/PRTB created without validating clusterName and logs keep generating with errors
* [#42913](https://github.com/rancher/rancher/issues/42913) [RFE] Projects Public API: validate `ClusterName`
* [#42905](https://github.com/rancher/rancher/issues/42905) Add  Istio versions to 1.19.0
* [#42903](https://github.com/rancher/rancher/issues/42903) [RFE] Update kubectl version in shell to support 1.27
* [#42895](https://github.com/rancher/rancher/issues/42895) [BUG] Etcd restore does not work on an RKE2 cluster
* [#42892](https://github.com/rancher/rancher/issues/42892) Run Conformance checks for v1.27/rancher
* [#42890](https://github.com/rancher/rancher/issues/42890) [BUG] can't delete cluster with rke2/k3s stacked (etcd+controlplane) node - cluster gets stuck in removing state
* [#42889](https://github.com/rancher/rancher/issues/42889) [BUG] Downstream RKE2 cluster does not come up "Active" after upgrading Rancher from v2.7.6 to v2.8-head
* [#42888](https://github.com/rancher/rancher/issues/42888) Upgrade 2.7.6 to 2.8-head [ERROR] error syncing rancher-charts
* [#42870](https://github.com/rancher/rancher/issues/42870) Add linting to e2e tests & framework
* [#42861](https://github.com/rancher/rancher/issues/42861) [BUG] Rancher logs are consistently generating warnings every few seconds for k8s 1.27 downstream clusters
* [#42838](https://github.com/rancher/rancher/issues/42838) [BUG] [cli] The cli2.json file gets created as a world readable file
* [#42828](https://github.com/rancher/rancher/issues/42828) Remove support for K8s 1.23 and 1.24 for Rancher 2.8.0
* [#42822](https://github.com/rancher/rancher/issues/42822) CRTB created with a non existing user from rancher, it causes UI is broken 
* [#42814](https://github.com/rancher/rancher/issues/42814) [BUG] All K3S versions are showing up as experimental on rancher v2.8-head
* [#42812](https://github.com/rancher/rancher/issues/42812) [v2.8] KDM Update for K8s September patch release
* [#42809](https://github.com/rancher/rancher/issues/42809) [BUG] Kubectl error after installing monitoring chart: ("dial tcp: lookup kubernetes.default on 10.43.0.10:53: no such host")
* [#42802](https://github.com/rancher/rancher/issues/42802) [Forwardport v2.8] [BUG] Downstream clusters not coming up after migration on v2.7-head
* [#42801](https://github.com/rancher/rancher/issues/42801) [Forwardport v2.8] Restoring rancher from a backup on a migrated rancher server fails with the error unable to create new content in namespace cluster-fleet-default-anupamapostbkp because it is being terminated error restoring
* [#42800](https://github.com/rancher/rancher/issues/42800) [Forwardport v2.8] Service "capi-webhook-service" not found
* [#42799](https://github.com/rancher/rancher/issues/42799) [Forwardport v2.8] [BUG] Upon upgrading to 2.7.6, uuid-unmigration can enter "Failure" state silently
* [#42793](https://github.com/rancher/rancher/issues/42793) [BUG] v2prov cert rotation unit test race condition
* [#42777](https://github.com/rancher/rancher/issues/42777) [Forwardport v2.8] [BUG][CAPR] rancher-provisioning-capi-patch-sa job failing due to lack of exclusion from PSA enforcement
* [#42754](https://github.com/rancher/rancher/issues/42754) [BUG] Creating a CRTB or PRTB in Default namespace doesn't get deleted
* [#42749](https://github.com/rancher/rancher/issues/42749) [RFE] Ability to deploy AWS external tree provider in RKE2
* [#42730](https://github.com/rancher/rancher/issues/42730) [RFE] Deprecate Weave CNI plugin from rke
* [#42721](https://github.com/rancher/rancher/issues/42721) [BUG] Removing the last InheritedClusterRole does not remove backing CRTBs
* [#42711](https://github.com/rancher/rancher/issues/42711) [flaky-test] test_app_namespace_annotation
* [#42709](https://github.com/rancher/rancher/issues/42709) Init Node cannot be removed
* [#42665](https://github.com/rancher/rancher/issues/42665) [TESTING] Add full end-to-end tests for Rancher Machine CLI
* [#42647](https://github.com/rancher/rancher/issues/42647) [RFE] API Quickstart docs
* [#42645](https://github.com/rancher/rancher/issues/42645) [Forwardport v2.8] flag provided but not defined: -format seen in docker-image-digests-linux pipeline on drone-publish
* [#42644](https://github.com/rancher/rancher/issues/42644) [Forwardport v2.8] Simplify image digests file creation in CI
* [#42630](https://github.com/rancher/rancher/issues/42630) [flaky-test] TestProjectUserTestSuite
* [#42606](https://github.com/rancher/rancher/issues/42606) [flaky-test]  TestRancherManagedChartsSuite
* [#42588](https://github.com/rancher/rancher/issues/42588) [BUG] Only set owned tag on ec2 instance if tag is not present
* [#42576](https://github.com/rancher/rancher/issues/42576) Update Nutanix node driver to version 3.4.0+
* [#42569](https://github.com/rancher/rancher/issues/42569) Rancher CLI failure while authentication with Active Directory via kubectl/kubeconfig after upgrade to 2.6.9
* [#42561](https://github.com/rancher/rancher/issues/42561) Forwardport GUID AD issues to 2.8-head
* [#42553](https://github.com/rancher/rancher/issues/42553) [RFE] Generate openapi spec for rancher 
* [#42527](https://github.com/rancher/rancher/issues/42527) [BUG] Fix RKE2/K3s team image CVEs
* [#42525](https://github.com/rancher/rancher/issues/42525) [BUG] Hostbusters Image CVEs fix
* [#42480](https://github.com/rancher/rancher/issues/42480) [CI/CD] Provisioning tests failures inconsistently affect publish builds
* [#42462](https://github.com/rancher/rancher/issues/42462) [2.8] Deprecate Restricted Admin 
* [#42419](https://github.com/rancher/rancher/issues/42419) [Backport v2.8] [BUG] Fix errors for specific checks in the K3s CIS 1.7 files
* [#42418](https://github.com/rancher/rancher/issues/42418) [Forwardport v2.8] [BUG] Fix errors for specific checks in the RKE2 CIS 1.7 files 
* [#42417](https://github.com/rancher/rancher/issues/42417) [Forwardport v2.8] [BUG] Fix errors for specific checks in the RKE1 CIS 1.7 files
* [#42411](https://github.com/rancher/rancher/issues/42411) [BUG] Provisioning fails with ipv6
* [#42396](https://github.com/rancher/rancher/issues/42396) [BUG] - RKE2/K3s shell and rancher-webhook images get pulled from the Global registry instead of the Cluster level in no auth registries
* [#42377](https://github.com/rancher/rancher/issues/42377) [BUG] Rancher pods panic on startup if cluster `.spec.rancherKubernetesEngineConfig` is null
* [#42370](https://github.com/rancher/rancher/issues/42370) [2.8] Bump norman to next
* [#42369](https://github.com/rancher/rancher/issues/42369) [2.7] Bump norman to next
* [#42366](https://github.com/rancher/rancher/issues/42366) [2.8] Bump apiserver to next
* [#42365](https://github.com/rancher/rancher/issues/42365) [2.7] Bump apiserver to next
* [#42364](https://github.com/rancher/rancher/issues/42364) [2.8] Bump webhook version to 0.4.0
* [#42363](https://github.com/rancher/rancher/issues/42363) [2.7] Bump webhook version to 0.3.6
* [#42347](https://github.com/rancher/rancher/issues/42347) Move PAYG into cattle-system NS
* [#42339](https://github.com/rancher/rancher/issues/42339) [flaky-test] test_cluster_catalog_creation
* [#42308](https://github.com/rancher/rancher/issues/42308) [RFE] Graceful Shutdown of vSphere VM
* [#42294](https://github.com/rancher/rancher/issues/42294) [RFE] Allow configuration for Image Pull policy for machine-provisioning job
* [#42239](https://github.com/rancher/rancher/issues/42239) [flaky-test] test_mcapp_rollback_validation test failure
* [#42214](https://github.com/rancher/rancher/issues/42214) [RFE] Add webhook escalation check for "InheritedClusterRoles" field 
* [#42213](https://github.com/rancher/rancher/issues/42213) [RFE] Add new "InheritedClusterRoles" field
* [#42093](https://github.com/rancher/rancher/issues/42093) Document limitations on UI-Extensions on air-gapped environments
* [#42092](https://github.com/rancher/rancher/issues/42092) Support Rancher Extensions on air-gapped environments
* [#42064](https://github.com/rancher/rancher/issues/42064) Bump CNI versions for RKE1
* [#42052](https://github.com/rancher/rancher/issues/42052) [RFE]  update the rancher server to propagate the value when deploying the rancher-webhook helm chart
* [#42048](https://github.com/rancher/rancher/issues/42048) [BUG] Global System Default Private Registry not being honored when pulling cattle-cluster-agent images, reverts back to docker.io
* [#42044](https://github.com/rancher/rancher/issues/42044) [BUG] Wrong base64-encoding used to encode DockerConfigJSON for private registries
* [#42028](https://github.com/rancher/rancher/issues/42028) Update dynamic-listener to 0.3.6
* [#42027](https://github.com/rancher/rancher/issues/42027) [RFE] TLS 1.3 Support for Rancher Manager Ingress
* [#42019](https://github.com/rancher/rancher/issues/42019) Rebase Monitoring to 45.x
* [#41919](https://github.com/rancher/rancher/issues/41919) Update token setting defaults to have non-zero TTLs
* [#41840](https://github.com/rancher/rancher/issues/41840) [Feature] K8s 1.27 Support
* [#41825](https://github.com/rancher/rancher/issues/41825) [Flaky Tests] TestCRTBRoleTemplateInheritance fails intermittently
* [#41803](https://github.com/rancher/rancher/issues/41803) NeuVector k8s 1.27 chart support
* [#41802](https://github.com/rancher/rancher/issues/41802) Epinio: support of k8s 1.27
* [#41801](https://github.com/rancher/rancher/issues/41801) Longhorn k8s 1.27 chart support
* [#41800](https://github.com/rancher/rancher/issues/41800) Harvester-csi-driver k8s 1.27 chart support
* [#41799](https://github.com/rancher/rancher/issues/41799) Harvester harvester-cloud-provider k8s 1.27 chart support
* [#41798](https://github.com/rancher/rancher/issues/41798) gke-operator k8s 1.27 chart support
* [#41797](https://github.com/rancher/rancher/issues/41797) eks-operator k8s 1.27 chart support
* [#41796](https://github.com/rancher/rancher/issues/41796) aks-operator k8s 1.27 chart support
* [#41795](https://github.com/rancher/rancher/issues/41795) Fleet supports k8s 1.27 & 1.28
* [#41794](https://github.com/rancher/rancher/issues/41794) k8s 1.27 support for the rancher-logging chart
* [#41793](https://github.com/rancher/rancher/issues/41793) k8s 1.27 support for rancher-vsphere-csi chart
* [#41792](https://github.com/rancher/rancher/issues/41792) k8s 1.27  support for rancher-vsphere-cpi chart
* [#41791](https://github.com/rancher/rancher/issues/41791) k8s 1.27 support for system-upgrade-controller chart
* [#41790](https://github.com/rancher/rancher/issues/41790) rancher -csp-adapter k8s 1.27 chart support
* [#41789](https://github.com/rancher/rancher/issues/41789) rancher- rancher-webhook k8s 1.27 chart support
* [#41788](https://github.com/rancher/rancher/issues/41788) rancher-monitoring k8s 1.27 chart support
* [#41787](https://github.com/rancher/rancher/issues/41787) rancher-cis-benchmark k8s 1.27 chart support (Infracloud)
* [#41786](https://github.com/rancher/rancher/issues/41786) rancher-backup k8s 1.27 chart support
* [#41785](https://github.com/rancher/rancher/issues/41785) rancher-alerting-drivers k8s 1.27 chart support (Infracloud)
* [#41784](https://github.com/rancher/rancher/issues/41784) prometheus-federator k8s 1.27 chart support
* [#41783](https://github.com/rancher/rancher/issues/41783) ui-plugin-operator k8s 1.27 chart support
* [#41782](https://github.com/rancher/rancher/issues/41782) rancher-istio k8s 1.27 chart support
* [#41781](https://github.com/rancher/rancher/issues/41781) rancher-gatekeeper k8s 1.27 chart support
* [#41746](https://github.com/rancher/rancher/issues/41746) [BUG] Rancher will spam helm-operation pods until it dies when a deployment fails
* [#41735](https://github.com/rancher/rancher/issues/41735) [Feature Request] Rancher logs spammed with info logs for hosted downstream clusters
* [#41720](https://github.com/rancher/rancher/issues/41720) [Feature] k8s 1.27 support - apps and feature charts
* [#41651](https://github.com/rancher/rancher/issues/41651) Update Rancher CLI to use new dashboard login url instead of legacy ember URL
* [#41645](https://github.com/rancher/rancher/issues/41645) [SURE-6228] [RFE] Tool for scheduled/conditional profiles
* [#41561](https://github.com/rancher/rancher/issues/41561) Remove deprecated setting rancher-webhook-min-version
* [#41521](https://github.com/rancher/rancher/issues/41521) [BUG] After adding service-account-issuer for conformance test cluster-agent goes into crashloopBrackoff
* [#41253](https://github.com/rancher/rancher/issues/41253) Cannot enable freeIPA through API
* [#41131](https://github.com/rancher/rancher/issues/41131) Permission issues on RKE, RKE2 and K3s Clusters When Running CIS 1.24 Scans
* [#40857](https://github.com/rancher/rancher/issues/40857) [BUG] Rancher cli kubectl token login fails randomly when kubeconfig-generate-token=false
* [#40608](https://github.com/rancher/rancher/issues/40608) Changing vSphere Credentials causes old nodes to fail on deletion
* [#40253](https://github.com/rancher/rancher/issues/40253) Error related to services/proxy when viewing metrics in Rancher UI
* [#40602](https://github.com/rancher/rancher/issues/40602) Disk Sync Duration graph set to milliseconds (not the expected seconds) in the y-axis
* [#39532](https://github.com/rancher/rancher/issues/39532) Installed Apps don't update after upgrade from v2.6.3 to v2.6.8 when Rancher chart uses --set useBundledSystemChart=true
* [#38820](https://github.com/rancher/rancher/issues/38820) [BUG][Monitoring v2]Prometheus target serviceMonitor/kube-system/rancher-monitoring-coredns is down in k3s hardened cluster - connect refused
* [#38711](https://github.com/rancher/rancher/issues/38711) ETCDSnapshot CRs not cleaned up/not following `etcd-snapshot-retention` value
* [#38535](https://github.com/rancher/rancher/issues/38535) Remove Deprecated setting kubeconfig-token-ttl-minutes
* [#37808](https://github.com/rancher/rancher/issues/37808) [v2.5] vsphere node driver clusters not respecting cpu count, all nodes have 1 cpu each regardless of user input
* [#36132](https://github.com/rancher/rancher/issues/36132) Cannot assign non-RKE1 Clusters to a Fleet Workspace
* [#32784](https://github.com/rancher/rancher/issues/32784) rke2 cluster provisioning - Access to configure audit logging from the API is missing
-----
