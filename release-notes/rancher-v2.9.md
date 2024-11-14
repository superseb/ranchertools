| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.9.3](rancher-v2.9.md#release-v293) | Oct 24 2024 | 10/24/24 | 2024-10-24 |
| [v2.9.2](rancher-v2.9.md#release-v292) | Sep 19 2024 | 09/19/24 | 2024-09-19 |
| [v2.9.1](rancher-v2.9.md#release-v291) | Aug 26 2024 | 08/26/24 | 2024-08-26 |
| [v2.9.0](rancher-v2.9.md#release-v290) | Jul 31 2024 | 07/31/24 | 2024-07-31 |



# Release v2.9.3

> **Important:** Review the Install/Upgrade Notes before upgrading to any Rancher version.

Rancher v2.9.3 is the latest minor release of Rancher. This is a Community and Prime version release that introduces new features, enhancements, and various updates. To learn more about Rancher Prime, see our page on the [Rancher Prime Platform](https://www.rancher.com/products/rancher-platform).

## Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Several enhancements have been made to the cluster and node driver registration process to prevent the possibility of remote code execution (RCE) through untrusted third-party cluster and node drivers. For more information, see [CVE-2024-22036](https://github.com/rancher/rancher/security/advisories/GHSA-h99m-6755-rgwc).
- Improvements have been made to binaries and configuration files that are known to be executed by administrative accounts to prevent the possibility of privilege escalation. The binaries and configuration files now have stricter ACLs so that only Administrators can amend the files. For more information, see [CVE-2023-32197](https://github.com/rancher/rancher/security/advisories/GHSA-7h8m-pvw3-5gh4).
- To avoid credentials being stored in plain-text within the vSphere add-on config when creating a vSphere Rancher HA setup, the `provisioningprebootstrap` feature was added. For more information, see [CVE-2022-45157](https://github.com/rancher/rancher/security/advisories/GHSA-xj7w-r753-vj8v).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/v2.9/reference-guides/rancher-security/security-advisories-and-cves) or in Rancher's [GitHub](https://github.com/rancher/rancher/security/advisories) repo.

## Rancher UI

### Features and Enhancements

<!-- Add Summary -->
- The performance of the Clusters list on the **Home** page and the Side Menu has greatly improved when there are hundreds of clusters. See [#11999](https://github.com/rancher/dashboard/issues/11999) and [#12009](https://github.com/rancher/dashboard/issues/12009).

## Harvester

### Features and Enhancements

- On the Cloud Credential list, you can now easily see if a Harvester Credential is about to expire or has expired and choose to renew it. You will also be notified on the Cluster Management Clusters list when an associated Harvester Cloud Credential is about to expire or has expired. When upgrading, an existing expired Harvester Credential will not contain a warning. You can still renew the token on the resources menu. See [#11270](https://github.com/rancher/dashboard/issues/11270).

## Role-Based Access Control (RBAC) Framework

### Major Bug Fixes

- Fixed issue where multiple, stale secrets may be erroneously created for users on downstream clusters. See [#46894](https://github.com/rancher/rancher/issues/46894).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

**Important:** With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or k3s.

RKE2 and K3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about re-platforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Images

- rancher/rancher:v2.9.3

## Tools

- CLI - [v2.9.0](https://github.com/rancher/cli/releases/tag/v2.9.0)
- RKE - [v1.6.3](https://github.com/rancher/rke/releases/tag/v1.6.3)

## Kubernetes Versions for RKE

- v1.30.5 (Default)
- v1.29.9
- v1.28.14
- v1.27.16

## Kubernetes Versions for RKE2/K3s

- v1.30.5 (Default)
- v1.29.9
- v1.28.14
- v1.27.16

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Rancher now supports the ability to use an OCI Helm chart registry for Apps & Marketplace. View documentation on [using OCI based Helm chart repositories](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/helm-charts-in-rancher/oci-repositories) and note this feature is in an experimental stage. See [#29105](https://github.com/rancher/rancher/issues/29105) and [#45062](https://github.com/rancher/rancher/pull/45062)

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

## Previous Rancher Behavior Changes - Rancher General

- **Rancher v2.9.0:**
  - Kubernetes v1.25 and v1.26 are no longer supported. Before you upgrade to Rancher v2.9.0, make sure that all clusters are running Kubernetes v1.27 or later. See [#45882](https://github.com/rancher/rancher/issues/45882).
  - The `external-rules` [feature flag](https://ranchermanager.docs.rancher.com/v2.9/getting-started/installation-and-upgrade/installation-references/feature-flags) functionality is removed in Rancher v2.9.0 as the behavior is enabled by default. The feature flag is [still present](https://github.com/rancher/rancher/issues/46272) when upgrading from v2.8.5; however, enabling or disabling the feature won't have any effect. For more information, see [CVE-2023-32196](https://github.com/rancher/rancher/security/advisories/GHSA-64jq-m7rq-768h) and [#45863](https://github.com/rancher/rancher/issues/45863).
  - Rancher now validates the Container Default Resource Limit on Projects. Validation mimics the upstream behavior of the Kubernetes API server when it validates LimitRanges. The container default resource configuration must have properly formatted quantities for all requests and limits. Limits for any resource must not be less than requests. See [#39700](https://github.com/rancher/rancher/issues/39700).
- **Rancher v2.8.4:**
  - The controller now cleans up instances of `ClusterUserAttribute` that have no corresponding `UserAttribute`. See [#44985](https://github.com/rancher/rancher/issues/44985).
- **Rancher v2.8.3:**
  - When Rancher starts, it now identifies all deprecated and unrecognized setting resources and adds a `cattle.io/unknown` label. You can list these settings with the command `kubectl get settings -l 'cattle.io/unknown==true'`. In Rancher v2.9 and later, these settings will be removed instead. See [#43992](https://github.com/rancher/rancher/issues/43992).
- **Rancher v2.8.0:**
  - Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
  - Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher v2.8.4:**
  - Docker CLI 20.x is at end-of-life and no longer supported in Rancher. Please update your local Docker CLI versions to 23.0.x or later. Earlier versions may not recognize OCI compliant Rancher image manifests. See [#45424](https://github.com/rancher/rancher/issues/45424).
- **Rancher v2.8.0:**
  - Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.
- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - RKE Provisioning

- **Rancher v2.9.0:**
  - With the release of Rancher Kubernetes Engine (RKE) v1.6.0, RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

    Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or K3s.

    RKE2 and K3s provide stronger security, and move away from the upstream-deprecated Docker machine. Learn more about re-platforming at the official [SUSE blog](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).
  - Rancher has added support for external Azure cloud providers in downstream RKE clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44857](https://github.com/rancher/rancher/issues/44857).
  - Weave CNI support for RKE clusters is removed in response to Weave CNI not being supported by upstream Kubernetes v1.30 and later. See [#45954](https://github.com/rancher/rancher/issues/45954)
- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

## Previous Rancher Behavior Changes - RKE2 Provisioning

- **Rancher v2.9.2:**
  - Fixed an issue where downstream RKE2 clusters may become corrupted if KDM data (from `rke-metadata-config` setting) is invalid. Note that per the fix these clusters' status may change to "Updating" with a message indicating KDM data is missing instead of the cluster status stating "Active". See [#46855](https://github.com/rancher/rancher/issues/46855).
- **Rancher v2.9.0:**
  - Rancher has added support for external Azure cloud providers in downstream RKE2 clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44856](https://github.com/rancher/rancher/issues/44856).
  - Added a new annotation, `provisioning.cattle.io/allow-dynamic-schema-drop`. When set to `true`, it drops the `dynamicSchemaSpec` field from machine pool definitions. This prevents cluster nodes from re-provisioning unintentionally when the cluster object is updated from an external source such as Terraform or Fleet. See [#44618](https://github.com/rancher/rancher/issues/44618).
- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094).
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062).

## Previous Rancher Behavior Changes - Rancher App (Global UI)

- **Rancher v2.8.0:**
  - The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->
  - Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
  - The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Continuous Delivery

- **Rancher v2.9.0:**
  - Rancher now supports **monitoring of continuous delivery**.  Starting with version `v104.0.1` of the Fleet (`v0.10.1` of Fleet) and `rancher-monitoring` chart, continuous delivery provides metrics about the state of its resources and the `rancher-monitoring` chart contains dashboards to visualize those metrics. Installing the `rancher-monitoring` chart to the local/upstream cluster automatically configures Prometheus to scrape metrics from the continuous delivery controllers and installs Grafana dashboards. These dashboards are accessible via Grafana but are not yet integrated into the Rancher UI. You can open Grafana from the Rancher UI by navigating to the *Cluster > Monitoring > Grafana* view. See [rancher/fleet#1408](https://github.com/rancher/fleet/issues/1408) for implementation details.
  - Continuous delivery in Rancher also introduces  **sharding with node selectors**. See [rancher/fleet#1740](https://github.com/rancher/fleet/issues/1740) for implementation details and the [Fleet documentation](https://fleet.rancher.io/installation#multi-controller-install-sharding) for instructions on how to use it.
  - We have **reduced image size and complexity** by integrating the former external gitjob repository and by merging various controller codes. This also means that the gitjob container image (`rancher/gitjob`) is not needed anymore, as the required functionality is embedded into the `rancher/fleet` container image. The gitjob deployment will still be created but pointing to the `rancher/fleet` container image instead. Please also note that a complete [list of necessary container images](https://github.com/rancher/rancher/releases/download/v2.9.0/rancher-images.txt) for air-gapped deployments is released alongside Rancher releases. You can find this list as `rancher-images.txt` in the assets of the [release on Github](https://github.com/rancher/rancher/releases/v2.9.0/). See [rancher/fleet#2342](https://github.com/rancher/fleet/issues/2342) for more details.
  - Continuous delivery also adds **experimental OCI content storage**. See [rancher/fleet#2561](https://github.com/rancher/fleet/pull/2561) for implementation details and [rancher/fleet-docs#179](https://github.com/rancher/fleet-docs/pull/179/files) for documentation.
  - Continuous delivery now splits components into containers and has switched to the controller-runtime framework. The rewritten controllers switch to **structured logging**.
  - Leader election can now be configured (see [rancher/fleet#1981](https://github.com/rancher/fleet/pull/1981)), as well as the worker count for the fleet-controller (see [rancher/fleet#2430](https://github.com/rancher/fleet/pull/2430)).
  - The release deprecates the "fleet test" command in favor of "target" and "deploy" with a dry-run option (see [rancher/fleet#2102](https://github.com/rancher/fleet/pull/2102/files)).
  - Bug fixes enhance drift detection, cluster status reporting, and various operational aspects.

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.8.3:**
  - Rancher uses additional trusted CAs when establishing a secure connection to the keycloak OIDC authentication provider. See [#43217](https://github.com/rancher/rancher/issues/43217).
- **Rancher v2.8.0:**
  - The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
  - [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).
- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.8.3:**
  - The embedded Cluster API webhook is removed from the Rancher webhook and can no longer be installed from the webhook chart. It has not been used as of Rancher v2.7.7, where it was migrated to a separate Pod. See [#44619](https://github.com/rancher/rancher/issues/44619).
- **Rancher v2.8.0:**
  - Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade.
- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.8.0:**
  - Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

    - `rancher-cis-benchmark`
    - `rancher-gatekeeper-operator`
    - `rancher-istio`
    - `rancher-logging`
    - `rancher-monitoring`

    The code for these charts will remain available for previous versions of Rancher.
  - Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.
- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Previous Rancher Behavior Changes - OPA Gatekeeper

- **Rancher v2.8.0:**
  - OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/comparisons/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

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

## Previous Rancher Behavior Changes - Security

- **Rancher v2.9.0:**
  - When `agent-tls-mode` is set to `strict`, users must provide the certificate authority to Rancher or downstream clusters will disconnect from Rancher, and require manual intervention to fix. This applies to several setup types, including:
    - Let's Encrypt - When set to `strict`, users must upload the Let's Encrypt Certificate Authority and provide `privateCA=true` when installing the chart.
    - Bring Your Own Cert - When set to `strict`, users must upload the Certificate Authority used to generate the cert and provide `privateCA=true` when installing the chart.
    - Proxy/External - when the setting is `strict`, users must upload the Certificate Authority used by the proxy and provide `privateCA=true` when installing the chart.

    See [#45628](https://github.com/rancher/rancher/issues/45628) and [#45655](https://github.com/rancher/rancher/pull/45655).
- **Rancher v2.8.0:**
  - TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Previous Rancher Behavior Changes - Extensions

- **Rancher v2.9.0:**
  - A new [feature flag `uiextensions`](https://ranchermanager.docs.rancher.com/v2.9/integrations-in-rancher/rancher-extensions#enabling-extension-support-in-rancher) has been added for enabling and disabling the UI extension feature (this replaces the need to install the `ui-plugin-operator`). The first time it's set to `true` (the default value is `true`) it will create the CRD and enable the controllers and endpoints necessary for the feature to work. If set to `false`, it won't create the CRD if it doesn't already exist, but it won't delete it if it does. It will also disable the controllers and endpoints used by the feature. Enabling or disabling the feature flag will cause Rancher to restart. See [#44230](https://github.com/rancher/rancher/pull/44230) and [#43089](https://github.com/rancher/rancher/issues/43089).
  - UI extension owners must update and publish a new version of their extensions to be compatible with Rancher v2.9.0 and later. For more information see the [Rancher v2.9 extension support page](https://extensions.rancher.io/extensions/rancher-2.9-support).
- **Rancher v2.8.4:**
  - The Rancher dashboard fails to load an extension that utilizes backported Vue 3 features, displaying an error in the console `object(...) is not a function`. New extensions that utilize the `defineComponent` will not be backwards compatible with older versions of the dashboard. Existing extensions should continue to work moving forward. See [#10568](https://github.com/rancher/dashboard/issues/10568).  

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.8.1:**
  - When you  attempt to register a new etcd/controlplane node in a CAPR-managed cluster after a failed etcd snapshot restoration, the node can become stuck in a perpetual paused state, displaying the error message `[ERROR]  000 received while downloading Rancher connection information. Sleeping for 5 seconds and trying again`. As a workaround, you can unpause the cluster by running `kubectl edit clusters.cluster clustername -n fleet-default` and set `spec.unpaused` to `false`.  See [#43735](https://github.com/rancher/rancher/issues/43735).
- **Rancher v2.7.2:**
  - If you upgrade or update any hosted cluster, and go to **Cluster Management > Clusters** while the cluster is still provisioning, the **Registration** tab is visible. Registering a cluster that is already registered with Rancher can cause data corruption. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
- **Rancher v2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## Long-standing Known Issues - RKE Provisioning

- **Rancher v2.9.0:**
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated, due to the plugin being deprecated for upstream Kubernetes v1.27 and later. RKE creation will not go through as it will raise a validation warning. See [#11322](https://github.com/rancher/dashboard/issues/11322).

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.9.0:**
  - Currently there are known issues with the [data directory feature](https://github.com/rancher/rancher/issues/45038) which are outlined below:
    - K3s does not support the data directory feature. See [#10589](https://github.com/k3s-io/k3s/issues/10589).
    - Currently selecting `Use the same path for System-agent, Provisioning and K8s Distro data directories configuration` results in Rancher using the same data directory for system agent, provisioning, and distribution components as opposed to appending the specified component names to the root directory. To mitigate this issue, you will need to configure the 3 paths separately and they must follow the guidelines below:
          - Absolute paths (start with /)
          - Clean (not contain env vars, shell expressions, ., or ..)
          - Not set to the same thing
          - Not nested one within another
      See [#11566](https://github.com/rancher/dashboard/issues/11566).
  - When adding the `provisioning.cattle.io/allow-dynamic-schema-drop` annotation through the cluster config UI, the annotation disappears before adding the value field. When viewing the YAML, the respective value field is not updated and is displayed as an empty string. As a workaround, when creating the cluster, set the annotation by using the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11435](https://github.com/rancher/dashboard/issues/11435).
- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.4:**
  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).
- **Rancher v2.7.2:**
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
- **Rancher v2.6.9:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->
- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->
- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
- **Rancher v2.6.0:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - Rancher App (Global UI)

- **Rancher v2.9.2**:
  - Although system mode node pools must have at least one node, the Rancher UI allows a minimum node count of zero. Inputting a zero minimum node count through the UI can cause cluster creation to fail due to an invalid parameter error. To prevent this error from occurring, enter a minimum node count at least equal to the node count. See [#11922](https://github.com/rancher/dashboard/issues/11922).
  - Node drivers that rely on machine configs that contain fields of the type `array string` render a form requesting a single string instead. See [#11936](https://github.com/rancher/dashboard/issues/11936).
  - Some node drivers incorrectly stipulate that no credentials are required, resulting in the UI skipping the requirement to supply credentials when provisioning a cluster of that type. See [#11974](https://github.com/rancher/dashboard/issues/11974).
- **Rancher v2.7.7**:
  - When creating a cluster in the Rancher UI it does not allow the use of an underscore `_` in the `Cluster Name` field. See [#9416](https://github.com/rancher/dashboard/issues/9416).
- **Rancher v2.7.2**:
  - When creating a GKE cluster in the Rancher UI you will see provisioning failures as the `clusterIpv4CidrBlock` and `clusterSecondaryRangeName` fields conflict. See [#8749](https://github.com/rancher/dashboard/issues/8749).

## Long-standing Known Issues - Rancher CLI

- **Rancher v2.9.0:**
  - The Rancher CLI currently lists the Azure authentication provider options out of order. See [#46128](https://github.com/rancher/rancher/issues/46128).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.6.4:**
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798) and [#40257](https://github.com/rancher/rancher/issues/40257).
- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://github.com/rancher/dashboard/issues/4658#issuecomment-733035658) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
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

## Long-standing Known Issues - Role-Based Access Control (RBAC) Framework <!-- neo -->

- **Rancher v2.9.1**
  - Temporarily reducing privileges by impersonating an account with lower privileges is currently not supported. See [#41988](https://github.com/rancher/rancher/issues/41988) and [#46790](https://github.com/rancher/rancher/issues/46790).

## Long-standing Known Issues - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.6.4:**
  - The deployment's `securityContext` section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy (PSP) support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).<!-- https://github.com/rancher/dashboard/issues/4815#issuecomment-1074184973 -->

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.9.0:**
  - There are some known issues with the OpenID Connect provider support:
    - When the generic OIDC auth provider is enabled, and you attempt to add auth provider users to a cluster or project, users are not populated in the dropdown search bar. This is expected behavior as the OIDC auth provider alone is not searchable. See [#46104](https://github.com/rancher/rancher/issues/46104).
    - When the generic OIDC auth provider is enabled, auth provider users that are added to a cluster/project by their username are not able to access resources upon logging in. A user will only have access to resources upon login if the user is added by their userID.  See [#46105](https://github.com/rancher/rancher/issues/46105).
    - When the generic OIDC auth provider is enabled and an auth provider user in a nested group is logged into Rancher, the user will see the following error when they attempt to create a Project: `[projectroletemplatebindings.management.cattle.io](http://projectroletemplatebindings.management.cattle.io/) is forbidden: User "u-gcxatwsnku" cannot create resource "projectroletemplatebindings" in API group "[management.cattle.io](http://management.cattle.io/)" in the namespace "p-9t5pg"`. However, the project is still created. See [#46106](https://github.com/rancher/rancher/issues/46106).
- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
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

- **Rancher v2.9.0:**
  - In the Rancher UI when navigating between Harvester clusters of different versions a refresh may be required to view version specific functionality. See [#11559](https://github.com/rancher/dashboard/issues/11559).
- **Rancher v2.8.4:**
  - When provisioning a Harvester RKE1 cluster in Rancher, the **vGPU** field is not displayed under **Cluster Management > Advanced Settings**, this is not a supported feature. However, the **vGPU** field is available when provisioning a Harvester RKE2 cluster. See [#10909](https://github.com/rancher/dashboard/issues/10909).
  - When provisioning a multi-node Harvester RKE2 cluster in Rancher, you need to allocate one vGPU more than the number of nodes you have or provisioning will fail. See [#11009](https://github.com/rancher/dashboard/issues/11009) and v2.9.0 back-port issue [#10989](https://github.com/rancher/dashboard/issues/10989).
- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - Upgrades from Harvester v0.3.0 are not supported.<!-- no issue number -->

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.8.3:**
  - Some CIS checks related to file permissions fail on RKE and RKE2 clusters with CIS v1.7 and CIS v1.8 profiles. See [#42971](https://github.com/rancher/rancher/issues/42971).
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

- **Rancher v2.8.0:**
  - Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

    1. If you haven't already, install Monitoring on the project.
    1. Move the `cattle-monitoring-system` namespace into the project.
    1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

    See [#4466](https://github.com/rancher/dashboard/issues/4466).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## All issues in v2.9.3 milestone

* [#47608](https://github.com/rancher/rancher/issues/47608) [Backport v2.9] [BUG] Migrating `rancher.io/expiration-timestamp` causes crashloop if credential uses expired token
* [#47508](https://github.com/rancher/rancher/issues/47508) [Backport v2.9][RFE] Bump Harvester node driver to v0.7.0
* [#47492](https://github.com/rancher/rancher/issues/47492) [BUG] [V2.9] Harvester Cloud Credential Expiry not Updated
* [#47469](https://github.com/rancher/rancher/issues/47469) [Backport v2.9] Enhance the secret-synchronization controller from Rancher's management cluster -> downstream clusters 
* [#47395](https://github.com/rancher/rancher/issues/47395) [Backport v2.9] [BUG] Downstream K3s registry rewrites break fallback to upstream registry
* [#47384](https://github.com/rancher/rancher/issues/47384) [v2.9] Update ACI-CNI to 6.1.1.1
* [#47357](https://github.com/rancher/rancher/issues/47357) [Backport v2.9] Improve lasso caches metrics
* [#47338](https://github.com/rancher/rancher/issues/47338) [backport dev-v2.9] rancher/mirrored-fluent-fluent-bit:2.2.0
* [#47332](https://github.com/rancher/rancher/issues/47332) [v2.9] Remove published versions of old/unused `rancher-sachet`
* [#47317](https://github.com/rancher/rancher/issues/47317) [Backport v2.9] [BUG] high memory usage for the aks.(*aksOperatorController).onClusterChange
* [#47294](https://github.com/rancher/rancher/issues/47294) [v2.9] update security-scan version in rancher-cis-benchmark chart
* [#47243](https://github.com/rancher/rancher/issues/47243) [Backport v2.9] [RFE] Cloud Credentials Expiry field support
* [#47201](https://github.com/rancher/rancher/issues/47201) [Backport v2.9] Reduce `webhook`'s dependency on RKE1 type changes
* [#47174](https://github.com/rancher/rancher/issues/47174) [2.9] Add support for docker 27.2.x
* [#47168](https://github.com/rancher/rancher/issues/47168) [v2.9] KDM Update for K8s Sept 2024 patch release
* [#47001](https://github.com/rancher/rancher/issues/47001) [v2.9] Backport Audit Log Image bumps
* [#46714](https://github.com/rancher/rancher/issues/46714) Add support for SUSE Liberty 8 to Rancher
* [#42823](https://github.com/rancher/rancher/issues/42823) CRTB: apiVersion and kind are mandatory in PUT but NOT on POST
-----
# Release v2.9.2

> **Important:** Review the Install/Upgrade Notes before upgrading to any Rancher version.

Rancher v2.9.2 is the latest minor release of Rancher. This is a Community and Prime version release that introduces new features, enhancements, and various updates. To learn more about Rancher Prime, see our page on the [Rancher Prime Platform](https://www.rancher.com/products/rancher-platform).

## RKE2 Provisioning

### Major Bug Fixes

- Fixed an issue where, when upgrading from Rancher v2.7.4 or earlier to a more recent Rancher version with provisioned RKE2/K3s clusters in an unhealthy state, you may have encountered the error message, `implausible joined server for entry`. This required manually marking the nodes in the cluster with a joined server. A [workaround](https://github.com/rancherlabs/support-tools/tree/master/windows-agent-strict-verify) was available. See [#42856](https://github.com/rancher/rancher/issues/42856).
- Fixed an issue where downstream RKE2 clusters may become corrupted if KDM data (from `rke-metadata-config` setting) is invalid. Note that per the fix these clusters' status may change to "Updating" with a message indicating KDM data is missing instead of the cluster status stating "Active". See [#46855](https://github.com/rancher/rancher/issues/46855).

## Windows Cluster Provisioning Fixes <!-- hostbusters -->

### Major Bug Fixes

- The following fix only applies to newly provisioned Windows nodes, and existing Windows nodes running the August 2024 patch releases of RKE2 (v1.30.4, v1.29.8, v1.28.13, and v1.27.16): The `STRICT_VERIFY` environment variable is now successfully passed to Windows nodes. There is a [workaround](https://github.com/rancherlabs/support-tools/tree/master/windows-agent-strict-verify) for existing nodes that do not have the August patches. See [#46396](https://github.com/rancher/rancher/issues/46396).

## Rancher App (Global UI)

### Known Issues

- Although system mode node pools must have at least one node, the Rancher UI allows a minimum node count of zero. Inputting a zero minimum node count through the UI can cause cluster creation to fail due to an invalid parameter error. To prevent this error from occuring, enter a minimum node count at least equal to the node count. See [#11922](https://github.com/rancher/dashboard/issues/11922).
- Node drivers that rely on machine configs that contain fields of the type `array string` render a form requesting a single string instead. See [#11936](https://github.com/rancher/dashboard/issues/11936).
- Some node drivers incorrectly stipulate that no credentials are required, resulting in the UI skipping the requirement to supply credentials when provisioning a cluster of that type. See [#11974](https://github.com/rancher/dashboard/issues/11974).
## Role-Based Access Control (RBAC) Framework

### Known Issues

- Multiple, stale secrets may be erroneously created for users on downstream clusters. The stale secrets don't get reconciled even if the referenced secret is deleted in the user account. This can cause problems with memory usage and UI slowdown. See [#46894](https://github.com/rancher/rancher/issues/46894).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

**Important:** With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or k3s.

RKE2 and K3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about re-platforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Images

- rancher/rancher:v2.9.2

## Tools

- CLI - [v2.9.0](https://github.com/rancher/cli/releases/tag/v2.9.0)
- RKE - [v1.6.2](https://github.com/rancher/rke/releases/tag/v1.6.2)

## Kubernetes Versions for RKE

- v1.30.4 (Default)
- v1.29.8
- v1.28.13
- v1.27.16

## Kubernetes Versions for RKE2/K3s

- v1.30.4 (Default)
- v1.29.7
- v1.28.13
- v1.27.16

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Rancher now supports the ability to use an OCI Helm chart registry for Apps & Marketplace. View documentation on [using OCI based Helm chart repositories](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/helm-charts-in-rancher/oci-repositories) and note this feature is in an experimental stage. See [#29105](https://github.com/rancher/rancher/issues/29105) and [#45062](https://github.com/rancher/rancher/pull/45062)

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

## Previous Rancher Behavior Changes - Rancher General

- **Rancher v2.9.0:**
  - Kubernetes v1.25 and v1.26 are no longer supported. Before you upgrade to Rancher v2.9.0, make sure that all clusters are running Kubernetes v1.27 or later. See [#45882](https://github.com/rancher/rancher/issues/45882).
  - The `external-rules` [feature flag](https://ranchermanager.docs.rancher.com/v2.9/getting-started/installation-and-upgrade/installation-references/feature-flags) functionality is removed in Rancher v2.9.0 as the behavior is enabled by default. The feature flag is [still present](https://github.com/rancher/rancher/issues/46272) when upgrading from v2.8.5; however, enabling or disabling the feature won't have any effect. For more information, see [CVE-2023-32196](https://github.com/rancher/rancher/security/advisories/GHSA-64jq-m7rq-768h) and [#45863](https://github.com/rancher/rancher/issues/45863).
  - Rancher now validates the Container Default Resource Limit on Projects. Validation mimics the upstream behavior of the Kubernetes API server when it validates LimitRanges. The container default resource configuration must have properly formatted quantities for all requests and limits. Limits for any resource must not be less than requests. See [#39700](https://github.com/rancher/rancher/issues/39700).
- **Rancher v2.8.4:**
  - The controller now cleans up instances of `ClusterUserAttribute` that have no corresponding `UserAttribute`. See [#44985](https://github.com/rancher/rancher/issues/44985).
- **Rancher v2.8.3:**
  - When Rancher starts, it now identifies all deprecated and unrecognized setting resources and adds a `cattle.io/unknown` label. You can list these settings with the command `kubectl get settings -l 'cattle.io/unknown==true'`. In Rancher v2.9 and later, these settings will be removed instead. See [#43992](https://github.com/rancher/rancher/issues/43992).
- **Rancher v2.8.0:**
  - Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
  - Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher v2.8.4:**
  - Docker CLI 20.x is at end-of-life and no longer supported in Rancher. Please update your local Docker CLI versions to 23.0.x or later. Earlier versions may not recognize OCI compliant Rancher image manifests. See [#45424](https://github.com/rancher/rancher/issues/45424).
- **Rancher v2.8.0:**
  - Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.
- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - RKE Provisioning

- **Rancher v2.9.0:**
  - With the release of Rancher Kubernetes Engine (RKE) v1.6.0, RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

    Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or K3s.

    RKE2 and K3s provide stronger security, and move away from the upstream-deprecated Docker machine. Learn more about re-platforming at the official [SUSE blog](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).
  - Rancher has added support for external Azure cloud providers in downstream RKE clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44857](https://github.com/rancher/rancher/issues/44857).
  - Weave CNI support for RKE clusters is removed in response to Weave CNI not being supported by upstream Kubernetes v1.30 and later. See [#45954](https://github.com/rancher/rancher/issues/45954)
- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

## Previous Rancher Behavior Changes - RKE2 Provisioning

- **Rancher v2.9.0:**
  - Rancher has added support for external Azure cloud providers in downstream RKE2 clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44856](https://github.com/rancher/rancher/issues/44856).
  - Added a new annotation, `provisioning.cattle.io/allow-dynamic-schema-drop`. When set to `true`, it drops the `dynamicSchemaSpec` field from machine pool definitions. This prevents cluster nodes from re-provisioning unintentionally when the cluster object is updated from an external source such as Terraform or Fleet. See [#44618](https://github.com/rancher/rancher/issues/44618).
- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094).
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062).

## Previous Rancher Behavior Changes - Rancher App (Global UI)

- **Rancher v2.8.0:**
  - The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->
  - Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
  - The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Continuous Delivery

- **Rancher v2.9.0:**
  - Rancher now supports **monitoring of continuous delivery**.  Starting with version `v104.0.1` of the Fleet (`v0.10.1` of Fleet) and `rancher-monitoring` chart, continuous delivery provides metrics about the state of its resources and the `rancher-monitoring` chart contains dashboards to visualize those metrics. Installing the `rancher-monitoring` chart to the local/upstream cluster automatically configures Prometheus to scrape metrics from the continuous delivery controllers and installs Grafana dashboards. These dashboards are accessible via Grafana but are not yet integrated into the Rancher UI. You can open Grafana from the Rancher UI by navigating to the *Cluster > Monitoring > Grafana* view. See [rancher/fleet#1408](https://github.com/rancher/fleet/issues/1408) for implementation details.
  - Continuous delivery in Rancher also introduces  **sharding with node selectors**. See [rancher/fleet#1740](https://github.com/rancher/fleet/issues/1740) for implementation details and the [Fleet documentation](https://fleet.rancher.io/installation#multi-controller-install-sharding) for instructions on how to use it.
  - We have **reduced image size and complexity** by integrating the former external gitjob repository and by merging various controller codes. This also means that the gitjob container image (`rancher/gitjob`) is not needed anymore, as the required functionality is embedded into the `rancher/fleet` container image. The gitjob deployment will still be created but pointing to the `rancher/fleet` container image instead. Please also note that a complete [list of necessary container images](https://github.com/rancher/rancher/releases/download/v2.9.0/rancher-images.txt) for air-gapped deployments is released alongside Rancher releases. You can find this list as `rancher-images.txt` in the assets of the [release on Github](https://github.com/rancher/rancher/releases/v2.9.0/). See [rancher/fleet#2342](https://github.com/rancher/fleet/issues/2342) for more details.
  - Continuous delivery also adds **experimental OCI content storage**. See [rancher/fleet#2561](https://github.com/rancher/fleet/pull/2561) for implementation details and [rancher/fleet-docs#179](https://github.com/rancher/fleet-docs/pull/179/files) for documentation.
  - Continuous delivery now splits components into containers and has switched to the controller-runtime framework. The rewritten controllers switch to **structured logging**.
  - Leader election can now be configured (see [rancher/fleet#1981](https://github.com/rancher/fleet/pull/1981)), as well as the worker count for the fleet-controller (see [rancher/fleet#2430](https://github.com/rancher/fleet/pull/2430)).
  - The release deprecates the "fleet test" command in favor of "target" and "deploy" with a dry-run option (see [rancher/fleet#2102](https://github.com/rancher/fleet/pull/2102/files)).
  - Bug fixes enhance drift detection, cluster status reporting, and various operational aspects.

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.8.3:**
  - Rancher uses additional trusted CAs when establishing a secure connection to the keycloak OIDC authentication provider. See [#43217](https://github.com/rancher/rancher/issues/43217).
- **Rancher v2.8.0:**
  - The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
  - [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).
- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.8.3:**
  - The embedded Cluster API webhook is removed from the Rancher webhook and can no longer be installed from the webhook chart. It has not been used as of Rancher v2.7.7, where it was migrated to a separate Pod. See [#44619](https://github.com/rancher/rancher/issues/44619).
- **Rancher v2.8.0:**
  - Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade.
- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.8.0:**
  - Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

    - `rancher-cis-benchmark`
    - `rancher-gatekeeper-operator`
    - `rancher-istio`
    - `rancher-logging`
    - `rancher-monitoring`

    The code for these charts will remain available for previous versions of Rancher.
  - Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.
- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Previous Rancher Behavior Changes - OPA Gatekeeper

- **Rancher v2.8.0:**
  - OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/comparisons/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

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

## Previous Rancher Behavior Changes - Security

- **Rancher v2.9.0:**
  - When `agent-tls-mode` is set to `strict`, users must provide the certificate authority to Rancher or downstream clusters will disconnect from Rancher, and require manual intervention to fix. This applies to several setup types, including:
    - Let's Encrypt - When set to `strict`, users must upload the Let's Encrypt Certificate Authority and provide `privateCA=true` when installing the chart.
    - Bring Your Own Cert - When set to `strict`, users must upload the Certificate Authority used to generate the cert and provide `privateCA=true` when installing the chart.
    - Proxy/External - when the setting is `strict`, users must upload the Certificate Authority used by the proxy and provide `privateCA=true` when installing the chart.

    See [#45628](https://github.com/rancher/rancher/issues/45628) and [#45655](https://github.com/rancher/rancher/pull/45655).
- **Rancher v2.8.0:**
  - TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Previous Rancher Behavior Changes - Extensions

- **Rancher v2.9.0:**
  - A new [feature flag `uiextensions`](https://ranchermanager.docs.rancher.com/v2.9/integrations-in-rancher/rancher-extensions#enabling-extension-support-in-rancher) has been added for enabling and disabling the UI extension feature (this replaces the need to install the `ui-plugin-operator`). The first time it's set to `true` (the default value is `true`) it will create the CRD and enable the controllers and endpoints necessary for the feature to work. If set to `false`, it won't create the CRD if it doesn't already exist, but it won't delete it if it does. It will also disable the controllers and endpoints used by the feature. Enabling or disabling the feature flag will cause Rancher to restart. See [#44230](https://github.com/rancher/rancher/pull/44230) and [#43089](https://github.com/rancher/rancher/issues/43089). 
  - UI extension owners must update and publish a new version of their extensions to be compatible with Rancher v2.9.0 and later. For more information see the [Rancher v2.9 extension support page](https://extensions.rancher.io/extensions/rancher-2.9-support).
- **Rancher v2.8.4:**
  - The Rancher dashboard fails to load an extension that utilizes backported Vue 3 features, displaying an error in the console `object(...) is not a function`. New extensions that utilize the `defineComponent` will not be backwards compatible with older versions of the dashboard. Existing extensions should continue to work moving forward. See [#10568](https://github.com/rancher/dashboard/issues/10568).  

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.8.1:**
  - When you  attempt to register a new etcd/controlplane node in a CAPR-managed cluster after a failed etcd snapshot restoration, the node can become stuck in a perpetual paused state, displaying the error message `[ERROR]  000 received while downloading Rancher connection information. Sleeping for 5 seconds and trying again`. As a workaround, you can unpause the cluster by running `kubectl edit clusters.cluster clustername -n fleet-default` and set `spec.unpaused` to `false`.  See [#43735](https://github.com/rancher/rancher/issues/43735).
- **Rancher v2.7.2:**
  - If you upgrade or update any hosted cluster, and go to **Cluster Management > Clusters** while the cluster is still provisioning, the **Registration** tab is visible. Registering a cluster that is already registered with Rancher can cause data corruption. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
- **Rancher v2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## Long-standing Known Issues - RKE Provisioning

- **Rancher v2.9.0:**
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated, due to the plugin being deprecated for upstream Kubernetes v1.27 and later. RKE creation will not go through as it will raise a validation warning. See [#11322](https://github.com/rancher/dashboard/issues/11322).

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.9.0:**
  - Currently there are known issues with the [data directory feature](https://github.com/rancher/rancher/issues/45038) which are outlined below:
    - K3s does not support the data directory feature. See [#10589](https://github.com/k3s-io/k3s/issues/10589).
    - Currently selecting `Use the same path for System-agent, Provisioning and K8s Distro data directories configuration` results in Rancher using the same data directory for system agent, provisioning, and distribution components as opposed to appending the specified component names to the root directory. To mitigate this issue, you will need to configure the 3 paths separately and they must follow the guidelines below:
          - Absolute paths (start with /)
          - Clean (not contain env vars, shell expressions, ., or ..)
          - Not set to the same thing
          - Not nested one within another
      See [#11566](https://github.com/rancher/dashboard/issues/11566).
  - When adding the `provisioning.cattle.io/allow-dynamic-schema-drop` annotation through the cluster config UI, the annotation disappears before adding the value field. When viewing the YAML, the respective value field is not updated and is displayed as an empty string. As a workaround, when creating the cluster, set the annotation by using the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11435](https://github.com/rancher/dashboard/issues/11435).
- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.4:**
  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).
- **Rancher v2.7.2:**
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
- **Rancher v2.6.9:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->
- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->
- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
- **Rancher v2.6.0:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - Rancher App (Global UI)

- **Rancher v2.7.7**:
  - When creating a cluster in the Rancher UI it does not allow the use of an underscore `_` in the `Cluster Name` field. See [#9416](https://github.com/rancher/dashboard/issues/9416).
- **Rancher v2.7.2**:
  - When creating a GKE cluster in the Rancher UI you will see provisioning failures as the `clusterIpv4CidrBlock` and `clusterSecondaryRangeName` fields conflict. See [#8749](https://github.com/rancher/dashboard/issues/8749).

## Long-standing Known Issues - Rancher CLI

- **Rancher v2.9.0:**
  - The Rancher CLI currently lists the Azure authentication provider options out of order. See [#46128](https://github.com/rancher/rancher/issues/46128).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.6.4:**
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798) and [#40257](https://github.com/rancher/rancher/issues/40257).
- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://github.com/rancher/dashboard/issues/4658#issuecomment-733035658) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
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

## Long-standing Known Issues - Role-Based Access Control (RBAC) Framework <!-- neo -->

- **Rancher v2.9.1**
  - Temporarily reducing privileges by impersonating an account with lower privileges is currently not supported. See [#41988](https://github.com/rancher/rancher/issues/41988) and [#46790](https://github.com/rancher/rancher/issues/46790).

## Long-standing Known Issues - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.6.4:**
  - The deployment's `securityContext` section is missing when a new workload is created. This prevents pods from starting when Pod Security Policy (PSP) support is enabled. See [#4815](https://github.com/rancher/dashboard/issues/4815).<!-- https://github.com/rancher/dashboard/issues/4815#issuecomment-1074184973 -->

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.9.0:**
  - There are some known issues with the OpenID Connect provider support:
    - When the generic OIDC auth provider is enabled, and you attempt to add auth provider users to a cluster or project, users are not populated in the dropdown search bar. This is expected behavior as the OIDC auth provider alone is not searchable. See [#46104](https://github.com/rancher/rancher/issues/46104).
    - When the generic OIDC auth provider is enabled, auth provider users that are added to a cluster/project by their username are not able to access resources upon logging in. A user will only have access to resources upon login if the user is added by their userID.  See [#46105](https://github.com/rancher/rancher/issues/46105).
    - When the generic OIDC auth provider is enabled and an auth provider user in a nested group is logged into Rancher, the user will see the following error when they attempt to create a Project: `[projectroletemplatebindings.management.cattle.io](http://projectroletemplatebindings.management.cattle.io/) is forbidden: User "u-gcxatwsnku" cannot create resource "projectroletemplatebindings" in API group "[management.cattle.io](http://management.cattle.io/)" in the namespace "p-9t5pg"`. However, the project is still created. See [#46106](https://github.com/rancher/rancher/issues/46106).
- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
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

- **Rancher v2.9.0:**
  - In the Rancher UI when navigating between Harvester clusters of different versions a refresh may be required to view version specific functionality. See [#11559](https://github.com/rancher/dashboard/issues/11559).
- **Rancher v2.8.4:**
  - When provisioning a Harvester RKE1 cluster in Rancher, the **vGPU** field is not displayed under **Cluster Management > Advanced Settings**, this is not a supported feature. However, the **vGPU** field is available when provisioning a Harvester RKE2 cluster. See [#10909](https://github.com/rancher/dashboard/issues/10909).
  - When provisioning a multi-node Harvester RKE2 cluster in Rancher, you need to allocate one vGPU more than the number of nodes you have or provisioning will fail. See [#11009](https://github.com/rancher/dashboard/issues/11009) and v2.9.0 back-port issue [#10989](https://github.com/rancher/dashboard/issues/10989).
- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - Upgrades from Harvester v0.3.0 are not supported.<!-- no issue number -->

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.8.3:**
  - Some CIS checks related to file permissions fail on RKE and RKE2 clusters with CIS v1.7 and CIS v1.8 profiles. See [#42971](https://github.com/rancher/rancher/issues/42971).
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

- **Rancher v2.8.0:**
  - Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

    1. If you haven't already, install Monitoring on the project.
    1. Move the `cattle-monitoring-system` namespace into the project.
    1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

    See [#4466](https://github.com/rancher/dashboard/issues/4466).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## All issues in v2.9.2 milestone

* [#47139](https://github.com/rancher/rancher/issues/47139) [BUG] RKE1 local cluster networking is unstable after creation.
* [#47039](https://github.com/rancher/rancher/issues/47039) [BUG] `C:\etc\rancher\wins\config` shows duplicate entries in a downstream vSphere Windows RKE2 cluster
* [#47024](https://github.com/rancher/rancher/issues/47024) [v2.9] High CPU load due to calico errors on Ubuntu 20.04 - Update to calico needed
* [#46962](https://github.com/rancher/rancher/issues/46962) [BUG]: 2.9 : Rancher Logs filled with errors related to auth-user-info-resync-cron for every 2mins
* [#46959](https://github.com/rancher/rancher/issues/46959) [v2.9] [BUG] SAML provider search always returns users
* [#46894](https://github.com/rancher/rancher/issues/46894) [2.9] Stale secrets for impersonation user in downstream cluster
* [#46871](https://github.com/rancher/rancher/issues/46871) [Backport 2.9] use fixed stream server bind address for cri-dockerd
* [#46869](https://github.com/rancher/rancher/issues/46869) [2.9] Rancher CLI panics when we try to switch context without any selection
* [#46855](https://github.com/rancher/rancher/issues/46855) [BUG] Managed RKE2 clusters are broken after upgrade to 2.9.1 when KDM is not updated to `release-v2.9`
* [#46809](https://github.com/rancher/rancher/issues/46809) [v2.9] Update ACI-CNI to 6.0.4.3
* [#46778](https://github.com/rancher/rancher/issues/46778) [BUG] EKS public + private enabled clusters fail to come up active in Rancher `v2.9`
* [#46775](https://github.com/rancher/rancher/issues/46775) [Backport release/v2.9] [BUG] `CATTLE_AGENT_FALLBACK_PATH` environment variable is way too prominent for custom clusters and can lead to confusion
* [#46751](https://github.com/rancher/rancher/issues/46751) RKE2 and K3S - KDM Update for K8s August 2024 patch release for Rancher 2.9
* [#46715](https://github.com/rancher/rancher/issues/46715) [v2.9] KDM Update for K8s Aug 2024 patch release
* [#46677](https://github.com/rancher/rancher/issues/46677) Generate and Publish sha256sum.txt in RKE Releases 
* [#46661](https://github.com/rancher/rancher/issues/46661) [2.9] Update `ingress-nginx` to the latest applicable version
* [#46621](https://github.com/rancher/rancher/issues/46621) [Backport v2.9] Transition `rancher/system-agent` to `bci-micro`
* [#46616](https://github.com/rancher/rancher/issues/46616) [v2.9] Bump rke-tools for rke1 k8s august 2024 patches 
* [#46582](https://github.com/rancher/rancher/issues/46582) [BUG] RKE1 agents provisionning fails when AWS IMDSv2 is set to required
* [#46528](https://github.com/rancher/rancher/issues/46528) Automate updating go version in rancher/machine
* [#46472](https://github.com/rancher/rancher/issues/46472) [2.9] Add debug to KDM args for k3s and rke2
* [#46469](https://github.com/rancher/rancher/issues/46469) [Backport] Machine Configs orphaned on failed cluster create
* [#46467](https://github.com/rancher/rancher/issues/46467) [Backport] Windows rke2 custom cluster - nodes stop displaying metrics in Monitoring after upgrading kubernetes version
* [#46455](https://github.com/rancher/rancher/issues/46455) [Backport 2.9] Add support for Docker 27.0.x and 27.1.x
* [#46452](https://github.com/rancher/rancher/issues/46452) [Backport] Validation of custom data directories for RKE2/K3s provisioning 
* [#46451](https://github.com/rancher/rancher/issues/46451) [Backport][Windows] STRICT_VERIFY environment variable is not passed to windows nodes
* [#46386](https://github.com/rancher/rancher/issues/46386) [RFE] Add Unit Tests to auth package
* [#46063](https://github.com/rancher/rancher/issues/46063) [BUG] Users: User Retention Settings: 'Last Login' column in the User table is not populated with value set in 'Default last login' 
* [#46034](https://github.com/rancher/rancher/issues/46034) [BUG] v2prov certificate rotation does not follow correct order of operations
* [#45577](https://github.com/rancher/rancher/issues/45577) [flaky-test] Certificate Rotation
* [#43502](https://github.com/rancher/rancher/issues/43502) [Documentation] Grafana dashboards created in wrong namespace
* [#42856](https://github.com/rancher/rancher/issues/42856) [BUG] [CAPR] Upgrading Rancher during etcd restoration from < v2.7.5 to v2.7.5+ can lead to `implausible joined server for entry` 
* [#42788](https://github.com/rancher/rancher/issues/42788) Create crtb with steve api(v1) is throwing 404 instead of 422 when user miss a field
* [#42040](https://github.com/rancher/rancher/issues/42040) Pin the hosted-provider charts to a specific version
* [#41605](https://github.com/rancher/rancher/issues/41605) Error "failed to wait for roles to be populated" when deploying Apps to user-created Namespaces
-----
# Release v2.9.1

> **Important:** Review the Install/Upgrade Notes before upgrading to any Rancher version.

Rancher v2.9.1 is the latest minor release of Rancher. This is a Community and Prime version release that introduces new features, enhancements, and various updates.

## Highlights

## Cluster Provisioning

### Features and Enhancements

- The vSphere Cloud Storage Interface (CSI) now supports Kubernetes v1.30. See [#45747](https://github.com/rancher/rancher/issues/45747).
- The vSphere Cloud Provider Interface (CPI) now supports Kubernetes v1.30. See [#45746](https://github.com/rancher/rancher/issues/45746).
- SLE Micro 6 is now supported for RKE2/K3s provisioned clusters. See [#45571](https://github.com/rancher/rancher/issues/45571).

## RKE2 Provisioning

### Major Bug Fixes

- Fixed an issue where vSphere CSI chart deployments would fail on RKE2 with Kubernetes v1.30. See [#46132](https://github.com/rancher/rancher/issues/46132).
- Fixed issues related to the [data directory feature](https://github.com/rancher/rancher/issues/45038) where:
  - Provisioning an RKE2 cluster with the data directory enabled would cause snapshot restores to fail. See [#46066](https://github.com/rancher/rancher/issues/46066).
  - The `system-agent-upgrader` SUC plan is not applied correctly after cluster provisioning leading to the specified `system-agent` data directory not being used. See [#46361](https://github.com/rancher/rancher/issues/46361).
  - Provisioning a custom RKE2 cluster with the data directory enabled would result in the registration command not including the user-specified data directory. See [#46362](https://github.com/rancher/rancher/issues/46362).

## Rancher App (Global UI)

### Major Bug Fixes

- Fixed an issue where the Rancher UI would display Azure as a possible in-tree cloud provider option for RKE1 and RKE2 clusters running Kubernetes v1.30, even though the Azure in-tree cloud provider has been removed for Kubernetes v1.30 and later. See [#11363](https://github.com/rancher/dashboard/issues/11363).

## Role-Based Access Control (RBAC) Framework

### Known Issues

- Temporarily reducing privileges by impersonating an account with lower privileges is currently not supported. See [#41988](https://github.com/rancher/rancher/issues/41988) and [#46790](https://github.com/rancher/rancher/issues/46790).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

**Important:** With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or k3s.

RKE2 and k3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about re-platforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Images

- rancher/rancher:v2.9.0

## Tools

- CLI - [v2.9.0](https://github.com/rancher/cli/releases/tag/v2.9.0)
- RKE - [v1.6.1](https://github.com/rancher/rke/releases/tag/v1.6.1)

## Kubernetes Versions for RKE
- v1.30.3 (Default)
- v1.29.7
- v1.28.12
- v1.27.16

## Kubernetes Versions for RKE2/K3s
- v1.30.3 (Default)
- v1.29.7
- v1.28.12
- v1.27.16

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Rancher now supports the ability to use an OCI Helm chart registry for Apps & Marketplace. View documentation on [using OCI based Helm chart repositories](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/helm-charts-in-rancher/oci-repositories) and note this feature is in an experimental stage. See [#29105](https://github.com/rancher/rancher/issues/29105) and [#45062](https://github.com/rancher/rancher/pull/45062)

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

## Previous Rancher Behavior Changes - Rancher General

- **Rancher v2.9.0:**
  - Kubernetes v1.25 and v1.26 are no longer supported. Before you upgrade to Rancher v2.9.0, make sure that all clusters are running Kubernetes v1.27 or later. See [#45882](https://github.com/rancher/rancher/issues/45882).
  - The `external-rules` [feature flag](https://ranchermanager.docs.rancher.com/v2.9/getting-started/installation-and-upgrade/installation-references/feature-flags) functionality is removed in Rancher v2.9.0 as the behavior is enabled by default. The feature flag is [still present](https://github.com/rancher/rancher/issues/46272) when upgrading from v2.8.5; however, enabling or disabling the feature won't have any effect. For more information, see [CVE-2023-32196](https://github.com/rancher/rancher/security/advisories/GHSA-64jq-m7rq-768h) and [#45863](https://github.com/rancher/rancher/issues/45863).
  - Rancher now validates the Container Default Resource Limit on Projects. Validation mimics the upstream behavior of the Kubernetes API server when it validates LimitRanges. The container default resource configuration must have properly formatted quantities for all requests and limits. Limits for any resource must not be less than requests. See [#39700](https://github.com/rancher/rancher/issues/39700).
- **Rancher v2.8.4:**
  - The controller now cleans up instances of `ClusterUserAttribute` that have no corresponding `UserAttribute`. See [#44985](https://github.com/rancher/rancher/issues/44985).
- **Rancher v2.8.3:**
  - When Rancher starts, it now identifies all deprecated and unrecognized setting resources and adds a `cattle.io/unknown` label. You can list these settings with the command `kubectl get settings -l 'cattle.io/unknown==true'`. In Rancher v2.9 and later, these settings will be removed instead. See [#43992](https://github.com/rancher/rancher/issues/43992).
- **Rancher v2.8.0:**
  - Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
  - Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher v2.8.4:**
  - Docker CLI 20.x is at end-of-life and no longer supported in Rancher. Please update your local Docker CLI versions to 23.0.x or later. Earlier versions may not recognize OCI compliant Rancher image manifests. See [#45424](https://github.com/rancher/rancher/issues/45424).
- **Rancher v2.8.0:**
  - Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.
- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - RKE Provisioning

- **Rancher v2.9.0:**
  - With the release of Rancher Kubernetes Engine (RKE) v1.6.0, RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

    Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or K3s.

    RKE2 and K3s provide stronger security, and move away from the upstream-deprecated Docker machine. Learn more about re-platforming at the official [SUSE blog](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).
  - Rancher has added support for external Azure cloud providers in downstream RKE clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44857](https://github.com/rancher/rancher/issues/44857).
  - Weave CNI support for RKE clusters is removed in response to Weave CNI not being supported by upstream Kubernetes v1.30 and later. See [#45954](https://github.com/rancher/rancher/issues/45954)
- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

## Previous Rancher Behavior Changes - RKE2 Provisioning

- **Rancher v2.9.0:**
  - Rancher has added support for external Azure cloud providers in downstream RKE2 clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44856](https://github.com/rancher/rancher/issues/44856).
  - Added a new annotation, `provisioning.cattle.io/allow-dynamic-schema-drop`. When set to `true`, it drops the `dynamicSchemaSpec` field from machine pool definitions. This prevents cluster nodes from re-provisioning unintentionally when the cluster object is updated from an external source such as Terraform or Fleet. See [#44618](https://github.com/rancher/rancher/issues/44618).
- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).
  - Similar to Rancher v2.7.9, when you upgrade to Rancher v2.8.0 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094).
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062).

## Previous Rancher Behavior Changes - Rancher App (Global UI)

- **Rancher v2.8.0:**
  - The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->
  - Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
  - The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Continuous Delivery

- **Rancher v2.9.0:**
  - Rancher now supports **monitoring of continuous delivery**.  Starting with version `v104.0.1` of the Fleet (`v0.10.1` of Fleet) and `rancher-monitoring` chart, continuous delivery provides metrics about the state of its resources and the `rancher-monitoring` chart contains dashboards to visualize those metrics. Installing the `rancher-monitoring` chart to the local/upstream cluster automatically configures Prometheus to scrape metrics from the continuous delivery controllers and installs Grafana dashboards. These dashboards are accessible via Grafana but are not yet integrated into the Rancher UI. You can open Grafana from the Rancher UI by navigating to the *Cluster > Monitoring > Grafana* view. See [rancher/fleet#1408](https://github.com/rancher/fleet/issues/1408) for implementation details.
  - Continuous delivery in Rancher also introduces  **sharding with node selectors**. See [rancher/fleet#1740](https://github.com/rancher/fleet/issues/1740) for implementation details and the [Fleet documentation](https://fleet.rancher.io/installation#multi-controller-install-sharding) for instructions on how to use it.
  - We have **reduced image size and complexity** by integrating the former external gitjob repository and by merging various controller codes. This also means that the gitjob container image (`rancher/gitjob`) is not needed anymore, as the required functionality is embedded into the `rancher/fleet` container image. The gitjob deployment will still be created but pointing to the `rancher/fleet` container image instead. Please also note that a complete [list of necessary container images](https://github.com/rancher/rancher/releases/download/v2.9.0/rancher-images.txt) for air-gapped deployments is released alongside Rancher releases. You can find this list as `rancher-images.txt` in the assets of the [release on Github](https://github.com/rancher/rancher/releases/v2.9.0/). See [rancher/fleet#2342](https://github.com/rancher/fleet/issues/2342) for more details.
  - Continuous delivery also adds **experimental OCI content storage**. See [rancher/fleet#2561](https://github.com/rancher/fleet/pull/2561) for implementation details and [rancher/fleet-docs#179](https://github.com/rancher/fleet-docs/pull/179/files) for documentation.
  - Continuous delivery now splits components into containers and has switched to the controller-runtime framework. The rewritten controllers switch to **structured logging**.
  - Leader election can now be configured (see [rancher/fleet#1981](https://github.com/rancher/fleet/pull/1981)), as well as the worker count for the fleet-controller (see [rancher/fleet#2430](https://github.com/rancher/fleet/pull/2430)).
  - The release deprecates the "fleet test" command in favor of "target" and "deploy" with a dry-run option (see [rancher/fleet#2102](https://github.com/rancher/fleet/pull/2102/files)).
  - Bug fixes enhance drift detection, cluster status reporting, and various operational aspects.

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.8.3:**
  - Rancher uses additional trusted CAs when establishing a secure connection to the keycloak OIDC authentication provider. See [#43217](https://github.com/rancher/rancher/issues/43217).
- **Rancher v2.8.0:**
  - The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
  - [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).
- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.8.3:**
  - The embedded Cluster API webhook is removed from the Rancher webhook and can no longer be installed from the webhook chart. It has not been used as of Rancher v2.7.7, where it was migrated to a separate Pod. See [#44619](https://github.com/rancher/rancher/issues/44619).
- **Rancher v2.8.0:**
  - Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade.
- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.8.0:**
  - Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

    - `rancher-cis-benchmark`
    - `rancher-gatekeeper-operator`
    - `rancher-istio`
    - `rancher-logging`
    - `rancher-monitoring`

    The code for these charts will remain available for previous versions of Rancher.
  - Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.
- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Previous Rancher Behavior Changes - OPA Gatekeeper

- **Rancher v2.8.0:**
  - OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/comparisons/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

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

## Previous Rancher Behavior Changes - Security

- **Rancher v2.9.0:**
  - When `agent-tls-mode` is set to `strict`, users must provide the certificate authority to Rancher or downstream clusters will disconnect from Rancher, and require manual intervention to fix. This applies to several setup types, including:
    - Let's Encrypt - When set to `strict`, users must upload the Let's Encrypt Certificate Authority and provide `privateCA=true` when installing the chart.
    - Bring Your Own Cert - When set to `strict`, users must upload the Certificate Authority used to generate the cert and provide `privateCA=true` when installing the chart.
    - Proxy/External - when the setting is `strict`, users must upload the Certificate Authority used by the proxy and provide `privateCA=true` when installing the chart.

    See [#45628](https://github.com/rancher/rancher/issues/45628) and [#45655](https://github.com/rancher/rancher/pull/45655).
- **Rancher v2.8.0:**
  - TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Previous Rancher Behavior Changes - Extensions

- **Rancher v2.9.0:**
  - A new [feature flag `uiextensions`](https://ranchermanager.docs.rancher.com/v2.9/integrations-in-rancher/rancher-extensions#enabling-extension-support-in-rancher) has been added for enabling and disabling the UI extension feature (this replaces the need to install the `ui-plugin-operator`). The first time it's set to `true` (the default value is `true`) it will create the CRD and enable the controllers and endpoints necessary for the feature to work. If set to `false`, it won't create the CRD if it doesn't already exist, but it won't delete it if it does. It will also disable the controllers and endpoints used by the feature. Enabling or disabling the feature flag will cause Rancher to restart. See [#44230](https://github.com/rancher/rancher/pull/44230) and [#43089](https://github.com/rancher/rancher/issues/43089). 
  - UI extension owners must update and publish a new version of their extensions to be compatible with Rancher v2.9.0 and later. For more information see the [Rancher v2.9 extension support page](https://extensions.rancher.io/extensions/rancher-2.9-support).
- **Rancher v2.8.4:**
  - The Rancher dashboard fails to load an extension that utilizes backported Vue 3 features, displaying an error in the console `object(...) is not a function`. New extensions that utilize the `defineComponent` will not be backwards compatible with older versions of the dashboard. Existing extensions should continue to work moving forward. See [#10568](https://github.com/rancher/dashboard/issues/10568).  

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.8.1:**
  - When you  attempt to register a new etcd/controlplane node in a CAPR-managed cluster after a failed etcd snapshot restoration, the node can become stuck in a perpetual paused state, displaying the error message `[ERROR]  000 received while downloading Rancher connection information. Sleeping for 5 seconds and trying again`. As a workaround, you can unpause the cluster by running `kubectl edit clusters.cluster clustername -n fleet-default` and set `spec.unpaused` to `false`.  See [#43735](https://github.com/rancher/rancher/issues/43735).
- **Rancher v2.7.2:**
  - If you upgrade or update any hosted cluster, and go to **Cluster Management > Clusters** while the cluster is still provisioning, the **Registration** tab is visible. Registering a cluster that is already registered with Rancher can cause data corruption. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
- **Rancher v2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## Long-standing Known Issues - RKE Provisioning

- **Rancher v2.9.0:**
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated, due to the plugin being deprecated for upstream Kubernetes v1.27 and later. RKE creation will not go through as it will raise a validation warning. See [#11322](https://github.com/rancher/dashboard/issues/11322).

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.9.0:**
  - Currently there are known issues with the [data directory feature](https://github.com/rancher/rancher/issues/45038) which are outlined below:
    - K3s does not support the data directory feature. See [#10589](https://github.com/k3s-io/k3s/issues/10589).
    - Currently selecting `Use the same path for System-agent, Provisioning and K8s Distro data directories configuration` results in Rancher using the same data directory for system agent, provisioning, and distribution components as opposed to appending the specified component names to the root directory. To mitigate this issue, you will need to configure the 3 paths separately and they must follow the guidelines below:
          - Absolute paths (start with /)
          - Clean (not contain env vars, shell expressions, ., or ..)
          - Not set to the same thing
          - Not nested one within another
      See [#11566](https://github.com/rancher/dashboard/issues/11566).
  - When adding the `provisioning.cattle.io/allow-dynamic-schema-drop` annotation through the cluster config UI, the annotation disappears before adding the value field. When viewing the YAML, the respective value field is not updated and is displayed as an empty string. As a workaround, when creating the cluster, set the annotation by using the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11435](https://github.com/rancher/dashboard/issues/11435).
- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.4:**
  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).
- **Rancher v2.7.2:**
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
- **Rancher v2.6.9:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->
- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->
- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
- **Rancher v2.6.0:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - Rancher App (Global UI)

- **Rancher v2.7.7**:
  - When creating a cluster in the Rancher UI it does not allow the use of an underscore `_` in the `Cluster Name` field. See [#9416](https://github.com/rancher/dashboard/issues/9416).
- **Rancher v2.7.2**:
  - When creating a GKE cluster in the Rancher UI you will see provisioning failures as the `clusterIpv4CidrBlock` and `clusterSecondaryRangeName` fields conflict. See [#8749](https://github.com/rancher/dashboard/issues/8749).

## Long-standing Known Issues - Rancher CLI

- **Rancher v2.9.0:**
  - The Rancher CLI currently lists the Azure authentication provider options out of order. See [#46128](https://github.com/rancher/rancher/issues/46128).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.6.4:**
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798) and [#40257](https://github.com/rancher/rancher/issues/40257).
- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://github.com/rancher/dashboard/issues/4658#issuecomment-733035658) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
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

- **Rancher v2.9.0:**
  - There are some known issues with the OpenID Connect provider support:
    - When the generic OIDC auth provider is enabled, and you attempt to add auth provider users to a cluster or project, users are not populated in the dropdown search bar. This is expected behavior as the OIDC auth provider alone is not searchable. See [#46104](https://github.com/rancher/rancher/issues/46104).
    - When the generic OIDC auth provider is enabled, auth provider users that are added to a cluster/project by their username are not able to access resources upon logging in. A user will only have access to resources upon login if the user is added by their userID.  See [#46105](https://github.com/rancher/rancher/issues/46105).
    - When the generic OIDC auth provider is enabled and an auth provider user in a nested group is logged into Rancher, the user will see the following error when they attempt to create a Project: `[projectroletemplatebindings.management.cattle.io](http://projectroletemplatebindings.management.cattle.io/) is forbidden: User "u-gcxatwsnku" cannot create resource "projectroletemplatebindings" in API group "[management.cattle.io](http://management.cattle.io/)" in the namespace "p-9t5pg"`. However, the project is still created. See [#46106](https://github.com/rancher/rancher/issues/46106).
- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
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

- **Rancher v2.9.0:**
  - In the Rancher UI when navigating between Harvester clusters of different versions a refresh may be required to view version specific functionality. See [#11559](https://github.com/rancher/dashboard/issues/11559).
- **Rancher v2.8.4:**
  - When provisioning a Harvester RKE1 cluster in Rancher, the **vGPU** field is not displayed under **Cluster Management > Advanced Settings**, this is not a supported feature. However, the **vGPU** field is available when provisioning a Harvester RKE2 cluster. See [#10909](https://github.com/rancher/dashboard/issues/10909).
  - When provisioning a multi-node Harvester RKE2 cluster in Rancher, you need to allocate one vGPU more than the number of nodes you have or provisioning will fail. See [#11009](https://github.com/rancher/dashboard/issues/11009) and v2.9.0 back-port issue [#10989](https://github.com/rancher/dashboard/issues/10989).
- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
  - Upgrades from Harvester v0.3.0 are not supported.<!-- no issue number -->

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.9.0:**
  - The git-sync job that clones the repository does not have access to the CA bundle as a necessary secret is not created from the GitRepo resource data. Cloning from git repositories that require custom certificates will fail. See [#2824](https://github.com/rancher/fleet/issues/2824).
- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.8.3:**
  - Some CIS checks related to file permissions fail on RKE and RKE2 clusters with CIS v1.7 and CIS v1.8 profiles. See [#42971](https://github.com/rancher/rancher/issues/42971).
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

- **Rancher v2.8.0:**
  - Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

    1. If you haven't already, install Monitoring on the project.
    1. Move the `cattle-monitoring-system` namespace into the project.
    1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

    See [#4466](https://github.com/rancher/dashboard/issues/4466).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## All issues in v2.9.1 milestone

* [#46790](https://github.com/rancher/rancher/issues/46790) [docs] document that impersonation, specially around using a lower privileged account in order to drops privileges doesn't work.
* [#46772](https://github.com/rancher/rancher/issues/46772) [BUG] Tenant Rancher - Cluster Member, and Restricted Admin Cannot List Downstream Cluster 
* [#46681](https://github.com/rancher/rancher/issues/46681) [BUG] Update KDM branch on `v2.9-head` to point to `dev-v2.9`
* [#46639](https://github.com/rancher/rancher/issues/46639) [BUG] [v2.9] cattle-cluster-agent missing linux image resulting in incomplete provisioning of hosted downstream clusters
* [#46602](https://github.com/rancher/rancher/issues/46602) [v2.9] `pnap` (PhoenixNAP) node driver update to version 0.5.1
* [#46569](https://github.com/rancher/rancher/issues/46569) [v2.9] [BUG] Fips errors on Rancher 2.9
* [#46549](https://github.com/rancher/rancher/issues/46549) Bug in install script
* [#46547](https://github.com/rancher/rancher/issues/46547) [BUG] Defaults are not validated for user retention settings
* [#46527](https://github.com/rancher/rancher/issues/46527) Update Kubectl to the latest version in system agent
* [#46526](https://github.com/rancher/rancher/issues/46526) Update go to the latest version in system agent 
* [#46516](https://github.com/rancher/rancher/issues/46516) [Backport 2.9] Update go to the latest version in `rancher/machine`
* [#46425](https://github.com/rancher/rancher/issues/46425) RKE2 and K3S - KDM Update for K8s July 2024 patch release for Rancher 2.9
* [#46382](https://github.com/rancher/rancher/issues/46382) Update `docker-machine-driver-linode` to v0.1.12
* [#46362](https://github.com/rancher/rancher/issues/46362) [BUG] Custom cluster registration command not including system agent data directory
* [#46361](https://github.com/rancher/rancher/issues/46361) [BUG] System-agent-upgrader plan removes system-agent data directory
* [#46334](https://github.com/rancher/rancher/issues/46334) Update kube-api-auth dependencies
* [#46272](https://github.com/rancher/rancher/issues/46272) [BUG] ExternalRules feature flag is not removed upon upgrading
* [#46241](https://github.com/rancher/rancher/issues/46241) Old Ubuntu 20.04 AMIs are used by default when provisioning downstream clusters in AWS
* [#46236](https://github.com/rancher/rancher/issues/46236) [BUG] MachineHealthCheck Object not deleted properly
* [#46223](https://github.com/rancher/rancher/issues/46223) Configure `renovatebot` for `rancher/rke-tools`
* [#46219](https://github.com/rancher/rancher/issues/46219) [v2.9] [Maintenance] Bump embedded system-agent within rancher-wins
* [#46213](https://github.com/rancher/rancher/issues/46213) [2.9.0][BUG][Steve] Steve server will panic if the cluster hosted NonStructuralSchema crds
* [#46189](https://github.com/rancher/rancher/issues/46189) [BUG] Webhook must only accept "true" for setting annotation cattle.io/force
* [#46167](https://github.com/rancher/rancher/issues/46167) [BUG] Error log seen when logging in as azure AD Page Iterator received incorrect value of type *models.DirectoryRole in rancher logs
* [#46161](https://github.com/rancher/rancher/issues/46161) [2.9] Panic setting password to Azure AD (Entra ID) user
* [#46147](https://github.com/rancher/rancher/issues/46147) Improve the logging for k3s based upgrader in Rancher
* [#46146](https://github.com/rancher/rancher/issues/46146) Remove old versions from `vsphere-charts`
* [#46132](https://github.com/rancher/rancher/issues/46132) [BUG] Downstream RKE2 Vsphere Cloud Provider clusters pull incorrect versioning for CSI pod images, which result in `imagepullbackoff` error
* [#46090](https://github.com/rancher/rancher/issues/46090) air gap RKE2 downstream cluster fails to pull images if the registry mirrors endpoint does not contain a schema
* [#46066](https://github.com/rancher/rancher/issues/46066) [BUG] Provisioning an RKE2 cluster with the data/dir feature enabled causes snapshot restores to fail
* [#46035](https://github.com/rancher/rancher/issues/46035) Time to rebase logging operator on 4.8.x
* [#45917](https://github.com/rancher/rancher/issues/45917) Run `Operations_Test_SetB_*` tests for `rancher/kontainer-driver-metadata` tests
* [#45841](https://github.com/rancher/rancher/issues/45841) [BUG] upgrade docker install from 2.8.3 -> 2.8.4 fails
* [#45815](https://github.com/rancher/rancher/issues/45815) Snapshots fail during creation in Sle Micro 6
* [#45747](https://github.com/rancher/rancher/issues/45747) k8s 1.30 support for vSphere CSI 
* [#45746](https://github.com/rancher/rancher/issues/45746) k8s 1.30 support for vSphere CPI
* [#45722](https://github.com/rancher/rancher/issues/45722) rancher-logging using deprecated fluentbit field in logging crd
* [#45571](https://github.com/rancher/rancher/issues/45571) Validate SLE Micro 6 on Rancher
* [#44780](https://github.com/rancher/rancher/issues/44780) [Forwardport v2.9] [BUG] Installing rancher on GKE with gce ingress class return "response 404 (backend NotFound)"
* [#44214](https://github.com/rancher/rancher/issues/44214) AWS region support ca-west-1 [RFE] 
* [#44212](https://github.com/rancher/rancher/issues/44212) [BUG] vsphere 8 using rke2/k3s - if vsphere DRS maxVcpusPerCore limit is reached on host, rancher does not clean up vsphere VMs
* [#44033](https://github.com/rancher/rancher/issues/44033) [BUG] RKE2 provisioned registry secret not being backed up by Backup/Restore operator
* [#43293](https://github.com/rancher/rancher/issues/43293) [BUG] first kubectl command fails when no service account has been created
* [#42611](https://github.com/rancher/rancher/issues/42611) [BUG]  failed to create mutating configuration
* [#41929](https://github.com/rancher/rancher/issues/41929) [RFE] Simple Permissions endpoint for UI
* [#41606](https://github.com/rancher/rancher/issues/41606) [BUG] rke2 clusters with invalid values for tolerations / affinity agent customization do not show error to user, stay in `updating` state on cluster create
* [#43421](https://github.com/rancher/rancher/issues/43421) [RFE] [rancher-logging] Prefix systemDefaultRegistry to all images
* [#40068](https://github.com/rancher/rancher/issues/40068) [BUG] Cattle-cleanup job for imported clusters not pulling from configured private registry
-----
# Release v2.9.0

> **Important:** Review the Install/Upgrade Notes before upgrading to any Rancher version.

Rancher v2.9.0 is the latest minor release of Rancher. This is a Community version release that introduces new features, enhancements, and various updates.

## Highlights

## Rancher General

### Features and Enhancements

- Rancher now supports Kubernetes v1.29 and v1.30. See  [#43110](https://github.com/rancher/rancher/issues/43110) for information on Rancher support for Kubernetes v1.29, and see [#45089](https://github.com/rancher/rancher/issues/45089) for information on Rancher support for  Kubernetes v1.30. Additionally, the upstream Kubernetes changelogs for [v1.29](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md) and [v1.30](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md) can be viewed for a full list of changes.

### Behavior Changes

- Kubernetes v1.25 and v1.26 are no longer supported. Before you upgrade to Rancher v2.9.0, make sure that all clusters are running Kubernetes v1.27 or later. See [#45882](https://github.com/rancher/rancher/issues/45882).
- The `external-rules` [feature flag](https://ranchermanager.docs.rancher.com/v2.9/getting-started/installation-and-upgrade/installation-references/feature-flags) functionality is removed in Rancher v2.9.0 as the behavior is enabled by default. The feature flag is [still present](https://github.com/rancher/rancher/issues/46272) when upgrading from v2.8.5; however, enabling or disabling the feature won't have any effect. For more information, see [CVE-2023-32196](https://github.com/rancher/rancher/security/advisories/GHSA-64jq-m7rq-768h) and [#45863](https://github.com/rancher/rancher/issues/45863).
- Rancher now validates Container Default Resource Limit on Projects. Validation mimics the upstream behavior of the Kubernetes API server when it validates LimitRanges. The container default resource configuration must have properly formatted quantities for all requests and limits. Limits for any resource must not be less than requests. See [#39700](https://github.com/rancher/rancher/issues/39700).

### Known Issues

- Rancher v2.9.0 does not currently support vSphere CSI charts in RKE2 v1.30.2 instances that run Kubernetes v1.30. A fix in RKE2 is in progress and being tracked by [#6334](https://github.com/rancher/rke2/issues/6334). Once the fix is completed, support for vSphere CSI charts while using RKE2 in Rancher v2.9.0 will be added via a KDM release. See [#46132](https://github.com/rancher/rancher/issues/46132).
- After upgrading to v2.9.0, Rancher's pods may crash and fail to become available. This primarily affects clusters which have been upgraded from older Kubernetes versions, and can also result in disconnected downstream clusters. As a workaround, all CRDs in each affected cluster need to be updated to add a `version.Schema.openAPIV3Schema`. See [#46213](https://github.com/rancher/rancher/issues/46213).

## Rancher App (Global UI)

### Features and Enhancements

- A deprecation toggle has been added to the UI **Apps > Charts** view. When toggled on, you will see all deprecated charts that have been labeled with a `Deprecated` badge. See [#11042](https://github.com/rancher/dashboard/issues/11042).
- The **Cluster Dashboard** view has replaced the **Install Monitoring** link with a **Cluster Tools** link. Clicking **Cluster Tools** takes you to the UI view to install cluster tools. The **Add Cluster Badge** link in the **Cluster Dashboard** has also been changed, to an icon button with a tooltip to customize appearance. See [#10034](https://github.com/rancher/dashboard/pull/10034) and [#9228](https://github.com/rancher/dashboard/issues/9228).
- Improved Rancher UI navigation menu performance, for environments with many CRDs, namespaces or resource churn. See [#7773](https://github.com/rancher/dashboard/issues/7773).
- Improved UI performance by supporting a new API feature to independently fetch schemes related to the primary resource. See [#7716](https://github.com/rancher/dashboard/issues/7716).

### Major Bug Fixes

- Fixed a bug where after a user created a resource and is returned to the list view for that resource, a duplicate row was shown. See [#11151](https://github.com/rancher/dashboard/issues/11151).
- Fixed an issue where global permissions in the UI were displayed in random order. See [#11013](https://github.com/rancher/dashboard/issues/11013).

### Known Issues

- The Azure in-tree cloud provider has been removed for Kubernetes versions v1.30 and later. The Rancher UI has a known issue with not properly updating the cloud provider dropdown options for RKE1 and RKE2 clusters running Kubernetes v1.30 and later. As a workaround, you can modify your configuration with the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11363](https://github.com/rancher/dashboard/issues/11363).

## Continuous Delivery

### Features and Enhancements

- Rancher now supports **monitoring of continuous delivery**.  Starting with version `v104.0.1` of the Fleet chart (`v0.10.1` of Fleet) and `rancher-monitoring` chart, continuous delivery provides metrics about the state of its resources and the `rancher-monitoring` chart contains dashboards to visualize those metrics. Installing the `rancher-monitoring` chart to the local/upstream cluster automatically configures Prometheus to scrape metrics from the continuous delivery controllers and installs Grafana dashboards. These dashboards are accessible via Grafana but are not yet integrated into the Rancher UI. You can open Grafana from the Rancher UI by navigating to the *Cluster > Monitoring > Grafana* view. See [rancher/fleet#1408](https://github.com/rancher/fleet/issues/1408) for implementation details.
- It also introduces new features such as **sharding with node selectors**. See [#1740](https://github.com/rancher/fleet/issues/1740) for implementation details and the [Fleet documentation](https://fleet.rancher.io/installation#multi-controller-install-sharding) for explanations.
- We have **reduced image size and complexity** by integrating the former external gitjob repository and by merging various controller codes. This also means that the gitjob container image (`rancher/gitjob`) is not needed anymore, as the required functionality is embedded into the `rancher/fleet` container image. The gitjob deployment will still be created but pointing to the `rancher/fleet` container image instead. Please also note that a complete [list of necessary container images](https://github.com/rancher/rancher/releases/download/v2.9.0/rancher-images.txt) for air-gapped deployments is released alongside Rancher releases. You can find this list as `rancher-images.txt` in the assets of the [release on Github](https://github.com/rancher/rancher/releases/v2.9.0/). See [rancher/fleet#2342](https://github.com/rancher/fleet/issues/2342) for more details.
- Continuous delivery also adds **experimental OCI content storage**. See [rancher/fleet/pull#2561](https://github.com/rancher/fleet/pull/2561) for implementation details and [rancher/fleet-docs/pull#179](https://github.com/rancher/fleet-docs/pull/179/files) for documentation.
- Continuous delivery now splits components into containers and has switched to the controller-runtime framework. The rewritten controllers switch to **structured logging**.
- Leader election can now be configured (see [rancher/fleet/pull#1981](https://github.com/rancher/fleet/pull/1981)), as well as the worker count for the fleet-controller (see [rancher/fleet/pull#2430](https://github.com/rancher/fleet/pull/2430)).
- The release deprecates the "fleet test" command in favor of "target" and "deploy" with a dry-run option.
- Bug fixes enhance drift detection, cluster status reporting, and various operational aspects.

## Security

### Features and Enhancements

- Added a new setting, `agent-tls-mode`, which allows users to specify if agents will use `strict` certificate verification when connecting to Rancher. The field can be set to `strict` (which requires the agent to verify the certificate using only the Certificate Authority in the `cacerts` setting) or `system-store` (which allows the agent to verify the certificate using any Certificate Authority in the operating system's trust store). This setting will default to `strict` on new installs of v2.9.0+. When upgrading from a prior version, the current value will be kept. For example, when upgrading from 2.8 (where the setting defaults to `system-store`), the value will still be `system-store` after the upgrade to 2.9. See [#45628](https://github.com/rancher/rancher/issues/45628).
  **Important:** Agents running on Windows nodes do not yet respect the `agent-tls-mode` setting, but will continue to function as expected. See [#46396](https://github.com/rancher/rancher/issues/46396).

#### Breaking Changes

- When `agent-tls-mode` is set to `strict`, users must provide the certificate authority to Rancher or downstream clusters will disconnect from Rancher, and require manual intervention to fix. This applies to several setup types, including:
  - Let's Encrypt - When set to `strict`, users must upload the Let's Encrypt Certificate Authority and provide `privateCA=true` when installing the chart.
  - Bring Your Own Cert - When set to `strict`, users must upload the Certificate Authority used to generate the cert and provide `privateCA=true` when installing the chart.
  - Proxy/External - When set to `strict`, users must upload the Certificate Authority used by the proxy and provide `privateCA=true` when installing the chart.

## Apps

### Major Bug Fixes

- Air-gapped installations with `useBundledSystemCharts` set to `true` received an update to improve loading and installing apps in the upstream cluster. See [#45280](https://github.com/rancher/rancher/pull/45280).

## RKE Provisioning

**Important:** With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or k3s.

RKE2 and k3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about re-platforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

### Features and Enhancements

- Rancher now supports Docker v26.0 and v26.1 for RKE provisioning. See [#45013](https://github.com/rancher/rancher/issues/45013) for supporting v26.0 information and [#45439](https://github.com/rancher/rancher/issues/45439) for supporting v26.1 information.

### Major Bug Fixes

- Fixed an issue where scaling up etcd nodes in RKE would lead to nodes being stuck waiting to register with Kubernetes. This caused clusters to hang. See [#43356](https://github.com/rancher/rancher/issues/43356).

### Behavior Changes

- Rancher has added support for external Azure cloud providers in downstream RKE clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44857](https://github.com/rancher/rancher/issues/44857).
- Weave CNI support for RKE clusters is removed in response to Weave CNI not being supported by upstream Kubernetes v1.30 and later. See [#45954](https://github.com/rancher/rancher/issues/45954)

### Known Issues

- The Weave CNI plugin for RKE v1.27 and later is now deprecated, due to the plugin being deprecated for upstream Kubernetes v1.27 and later. RKE creation will not go through as it will raise a validation warning. See [#11322](https://github.com/rancher/dashboard/issues/11322).

## RKE2 Provisioning

### Features and Enhancements

- Rancher now provides support for configuring the data directory for RKE2 clusters through the UI **Cluster Configuration > Advanced** tab. Note that values can only be set during cluster creation. See [#45038](https://github.com/rancher/rancher/issues/45038) and [#10824](https://github.com/rancher/dashboard/issues/10824). For known limitations with this feature please note the [section below](./v2.9.md#known-issues-3)
- Added a new annotation, `rke.cattle.io/delete-missing-custom-machines-after`, to enable machine deletion on corresponding Node deletion. Users can set the annotation to the `clusters.provisioning.cattle.io/v1` or `rkecluster.rke.cattle.io` objects. Once set, it causes  missing machines to be deleted after a specified duration (example: `rke.cattle.io/delete-missing-custom-machines-after: '5s'`). See [#43686](https://github.com/rancher/rancher/issues/43686).

### Major Bug Fixes

- Fixed an issue where scaling down etcd node pools on RKE2 machine-provisioned clusters caused unexpected behavior and clusters to hang in various states. See [#43097](https://github.com/rancher/rancher/issues/43097) and [#42582](https://github.com/rancher/rancher/issues/42582).

### Behavior Changes
<!-- Doc Link based on https://github.com/rancher/rancher-docs/pull/1369 -->
- Rancher has added support for external Azure cloud providers in downstream RKE2 clusters. Note that [migration to an external Azure cloud provider](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/migrate-to-an-out-of-tree-cloud-provider/migrate-to-out-of-tree-azure) is **required** when running Kubernetes v1.30 and **recommended** when running Kubernetes v1.29. See [#44856](https://github.com/rancher/rancher/issues/44856).
- Added a new annotation, `provisioning.cattle.io/allow-dynamic-schema-drop`. When set to `true`, it drops the `dynamicSchemaSpec` field from machine pool definitions. This prevents cluster nodes from re-provisioning unintentionally when the cluster object is updated from an external source such as Terraform or Fleet. See [#44618](https://github.com/rancher/rancher/issues/44618).

### Known Issues

- Currently there are known issues with the [data directory feature](https://github.com/rancher/rancher/issues/45038) which are outlined below:
  - Provisioning an RKE2 cluster with the feature enabled causes snapshot restores to fail. See [#46066](https://github.com/rancher/rancher/issues/46066).
  - Custom RKE2 clusters need to ensure the environment variable (`CATTLE_AGENT_VAR_DIR`) is configured into the system agent install command as the default variable is missing. A workaround exists to manually specify the `CATTLE_AGENT_VAR_DIR` in the registration command [per this comment](https://github.com/rancher/rancher/issues/46362#issuecomment-2260793382). Currently, node driver provisioned clusters can make use of the data directory. See [#46362](https://github.com/rancher/rancher/issues/46362).
  - K3s does not support the data directory feature. See [#10589](https://github.com/k3s-io/k3s/issues/10589).
  - The `system-agent-upgrader` SUC plan is not applied correctly after cluster provisioning leading to the specified `system-agent` data directory not being used. See [#46361](https://github.com/rancher/rancher/issues/46361).
  - Currently selecting `Use the same path for System-agent, Provisioning and K8s Distro data directories configuration` results in Rancher using the same data directory for system agent, provisioning, and distribution components as opposed to appending the specified component names to the root directory. To mitigate this issue, you will need to configure the 3 paths separately and they must follow the guidelines below:
        - Absolute paths (start with /)
        - Clean (not contain env vars, shell expressions, ., or ..)
        - Not set to the same thing
        - Not nested one within another
    See [#11566](https://github.com/rancher/dashboard/issues/11566).
- When adding the `provisioning.cattle.io/allow-dynamic-schema-drop` annotation through the cluster config UI, the annotation disappears before adding the value field. When viewing the YAML, the respective value field is not updated and is displayed as an empty string. As a workaround, when creating the cluster, set the annotation by using the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11435](https://github.com/rancher/dashboard/issues/11435).

## Rancher CLI

### Features and Enhancements
<!-- Doc Link based on https://github.com/rancher/rancher-docs/pull/1311 -->
- Added support for authentication with an Azure AD provider with kubectl through the Rancher CLI. Note you must [allow public client flows](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-azure-ad#4-allow-public-client-flows) to login from Rancher CLI. See [#42939](https://github.com/rancher/rancher/issues/42939).

### Known Issues

- The Rancher CLI currently lists the Azure authentication provider options out of order. See [#46128](https://github.com/rancher/rancher/issues/46128).

## Authentication

### Features and Enhancements

- Extended Rancher's Azure AD (aka [Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/new-name)) authentication provider with a filter field which lists the groups attached to a user. When you enable the setting the groups of a user are later filtered down as per the provided clauses. See [#42940](https://github.com/rancher/rancher/issues/42940).
  Caution: This filter does not affect the general group listing, only the list of groups for a user. Additionally, if you filter out a group, all permissions the group would have given will not apply. As the filter prevents Rancher from seeing that the user belongs to the group, it also does not see any permissions from that group. This means that filtering can have the side effect of denying users permissions they should have.
- Added authentication support for generic OpenID Connect providers, such as Keycloak and Okta. See [#10053](https://github.com/rancher/rancher/issues/10053).

### Major Bug Fixes

- Upon login using a SAML provider, the `lastLogin` user attribute is now set at login time. See [#46124](https://github.com/rancher/rancher/issues/46124).
- An issue was fixed where Rancher was not updating additional groups a user had been added to in their SAML provider. See [#45956](https://github.com/rancher/rancher/issues/45956).

### Known Issues

- There are some known issues with the OpenID Connect provider support:
  - When the generic OIDC auth provider is enabled, and you attempt to add auth provider users to a cluster or project, users are not populated in the dropdown search bar. This is expected behavior as the OIDC auth provider alone is not searchable. See [#46104](https://github.com/rancher/rancher/issues/46104).
  - When the generic OIDC auth provider is enabled, auth provider users that are added to a cluster/project by their username are not able to access resources upon logging in. A user will only have access to resources upon login if the user is added by their userID.  See [#46105](https://github.com/rancher/rancher/issues/46105).
  - When the generic OIDC auth provider is enabled and an auth provider user in a nested group is logged into Rancher, the user will see the following error when they attempt to create a Project: `[projectroletemplatebindings.management.cattle.io](http://projectroletemplatebindings.management.cattle.io/) is forbidden: User "u-gcxatwsnku" cannot create resource "projectroletemplatebindings" in API group "[management.cattle.io](http://management.cattle.io/)" in the namespace "p-9t5pg"`. However, the project is still created. See [#46106](https://github.com/rancher/rancher/issues/46106).

## Pod Security Admissions (PSA)

### Major Bug Fixes

- Rancher now updates the value of the PSACT `rancher-restricted` to include `cattle-provisioning-capi-system` and `cattle-fleet-local-system` under the `exemptions.namespaces` list. See [#43150](https://github.com/rancher/rancher/issues/43150).

## Extensions

### Features and Enhancements

- Rancher now enables UI extensions to load without the need for authentication. To do so set the extension chart's annotation `noAuth` to `true`. For more information see https://extensions.rancher.io/extensions/extensions-configuration#other-configuration-properties. See [#43090](https://github.com/rancher/rancher/issues/43090).
- A new [feature flag `uiextensions`](https://ranchermanager.docs.rancher.com/v2.9/integrations-in-rancher/rancher-extensions#enabling-extension-support-in-rancher) has been added for enabling and disabling the UI extension feature (this replaces the need to install the `ui-plugin-operator`). The first time it's set to `true` (the default value is `true`) it will create the CRD and enable the controllers and endpoints necessary for the feature to work. If set to `false`, it won't create the CRD if it doesn't already exist, but it won't delete it if it does. It will also disable the controllers and endpoints used by the feature. Enabling or disabling the feature flag will cause Rancher to restart. See [#44230](https://github.com/rancher/rancher/pull/44230) and [#43089](https://github.com/rancher/rancher/issues/43089).

### Behavior Changes

- UI extension owners must update and publish a new version of their extensions to be compatible with Rancher v2.9.0 and later. For more information see the [Rancher v2.9 extension support page](https://extensions.rancher.io/extensions/rancher-2.9-support).

## Role-Based Access Control (RBAC)

### Features and Enhancements

- Users can now provide rules that apply only in specific namespaces using the new field `namespacedRules`, which has been added to the `GlobalRules` type. View this [example configuration and context](https://github.com/rancher/rancher/issues/42215#issuecomment-1847543482) and see [#42215](https://github.com/rancher/rancher/issues/42215) for general information.
- Added the new field, `InheritedFleetWorkspacePermissions`, to the `GlobalRole` type. The field allows users to deploy resources using Fleet in downstream clusters. The Restricted Admin user, which was once needed to deploy resources, is now deprecated and can be replaced by using `InheritedFleetWorkspacePermissions`. Note that Admin or Restricted Admin users can create `GlobalRoles` with `InheritedFleetWorkspacePermissions` that allow users to deploy Fleet resources in all workspaces except `fleet-local`.
  Each `fleetworkspace` has a backing namespace in the local cluster. For a user to be able to deploy resources using Fleet in a downstream cluster they need:

  - Permissions to deploy Fleet resources in the backing namespace of the `fleetworkspace`. For example, permission to create `GitRepos` in `fleet-default`.
  - Permissions to get `fleetworkspace` cluster-wide resources in the local cluster.

  Two new fields were added to `GlobalRole` in order to provide access to all Fleet workspaces except `fleet-local`:

  - `InheritedFleetWorkspacePermissions.ResourceRules`: rules granted in all backing namespaces for all Fleet workspaces excluding `fleet-local`.
  - `InheritedFleetWorkspacePermissions.WorkspaceVerbs`: verbs used to grant permissions to the cluster-wide `fleetworkspace` resources. `ResourceNames` for this rule will contain all Fleet workspace names except `fleet-local`.
  
  View this [example configuration and context](https://github.com/rancher/rancher/issues/42170#issuecomment-2186222366) and see [#42170](https://github.com/rancher/rancher/issues/42170) for general information.

## vSphere Charts

### Major Bug Fixes

- Support for using snapshots to backup vSphere CSI volumes has been fixed by adding a missing `csi-snapshotter` field used by images in the Rancher provided chart configuration. See [#41321](https://github.com/rancher/rancher/issues/41321).

## VM Management (Harvester)

### Major Bug Fixes

- Fixed a bug where attempting to provision a Harvester RKE2 cluster and adding two vGPUs would have the provisioning process get stuck in a `starting` state and the VMs would not start. See [#10947](https://github.com/rancher/dashboard/issues/10947).

### Known Issues

- In the Rancher UI when navigating between Harvester clusters of different versions a refresh may be required to view version specific functionality. See [#11559](https://github.com/rancher/dashboard/issues/11559).

# Install/Upgrade Notes

> - If you're installing Rancher for the first time, your environment must fulfill the [installation requirements](https://docs.ranchermanager.rancher.io/pages-for-subheaders/installation-requirements).

# Upgrade Requirements

- **Creating backups:** [Create a backup](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-rancher) before you upgrade Rancher. To roll back Rancher after an upgrade, you must first back up and restore Rancher to the previous Rancher version. Because Rancher will be restored to the same state as when the backup was created, any changes post-upgrade will not be included after the restore.
- **CNI requirements:**
  - For Kubernetes v1.19 and later, disable firewalld as it's incompatible with various CNI plugins. See [#28840](https://github.com/rancher/rancher/issues/28840).
  - When upgrading or installing a Linux distribution that uses nf_tables as the backend packet filter, such as SLES 15, RHEL 8, Ubuntu 20.10, Debian 10, or later, upgrade to RKE v1.19.2 or later to get Flannel v0.13.0. Flannel v0.13.0 supports nf_tables. See Flannel [#1317](https://github.com/flannel-io/flannel/issues/1317).
- **Requirements for air gapped environments:**
  - When using a proxy in front of an air-gapped Rancher instance, you must pass additional parameters to `NO_PROXY`. See the [documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/other-installation-methods/rancher-behind-an-http-proxy/install-rancher) and  issue [#2725](https://github.com/rancher/docs/issues/2725#issuecomment-702454584).
  - When installing Rancher with Docker in an air-gapped environment, you must supply a custom `registries.yaml` file to the `docker run` command, as shown in the [K3s documentation](https://docs.k3s.io/installation/private-registry). If the registry has certificates, then you'll also need to supply those. See [#28969](https://github.com/rancher/rancher/issues/28969#issuecomment-694474229).
- **Requirements for general Docker installs:**
  - When starting the Rancher Docker container, you must use the `privileged` flag. See [documentation](https://docs.ranchermanager.rancher.io/pages-for-subheaders/rancher-on-a-single-node-with-docker).
  - When upgrading a Docker installation, a panic may occur in the container, which causes it to restart. After restarting, the container will come up and work as expected. See [#33685](https://github.com/rancher/rancher/issues/33685).

# Versions

Please refer to the [README](https://github.com/rancher/rancher#latest-release) for the latest and stable Rancher versions.

Please review our [version documentation](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/resources/choose-a-rancher-version) for more details on versioning and tagging conventions.

**Important:** With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must re-platform from RKE to RKE2 or k3s.

RKE2 and k3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about re-platforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Images

- rancher/rancher:v2.9.0

## Tools

- CLI - [v2.9.0](https://github.com/rancher/cli/releases/tag/v2.9.0)
- RKE - [v1.6.0](https://github.com/rancher/rke/releases/tag/v1.6.0)

## Kubernetes Versions for RKE
- v1.30.2 (Default)
- v1.29.6
- v1.28.11
- v1.27.15

## Kubernetes Versions for RKE2/K3s
- v1.30.2 (Default)
- v1.29.6
- v1.28.11
- v1.27.15

## Rancher Helm Chart Versions

In Rancher v2.6.0 and later, in the **Apps & Marketplace** UI, many Rancher Helm charts are named with a major version that starts with *100*. This avoids simultaneous upstream changes and Rancher changes from causing conflicting version increments. This also complies with semantic versioning (SemVer), which is a requirement for Helm. You can see the upstream version number of a chart in the build metadata, for example: `100.0.0+up2.1.0`. See [#32294](https://github.com/rancher/rancher/issues/32294).

# Other Notes

## Experimental Features

Rancher now supports the ability to use an OCI Helm chart registry for Apps & Marketplace. View documentation on [using OCI based Helm chart repositories](https://ranchermanager.docs.rancher.com/v2.9/how-to-guides/new-user-guides/helm-charts-in-rancher/oci-repositories) and note this feature is in an experimental stage. See [#29105](https://github.com/rancher/rancher/issues/29105) and [#45062](https://github.com/rancher/rancher/pull/45062)

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

## Previous Rancher Behavior Changes - Rancher General

- **Rancher 2.8.4:**
  - The controller now cleans up instances of `ClusterUserAttribute` that have no corresponding `UserAttribute`. See [#44985](https://github.com/rancher/rancher/issues/44985).
- **Rancher 2.8.3:**
  - When Rancher starts, it now identifies all deprecated and unrecognized setting resources and adds a `cattle.io/unknown` label. You can list these settings with the command `kubectl get settings -l 'cattle.io/unknown==true'`. In Rancher v2.9 and later, these settings will be removed instead. See [#43992](https://github.com/rancher/rancher/issues/43992).
- **Rancher v2.8.0:**
  - Rancher Compose is no longer supported, and all parts of it are being removed in the v2.8 release line. See [#43341](https://github.com/rancher/rancher/issues/43341).
  - Kubernetes v1.23 and v1.24 are no longer supported. Before you upgrade to Rancher v2.8.0, make sure that all clusters are running Kubernetes v1.25 or later. See [#42828](https://github.com/rancher/rancher/issues/42828).

## Previous Rancher Behavior Changes - Cluster Provisioning

- **Rancher 2.8.4:**
  - Docker CLI 20.x is at end-of-life and no longer supported in Rancher. Please update your local Docker CLI versions to 23.0.x or later. Earlier versions may not recognize OCI compliant Rancher image manifests. See [#45424](https://github.com/rancher/rancher/issues/45424).
- **Rancher v2.8.0:**
  - Kontainer Engine v1 (KEv1) provisioning and the respective cluster drivers are now deprecated. KEv1 provided plug-ins for different targets using cluster drivers. The Rancher-maintained cluster drivers for EKS, GKE and AKS have been replaced by the hosted provider drivers, EKS-Operator, GKE-Operator and AKS-Operator. Node drivers are now available for self-managed Kubernetes.
- **Rancher v2.7.2:**
  - When you provision a downstream cluster, the cluster's name must conform to [RFC-1123](https://www.rfc-editor.org/rfc/rfc1123). Previously, characters that did not follow the specification, such as `.`, were permitted and would result in clusters being provisioned without the necessary Fleet components. See [#39248](https://github.com/rancher/rancher/issues/39248).
  - Privilege escalation is disabled by default when creating deployments from the Rancher API. See [#7165](https://github.com/rancher/dashboard/issues/7165).

## Previous Rancher Behavior Changes - RKE Provisioning

- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke1) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#43175](https://github.com/rancher/rancher/issues/43175).
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated. Weave will be removed in RKE v1.30. See [#42730](https://github.com/rancher/rancher/issues/42730).

## Previous Rancher Behavior Changes - RKE2 Provisioning

- **Rancher v2.8.0:**
  - Rancher no longer supports the Amazon Web Services (AWS) in-tree cloud provider for RKE2 clusters. This is in response to upstream Kubernetes removing the in-tree AWS provider in Kubernetes v1.27. You should instead [use the out-of-tree AWS cloud provider](https://ranchermanager.docs.rancher.com/v2.8/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup/set-up-cloud-providers/amazon#using-the-out-of-tree-aws-cloud-provider-for-rke2) for any Rancher-managed clusters running Kubernetes v1.27 or later. See [#42749](https://github.com/rancher/rancher/issues/42749).
  - Similar to Rancher v2.7.9, when you upgrade to Rancher v2.8.0 with provisioned RKE2/K3s clusters in an unhealthy state, you may encounter the error message, `implausible joined server for entry`. This requires manually marking the nodes in the cluster with a joined server. See [#42856](https://github.com/rancher/rancher/issues/42856).

## Previous Rancher Behavior Changes - Cluster API <!-- highlander -->

- **Rancher v2.7.7:**
  - The `cluster-api` core provider controllers run in a pod in the `cattle-provisioning-cattle-system` namespace, within the local cluster. These controllers are installed with a [Helm chart](https://github.com/rancher/provisioning). Previously, Rancher ran `cluster-api` controllers in an embedded fashion. This change makes it easier to maintain `cluster-api` versioning. See [#41094](https://github.com/rancher/rancher/issues/41094).
  - The token hashing algorithm generates new tokens using SHA3. Existing tokens that don't use SHA3 won't be re-hashed. This change affects ClusterAuthTokens (the downstream synced version of tokens for ACE) and Tokens (only when token hashing is enabled). SHA3 tokens should work with ACE and Token Hashing. Tokens that don't use SHA3 may not work when ACE and token hashing are used in combination. If, after upgrading to Rancher v2.7.7, you experience issues with ACE while token hashing is enabled, re-generate any applicable tokens. See [#42062](https://github.com/rancher/rancher/pull/42062).

## Previous Rancher Behavior Changes - Rancher App (Global UI)

- **Rancher v2.8.0:**
  - The built-in `restricted-admin` role is being deprecated in favor of a more flexible global role configuration, which is now available for different use cases other than only the `restricted-admin`. If you want to replicate the permissions given through this role, use the new `inheritedClusterRoles` feature to create a custom global role. A custom global role, like the `restricted-admin` role, grants permissions on all downstream clusters. See [#42462](https://github.com/rancher/rancher/issues/42462). Given its deprecation, the `restricted-admin` role will continue to be included in future builds of Rancher through the v2.8.x and v2.9.x release lines. However, in accordance with the CVSS standard, only security issues scored as critical will be backported and fixed in the `restricted-admin` role until it is completely removed from Rancher. <!-- Security 1249 -->
  - Reverse DNS server functionality has been removed. The associated [`rancher/rdns-server`](https://github.com/rancher/rdns-server) repository is now archived. Reverse DNS is already disabled by default. <!--Rancher security 1201 -->
  - The Rancher CLI configuration file `~/.rancher/cli2.json` previously had permissions set to `0644`. Although `0644` would usually indicate that all users have read access to the file, the parent directory would block users' access. New Rancher CLI configuration files will only be readable by the owner (`0600`). Invoking the CLI will trigger a warning, in case old configuration files are world-readable or group-readable. See [#42838](https://github.com/rancher/rancher/issues/42838).

## Previous Rancher Behavior Changes - Rancher App (Helm Chart) <!-- night's watch -->

- **Rancher v2.7.0:**
  - When installing or upgrading an official Rancher Helm chart app in a RKE2/K3s cluster, if a private registry exists in the cluster configuration, that registry will be used for pulling images. If no cluster-scoped registry is found, the global container registry will be used. A custom default registry can be specified during the Helm chart install and upgrade workflows. Previously, only the global container registry was used when installing or upgrading an official Rancher Helm chart app for RKE2/K3s node driver clusters.<!-- no issue number --><!-- introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->

## Previous Rancher Behavior Changes - Pod Security Standard (PSS) & Pod Security Admission (PSA) <!-- neo -->

- **Rancher v2.7.2:**
  - You must manually change the `psp.enabled` value in the chart install yaml when you install or upgrade v102.x.y charts on hardened RKE2 clusters. [Instructions](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/pod-security-standards#cleaning-up-releases-after-a-kubernetes-v125-upgrade) for updating the value are available. See [#41018](https://github.com/rancher/rancher/issues/41018).

## Previous Rancher Behavior Changes - Authentication <!-- night's watch -->

- **Rancher v2.8.3:**
  - Rancher uses additional trusted CAs when establishing a secure connection to the keycloak OIDC authentication provider. See [#43217](https://github.com/rancher/rancher/issues/43217).
- **Rancher v2.8.0:**
  - The `kubeconfig-token-ttl-minutes` setting has been replaced by the setting, `kubeconfig-default-token-ttl-minutes`, and is no longer available in the UI. See [#38535](https://github.com/rancher/rancher/issues/38535).
  - [API tokens](https://ranchermanager.docs.rancher.com/v2.8/reference-guides/about-the-api/api-tokens) now have default time periods after which they expire. Authentication tokens expire after 90 days, while kubeconfig tokens expire after 30 days. See [#41919](https://github.com/rancher/rancher/issues/41919).
- **Rancher v2.7.2:**
  - Rancher might retain resources from a disabled auth provider configuration in the local cluster, even after you configure another auth provider. To manually trigger cleanup for a disabled auth provider, add the `management.cattle.io/auth-provider-cleanup` annotation with the `unlocked` value to its auth config. See [#40378](https://github.com/rancher/rancher/pull/40378).

## Previous Rancher Behavior Changes - Rancher Webhook <!-- neo -->

- **Rancher v2.8.3:**
  - The embedded Cluster API webhook is removed from the Rancher webhook and can no longer be installed from the webhook chart. It has not been used as of Rancher v2.7.7, where it was migrated to a separate Pod. See [#44619](https://github.com/rancher/rancher/issues/44619).
- **Rancher v2.8.0:**
  - Rancher's webhook now honors the `bind` and `escalate` verbs for GlobalRoles. Users who have `*` set on GlobalRoles will now have both of these verbs, and could potentially use them to escalate privileges in Rancher v2.8.0 and later. You should review current custom GlobalRoles, especially cases where `bind`, `escalate`, or `*` are granted, before you upgrade.
- **Rancher v2.7.5:**
  - Rancher installs the same pinned version of the `rancher-webhook` chart not only in the local cluster but also in all downstream clusters. Restoring Rancher from v2.7.5 to an earlier version will result in downstream clusters' webhooks being at the version set by Rancher v2.7.5, which might cause incompatibility issues. Local and downstream webhook versions need to be in sync. See [#41730](https://github.com/rancher/rancher/issues/41730) and [#41917](https://github.com/rancher/rancher/issues/41917).
  - The mutating webhook configuration for secrets is no longer active in downstream clusters. See [#41613](https://github.com/rancher/rancher/issues/41613).

## Previous Rancher Behavior Changes - Apps & Marketplace <!-- mapps -->

- **Rancher v2.8.0:**
  - Legacy code for the following v1 charts is no longer available in the [`rancher/system-charts`](https://github.com/rancher/system-charts) repository:

    - `rancher-cis-benchmark`
    - `rancher-gatekeeper-operator`
    - `rancher-istio`
    - `rancher-logging`
    - `rancher-monitoring`

    The code for these charts will remain available for previous versions of Rancher.
  - Helm v2 support is deprecated as of the Rancher v2.7 line and will be removed in Rancher v2.9.
- **Rancher v2.7.0:**
  - Rancher no longer validates an app registration's permissions to use Microsoft Graph on endpoint updates or initial setup. You should add `Directory.Read.All` permissions of type `Application`. If you configure a different set of permissions, Rancher may not have sufficient privileges to perform some necessary actions within Azure AD, causing errors.<!-- no issue number --><!--introduced in https://github.com/rancher/rancher/releases/tag/v2.7.0 -->
  - The multi-cluster app legacy feature is no longer available. See [#39525](https://github.com/rancher/rancher/issues/39525).

## Previous Rancher Behavior Changes - OPA Gatekeeper

- **Rancher v2.8.0:**
  - OPA Gatekeeper is now deprecated and will be removed in a future release. As a replacement for OPA Gatekeeper, consider [switching to Kubewarden](https://docs.kubewarden.io/explanations/comparisons/opa-comparison). See [#42627](https://github.com/rancher/rancher/issues/42627).

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

## Previous Rancher Behavior Changes - Security

- **Rancher v2.8.0:**
  - TLS v1.0 and v1.1 are no longer supported for Rancher app ingresses. See [#42027](https://github.com/rancher/rancher/issues/42027).

## Previous Rancher Behavior Changes - Extensions

- **Rancher 2.8.4:**
  - The Rancher dashboard fails to load an extension that utilizes backported Vue 3 features, displaying an error in the console `object(...) is not a function`. New extensions that utilize the `defineComponent` will not be backwards compatible with older versions of the dashboard. Existing extensions should continue to work moving forward. See [#10568](https://github.com/rancher/dashboard/issues/10568).  

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.8.1:**
  - When you  attempt to register a new etcd/controlplane node in a CAPR-managed cluster after a failed etcd snapshot restoration, the node can become stuck in a perpetual paused state, displaying the error message `[ERROR]  000 received while downloading Rancher connection information. Sleeping for 5 seconds and trying again`. As a workaround, you can unpause the cluster by running `kubectl edit clusters.cluster clustername -n fleet-default` and set `spec.unpaused` to `false`.  See [#43735](https://github.com/rancher/rancher/issues/43735).
- **Rancher v2.7.2:**
  - If you upgrade or update any hosted cluster, and go to **Cluster Management > Clusters** while the cluster is still provisioning, the **Registration** tab is visible. Registering a cluster that is already registered with Rancher can cause data corruption. See [#8524](https://github.com/rancher/dashboard/issues/8524).
  - When you upgrade your Kubernetes cluster, you might see the following error: `Cluster health check failed`. This is a benign error that occurs as part of the upgrade process, and will self-resolve. It's caused by the Kubernetes API server becoming temporarily unavailable as it is being upgraded within your cluster. See [#41012](https://github.com/rancher/rancher/issues/41012).
  - Once you configure a setting with an environmental variable, it can't be updated through the Rancher API or the UI. It can only be updated through changing the value of the environmental variable. Setting the environmental variable to "" (the empty string) changes the value in the Rancher API but not in Kubernetes. As a workaround, run `kubectl edit setting <setting-name>`, then set the value and source fields to `""`, and re-deploy Rancher. See [#37998](https://github.com/rancher/rancher/issues/37998).
- **Rancher 2.6.1:**
  - When using the Rancher UI to add a new port of type `ClusterIP` to an existing Deployment created using the legacy UI, the new port won't be created upon your first attempt to save the new port. You must repeat the procedure to add the port again. The Service Type field will display `Do not create a service` during the second procedure. Change this to `ClusterIP` and save to create the new port. See [#4280](https://github.com/rancher/dashboard/issues/4280).

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.4:**
  - RKE2 clusters with invalid values for tolerations or affinity agent customizations don't display an error message, and remain in an `Updating` state. This causes cluster creation to hang. See [#41606](https://github.com/rancher/rancher/issues/41606).
- **Rancher v2.7.2:**
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).
- **Rancher v2.6.9:**
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021).<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->
- **Rancher v2.6.4:**
  - Communication between the ingress controller and the pods doesn't work when you create an RKE2 cluster with Cilium as the CNI and activate project network isolation. See [documentation](https://docs.ranchermanager.rancher.io/faq/container-network-interface-providers#ingress-routing-across-nodes-in-cilium) and [#34275](https://github.com/rancher/rancher/issues/34275).
- **Rancher v2.6.3:**
  - When provisioning clusters with an RKE2 cluster template, the `rootSize` for AWS EC2 provisioners doesn't take an integer when it should, and an error is thrown. As a workaround, wrap the EC2 `rootSize` in quotes. See [#40128](https://github.com/rancher/rancher/issues/40128).<!-- first appears in https://github.com/rancher/rancher/releases/tag/v2.6.3 as https://github.com/rancher/dashboard/issues/3689 which redirects to https://github.com/rancher/rancher/issues/40128 -->
- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920).

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).
  - Deleting nodes from custom RKE2/K3s clusters in Rancher v2.7.2 can cause unexpected behavior, if the underlying infrastructure isn't thoroughly cleaned. When deleting a custom node from your cluster, ensure that you delete the underlying infrastructure for it, or run the corresponding uninstall script for the Kubernetes distribution installed on the node. See [#41034](https://github.com/rancher/rancher/issues/41034):
    - [K3s uninstall script](https://docs.k3s.io/installation/uninstall).
- **Rancher v2.6.0:**
  - Amazon ECR Private Registries don't work from RKE2/K3s. See [#33920](https://github.com/rancher/rancher/issues/33920). 
  - Deleting a control plane node results in worker nodes also reconciling. See [#39021](https://github.com/rancher/rancher/issues/39021)..<!-- first added in https://github.com/rancher/rancher/releases/tag/v2.7.3, but issue mentions 2.6.9, and isn't listed at all in v2.6.x notes yet -->

## Long-standing Known Issues - Rancher App (Global UI)

- **Rancher 2.7.7**:
  - When creating a cluster in the Rancher UI it does not allow the use of an underscore `_` in the `Cluster Name` field. See [#9416](https://github.com/rancher/dashboard/issues/9416).
- **Rancher 2.7.2**:
  - When creating a GKE cluster in the Rancher UI you will see provisioning failures as the `clusterIpv4CidrBlock` and `clusterSecondaryRangeName` fields conflict. See [#8749](https://github.com/rancher/dashboard/issues/8749).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - Docker Install <!-- hostbusters -->

- **Rancher v2.6.4:**
  - Single node Rancher won't start on Apple M1 devices with Docker Desktop 4.3.0 or later. See [#35930](https://github.com/rancher/rancher/issues/35930).
- **Rancher v2.6.3:**
  - On a Docker install upgrade and rollback, Rancher logs repeatedly display the messages "Updating workload `ingress-nginx/nginx-ingress-controller`" and "Updating service `frontend` with public endpoints". Ingresses and clusters are functional and active, and logs resolve eventually. See [#35798](https://github.com/rancher/rancher/issues/35798) and [#40257](https://github.com/rancher/rancher/issues/40257).
- **Rancher v2.5.0:**
  - UI issues may occur due to longer startup times. When launching Docker for the first time, you'll receive an error message stating, "Cannot read property `endsWith` of undefined", as described in [#28800](https://github.com/rancher/rancher/issues/28800).  You'll then be directed to a login screen. See [#28798](https://github.com/rancher/rancher/issues/28798).

## Long-standing Known Issues - Windows <!-- hostbusters -->

- **Rancher v2.5.8:**
  - Windows nodeAgents are not deleted when performing a helm upgrade after disabling Windows logging on a Windows cluster. See [#32325](https://github.com/rancher/rancher/issues/32325).
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

### Long-standing Known Issues - Windows Nodes in RKE2 Clusters

- **Rancher v2.6.4:**
  - NodePorts do not work on Windows Server 2022 in RKE2 clusters due to a Windows kernel bug. See [#159](https://github.com/rancher/windows/issues/159).

## Long-standing Known Issues - AKS

- **Rancher v2.7.2:**
  - Imported Azure Kubernetes Service (AKS) clusters don't display workload level metrics. This bug affects Monitoring V1. A [workaround](https://github.com/rancher/dashboard/issues/4658#issuecomment-733035658) is available. See [#4658](https://github.com/rancher/dashboard/issues/4658).
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

- **Rancher v2.7.7:**
  - The SAML authentication pop-up throws a `404` error on high-availability RKE installations. Single node Docker installations aren't affected. If you refresh the browser window and select **Resend**, the authentication request will succeed, and you will be able to log in. See [#31163](https://github.com/rancher/rancher/issues/31163).
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
- **Rancher v2.8.4:**
  - When provisioning a Harvester RKE1 cluster in Rancher, the **vGPU** field is not displayed under **Cluster Management > Advanced Settings**, this is not a supported feature. However, the **vGPU** field is available when provisioning a Harvester RKE2 cluster. See [#10909](https://github.com/rancher/dashboard/issues/10909).
  - When provisioning a multi-node Harvester RKE2 cluster in Rancher, you need to allocate one vGPU more than the number of nodes you have or provisioning will fail. See [#11009](https://github.com/rancher/dashboard/issues/11009) and v2.9.0 back-port issue [#10989](https://github.com/rancher/dashboard/issues/10989).
- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).

## Long-standing Known Issues - Continuous Delivery <!-- fleet --> <!-- use function based naming from https://jira.suse.com/browse/SURE-6864? e.g. "Continuous Deployment with Fleet?" -->

- **Rancher v2.9.0:**
  - The git-sync job that clones the repository does not have access to the CA bundle as a necessary secret is not created from the GitRepo resource data. Cloning from git repositories that require custom certificates will fail. See [#2824](https://github.com/rancher/fleet/issues/2824).
- **Rancher v2.7.6:**
  - Target customization can produce custom resources that exceed the Rancher API's maximum bundle size. This results in `Request entity too large` errors when attempting to add a GitHub repo. Only target customizations that modify the Helm chart URL or version are affected. As a workaround, use multiple paths or GitHub repos instead of target customization. See [#1650](https://github.com/rancher/fleet/issues/1650).
- **Rancher v2.6.1:**
  - Deploying Fleet to Harvester clusters is not yet supported. Clusters, whether Harvester or non-Harvester, imported using the Virtualization Management page will result in the cluster not being listed on the **Continuous Delivery** page. See [#35049](https://github.com/rancher/rancher/issues/35049).
- **Rancher v2.6.0:**
  - Multiple `fleet-agent` pods may be created and deleted during initial downstream agent deployment, rather than just one. This resolves itself quickly, but is unintentional behavior. See [#33293](https://github.com/rancher/rancher/issues/33293).<!-- first added in https://github.com/rancherlabs/release-notes/pull/139-->

## Long-standing Known Issues - Feature Charts

- **Rancher v2.6.5:**
  - After installing an app from a partner chart repo, the partner chart will upgrade to feature charts if the chart also exists in the feature charts default repo. See [#5655](https://github.com/rancher/dashboard/issues/5655).

## Long-standing Known Issues - CIS Scan <!-- neo/security -->

- **Rancher v2.8.3:**
  - Some CIS checks related to file permissions fail on RKE and RKE2 clusters with CIS v1.7 and CIS v1.8 profiles. See [#42971](https://github.com/rancher/rancher/issues/42971).
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

- **Rancher v2.8.0:**
  - Read-only project permissions and the View Monitoring role aren't sufficient to view links on the Monitoring index page. Users won't be able to see monitoring links. As a workaround, you can perform the following steps:

    1. If you haven't already, install Monitoring on the project.
    1. Move the `cattle-monitoring-system` namespace into the project.
    1. Grant project users the View Monitoring (`monitoring-ui-view`) role, and `read-only` or higher permissions on at least one project in the cluster.

    See [#4466](https://github.com/rancher/dashboard/issues/4466).

## Long-standing Known Issues - Project Monitoring <!-- opni-->

- **Rancher v2.5.8:**
  - If you deploy Monitoring V2 on a Windows cluster with `win_prefix_path` set, you must deploy Rancher Wins Upgrader to restart wins on the hosts. This will allow Rancher to start collecting metrics in Prometheus. See [#32535](https://github.com/rancher/rancher/issues/32535).

## All issues in v2.9.0 milestone

* [#46378](https://github.com/rancher/rancher/issues/46378) Ubuntu 24.04 validations on v2.9 
* [#46375](https://github.com/rancher/rancher/issues/46375) [BUG] CIS-benchmark fails to install on rancher 2.9.0 cis 6.0.0 due to missing CRDs
* [#46316](https://github.com/rancher/rancher/issues/46316) [BUG] provisioning v2 prov clusters `rancher/machine` image in `backOff` state when using private registry
* [#46257](https://github.com/rancher/rancher/issues/46257) [BUG] Agent fails to connect when using `agent-tls-mode` set to `system-store`
* [#46215](https://github.com/rancher/rancher/issues/46215) [v2.9] No v1.30.x version available for gke cluster
* [#46208](https://github.com/rancher/rancher/issues/46208) [BUG] Unable to search users when SAML auth is enabled
* [#46187](https://github.com/rancher/rancher/issues/46187) [BUG] Enabling shibboleth causes a rancher panic
* [#46181](https://github.com/rancher/rancher/issues/46181) [BUG] - Issue with Rancher Monitoring Prometheus Node Exporter Pod
* [#46169](https://github.com/rancher/rancher/issues/46169) [BUG] Members of nested groups in Azure AD do not inherit the same permissions as those in the parent group
* [#46164](https://github.com/rancher/rancher/issues/46164) [BUG]: Enabling Auth giving 500 errors intermittently, Failed to update UserAttribute
* [#46160](https://github.com/rancher/rancher/issues/46160) [BUG] Unable to provision downstream RKE2/K3s clusters, stuck at `waiting for cluster agent to connect`
* [#46152](https://github.com/rancher/rancher/issues/46152) [BUG] [2.9] Unable to provision/import hosted provider clusters 
* [#46124](https://github.com/rancher/rancher/issues/46124) [BUG] LastLogin is not set for SAML providers
* [#46111](https://github.com/rancher/rancher/issues/46111) Feature Charts: Add Longhorn 1.5.5 Chart in 2.9.0
* [#46110](https://github.com/rancher/rancher/issues/46110) Feature Charts: Add Longhorn 1.6.2 Chart in 2.9.0
* [#46094](https://github.com/rancher/rancher/issues/46094) [BUG] update CLI
* [#46068](https://github.com/rancher/rancher/issues/46068) [BUG] New Rancher CLI binaries are no longer published to releases.rancher.com
* [#46062](https://github.com/rancher/rancher/issues/46062) [BUG] k3s node driver clusters is stuck on provisioning with the error validating data: failed to download openapi
* [#46061](https://github.com/rancher/rancher/issues/46061) [BUG] k3s clusters nodes are on unavailable state post rancher upgrade
* [#46058](https://github.com/rancher/rancher/issues/46058) Release Wrangler v3.0.0
* [#46050](https://github.com/rancher/rancher/issues/46050) [RKE] Bump Components in rke-tools and confd
* [#46033](https://github.com/rancher/rancher/issues/46033) Make the GHA image publishing process pin the webhook version
* [#46020](https://github.com/rancher/rancher/issues/46020) Set Docker Install URL 26.1 as the default for RKE1
* [#45977](https://github.com/rancher/rancher/issues/45977) [BUG] Default Alert missing from monitoring dashboard
* [#45966](https://github.com/rancher/rancher/issues/45966) Reintroduce monitoring 45.31.1 for release 2.9
* [#45960](https://github.com/rancher/rancher/issues/45960) [forwardport v2.9][SURE-7122] goroutine leak in remotedialer
* [#45956](https://github.com/rancher/rancher/issues/45956) [BUG] SAML login does not update groups
* [#45955](https://github.com/rancher/rancher/issues/45955) [BUG] `apiGroups` endpoint no longer accessible
* [#45954](https://github.com/rancher/rancher/issues/45954) Remove Weave support in rke for kubernetes versions >=1.30.0
* [#45952](https://github.com/rancher/rancher/issues/45952) [v2.9] Update ACI-CNI to 6.0.4.2 
* [#45926](https://github.com/rancher/rancher/issues/45926) User Retention Feature
* [#45885](https://github.com/rancher/rancher/issues/45885) [BUG] Unable to setup fleet git repo in upstream cluster
* [#45882](https://github.com/rancher/rancher/issues/45882) Remove support for K8s 1.25 and 1.26 for Rancher 2.9.0
* [#45869](https://github.com/rancher/rancher/issues/45869) Validate RKE SLE Micro 5.5 - Imported Only
* [#45868](https://github.com/rancher/rancher/issues/45868) Validate SLE Micro 5.5 in Rancher 2.9.0 - Imported Only
* [#45863](https://github.com/rancher/rancher/issues/45863) Remove external-rules feature flag
* [#45812](https://github.com/rancher/rancher/issues/45812) [BUG] Need script | Secrets created via Fleet UI are not being backed up by BRO
* [#45785](https://github.com/rancher/rancher/issues/45785) [v2.9] KDM Update for K8s June 2024 patch release
* [#45770](https://github.com/rancher/rancher/issues/45770) [BUG] ETCD snapshot fails on RKE2 clusters
* [#45764](https://github.com/rancher/rancher/issues/45764)  [Feature] k8s 1.30 support - apps and feature charts 
* [#45763](https://github.com/rancher/rancher/issues/45763) k8s 1.30 support for Kubewarden
* [#45762](https://github.com/rancher/rancher/issues/45762) k8s 1.30 support for NeuVector 
* [#45760](https://github.com/rancher/rancher/issues/45760) k8s 1.30 support for longhorn
* [#45759](https://github.com/rancher/rancher/issues/45759) k8s 1.30 support for Harvester-CSI-driver 
* [#45758](https://github.com/rancher/rancher/issues/45758) k8s 1.30 support for Harvester-cloud-provider
* [#45757](https://github.com/rancher/rancher/issues/45757) k8s 1.30 support for GKE-operator
* [#45756](https://github.com/rancher/rancher/issues/45756) k8s 1.30 support for EKS-operator
* [#45755](https://github.com/rancher/rancher/issues/45755) k8s 1.30 support for AKS-operator 
* [#45754](https://github.com/rancher/rancher/issues/45754) k8s 1.30 support for Fleet 
* [#45753](https://github.com/rancher/rancher/issues/45753) k8s 1.30 support for CIS-benchmark
* [#45752](https://github.com/rancher/rancher/issues/45752) k8s 1.30 support for rancher-backup
* [#45751](https://github.com/rancher/rancher/issues/45751) k8s 1.30 support for rancher-alerting-drivers
* [#45750](https://github.com/rancher/rancher/issues/45750) k8s 1.30 support for rancher-monitoring 
* [#45749](https://github.com/rancher/rancher/issues/45749) k8s 1.30 support for rancher-logging 
* [#45748](https://github.com/rancher/rancher/issues/45748) k8s 1.30 support for prometheus-federator 
* [#45745](https://github.com/rancher/rancher/issues/45745) k8s 1.30 support for system-upgrade-controller
* [#45741](https://github.com/rancher/rancher/issues/45741) k8s 1.30 support for Istio 
* [#45714](https://github.com/rancher/rancher/issues/45714) [BUG] GlobalRole with just `inheritedClusterRoles` and no `rules` doesn't give any permissions
* [#45676](https://github.com/rancher/rancher/issues/45676) Reduce reliance on Rancher Git mirror for running CI tests
* [#45645](https://github.com/rancher/rancher/issues/45645) [BUG] Provisioning RKE1 node-driver cluster fails when extra_env is used for the kube-api service
* [#45635](https://github.com/rancher/rancher/issues/45635) [EPIC] SQLite backed cache in the Steve API - iteration 1
* [#45633](https://github.com/rancher/rancher/issues/45633) Using install-docker script URL from settings.go
* [#45630](https://github.com/rancher/rancher/issues/45630) CA check improvements for `fleet-agent`
* [#45629](https://github.com/rancher/rancher/issues/45629) add helm chart variable to set agent-tls-mode setting
* [#45628](https://github.com/rancher/rancher/issues/45628) add new agent-tls-mode setting
* [#45620](https://github.com/rancher/rancher/issues/45620) Cleanup PSP-related Resources from Rancher-Charts
* [#45605](https://github.com/rancher/rancher/issues/45605) [BUG] cannot drop the username and password of a private registry in the secret cattle-system/cattle-private-registry in the downstream cluster once it is set on RKE1 downstream cluster
* [#45589](https://github.com/rancher/rancher/issues/45589)  add a webhook check for the agent-tls-mode setting
* [#45588](https://github.com/rancher/rancher/issues/45588) [BUG] CIS scan fails on K3s cluster created using ubuntu 24.04 nodes.
* [#45582](https://github.com/rancher/rancher/issues/45582) CA check improvements for `rancher-agent`
* [#45581](https://github.com/rancher/rancher/issues/45581) CA check improvements for `system-agent`
* [#45570](https://github.com/rancher/rancher/issues/45570) [BUG] Steve VAI API returns 500 error when filtering secrets by label selectors
* [#45567](https://github.com/rancher/rancher/issues/45567) [v2.9][ForwardPort] KDM Update for K8s May 2024 patch release
* [#45564](https://github.com/rancher/rancher/issues/45564) [v2.9] Update Shepherd Tag for 1.29 Support
* [#45517](https://github.com/rancher/rancher/issues/45517) [BUG] It is nonstop syncing a roletemplate with a clusterrole
* [#45474](https://github.com/rancher/rancher/issues/45474) k8s 1.29 support for KubeWarden
* [#45473](https://github.com/rancher/rancher/issues/45473) k8s 1.29 support for NeuVector
* [#45472](https://github.com/rancher/rancher/issues/45472) k8s 1.29 support for Longhorn
* [#45471](https://github.com/rancher/rancher/issues/45471) k8s 1.29 support for Harvester-csi-driver
* [#45470](https://github.com/rancher/rancher/issues/45470) k8s 1.29 support for harvester-cloud-provider
* [#45469](https://github.com/rancher/rancher/issues/45469) k8s 1.29 support for gke-operator
* [#45468](https://github.com/rancher/rancher/issues/45468) k8s 1.29 support for eks-operator
* [#45467](https://github.com/rancher/rancher/issues/45467) k8s 1.29 support for aks-operator
* [#45466](https://github.com/rancher/rancher/issues/45466) k8s 1.29 support for Fleet
* [#45465](https://github.com/rancher/rancher/issues/45465) k8s 1.29 support for cis-benchmark 
* [#45464](https://github.com/rancher/rancher/issues/45464) k8s 1.29 support for vsphere-csi 
* [#45463](https://github.com/rancher/rancher/issues/45463) k8s 1.29 support for vsphere-cpi 
* [#45462](https://github.com/rancher/rancher/issues/45462) k8s 1.29 support for system-upgrade-controller 
* [#45439](https://github.com/rancher/rancher/issues/45439) Add support for docker 26.1.x
* [#45377](https://github.com/rancher/rancher/issues/45377) Migrate rancher/rke from Drone to GH Actions
* [#45376](https://github.com/rancher/rancher/issues/45376) Migrate rancher/rke-tools from Drone to GH Actions
* [#45356](https://github.com/rancher/rancher/issues/45356) k8s 1.29 support for rancher-logging-operator
* [#45355](https://github.com/rancher/rancher/issues/45355) k8s 1.29 support for rancher-alerting-drivers
* [#45354](https://github.com/rancher/rancher/issues/45354) k8s 1.29 support for rancher-monitoring
* [#45352](https://github.com/rancher/rancher/issues/45352) k8s 1.29 support for  prometheus-federator
* [#45351](https://github.com/rancher/rancher/issues/45351) k8s 1.29 support for webhook
* [#45350](https://github.com/rancher/rancher/issues/45350) k8s 1.29 support for steve
* [#45349](https://github.com/rancher/rancher/issues/45349) k8s 1.29 support for apiserver
* [#45348](https://github.com/rancher/rancher/issues/45348) k8s 1.29 support for dynamiclistener
* [#45347](https://github.com/rancher/rancher/issues/45347) k8s 1.29 support for norman
* [#45339](https://github.com/rancher/rancher/issues/45339) k8s 1.30 Support for rancher-backup-operator
* [#45338](https://github.com/rancher/rancher/issues/45338) k8s 1.30 Support for rancher-alerting-drivers
* [#45337](https://github.com/rancher/rancher/issues/45337) k8s 1.30 Support for prometheus-federator
* [#45336](https://github.com/rancher/rancher/issues/45336) k8s 1.30 Support for rancher-monitoring
* [#45335](https://github.com/rancher/rancher/issues/45335) k8s 1.30 Support for rancher-logging
* [#45334](https://github.com/rancher/rancher/issues/45334) k8s 1.30 support for DynamicListener
* [#45333](https://github.com/rancher/rancher/issues/45333) k8s 1.30 support in APIServer
* [#45332](https://github.com/rancher/rancher/issues/45332) k8s 1.30 support for Steve
* [#45331](https://github.com/rancher/rancher/issues/45331) k8s 1.30 support for Webhook
* [#45325](https://github.com/rancher/rancher/issues/45325) [Maintenance] Bump Go in `wins` to 1.20+
* [#45324](https://github.com/rancher/rancher/issues/45324) [RFE] Update Wrangler to use 1.30
* [#45320](https://github.com/rancher/rancher/issues/45320) [v2.9] Rancher logging does not work on windows nodes when using `logging-operator:4.4.0`
* [#45309](https://github.com/rancher/rancher/issues/45309) [BUG] Errors while removing an etcd member can cause RKE to try to remove the member indefinitely
* [#45301](https://github.com/rancher/rancher/issues/45301) [RFE] Update gengo to v2 in Norman to support K8s 1.30
* [#45289](https://github.com/rancher/rancher/issues/45289) Ubuntu 24.04 validations on v2.9
* [#45232](https://github.com/rancher/rancher/issues/45232) Migrate DynamicListener CI To Github Actions
* [#45230](https://github.com/rancher/rancher/issues/45230) Migrate Steve CI To Github Actions
* [#45229](https://github.com/rancher/rancher/issues/45229) Migrate Norman CI To Github Actions
* [#45228](https://github.com/rancher/rancher/issues/45228) Migrate APIServer CI To Github Actions
* [#45227](https://github.com/rancher/rancher/issues/45227) Migrate Lasso CI To Github Actions
* [#45226](https://github.com/rancher/rancher/issues/45226) Migrate Wrangler CI To Github Actions
* [#45219](https://github.com/rancher/rancher/issues/45219) [Forward Port] - [v2.9] Bump Windows Containers throughout Rancher
* [#45216](https://github.com/rancher/rancher/issues/45216) [RFE] Lasso Support for 1.30
* [#45205](https://github.com/rancher/rancher/issues/45205) [BUG] rancher/rancher changes break UI tests
* [#45199](https://github.com/rancher/rancher/issues/45199) [BUG] Unable to Add Cloud Credentials in Rancher
* [#45173](https://github.com/rancher/rancher/issues/45173) [BUG] Inadvertent removal of SSH from `rancher/machine`
* [#45158](https://github.com/rancher/rancher/issues/45158) [BUG] Schema Definitions returns a 503 for certain resource types
* [#45157](https://github.com/rancher/rancher/issues/45157) [BUG] Schema Definitions are missing formation for RKE Config on the provisioning cluster
* [#45154](https://github.com/rancher/rancher/issues/45154) [Forwardport v2.9] Add endpointslice dependency
* [#45107](https://github.com/rancher/rancher/issues/45107) [RFE] add the ability to customize the link and primary ui colors on Rancher UI login/logout screens
* [#45105](https://github.com/rancher/rancher/issues/45105) [2.9][ForwardPort] KDM Update for K8s April 2024 patch release
* [#45099](https://github.com/rancher/rancher/issues/45099) Version pinning for `rancher-provisioning-capi` chart
* [#45090](https://github.com/rancher/rancher/issues/45090) Update CAPI in Rancher to 1.7.1+
* [#45089](https://github.com/rancher/rancher/issues/45089) [Feature] K8s 1.30 Support
* [#45075](https://github.com/rancher/rancher/issues/45075) [RFE] Add active remotedialer connections dashboard to rancher-monitoring's "Performance debugging" dashboard
* [#45061](https://github.com/rancher/rancher/issues/45061) [BUG - 2.9] provisioning 1.28 not working with rke1: ` GetDefaultKubernetesServicesOptions: No serviceOptions found for cluster version [v1.28.7-rancher1-1] or cluster major version [v1.28]`
* [#45038](https://github.com/rancher/rancher/issues/45038) [RFE] Option to provide data-dir for RKE2 provisioned by Rancher
* [#45015](https://github.com/rancher/rancher/issues/45015) [BUG] Remove clusterauthtokens in the controller's handler when the corresponding orphaned clusteruserattribute is deleted
* [#45013](https://github.com/rancher/rancher/issues/45013) Add support for docker 26.0.x
* [#45009](https://github.com/rancher/rancher/issues/45009) [RFE] Migrate Microsoft Graph API client from manicminer/hamilton to microsoftgraph/msgraph-sdk-go
* [#45004](https://github.com/rancher/rancher/issues/45004) [BUG] can't enable Azure AD because there is a timeout when our login code tries to do a simple GET on the user
* [#44984](https://github.com/rancher/rancher/issues/44984) Update Nutanix node driver to version 3.6.0 / rancher 2.9
* [#44969](https://github.com/rancher/rancher/issues/44969) Update lasso controller runtime to v0.16.5
* [#44949](https://github.com/rancher/rancher/issues/44949) [v2.9] Windows cluster in an airgap setup doesn't properly get catalog apps. User is unable to install apps to windows cluster in airgap
* [#44931](https://github.com/rancher/rancher/issues/44931) [BUG] Node Driver RKE1 Cluster: Unable to provision RKE1 Amazon EC2 cluster when using most recent k8s version (v1.28.7-rancher1-1)
* [#44924](https://github.com/rancher/rancher/issues/44924) [Port v2.9] cluster deploy running excessively and taking a long time to execute
* [#44922](https://github.com/rancher/rancher/issues/44922) [v2.9][1.29] Remove PSP enablement for RKE2 and K3s (imported clusters)
* [#44914](https://github.com/rancher/rancher/issues/44914) [BUG] Remove the clusteruserattribute in the controller's handler when the corresponding userattribute no longer exists.
* [#44902](https://github.com/rancher/rancher/issues/44902) Ensure RKE1 / KDM for Rancher v2.9 include all relevant changes from v2.8
* [#44863](https://github.com/rancher/rancher/issues/44863) Automation for adding support for new Docker versions
* [#44860](https://github.com/rancher/rancher/issues/44860) [BUG] Cluster Role Templates can be set with projectCreatorDefault: true
* [#44857](https://github.com/rancher/rancher/issues/44857) Support for Azure external cloud provider for downstream RKE1 clusters
* [#44856](https://github.com/rancher/rancher/issues/44856) Support for Azure external cloud provider for downstream RKE2 clusters
* [#44845](https://github.com/rancher/rancher/issues/44845) Shibboleth + LDAP small error when searching user and groups (shibbolethconfig-serviceAccountPassword)
* [#44840](https://github.com/rancher/rancher/issues/44840) [RFE] Update CODEOWNERS for Framework Repos 
* [#44812](https://github.com/rancher/rancher/issues/44812) [BUG] Rancher CLI panics when trying to kubectl after a login #44811
* [#44793](https://github.com/rancher/rancher/issues/44793) [BUG] ClusterAlertRules keep getting recreated
* [#44907](https://github.com/rancher/rancher/issues/44907) Some members with Github as Auth Provider could not be shown in cluster member list
* [#44725](https://github.com/rancher/rancher/issues/44725) [BUG] Rancher Monitoring - Unable to specify private registries for all images
* [#44724](https://github.com/rancher/rancher/issues/44724) [BUG] Links leading to 404 errors
* [#44714](https://github.com/rancher/rancher/issues/44714) [Forwardport v2.9] [BUG] RKE2/K3S registration command not working on airgap setup
* [#44679](https://github.com/rancher/rancher/issues/44679) [Forwardport] [2.9] COREDNS deployment manifest replicas: 1 in kontainer-driver-metadata will make cluster unstable during upgrade
* [#44658](https://github.com/rancher/rancher/issues/44658) v2.9 [RFE] [RBAC] Upgrade Golang and the net package to fix CVE-2023-44487
* [#44649](https://github.com/rancher/rancher/issues/44649) [BUG] Rancher pods are restarted too often
* [#44638](https://github.com/rancher/rancher/issues/44638) [BUG] Cluster member cannot create/list projects using public API
* [#44634](https://github.com/rancher/rancher/issues/44634) [BUG] Cattle Agent Instability -- Unable to cancel request for *client.addQuery
* [#44630](https://github.com/rancher/rancher/issues/44630) [BUG] Fleet controller can't provision local cluster immediately
* [#44618](https://github.com/rancher/rancher/issues/44618) [RFE] Improve handling of `dynamicSchemaSpec`
* [#44614](https://github.com/rancher/rancher/issues/44614) [RFE] Rebase monitoring to upstream version 50.x
* [#44613](https://github.com/rancher/rancher/issues/44613) [BUG] Rancher is restarted in loop after a restore
* [#44605](https://github.com/rancher/rancher/issues/44605) [RFE] Update monitoring to use prometheus 2.45
* [#44598](https://github.com/rancher/rancher/issues/44598) [2.9 Forwardport] rancher-logging k8s 1.28 chart support
* [#44577](https://github.com/rancher/rancher/issues/44577) [RFE] Add settings to customize login and landing page for non-logged in parameters to be passed to UI
* [#44569](https://github.com/rancher/rancher/issues/44569) [v2.9] `sriov` chart K8s 1.28 support
* [#44552](https://github.com/rancher/rancher/issues/44552) [Documentation] Clarify expected monitoring views based on user roles.
* [#44472](https://github.com/rancher/rancher/issues/44472) [v2.9] KDM Update for K8s February patch release
* [#44439](https://github.com/rancher/rancher/issues/44439) [RFE] Add support for separate UI banner settings
* [#44409](https://github.com/rancher/rancher/issues/44409) [RFE] Upgrade alert manager to 0.26.x
* [#44388](https://github.com/rancher/rancher/issues/44388) Add docker version v25.0.x
* [#44359](https://github.com/rancher/rancher/issues/44359) [BUG] Rancher logs spamming error: "failed to write audit log"
* [#44351](https://github.com/rancher/rancher/issues/44351) Add managed annotation to Chart.yaml in fleet helm charts
* [#44332](https://github.com/rancher/rancher/issues/44332) [BUG] CLI panics when trying to `kubectl` after a login
* [#44289](https://github.com/rancher/rancher/issues/44289) [v2.9] RKE1 - Update containerd and runc
* [#44267](https://github.com/rancher/rancher/issues/44267) [BUG] [Release] The script for promoting charts to stable is broken
* [#44226](https://github.com/rancher/rancher/issues/44226) Migrate to lighter base images
* [#44210](https://github.com/rancher/rancher/issues/44210) [Research Spike] K8s 1.30 Support
* [#44208](https://github.com/rancher/rancher/issues/44208) [RFE] rancher-monitoring use the deprecated API v2beta2.HorizontalPodAutoscaler and block k8s update to 1.26
* [#44202](https://github.com/rancher/rancher/issues/44202) [ForwardPort] [v2.9] KDM Update for K8s January patch release #44086
* [#44197](https://github.com/rancher/rancher/issues/44197) [BUG] - Monitoring chart install error throws undefined variable "$forceHTTPSScheme" on Rancher v2.9-head
* [#44179](https://github.com/rancher/rancher/issues/44179) [BUG] Default RKE1 Node template image for Linode fails to provision w/ `Error installing Docker:`
* [#44168](https://github.com/rancher/rancher/issues/44168) [BUG] kontainer-engine-driver-lke consistently fails to start
* [#44140](https://github.com/rancher/rancher/issues/44140) [BUG] RKE1 Cluster keeps constantly reconciling when secrets encryption is enabled
* [#44092](https://github.com/rancher/rancher/issues/44092) RKE2 and K3S - KDM Update for K8s Jan/Feb/Mar/Apr 2024 patch release for Rancher 2.9
* [#44090](https://github.com/rancher/rancher/issues/44090) [SURE-7356] Rancher pods memory increasing over time
* [#44015](https://github.com/rancher/rancher/issues/44015) [Forwardport 2.9] Add unit tests for AD GUID unmigration
* [#44010](https://github.com/rancher/rancher/issues/44010) [Forwardport] Additional trusted CAs doesn't apply to keycloak oidc
* [#44009](https://github.com/rancher/rancher/issues/44009) [RFE] Remove deprecated setting kubeconfig-token-ttl-minutes from v3 and v1 API
* [#44007](https://github.com/rancher/rancher/issues/44007) [2.9] custom rke2 cluster upgraded to v1.26.8+rke2r1 has issues with limitranges and clusterauthtokens 
* [#43991](https://github.com/rancher/rancher/issues/43991) [BUG] System-agent proceeds with installation despite failing to download connection info
* [#43988](https://github.com/rancher/rancher/issues/43988) Forwardport [v2.9] Update ACI-CNI to 6.0.3.2
* [#43978](https://github.com/rancher/rancher/issues/43978) Add 0.4.2 version of prometheus federator
* [#43964](https://github.com/rancher/rancher/issues/43964) [Forwardport 2.9][BUG] [CAPR] rancher-system-agent can be restarted during an etcd restoration operation which will lead to inconsistent results 
* [#43963](https://github.com/rancher/rancher/issues/43963) [Forwardport 2.9] system-upgrade-controller k8s 1.28 chart support
* [#43948](https://github.com/rancher/rancher/issues/43948) [Forwardport v2.9] [rke1 etcd restore] unable to restore etcd snapshot
* [#43947](https://github.com/rancher/rancher/issues/43947) [Forwardport v2.9] [BUG] Unnecessary node restart during vSphere provisioning on RHEL 8.8
* [#43946](https://github.com/rancher/rancher/issues/43946) [Forwardport v2.9] [BUG] Scaling provisioned nodes is unreliable not successful in certain cases
* [#43945](https://github.com/rancher/rancher/issues/43945) [Forwardport v2.9] [Feature] K8s 1.28 Support
* [#43942](https://github.com/rancher/rancher/issues/43942) [Forwardport 2.9][BUG] Downstream RKE1 Digital Ocean cluster fails to provision with Ubuntu 22.04 image
* [#43932](https://github.com/rancher/rancher/issues/43932) [BUG] Environment variables `https_proxy` and `no_proxy` are not correctly set in windows worker nodes of `custom` type `downstream` `RKE2` cluster with *Agent Environment Vars* `http_proxy`, `https_proxy` and `no_proxy`
* [#43911](https://github.com/rancher/rancher/issues/43911) [Forwardport - v2.9] [BUG] Rancher can't start on air-gapped environments
* [#43899](https://github.com/rancher/rancher/issues/43899) [ForwardPort] [v2.9] [RFE] Add CIS-1.8 (k8s v1.26) Scan capability #43898
* [#43895](https://github.com/rancher/rancher/issues/43895) [Forwardport] [v2.9] [BUG] RKE1 Node driver cluster creation fails on SLE-15-SP5 and SP4
* [#43864](https://github.com/rancher/rancher/issues/43864) [2.9] custom rke2 cluster upgraded to v1.26.8+rke2r1 has issues with limitranges and clusterauthtokens
* [#43863](https://github.com/rancher/rancher/issues/43863) Complete branching steps for Rancher 2.9 for system-upgrade-controller
* [#43862](https://github.com/rancher/rancher/issues/43862) Complete branching steps for Rancher 2.9 for Windows GSMA
* [#43861](https://github.com/rancher/rancher/issues/43861) Complete branching steps for Rancher 2.9 for webhook
* [#43860](https://github.com/rancher/rancher/issues/43860) Complete branching steps for Rancher 2.9 for Vsphere
* [#43859](https://github.com/rancher/rancher/issues/43859) Complete branching steps for Rancher 2.9 for Provisioning CAPI
* [#43855](https://github.com/rancher/rancher/issues/43855) Complete branching steps for Rancher 2.9 for CIS Benchmark
* [#43852](https://github.com/rancher/rancher/issues/43852) Complete branching steps for Rancher 2.9 for GKE Operator
* [#43851](https://github.com/rancher/rancher/issues/43851) Complete branching steps for Rancher 2.9 for EKS Operator
* [#43850](https://github.com/rancher/rancher/issues/43850) Complete branching steps for Rancher 2.9 for AKS Operator
* [#43837](https://github.com/rancher/rancher/issues/43837) Complete branching steps for Rancher 2.9 for Fleet 
* [#43831](https://github.com/rancher/rancher/issues/43831) Branching Exercise for rancher/charts
* [#44097](https://github.com/rancher/rancher/issues/44097) Kubernetes 1.29 support for Backup/Restore Operator
* [#43728](https://github.com/rancher/rancher/issues/43728) rancher-webhook k8s 1.28 chart support
* [#43690](https://github.com/rancher/rancher/issues/43690) [Feature] k8s 1.29 support - apps and feature charts
* [#43686](https://github.com/rancher/rancher/issues/43686) [BUG] rancher machines are not removed from the cluster after actual worker nodes removed
* [#43668](https://github.com/rancher/rancher/issues/43668) [BUG] OIDCConfig.Scopes struct field tag is not compatible with reflect.StructTag.Get
* [#43621](https://github.com/rancher/rancher/issues/43621) Update Rancher Webhook Docs page
* [#43619](https://github.com/rancher/rancher/issues/43619) Remove CAPI webhook from rancher/webhook
* [#43618](https://github.com/rancher/rancher/issues/43618)  [BUG] Update Wrangler to v2 tag
* [#43594](https://github.com/rancher/rancher/issues/43594) [RFE] Bump Harvester node driver to v0.6.7
* [#43587](https://github.com/rancher/rancher/issues/43587) [BUG] Cannot set custom Node Name for Windows worker nodes
* [#43585](https://github.com/rancher/rancher/issues/43585) [RFE] Add v2prov integration tests to KDM
* [#43577](https://github.com/rancher/rancher/issues/43577) Bump wins.exe dependency to v0.4.14
* [#43534](https://github.com/rancher/rancher/issues/43534) Need to bump Go to version v1.21 in KDM and Provisioning repos.
* [#43515](https://github.com/rancher/rancher/issues/43515) [BUG] Cluster Agent restarts because of concurrent map write
* [#43495](https://github.com/rancher/rancher/issues/43495) [RFE] vSphere CPI chart updates to upstream v1.28.0 / v1.23.5 / v1.22.9 (incl. K8s 1.28 support)
* [#43494](https://github.com/rancher/rancher/issues/43494) [RFE] vSphere CSI chart updates to upstream v3.0.3 / v1.27.3 (incl. K8s 1.28 support)
* [#43356](https://github.com/rancher/rancher/issues/43356) Unable scale an RKE1 cluster from 1 to 3 etcd nodes or nodes with etcd role
* [#43292](https://github.com/rancher/rancher/issues/43292) [BUG] removing permission from role template doesn't propagate to 'promoted' clusterRole in downstream cluster
* [#43380](https://github.com/rancher/rancher/issues/43380) [BUG] rancher-monitoring-crd Helm lint fails on rancher-monitoring-crd chart
* [#43150](https://github.com/rancher/rancher/issues/43150) [BUG] Built-in PSACT `rancher-restricted` is not updated to the new version after Rancher is upgraded
* [#43131](https://github.com/rancher/rancher/issues/43131) [RFE]  Feature flag to have RKE1 disabled 
* [#44177](https://github.com/rancher/rancher/issues/44177) [Documentation] Rancher read-only project member seeing 403 errors for monitoring endpoints in console
* [#43113](https://github.com/rancher/rancher/issues/43113) [flaky-test] test_globalrolebinding_finalizer_cleanup
* [#43110](https://github.com/rancher/rancher/issues/43110) [Feature] K8s 1.29 Support
* [#43103](https://github.com/rancher/rancher/issues/43103) [RFE] Label deprecated setting kubeconfig-token-ttl-minutes from v3 and v1 API for future removal
* [#43097](https://github.com/rancher/rancher/issues/43097) [BUG] Cluster breaks when scaling down etcd nodes in an RKE2 cluster
* [#43090](https://github.com/rancher/rancher/issues/43090) Allow extensions to load before login
* [#43089](https://github.com/rancher/rancher/issues/43089) Remove the need to install ui-plugin-operator
* [#42971](https://github.com/rancher/rancher/issues/42971) Document expected failures for file permission issues on RKE and RKE2 Clusters when running CIS Scan
* [#43036](https://github.com/rancher/rancher/issues/43036) Not able to see the apps in the rancher ui
* [#42940](https://github.com/rancher/rancher/issues/42940) [RFE] Add optional filter on AzureAD auth group memberships
* [#42939](https://github.com/rancher/rancher/issues/42939) [RFE] Rancher CLI doesn't have a driver for AzureAD for authenticating with kubectl
* [#43383](https://github.com/rancher/rancher/issues/43383) [RFE] Update logging-operator to version 4.2+
* [#42904](https://github.com/rancher/rancher/issues/42904) [BUG] If project namespace is terminating, creating a CRTB produces an error in the logs
* [#42582](https://github.com/rancher/rancher/issues/42582) [BUG] Scaling down etcd machine pool can cause multiple machines to be deleted unintentionally
* [#42298](https://github.com/rancher/rancher/issues/42298) [BUG] Need Updated CSI-Proxy to Address Windows Volume Mount Issue
* [#42218](https://github.com/rancher/rancher/issues/42218) [RFE]  Validate that the new "Status" field cannot be changed by users with standard permissions.
* [#42217](https://github.com/rancher/rancher/issues/42217) [RFE] Add new "Status" field
* [#42216](https://github.com/rancher/rancher/issues/42216) [RFE] Add webhook escalation check for "NamespacedRules" field
* [#42215](https://github.com/rancher/rancher/issues/42215) [RFE] Add new "NamespacedRules" field.
* [#42207](https://github.com/rancher/rancher/issues/42207) [SURE-6567] Monitoring v102.0.0+up40.1.2/v102.0.1+up40.1.2 - Grafana Dashboard "Rancher/pod(containers)" showing empty values in Rancher 2.7.3/2.7.4
* [#42170](https://github.com/rancher/rancher/issues/42170) [RFE] Fleet RBAC in Rancher
* [#41964](https://github.com/rancher/rancher/issues/41964) OIDC Implementation planning
* [#43402](https://github.com/rancher/rancher/issues/43402) [BUG] [KSM/Kubelet] Bugs in templating of metricRelabelings icw cluster{Id|Name}
* [#41832](https://github.com/rancher/rancher/issues/41832) [BUG] Enabling ACE after cluster provisioning results in unusable kubeconfig contexts
* [#41809](https://github.com/rancher/rancher/issues/41809) [SURE-7122] Excessive WebSocket activity when watching resources with permission by name
* [#41662](https://github.com/rancher/rancher/issues/41662) [BUG] Creating/updating cluster with RKE1 template containing private registry with empty password causes panic
* [#41534](https://github.com/rancher/rancher/issues/41534) Windows node stuck at wins.exe on airgapped env
* [#41321](https://github.com/rancher/rancher/issues/41321) Missing the vSphere CSI Snapshotter sidecar - blockSnapshots will never work
* [#41301](https://github.com/rancher/rancher/issues/41301) [RFE] Improve Steve Schemas performance
* [#43413](https://github.com/rancher/rancher/issues/43413) [BUG] CRDs not updated when upgrading to rancher-monitoring 102.0.0+up40.1.2
* [#40584](https://github.com/rancher/rancher/issues/40584) [BUG] Rancher RoleTemplate CRD does not validate roles properly
* [#40484](https://github.com/rancher/rancher/issues/40484) [BUG] RoleTemplate Sync can not handle semantic differences.
* [#40303](https://github.com/rancher/rancher/issues/40303) [BUG] statefulset/scale is not default granted permission
* [#40227](https://github.com/rancher/rancher/issues/40227) [BUG] rancher-machine sends data to bugsnag.com without user consent
* [#39060](https://github.com/rancher/rancher/issues/39060) [BUG] vSphere RKE2 node driver windows cluster with cloud provider enabled fails to bring windows worker node to active state.
* [#39700](https://github.com/rancher/rancher/issues/39700) Project "Container Default Resource Limit" settings allow you to define a default reservation greater than the default limit
* [#38490](https://github.com/rancher/rancher/issues/38490) [SURE-7621] RKE2 + Calico + Project Network Isolation - Networkpolicies hn-nodes contain wrong node IP addresses
* [#37328](https://github.com/rancher/rancher/issues/37328) Remove Alerts and Notifiers v1
* [#31967](https://github.com/rancher/rancher/issues/31967) login command doesn't create cli2.json file
* [#29105](https://github.com/rancher/rancher/issues/29105) Ability to use an OCI Helm Chart Registry on a Rancher Catalog
* [#24343](https://github.com/rancher/rancher/issues/24343) Rancher-Monitoring: Query on Cluster Grafana Dashboard reports incorrect values
* [#22417](https://github.com/rancher/rancher/issues/22417) Support authentication with service account tokens
* [#20793](https://github.com/rancher/rancher/issues/20793) Logging: Add option for fluentd log level in helm chart
* [#10053](https://github.com/rancher/rancher/issues/10053) Support OpenID Connect providers (like Google)
-----
