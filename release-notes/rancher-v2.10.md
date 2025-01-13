| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.10.1](rancher-v2.10.md#release-v2101) | Dec 19 2024 | 12/19/24 | 2024-12-19 |
| [v2.10.0](rancher-v2.10.md#release-v2100) | Nov 19 2024 | 11/19/24 | 2024-11-19 |



# Release v2.10.1

> [!CAUTION]
> **Note:** If you are using Active Directory Federation Service (AD FS) upgrading to Rancher v2.10.1 or later may cause issues with authentication caused by the AD FS Relying Party Trust not being able to pick up a signature verification certificate from the metadata, that requires manual intervention. This can be corrected by either trying to update Relying Party Trust information from federation metadata (Relying Party Trust -> Update from Federation Metadata...) or by directly adding the certificate (Relying Party Trust -> Properties -> Signature tab -> Add -> Select the certificate). For more information see #48655.

> **Important:** Review the Install/Upgrade Notes before upgrading to any Rancher version.

Rancher v2.10.1 is the latest patch release of Rancher. This is a Community and Prime version release that introduces maintenance updates and bug fixes.
For more information on new features in the general minor release see the [v2.10.0 release notes](https://github.com/rancher/rancher/releases/tag/v2.10.0).

## Cluster Provisioning

### Major Bug Fixes

- Fixed a file permission issue where after upgrading to Rancher v2.9.3 or newer and deleting a node (i.e., scaling down a node pool) that was present before the upgrade would result in the node being removed from Rancher and the downstream cluster, but the underlying virtual machine is not removed from the infrastructure provider. See [#48341](https://github.com/rancher/rancher/issues/48341).
- Fixed how ClusterIPs with IPv6 addresses were being handled incorrectly, which led to IPv6-based deployments getting `waiting for cluster agent to connect`. See [#43878](https://github.com/rancher/rancher/issues/43878).

## K3s Provisioning

### Major Bug Fixes

- Fixed an issue where upgrading the K8s version of the downstream node driver and custom K3s clusters may result in an etcd node reporting `NodePressure`, and eventually the `rancher-system-agent` reporting failures to execute plans. If this issue is encountered, it can be resolved by performing a `systemctl restart k3s.service` on the affected etcd-only nodes. See [#48096](https://github.com/rancher/rancher/issues/48096).

## RKE2 Provisioning

### Known Issues

- Clusters containing nodes with split etcd and control plane roles may fail to reconcile when upgrading Rancher. The following can be seen repeatedly in the control plane logs:

  ```
  time="(timestamp)" level=info msg="Starting rke2 v1.28.15+rke2r1 (96bb2a62fad8cb938a1761286b1d896623ac7014)"
  time="(timestamp)" level=fatal msg="starting kubernetes: preparing server: failed to get CA certs: Get \"https://(etcd-init-node-ip):9345/cacerts\": context deadline exceeded (Client.Timeout exceeded while awaiting headers)"
  ...
  Failed to start Rancher Kubernetes Engine v2 (server).
  rke2-server.service: Scheduled restart job, restart counter is at 173.
  Stopped Rancher Kubernetes Engine v2 (server).
  ```

  In the event that a control plane node gets stuck during a Rancher upgrade, perform a `systemctl restart rke2-server.service` on the stuck control plane node, and then the etcd node that it is joined to (specified via the `"server"` field in `/etc/rancher/rke2/config.yaml.d/50-rancher.yaml`). This results in the cluster reconciling as normal.

  See [#48389](https://github.com/rancher/rancher/issues/48389).

## Rancher CLI

### Known Issues

- The Rancher CLI uses dedicated HTTP clients in login and SSH commands to download certificates and an SSH key respectively. However, the CLI currently does not respect proxy settings and does not set an HTTP timeout. See [#48321](https://github.com/rancher/rancher/issues/48321).

## Rancher App (Global UI)

### Major Bug Fixes

- This release includes a major upgrade to the Dashboard (Cluster Explorer) Vue framework from Vue 2 to Vue 3. Please view our documentation on updating existing UI extensions to be compliant with the Rancher v2.10 UI framework in the [v2.10.0 UI extension changelog](https://extensions.rancher.io/extensions/next/rancher-2.10-support). If experiencing a page that fails to load please file an issue via the [Dashboard repository](https://github.com/rancher/dashboard/issues/new/choose) and choose the "Bug report" option for us to further investigate. See [#7653](https://github.com/rancher/dashboard/issues/7653).

- As part of the Dashboard Vue framework transition to Vue 3 introduced in Rancher v2.10.0, [a migration script](https://extensions.rancher.io/extensions/next/rancher-2.10-support) was developed to allow extension developers to easily migrate their extensions to the minimum required setup required. A number of fixes and enhancements have been made to this script:
  - Added a completion log to inform user to install dependencies.
  - Resolved build errors that would appear after running the migration script by updating the libraries used.
  - Fixed an issue where resolutions were not updating properly.

  See [#12656](https://github.com/rancher/dashboard/issues/12656).

### Known Issues

- Users are able to create or edit clusters even when using an invalid Add-on YAML configuration. See [#12466](https://github.com/rancher/dashboard/issues/12466).

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

Please note, EOL for RKE is July 31st, 2025. Prime customers must replatform from RKE to RKE2 or K3s.

RKE2 and K3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about replatforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Images

- rancher/rancher:v2.10.1

## Tools

- CLI - [v2.10.1](https://github.com/rancher/cli/releases/tag/v2.10.1)
- RKE - [v1.7.1](https://github.com/rancher/rke/releases/tag/v1.7.1)

## Kubernetes Versions for RKE

- v1.31.3 (Default)
- v1.30.7
- v1.29.11
- v1.28.15

## Kubernetes Versions for RKE2/K3s

- v1.31.3 (Default)
- v1.30.7
- v1.29.11
- v1.28.15

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

## Previous Rancher Behavior Changes - Rancher General

- **Rancher v2.10.0:**
  - Kubernetes v1.27 is no longer supported. Before you upgrade to Rancher v2.10.0, make sure that all clusters are running Kubernetes v1.28 or later. See [#47591](https://github.com/rancher/rancher/issues/47591).
  - The new annotation `field.cattle.io/creator-principal-name` was introduced in addition to the existing `field.cattle.io/creatorId` that allows specifying the creator's principal name when creating a cluster or a project. If this annotation is used, the `userPrincipalName` field of the corresponding `ClusterRoleTemplateBinding` or `ProjectRoleTemplateBinding` will be set to the specified principal. The principal should belong to the creator's user, which is enforced by the webhook. See [#46828](https://github.com/rancher/rancher/issues/46828).
  - When searching for group principals with a SAML authentication provider (with LDAP turned off), Rancher now returns a principal of correct type (group) with the name matching the search term. When searching principals with a SAML provider (with LDAP turned off) without specifying the desired type (as in Add cluster/project member), Rancher now returns both user and group principals with the name matching the search term. See [#44441](https://github.com/rancher/rancher/issues/44441).
  - Rancher now captures the last used time for Tokens and stores it in the `lastUsedAt` field. If the Authorized Cluster Endpoint is enabled and used on a downstream cluster Rancher captures the last used time in the `ClusterAuthToken` object and makes the best effort to sync it back to the corresponding Token in the upstream. See [#45732](https://github.com/rancher/rancher/issues/45732).
  - Rancher deploys the System Upgrade Controller (SUC) to facilitate Kubernetes upgrades for imported RKE2/K3s clusters. Starting with this version, the mechanism used to deploy this component in downstream clusters has transitioned from legacy V1 apps to fully supported V2 apps, providing a seamless upgrade process for Rancher. For more details, please see this [issue comment](https://github.com/rancher/rancher/issues/42448#issuecomment-2477309567).

## Previous Rancher Behavior Changes - Rancher CLI

- **Rancher v2.10.0:**
  - The deprecated subcommand `globaldns` was removed from the Rancher CLI. See [#48127](https://github.com/rancher/rancher/issues/48127).

## Previous Rancher Behavior Changes - Rancher App (Global UI)

- **Rancher v2.10.0:**
  - This release includes a major upgrade to the Dashboard (Cluster Explorer) Vue framework from Vue 2 to Vue 3. Please view our documentation on updating existing UI extensions to be compliant with the Rancher v2.10 UI framework in the [v2.10.0 UI extension changelog](https://extensions.rancher.io/extensions/next/rancher-2.10-support). If experiencing a page that fails to load please file an issue via the [Dashboard repository](https://github.com/rancher/dashboard/issues/new/choose) and choose the "Bug report" option for us to further investigate. See [#7653](https://github.com/rancher/dashboard/issues/7653).
  - The performance of the Clusters lists in the Home page and the Side Menu has greatly improved when there are hundreds of clusters. See [#11995](https://github.com/rancher/dashboard/issues/11995) and [#11993](https://github.com/rancher/dashboard/issues/11993).
  - The previous Dashboard Ember UI (Cluster Manager) will no longer be directly accessible. The relative pages that rely on the previous UI will continue to be embedded in the new Vue UI (Cluster Explorer). See [#11371](https://github.com/rancher/dashboard/issues/11371).
  - Updated the data directory configuration by replacing the checkbox option with 3 user input options below:
    1. `Use default data directory configuration`
    2. `Use a common base directory for data directory configuration (sub-directories will be used for the system-agent, provisioning and distro paths)` - This option displays a text input where users can enter a base directory for all 3 subdirectories which Rancher programmatically appends to the correct subdirectories.
    3. `Use custom data directories` - This option displays 3 text inputs, one for each subdirectory type where users can input each path individually.

    See [#11560](https://github.com/rancher/dashboard/issues/11560).

## Previous Rancher Behavior Changes - RKE Provisioning

- **Rancher v2.10.0:**
  - With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

    Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must replatform from RKE to RKE2 or K3s.

    RKE2 and K3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about replatforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Previous Rancher Behavior Changes - Virtualization (Harvester)

- **Rancher v2.10.0:**
  - On the Cloud Credential list, you can now easily see if a Harvester Credential is about to expire or has expired and choose to renew it. You will also be notified on the Cluster Management Clusters list when an associated Harvester Cloud Credential is about to expire or has expired. When upgrading, an existing expired Harvester Credential will not contain a warning. You can still renew the token on the resources menu. See [#11332](https://github.com/rancher/dashboard/issues/11332).

## Previous Rancher Behavior Changes - Windows

- **Rancher v2.10.0:**
  - Rancher v2.10.0 includes changes to how Windows nodes behave post node reboot, as well as provides two new settings to control how Windows services created by Rancher behave on startup.

    Two new agent environment variables have been added for Windows nodes, `CATTLE_ENABLE_WINS_SERVICE_DEPENDENCY` and `CATTLE_ENABLE_WINS_DELAYED_START`. These changes can be configured in the Rancher UI, and will be respected by all nodes running `rancher-wins` version `v0.4.20` or greater.

    - `CATTLE_ENABLE_WINS_SERVICE_DEPENDENCY` defines a service dependency between RKE2 and `rancher-wins`, ensuring RKE2 will not start before `rancher-wins`.
    - `CATTLE_ENABLE_WINS_DELAYED_START` changes the start type of `rancher-wins` to `AUTOMATIC (DELAYED)`, ensuring it starts after other Windows services.

    Additionally, Windows nodes will now attempt to execute plans multiple times if the initial application fails, up to 5 times. This change, as well as appropriate use of the above two agent environment variables, aims to address plan failures for Windows nodes after a node reboot.

    See [#42458](https://github.com/rancher/rancher/issues/42458).
  - A change was made starting with RKE2 versions `v1.28.15`, `v1.29.10`, `v1.30.6` and `v1.31.2` on Windows which allows the user to configure `*_PROXY` environment variables on the `rke2` service after the node has already been provisioned.

    Previously any attempt to do so would be a no-op. With this change, If the `*_PROXY` environment variables are set on the cluster _after_ a Windows node is provisioned, they can be automatically removed from the `rke2` service. However, if the variables are set _before_ the node is provisioned, they cannot be removed.

    More information can be found [here](https://github.com/rancher/rancher/issues/47839). A workaround is to remove the environment variables from the `rancher-wins` service and restart the service or node. At which point `*_PROXY` environment variables will no longer be set on either service.

    ```shell
    Remove-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\rancher-wins -Name Environment
    Restart-Service rancher-wins
    ```

    See [#47544](https://github.com/rancher/rancher/issues/47544).

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.8.1:**
  - When you  attempt to register a new etcd/controlplane node in a CAPR-managed cluster after a failed etcd snapshot restoration, the node can become stuck in a perpetual paused state, displaying the error message `[ERROR]  000 received while downloading Rancher connection information. Sleeping for 5 seconds and trying again`. As a workaround, you can unpause the cluster by running `kubectl edit clusters.cluster clustername -n fleet-default` and set `spec.unpaused` to `false`.  See [#43735](https://github.com/rancher/rancher/issues/43735).
- **Rancher v2.7.2:**
  - If you upgrade or update any hosted cluster, and go to **Cluster Management > Clusters** while the cluster is still provisioning, the **Registration** tab is visible. Registering a cluster that is already registered with Rancher can cause data corruption. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - RKE Provisioning

- **Rancher v2.9.0:**
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated, due to the plugin being deprecated for upstream Kubernetes v1.27 and later. RKE creation will not go through as it will raise a validation warning. See [#11322](https://github.com/rancher/dashboard/issues/11322).

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.9.0:**
  - When adding the `provisioning.cattle.io/allow-dynamic-schema-drop` annotation through the cluster config UI, the annotation disappears before adding the value field. When viewing the YAML, the respective value field is not updated and is displayed as an empty string. As a workaround, when creating the cluster, set the annotation by using the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11435](https://github.com/rancher/dashboard/issues/11435).
- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).

## Long-standing Known Issues - Rancher App (Global UI)

- **Rancher v2.9.2**:
  - Although system mode node pools must have at least one node, the Rancher UI allows a minimum node count of zero. Inputting a zero minimum node count through the UI can cause cluster creation to fail due to an invalid parameter error. To prevent this error from occurring, enter a minimum node count at least equal to the node count. See [#11922](https://github.com/rancher/dashboard/issues/11922).
- **Rancher v2.7.7**:
  - When creating a cluster in the Rancher UI it does not allow the use of an underscore `_` in the `Cluster Name` field. See [#9416](https://github.com/rancher/dashboard/issues/9416).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - EKS

- **Rancher v2.7.0:**
  - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. See [#39392](https://github.com/rancher/rancher/issues/39392).

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.9.0:**
  - There are some known issues with the OpenID Connect provider support:
    - When the generic OIDC auth provider is enabled, and you attempt to add auth provider users to a cluster or project, users are not populated in the dropdown search bar. This is expected behavior as the OIDC auth provider alone is not searchable. See [#46104](https://github.com/rancher/rancher/issues/46104).
    - When the generic OIDC auth provider is enabled, auth provider users that are added to a cluster/project by their username are not able to access resources upon logging in. A user will only have access to resources upon login if the user is added by their userID.  See [#46105](https://github.com/rancher/rancher/issues/46105).
    - When the generic OIDC auth provider is enabled and an auth provider user in a nested group is logged into Rancher, the user will see the following error when they attempt to create a Project: `[projectroletemplatebindings.management.cattle.io](http://projectroletemplatebindings.management.cattle.io/) is forbidden: User "u-gcxatwsnku" cannot create resource "projectroletemplatebindings" in API group "[management.cattle.io](http://management.cattle.io/)" in the namespace "p-9t5pg"`. However, the project is still created. See [#46106](https://github.com/rancher/rancher/issues/46106).

## Long-standing Known Issues - Rancher Webhook <!-- neo -->

- **Rancher v2.7.2:**
  - A webhook is installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher v2.7.2 or later, to a Rancher version earlier than v2.7.2, the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after a Rancher version earlier than v2.7.2 is running). This removes the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).

## Long-standing Known Issues - Harvester

- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).

## Long-standing Known Issues - Backup/Restore <!-- night's watch -->

- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.<!-- no issue number -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

## Long-standing Known Issues - Continuous Delivery (Fleet)

- **Rancher v2.10.0:**
  - Target customization for namespace labels and annotations cannot modify/remove labels when updating. See [#3064](https://github.com/rancher/fleet/issues/3064).
  - In version 0.10, GitRepo resources provided a comprehensive list of all deployed resources across all clusters in their status. However, in version 0.11, this list has been modified to report resources only once until the feature is integrated into the Rancher UI. While this change addresses a UI freeze issue, it may result in potential inaccuracies in the list of resources and resource counts under some conditions. See [#3027](https://github.com/rancher/fleet/pull/3027).

## All issues in v2.10.1 milestone

* [#48661](https://github.com/rancher/rancher/issues/48661) [flaky-test] Step `Uninstall existing Python versions` in the `validate` Workflow fails  
* [#48431](https://github.com/rancher/rancher/issues/48431) [2.10] [BUG] Panic in nodesyncer
* [#48413](https://github.com/rancher/rancher/issues/48413) [BUG] [v2.10] Failed to install system chart fleet: specified version 105.0.2+up0.11.2-rc.2 doesn't exist in the index
* [#48375](https://github.com/rancher/rancher/issues/48375) [v2.10] [BUG] RKE cluster upgrade from v1.30 to v1.31 fails when drain is enabled in upgrade strategy option
* [#48354](https://github.com/rancher/rancher/issues/48354) [BUG][2.10] script user-cluster.sh fails to cleanup Rancher Components from Registered Clusters
* [#48341](https://github.com/rancher/rancher/issues/48341) [Backport v2.10] [BUG] VM of existing RKE1 node is not removed after the node is deleted from the cluster after upgrading to Rancher 2.9.3+
* [#48264](https://github.com/rancher/rancher/issues/48264) [BUG][2.10] Azure AD China auth returning "error status code received from the API
* [#48206](https://github.com/rancher/rancher/issues/48206) [Backport v2.10] [BUG] The state of the imported K3s cluster alternates between "Ready" and "Upgrading" at the start of the cluster upgrade process
* [#48202](https://github.com/rancher/rancher/issues/48202) The system-upgrade-controller App is not marked as Managed on the Installed Apps Page 
* [#48199](https://github.com/rancher/rancher/issues/48199) [BUG] rancher-monitoring ignoreNamespaceSelectors has wrong default value
* [#48193](https://github.com/rancher/rancher/issues/48193) [Backport v2.10] [BUG] Unable to provision RKE1 node driver cluster using RHEL 9.2 and 9.0 amis
* [#48184](https://github.com/rancher/rancher/issues/48184) [Backport v2.10] Transition rancher/machine to bci-busybox
* [#48180](https://github.com/rancher/rancher/issues/48180) [BUG] "Oberved a panic" on Upgrade to 2.10.0
* [#48157](https://github.com/rancher/rancher/issues/48157) [Backport v2.10] Stale Secret Fix
* [#48155](https://github.com/rancher/rancher/issues/48155) [v2.10] Update ACI-CNI to 6.0.4.4
* [#48112](https://github.com/rancher/rancher/issues/48112) [v2.10] CIS: Unexpected Failures in scans for gke 1.6.0 profile
* [#48096](https://github.com/rancher/rancher/issues/48096) [Backport v2.10] Nodes may fail to reconnect after K8s upgrade for K3s clusters with multiple etcd-only nodes
* [#48094](https://github.com/rancher/rancher/issues/48094) [Backport v2.10] Add managed annotation to Chart.yaml in rancher-provisioning-capi helm chart
* [#48085](https://github.com/rancher/rancher/issues/48085) [Backport 2.10] [BUG] `legacy-rolebinding-ownerref-cleaner` handlers fire millions of times per hour
* [#48083](https://github.com/rancher/rancher/issues/48083) [v2.10] KDM Update for K8s November 2024 patch
* [#48075](https://github.com/rancher/rancher/issues/48075) k8s 1.31 support for Istio
* [#48064](https://github.com/rancher/rancher/issues/48064) [Backport 2.10] [BUG] rancher-provisioning-capi chart version is not being pinned
* [#48005](https://github.com/rancher/rancher/issues/48005) [Backport 2.10] Chart rancher-provisioning-capi doesn't add tolerations from chart values to post-install hook Job
* [#48003](https://github.com/rancher/rancher/issues/48003) [Backport 2.10]ranchercli - readable warning that give no meaning on windows
* [#47981](https://github.com/rancher/rancher/issues/47981) [Backport v2.10] Stale Secret Fix
* [#47912](https://github.com/rancher/rancher/issues/47912) [BUG] Remove mirrored-prometheus-windows-exporter from rancher-images.txt
* [#47783](https://github.com/rancher/rancher/issues/47783) [RFE] Rebase Logging
* [#47766](https://github.com/rancher/rancher/issues/47766) Rebase pushprox to catch up with upstream 2.0
* [#47641](https://github.com/rancher/rancher/issues/47641) [2.10] Bump calico & canal to support v1.31
* [#47045](https://github.com/rancher/rancher/issues/47045) [BUG] Only apply "auth-prov-v2-" finalizers to necessary resources
* [#46905](https://github.com/rancher/rancher/issues/46905) Update DynamicListener's CI and Renovate Config
* [#46903](https://github.com/rancher/rancher/issues/46903) Update Norman's CI and Renovate Config
* [#46902](https://github.com/rancher/rancher/issues/46902) Update APIServer's CI and Renovate Config
* [#46899](https://github.com/rancher/rancher/issues/46899) Update Frameworks Branches for new versioning approach
* [#46450](https://github.com/rancher/rancher/issues/46450) [Forwardport] Validate SLE Micro 6 on Rancher
* [#43878](https://github.com/rancher/rancher/issues/43878) [BUG] cluster creation stuck waiting for cluster agent to connect ipv6
-----
# Release v2.10.0

> [!CAUTION]
> **Note:** If you are using Active Directory Federation Service (AD FS) upgrading to Rancher v2.10.1 or later may cause issues with authentication caused by the AD FS Relying Party Trust not being able to pick up a signature verification certificate from the metadata, that requires manual intervention. This can be corrected by either trying to update Relying Party Trust information from federation metadata (Relying Party Trust -> Update from Federation Metadata...) or by directly adding the certificate (Relying Party Trust -> Properties -> Signature tab -> Add -> Select the certificate). For more information see #48655.

> **Important:** Review the Install/Upgrade Notes before upgrading to any Rancher version.

Rancher v2.10.0 is the latest minor release of Rancher. This is a Community version release that introduces new features, enhancements, and various updates.

## Security Fixes for Rancher Vulnerabilities

This release addresses the following Rancher security issues:

- Permissions required to view, edit, and upgrade Apps have been revised. Users must now possess the "read" permission for the associated Helm secret in order to view the values used during an App's installation, as well as to edit or upgrade it. For more information, see [CVE-2024-52282](https://github.com/rancher/rancher/security/advisories/GHSA-9c5p-35gj-jqp4).
- Fixed an issue where Rancher API watch requests ignored user permissions, enabling non-privileged Rancher users to view sensitive objects (including secrets and credentials) they do not own. For more information, see [CVE-2024-52280](https://github.com/rancher/steve/security/advisories/GHSA-j5hq-5jcr-xwx7).
- Fixed an issue where namespace filters issued to watch requests through the Rancher API were sometimes ignored. Specifying multiple different namespaces in a watch request by ID now generates a warning, and will be disallowed in a future Rancher version. For more information, see [CVE-2024-52280](https://github.com/rancher/steve/security/advisories/GHSA-j5hq-5jcr-xwx7).
- Several enhancements have been made to the cluster and node driver registration process to prevent the possibility of remote code execution (RCE) through untrusted third-party cluster and node drivers. For more information, see [CVE-2024-22036](https://github.com/rancher/rancher/security/advisories/GHSA-h99m-6755-rgwc).
- To avoid credentials being stored in plain-text within the vSphere add-on config when creating a vSphere Rancher HA setup, the `provisioningprebootstrap` feature was added. For more information, see [CVE-2022-45157](https://github.com/rancher/rancher/security/advisories/GHSA-xj7w-r753-vj8v).

For more details, see the Security Advisories and CVEs page in Rancher's [documentation](https://ranchermanager.docs.rancher.com/v2.10/reference-guides/rancher-security/security-advisories-and-cves) or in Rancher's [GitHub](https://github.com/rancher/rancher/security/advisories) repo.

## Highlights

## Rancher General

### Features and Enhancements

- Rancher now supports Kubernetes v1.31. See [#46197](https://github.com/rancher/rancher/issues/46197) for information on Rancher support for Kubernetes v1.31. Additionally, the upstream Kubernetes changelogs for [v1.31](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.31.md) can be viewed for a full list of changes.

### Behavior Changes

- Kubernetes v1.27 is no longer supported. Before you upgrade to Rancher v2.10.0, make sure that all clusters are running Kubernetes v1.28 or later. See [#47591](https://github.com/rancher/rancher/issues/47591).
- The new annotation `field.cattle.io/creator-principal-name` was introduced in addition to the existing `field.cattle.io/creatorId` that allows specifying the creator's principal name when creating a cluster or a project. If this annotation is used the `userPrincipalName` field of the corresponding `ClusterRoleTemplateBinding` or `ProjectRoleTemplateBinding` will be set to the specified principal. The principal should belong to the creator's user, which is enforced by the webhook. See [#46828](https://github.com/rancher/rancher/issues/46828).
- When searching for group principals with a SAML authentication provider (with LDAP turned off) Rancher now returns a principal of correct type (group) with the name matching the search term. When searching principals with a SAML provider (with LDAP turned off) without specifying the desired type (as in Add cluster/project member) Rancher now returns both user and group principals with the name matching the search term. See [#44441](https://github.com/rancher/rancher/issues/44441).
- Rancher now captures the last used time for Tokens and stores it in the `lastUsedAt` field. If the Authorized Cluster Endpoint is enabled and used on a downstream cluster Rancher captures the last used time in the `ClusterAuthToken` object and makes the best effort to sync it back to the corresponding Token in the upstream. See [#45732](https://github.com/rancher/rancher/issues/45732).
- Rancher deploys the System Upgrade Controller (SUC) to facilitate Kubernetes upgrades for imported RKE2/K3s clusters. Starting with this version, the mechanism used to deploy this component in downstream clusters has transitioned from legacy V1 apps to fully supported V2 apps, providing a seamless upgrade process for Rancher. For more details, please see this [issue comment](https://github.com/rancher/rancher/issues/42448#issuecomment-2477309567).

## Rancher App (Global UI)

### Behavior Changes

- This release includes a major upgrade to the Dashboard (Cluster Explorer) Vue framework from Vue 2 to Vue 3. Please view our documentation on updating existing UI extensions to be compliant with the Rancher v2.10 UI framework in the [v2.10.0 UI extension changelog](https://extensions.rancher.io/extensions/next/rancher-2.10-support). If experiencing a page that fails to load please file an issue via the [Dashboard repository](https://github.com/rancher/dashboard/issues/new/choose) and choose the "Bug report" option for us to further investigate. See [#7653](https://github.com/rancher/dashboard/issues/7653).
- The performance of the Clusters lists in the Home page and the Side Menu has greatly improved when there are hundreds of clusters. See [#11995](https://github.com/rancher/dashboard/issues/11995) and [#11993](https://github.com/rancher/dashboard/issues/11993).
- The previous Dashboard Ember UI (Cluster Manager) will no longer be directly accessible. The relative pages that rely on the previous UI will continue to be embedded in the new Vue UI (Cluster Explorer). See [#11371](https://github.com/rancher/dashboard/issues/11371).
- Updated the data directory configuration by replacing the checkbox option with 3 user input options below:
  1. `Use default data directory configuration`
  2. `Use a common base directory for data directory configuration (sub-directories will be used for the system-agent, provisioning and distro paths)` -> This option displays a text input where users can enter a base directory for all 3 subdirectories which Rancher programmatically appends to the correct subdirectories.
  3. `Use custom data directories` -> This option displays 3 text inputs, one for each subdirectory type where users can input each path individually.
  
  See [#11560](https://github.com/rancher/dashboard/issues/11560).

### Major Bug Fixes

- Fixed an issue where when creating a GKE cluster in the Rancher UI you would see provisioning failures as the `clusterIpv4CidrBlock` and `clusterSecondaryRangeName` fields conflict. See [#8749](https://github.com/rancher/dashboard/issues/8749).

## K3s Provisioning

### Known Issues

- An issue was discovered where upgrading the k8s version of the downstream node driver and custom K3s clusters may result in an etcd node reporting `NodePressure`, and eventually the `rancher-system-agent` reporting failures to execute plans. If this issue is encountered, it can be solved by performing a `systemctl restart k3s.service` on the affected etcd-only nodes. See [#48096](https://github.com/rancher/rancher/issues/48096) and this [issue comment](https://github.com/rancher/rancher/issues/48050#issuecomment-2477030217) for more information.

## RKE Provisioning

**Important:** With the release of Rancher Kubernetes Engine (RKE) v1.6.0, we are informing customers that RKE is now deprecated. RKE will be maintained for two more versions, following our [deprecation policy](https://www.suse.com/support/rancher-prime/#Rancher-Prime-Deprecation-Policy).

Please note, End-of-Life (EOL) for RKE is July 31st, 2025. Prime customers must replatform from RKE to RKE2 or K3s.

RKE2 and K3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about replatforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

### Major Bug Fixes

- Fixed a permission issue which led to failures when attempting to provision an RKE cluster on vSphere. See [#47938](https://github.com/rancher/rancher/issues/47938).

## Rancher CLI

### Major Bug Fixes

- When using the Rancher CLI, the prompt to choose an auth provider will now always have the local provider in the first position. See [#46128](https://github.com/rancher/rancher/issues/46128).

### Behavior Changes

The deprecated subcommand `globaldns` was removed from the Rancher CLI. See [#48127](https://github.com/rancher/rancher/issues/48127).

## Authentication

### Features and Enhancements

- Added support for SAML `logout-all` to the SAML-based external auth providers (EAP). A `logout-all` logs a user not only out of Rancher, but also out of the associated session in the EAP. This logs the user out of other applications attached to the same session as well. When logging into Rancher again a full authentication has to be performed to reestablish a new session in the EAP. This is in contrast to a regular logout where a re-login re-uses the session and bypasses the need for actual re-authentication.
  Extended the EAP configuration form enabling the configuring admin to choose whether `logout-all` will be available to users or not, and if yes, if users may even be forced to always use `logout-all` instead of having a choice between it and regular logout.
  See [#38494](https://github.com/rancher/rancher/issues/38494).
- There is an option now to force a password reset on first logon when setting up a `rancher2_user`. See [#45736](https://github.com/rancher/rancher/issues/45736).

## Continuous Delivery (Fleet)

- Fleet v0.11.0 is also releasing alongside Rancher v2.10 and improves several log and status messages. It reduces the amount of reconciles done by the controllers for resource changes. It adds k8s events for the GitRepo resource, that users can subscribe to and are [documented](https://fleet.rancher.io/observability).

### Known Issues

- There are a few known issues which were not fixed in time which affect Rancher:

- Target customization for namespace labels and annotations cannot modify/remove labels when updating. See [#3064](https://github.com/rancher/fleet/issues/3064).
- In version 0.10, GitRepo resources provided a comprehensive list of all deployed resources across all clusters in their status. However, in version 0.11, this list has been modified to report resources only once until the feature is integrated into the Rancher UI. While this change addresses a UI freeze issue, it may result in potential inaccuracies in the list of resources and resource counts under some conditions. See [#3027](https://github.com/rancher/fleet/pull/3027).

## Role-Based Access Control (RBAC) Framework

### Features and Enhancements

- Impersonation in downstream clusters via the Rancher proxy is now supported, enabling users with the appropriate permissions to impersonate other users or ServiceAccounts. See [#41988](https://github.com/rancher/rancher/issues/41988).
- It is possible to opt out of cluster owner and project owner RBAC for a newly provisioned cluster if the cluster yaml includes the annotation `field.cattle.io/no-creator-rbac: "true"`. This is useful when a service account is provisioning the cluster as service accounts can't have RBAC applied to them. See [#45591](https://github.com/rancher/rancher/issues/45591).

## Virtualization (Harvester)

### Features and Enhancements

- A warning banner has been added when provisioning a multi-node Harvester RKE2 cluster in Rancher that you will need to allocate one vGPU more than the number of nodes you have to avoid the "un-schedulable" errors seen after cluster updates. See [#10989](https://github.com/rancher/dashboard/issues/10989).

### Behavior Changes

- On the Cloud Credential list, you can now easily see if a Harvester Credential is about to expire or has expired and choose to renew it. You will also be notified on the Cluster Management Clusters list when an associated Harvester Cloud Credential is about to expire or has expired. When upgrading, an existing expired Harvester Credential will not contain a warning. You can still renew the token on the resources menu. See [#11332](https://github.com/rancher/dashboard/issues/11332).

## Windows Nodes - General

### Behavior Changes

- Rancher v2.10.0 includes changes to how Windows nodes behave post node reboot, as well as provides two new settings to control how Windows services created by Rancher behave on startup.

  Two new agent environment variables have been added for Windows nodes, `CATTLE_ENABLE_WINS_SERVICE_DEPENDENCY` and `CATTLE_ENABLE_WINS_DELAYED_START`. These changes can be configured in the Rancher UI, and will be respected by all nodes running `rancher-wins` version `v0.4.20` or greater.

    - `CATTLE_ENABLE_WINS_SERVICE_DEPENDENCY` defines a service dependency between RKE2 and `rancher-wins`, ensuring RKE2 will not start before `rancher-wins`.
    - `CATTLE_ENABLE_WINS_DELAYED_START` changes the start type of `rancher-wins` to `AUTOMATIC (DELAYED)`, ensuring it starts after other Windows services.

  Additionally, Windows nodes will now attempt to execute plans multiple times if the initial application fails, up to 5 times. This change, as well as appropriate use of the above two agent environment variables, aims to address plan failures for Windows nodes after a node reboot.

  See [#42458](https://github.com/rancher/rancher/issues/42458).

## Windows Nodes in RKE2 Clusters

### Behavior Changes

- A change was made starting with RKE2 versions `v1.28.15`, `v1.29.10`, `v1.30.6` and `v1.31.2` on Windows which allows the user to configure `*_PROXY` environment variables on the `rke2` service after the node has already been provisioned.

  Previously any attempt to do so would be a no-op. With this change, If the `*_PROXY` environment variables are set on the cluster _after_ a Windows node is provisioned, they can be automatically removed from the `rke2` service. However, if the variables are set _before_ the node is provisioned, they cannot be removed.

  More information can be found [here](https://github.com/rancher/rancher/issues/47839). A workaround is to remove the environment variables from the `rancher-wins` service and restart the service or node. At which point `*_PROXY` environment variables will no longer be set on either service.

  ```shell
  Remove-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\rancher-wins -Name Environment
  Restart-Service rancher-wins
  ```

  See [#47544](https://github.com/rancher/rancher/issues/47544).

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

Please note, EOL for RKE is July 31st, 2025. Prime customers must replatform from RKE to RKE2 or K3s.

RKE2 and K3s provide stronger security, and move away from upstream-deprecated Docker machine. Learn more about replatforming [here](https://www.suse.com/c/rke-end-of-life-by-july-2025-replatform-to-rke2-or-k3s/).

## Images

- rancher/rancher:v2.10.0

## Tools

- CLI - [v2.10.0](https://github.com/rancher/cli/releases/tag/v2.10.0)
- RKE - [v1.7.0](https://github.com/rancher/rke/releases/tag/v1.7.0)

## Kubernetes Versions for RKE

- v1.31.2 (Default)
- v1.30.6
- v1.29.10
- v1.28.15

## Kubernetes Versions for RKE2/K3s

- v1.31.2 (Default)
- v1.30.6
- v1.29.10
- v1.28.15

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

# Long-standing Known Issues

<!-- Apply same headers as "Major Bug Fixes" but with "Long-standing Known Issues" suffix instead -->

## Long-standing Known Issues - Cluster Provisioning

- Not all cluster tools can be installed on a hardened cluster.<!--no issue number available -->

- **Rancher v2.8.1:**
  - When you  attempt to register a new etcd/controlplane node in a CAPR-managed cluster after a failed etcd snapshot restoration, the node can become stuck in a perpetual paused state, displaying the error message `[ERROR]  000 received while downloading Rancher connection information. Sleeping for 5 seconds and trying again`. As a workaround, you can unpause the cluster by running `kubectl edit clusters.cluster clustername -n fleet-default` and set `spec.unpaused` to `false`.  See [#43735](https://github.com/rancher/rancher/issues/43735).
- **Rancher v2.7.2:**
  - If you upgrade or update any hosted cluster, and go to **Cluster Management > Clusters** while the cluster is still provisioning, the **Registration** tab is visible. Registering a cluster that is already registered with Rancher can cause data corruption. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - RKE Provisioning

- **Rancher v2.9.0:**
  - The Weave CNI plugin for RKE v1.27 and later is now deprecated, due to the plugin being deprecated for upstream Kubernetes v1.27 and later. RKE creation will not go through as it will raise a validation warning. See [#11322](https://github.com/rancher/dashboard/issues/11322).

## Long-standing Known Issues - RKE2 Provisioning <!-- hostbusters -->

- **Rancher v2.9.0:**
  - When adding the `provisioning.cattle.io/allow-dynamic-schema-drop` annotation through the cluster config UI, the annotation disappears before adding the value field. When viewing the YAML, the respective value field is not updated and is displayed as an empty string. As a workaround, when creating the cluster, set the annotation by using the **Edit Yaml** option located in the dropdown **⋮** attached to your respective cluster in the **Cluster Management** view. See [#11435](https://github.com/rancher/dashboard/issues/11435).
- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).
- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - When viewing or editing the YAML configuration of downstream RKE2 clusters through the UI, `spec.rkeConfig.machineGlobalConfig.profile` is set to `null`, which is an invalid configuration. See [#8480](https://github.com/rancher/dashboard/issues/8480).
    - [RKE2 uninstall script](https://docs.rke2.io/install/uninstall?_highlight=uninstall#tarball-method).

## Long-standing Known Issues - K3s Provisioning <!-- hostbusters -->

- **Rancher v2.7.6:**
  - Provisioning RKE2/K3s clusters with added (not built-in) custom node drivers causes provisioning to fail. As a workaround, [fix](https://github.com/rancher/rancher/issues/37074#issuecomment-1664722305) the added node drivers after activating. See [#37074](https://github.com/rancher/rancher/issues/37074).
- **Rancher v2.7.2:**
  - Clusters remain in an `Updating` state even when they contain nodes in an `Error` state. See [#39164](https://github.com/rancher/rancher/issues/39164).

## Long-standing Known Issues - Rancher App (Global UI)

- **Rancher v2.9.2**:
  - Although system mode node pools must have at least one node, the Rancher UI allows a minimum node count of zero. Inputting a zero minimum node count through the UI can cause cluster creation to fail due to an invalid parameter error. To prevent this error from occurring, enter a minimum node count at least equal to the node count. See [#11922](https://github.com/rancher/dashboard/issues/11922).
- **Rancher v2.7.7**:
  - When creating a cluster in the Rancher UI it does not allow the use of an underscore `_` in the `Cluster Name` field. See [#9416](https://github.com/rancher/dashboard/issues/9416).

## Long-standing Known Issues - Hosted Rancher <!-- hostbusters -->

- **Rancher v2.7.5:**
  - The **Cluster** page shows the **Registration** tab when updating or upgrading a hosted cluster. See [#8524](https://github.com/rancher/dashboard/issues/8524).

## Long-standing Known Issues - EKS

- **Rancher v2.7.0:**
  - EKS clusters on Kubernetes v1.21 or below on Rancher v2.7 cannot be upgraded. See [#39392](https://github.com/rancher/rancher/issues/39392).

## Long-standing Known Issues - Authentication <!-- night's watch -->

- **Rancher v2.9.0:**
  - There are some known issues with the OpenID Connect provider support:
    - When the generic OIDC auth provider is enabled, and you attempt to add auth provider users to a cluster or project, users are not populated in the dropdown search bar. This is expected behavior as the OIDC auth provider alone is not searchable. See [#46104](https://github.com/rancher/rancher/issues/46104).
    - When the generic OIDC auth provider is enabled, auth provider users that are added to a cluster/project by their username are not able to access resources upon logging in. A user will only have access to resources upon login if the user is added by their userID.  See [#46105](https://github.com/rancher/rancher/issues/46105).
    - When the generic OIDC auth provider is enabled and an auth provider user in a nested group is logged into Rancher, the user will see the following error when they attempt to create a Project: `[projectroletemplatebindings.management.cattle.io](http://projectroletemplatebindings.management.cattle.io/) is forbidden: User "u-gcxatwsnku" cannot create resource "projectroletemplatebindings" in API group "[management.cattle.io](http://management.cattle.io/)" in the namespace "p-9t5pg"`. However, the project is still created. See [#46106](https://github.com/rancher/rancher/issues/46106).

## Long-standing Known Issues - Rancher Webhook <!-- neo -->

- **Rancher v2.7.2:**
  - A webhook is installed in all downstream clusters. There are several issues that users may encounter with this functionality:
    - If you rollback from a version of Rancher v2.7.2 or later, to a Rancher version earlier than v2.7.2, the webhooks will remain in downstream clusters. Since the webhook is designed to be 1:1 compatible with specific versions of Rancher, this can cause unexpected behaviors to occur downstream. The Rancher team has developed a [script](https://github.com/rancher/webhook/wiki/Remove-Webhook-from-downstream-clusters) which should be used after rollback is complete (meaning after a Rancher version earlier than v2.7.2 is running). This removes the webhook from affected downstream clusters. See [#40816](https://github.com/rancher/rancher/issues/40816).

## Long-standing Known Issues - Harvester

- **Rancher v2.9.0:**
  - In the Rancher UI when navigating between Harvester clusters of different versions a refresh may be required to view version specific functionality. See [#11559](https://github.com/rancher/dashboard/issues/11559).
- **Rancher v2.7.2:**
  - If you're using Rancher v2.7.2 with Harvester v1.1.1 clusters, you won't be able to select the Harvester cloud provider when deploying or updating guest clusters. The [Harvester release notes](https://github.com/harvester/release-notes/blob/main/v1.1.2.md#important-information-about-rancher-support) contain instructions on how to resolve this. See [#3750](https://github.com/harvester/harvester/issues/3750).

## Long-standing Known Issues - Backup/Restore <!-- night's watch -->

- When migrating to a cluster with the Rancher Backup feature, the server-url cannot be changed to a different location. It must continue to use the same URL.<!-- no issue number -->

- **Rancher v2.7.7:**
  - Due to the backoff logic in various components, downstream provisioned K3s and RKE2 clusters may take longer to re-achieve `Active` status after a migration. If you see that a downstream cluster is still updating or in an error state immediately after a migration, please let it attempt to resolve itself. This might take up to an hour to complete. See [#34518](https://github.com/rancher/rancher/issues/34518) and [#42834](https://github.com/rancher/rancher/issues/42834).

## All issues in v2.10.0 milestone

* [#48127](https://github.com/rancher/rancher/issues/48127) [v2.10] Remove deprecated globaldns command from CLI
* [#47938](https://github.com/rancher/rancher/issues/47938) [BUG] Cannot Provision RKE1 on vSphere
* [#47897](https://github.com/rancher/rancher/issues/47897) [BUG] Concurrent updates to ms-graph-sdk internals cause errors
* [#47863](https://github.com/rancher/rancher/issues/47863) [BUG] [EKS] Unable to re-import a deleted cluster
* [#47853](https://github.com/rancher/rancher/issues/47853) [BUG] Provisioning a downstream RKE2/K3s Linode cluster fails due to being unable to download docker-machine-driver
* [#47836](https://github.com/rancher/rancher/issues/47836) [BUG] No results returned for exact search for a user with Non-ASCII characters in the display name
* [#47824](https://github.com/rancher/rancher/issues/47824) [BUG] Azure cloud provider config fails to apply on RKE2 cluster.
* [#47814](https://github.com/rancher/rancher/issues/47814) [BUG] `provisioningprebootstrap` flag does not restart rancher when toggled
* [#47771](https://github.com/rancher/rancher/issues/47771) [BUG] Failed bootstrapping cluster with provisioningprebootstrap and ACE enabled
* [#47742](https://github.com/rancher/rancher/issues/47742) [BUG] VAI Cache Namespace Taking ~9 Mins to Propagate Across All .DB Files
* [#47702](https://github.com/rancher/rancher/issues/47702) [BUG] Endpoint /v3/principal returns 500 when the principal can't be found
* [#47698](https://github.com/rancher/rancher/issues/47698) [RKE1] v1.31 ImageGCFailed due to missing ContainerFilesystems
* [#47681](https://github.com/rancher/rancher/issues/47681) [2.10] Enable metrics in nginx template, bump nginx to 1.11.3
* [#47678](https://github.com/rancher/rancher/issues/47678) Bump go version to 1.22.8
* [#47672](https://github.com/rancher/rancher/issues/47672) [BUG]Rancher Azure AD Access Token login issue
* [#47630](https://github.com/rancher/rancher/issues/47630) [BUG] SAML logout error reported for a non SAML provider
* [#47601](https://github.com/rancher/rancher/issues/47601) [BUG] VAI Cache DB Files Not Present in Pods/Breaks Rancher UI
* [#47591](https://github.com/rancher/rancher/issues/47591) Remove support for K8s 1.27 for Rancher 2.10.0
* [#47584](https://github.com/rancher/rancher/issues/47584) [RFE] Add ability to set tolerations on Rancher pod via chart
* [#47583](https://github.com/rancher/rancher/issues/47583) [BUG] Migrating `rancher.io/expiration-timestamp` causes crashloop if credential uses expired token
* [#47569](https://github.com/rancher/rancher/issues/47569) [BUG] Linode node driver download causes node driver hangups on arm64
* [#47551](https://github.com/rancher/rancher/issues/47551) [v2.10] add gke 1.6.0 support in rancher-cis-benchmark chart
* [#47544](https://github.com/rancher/rancher/issues/47544) [BUG] Existing Windows nodes will fail to update service configuration with Proxy environment variables
* [#47537](https://github.com/rancher/rancher/issues/47537) [v2.10] KDM Update for K8s October 2024 patch
* [#47533](https://github.com/rancher/rancher/issues/47533) [dev-v2.10] Remove CIS-1.7 profiles from the `rancher-cis-benchmark` chart
* [#47522](https://github.com/rancher/rancher/issues/47522) [BUG] Downstream RKE2 registry rewrites break fallback to upstream registry
* [#47520](https://github.com/rancher/rancher/issues/47520) [BUG] Unable to provision RKE1 downstream clusters on v2.10-head
* [#47507](https://github.com/rancher/rancher/issues/47507) [RFE] Bump Harvester node driver to v0.7.0
* [#47491](https://github.com/rancher/rancher/issues/47491) [BUG] Harvester Cloud Credential Expiry not Updated
* [#47489](https://github.com/rancher/rancher/issues/47489) [BUG] Okta SAML Auth Provider sets `logoutAllSupported` as `false` after disabling auth provider from the UI
* [#47465](https://github.com/rancher/rancher/issues/47465)  search resources functionality
* [#47464](https://github.com/rancher/rancher/issues/47464) [v2.10] Update CNI Plugins source in rke-tools
* [#47460](https://github.com/rancher/rancher/issues/47460) [RFE] Refactor AccessStore key hashing
* [#47441](https://github.com/rancher/rancher/issues/47441) [BUG] RoleBinding for project owner does not get created after moving RKE1 cluster to a new Fleet workspace
* [#47413](https://github.com/rancher/rancher/issues/47413) [v2.10] Update ACI-CNI to 6.1.1.1
* [#47409](https://github.com/rancher/rancher/issues/47409) [BUG] Roles updated too often due unsorted resourceNames
* [#47379](https://github.com/rancher/rancher/issues/47379) [BUG] Downstream K3s registry rewrites break fallback to upstream registry
* [#47339](https://github.com/rancher/rancher/issues/47339) [BUG] etcd snapshot count reported in rancher is incorrect when taking manual snapshot with s3 enabled on rke2 clusters, but is correct in s3
* [#47318](https://github.com/rancher/rancher/issues/47318) [BUG] Possible memory leak on accesscontrol/schemas
* [#47296](https://github.com/rancher/rancher/issues/47296) [BUG] [2.10] Unable to create the CIS scan output because of the configMap size is exceeding 1 MB 
* [#47246](https://github.com/rancher/rancher/issues/47246) [Feature] k8s 1.31 Support for `rancher/shell`
* [#47241](https://github.com/rancher/rancher/issues/47241) [RFE] Cloud Credentials Expiry field support
* [#47234](https://github.com/rancher/rancher/issues/47234) [v2.10] Bump rancher/mirrored-jimmidyson-configmap-reload for rancher-alerting-drivers
* [#47200](https://github.com/rancher/rancher/issues/47200) Reduce `webhook`'s dependency on RKE1 type changes
* [#47173](https://github.com/rancher/rancher/issues/47173) [2.10] Add support for docker 27.2.x
* [#47170](https://github.com/rancher/rancher/issues/47170) [ForwardPort] [v2.10] KDM Update for K8s Sept 2024 patch release
* [#47086](https://github.com/rancher/rancher/issues/47086) [Forwardport 2.10] Managed RKE2 clusters are broken after upgrade to 2.9.1 when KDM is not updated to release-v2.9
* [#47081](https://github.com/rancher/rancher/issues/47081) [RFE] Create a yaml replacement for Restricted Admin
* [#47066](https://github.com/rancher/rancher/issues/47066) [main] `C:\etc\rancher\wins\config` shows duplicate entries in a downstream vSphere Windows RKE2 cluster
* [#47047](https://github.com/rancher/rancher/issues/47047) [v2.10] High CPU load due to calico errors on Ubuntu 20.04 - Update to calico needed
* [#47032](https://github.com/rancher/rancher/issues/47032) Serve `/ext` in Rancher
* [#47030](https://github.com/rancher/rancher/issues/47030) Implement `/ext` in Steve 
* [#47007](https://github.com/rancher/rancher/issues/47007) Add OpenAPI code generation to wrangler
* [#47000](https://github.com/rancher/rancher/issues/47000) [BUG] Project Owner unable to grant users permissions inherited from Kubernetes admin role.
* [#46970](https://github.com/rancher/rancher/issues/46970) [2.10]  Rancher Logs filled with errors related to auth-user-info-resync-cron for every 2mins
* [#46963](https://github.com/rancher/rancher/issues/46963) [main] [BUG] CATTLE_AGENT_FALLBACK_PATH environment variable is way too prominent for custom clusters and can lead to confusion
* [#46956](https://github.com/rancher/rancher/issues/46956) Bump v2.10 dynamiclistener consumers to use release v0.6.1
* [#46945](https://github.com/rancher/rancher/issues/46945) Update main branch to point to dashboard main branch
* [#46879](https://github.com/rancher/rancher/issues/46879) [BUG] Unable to authenticate with AzureAD to cluster
* [#46870](https://github.com/rancher/rancher/issues/46870) [2.10] use fixed stream server bind address for cri-dockerd 
* [#46860](https://github.com/rancher/rancher/issues/46860) Drop internal /metrics/<clusterID> endpoint for downstream object counts
* [#46853](https://github.com/rancher/rancher/issues/46853)  [Feature] k8s 1.31 support- apps and feature charts
* [#46852](https://github.com/rancher/rancher/issues/46852) k8's 1.31 support for Kubewarden
* [#46851](https://github.com/rancher/rancher/issues/46851) k8's 1.31 support for NeuVector 
* [#46850](https://github.com/rancher/rancher/issues/46850) k8's 1.31 support for longhorn 
* [#46849](https://github.com/rancher/rancher/issues/46849) k8s 1.31 support for Harvester-CSI-Driver 
* [#46848](https://github.com/rancher/rancher/issues/46848) k8s 1.31 support for Harvester-cloud-provider
* [#46847](https://github.com/rancher/rancher/issues/46847) k8's 1.31 support for GKE-Operator 
* [#46846](https://github.com/rancher/rancher/issues/46846) k8's 1.31 support for EKS-Operator 
* [#46845](https://github.com/rancher/rancher/issues/46845) k8's 1.31 support for AKS-Operator 
* [#46844](https://github.com/rancher/rancher/issues/46844) k8's 1.31 support for Fleet 
* [#46843](https://github.com/rancher/rancher/issues/46843) k8's 1.31 support for CIS-Benchmark 
* [#46842](https://github.com/rancher/rancher/issues/46842) k8's 1.31 support for rancher backup-operator 
* [#46841](https://github.com/rancher/rancher/issues/46841) k8's 1.31 support for rancher-alerting-drivers
* [#46840](https://github.com/rancher/rancher/issues/46840) K8's 1.31 support for rancher-monitoring 
* [#46839](https://github.com/rancher/rancher/issues/46839) K8's 1.31 support for rancher-logging
* [#46838](https://github.com/rancher/rancher/issues/46838) K8's 1.31 support for Prometheus-federator 
* [#46837](https://github.com/rancher/rancher/issues/46837) K8's 1.31 support for vsphere CSI 
* [#46836](https://github.com/rancher/rancher/issues/46836) k8's 1.31 support for vsphere CPI
* [#46835](https://github.com/rancher/rancher/issues/46835) K8's 1.31 support for system upgrade controller 
* [#46834](https://github.com/rancher/rancher/issues/46834) [BUG] Rancher logging chart installation failing with error "apiVersion not set"
* [#46833](https://github.com/rancher/rancher/issues/46833) K8's 1.31 support for csp-adapter
* [#46832](https://github.com/rancher/rancher/issues/46832) Update wrangler to use 1.31
* [#46831](https://github.com/rancher/rancher/issues/46831) K8's 1.31 support for Lasso 
* [#46830](https://github.com/rancher/rancher/issues/46830) K8s 1.31 support for Dynamic Listener
* [#46829](https://github.com/rancher/rancher/issues/46829) K8's 1.31 Support for Gengo 
* [#46828](https://github.com/rancher/rancher/issues/46828) [RFE] Respect creator's principal ID when creating projects and clusters
* [#46752](https://github.com/rancher/rancher/issues/46752) RKE2 and K3S - KDM Update for K8s August 2024 patch release for Rancher 2.10
* [#46743](https://github.com/rancher/rancher/issues/46743) [BUG]ui-offline-preferred 'dynamic' value not working
* [#46720](https://github.com/rancher/rancher/issues/46720) [Forwardport 2.10] KDM Update for K8s Aug 2024 patch release
* [#46700](https://github.com/rancher/rancher/issues/46700) [BUG] When attempting to provision a downstream RKE2/K3S cluster in v2.10 images, error message `No version info found in KDM` is presented
* [#46701](https://github.com/rancher/rancher/issues/46701) [Vai] Server side pagination - Sync lag of Kubernetes resources counts when quering the counts after resources creation 
* [#46680](https://github.com/rancher/rancher/issues/46680) [Forwardport ] Generate and Publish sha256sum.txt in RKE Releases
* [#46658](https://github.com/rancher/rancher/issues/46658) [BUG] If LDAP is not configured SAML provider always returns users when searching principals
* [#46648](https://github.com/rancher/rancher/issues/46648) [RFE] Check that {disable|delete}-inactive-user-after setting is not less than auth-user-session-ttl-minutes
* [#46642](https://github.com/rancher/rancher/issues/46642) SQLite backed cache: Request for additional indexed fields
* [#46632](https://github.com/rancher/rancher/issues/46632) [RFE] Refactor project and cluster handler
* [#46620](https://github.com/rancher/rancher/issues/46620) [BUG] system-agent does not respect `maxFailures` if running the same plan post restart
* [#46601](https://github.com/rancher/rancher/issues/46601) `pnap` (PhoenixNAP) node driver update to version 0.5.1
* [#46591](https://github.com/rancher/rancher/issues/46591) [RFE] Monitor the logging stack
* [#46565](https://github.com/rancher/rancher/issues/46565) [2.10] Update `ingress-nginx` to the latest applicable version
* [#46555](https://github.com/rancher/rancher/issues/46555) [2.10] Defaults are not validated for user retention settings
* [#46551](https://github.com/rancher/rancher/issues/46551) Rebase monitoring to current latest upstream
* [#46532](https://github.com/rancher/rancher/issues/46532) [Forwardport 2.10] Update Kubectl to the latest version in system agent
* [#46530](https://github.com/rancher/rancher/issues/46530) [Forwardport 2.10] Update go to the latest version in system agent
* [#46515](https://github.com/rancher/rancher/issues/46515) Update go to the latest version in `rancher/machine`
* [#46486](https://github.com/rancher/rancher/issues/46486) [BUG] Fips errors on Rancher 2.9
* [#46473](https://github.com/rancher/rancher/issues/46473) Add debug to KDM args for k3s and rke2
* [#46470](https://github.com/rancher/rancher/issues/46470) [Forwardport] KDM Update for K8s July 2024 patch release
* [#46449](https://github.com/rancher/rancher/issues/46449) [Forwardport] Downstream RKE2 Vsphere Cloud Provider clusters pull incorrect versioning for CSI pod images, which result in imagepullbackoff error
* [#46448](https://github.com/rancher/rancher/issues/46448) [Forwardport] k8s 1.30 support for vSphere CPI
* [#46447](https://github.com/rancher/rancher/issues/46447) [Forwardport] k8s 1.30 support for vSphere CSI
* [#46445](https://github.com/rancher/rancher/issues/46445) [Forwardport] Snapshots fail during creation in Sle Micro 6
* [#46444](https://github.com/rancher/rancher/issues/46444) [Forwardport] Improve the logging for k3s based upgrader in Rancher
* [#46442](https://github.com/rancher/rancher/issues/46442) [Forwardport] MachineHealthCheck Object not deleted properly
* [#46440](https://github.com/rancher/rancher/issues/46440) [Forwardport] [Maintenance] Bump embedded system-agent within rancher-wins
* [#46439](https://github.com/rancher/rancher/issues/46439) [Forwardport] Remove old versions from vsphere-charts
* [#46438](https://github.com/rancher/rancher/issues/46438) [Forwardport] Run Operations_Test_SetB_* tests for rancher/kontainer-driver-metadata tests
* [#46437](https://github.com/rancher/rancher/issues/46437) [ Forwardport -flaky-test] Certificate Rotation
* [#46436](https://github.com/rancher/rancher/issues/46436) [Forwardport] Old Ubuntu 20.04 AMIs are used by default when provisioning downstream clusters in AWS
* [#46435](https://github.com/rancher/rancher/issues/46435) [Forwardport] AWS region support ca-west-1
* [#46434](https://github.com/rancher/rancher/issues/46434) [Forwardport] v2prov certificate rotation does not follow correct order of operations
* [#46432](https://github.com/rancher/rancher/issues/46432) [Forwardport] Update docker-machine-driver-linode to v0.1.12
* [#46431](https://github.com/rancher/rancher/issues/46431) [Forwardport] Provisioning an RKE2 cluster with the data/dir feature enabled causes snapshot restores to fail
* [#46429](https://github.com/rancher/rancher/issues/46429) [Forwardport] System-agent-upgrader plan removes system-agent data directory
* [#46428](https://github.com/rancher/rancher/issues/46428) [Forwardport] Custom cluster registration command not including system agent data directory
* [#46409](https://github.com/rancher/rancher/issues/46409) SQLite backed cache in the Steve API - small things part 1
* [#46404](https://github.com/rancher/rancher/issues/46404) [Forwardport] vsphere 8 using rke2/k3s - if vsphere DRS maxVcpusPerCore limit is reached on host, rancher does not clean up vsphere VMs
* [#46403](https://github.com/rancher/rancher/issues/46403) [Forwardport] [CAPR] Upgrading Rancher during etcd restoration from < v2.7.5 to v2.7.5+ can lead to implausible joined server for entry
* [#46402](https://github.com/rancher/rancher/issues/46402) [Forwardport]  rke2 clusters with invalid values for tolerations / affinity agent customization do not show error to user, stay in updating state on cluster create 
* [#46401](https://github.com/rancher/rancher/issues/46401) [Forwardport] Cattle-cleanup job for imported clusters not pulling from configured private registry
* [#46400](https://github.com/rancher/rancher/issues/46400) [Forwardport] air gap RKE2 downstream cluster fails to pull images if the registry mirrors endpoint does not contain a schema
* [#46396](https://github.com/rancher/rancher/issues/46396) [BUG] [Windows] `STRICT_VERIFY` environment variable is not passed to windows nodes
* [#46381](https://github.com/rancher/rancher/issues/46381) Validation of custom data directories for RKE2/K3s provisioning
* [#46344](https://github.com/rancher/rancher/issues/46344) [Windows] System Agent and rke2 startup may conflict with one another
* [#46332](https://github.com/rancher/rancher/issues/46332) SQLite backed cache: support autorefresh
* [#46331](https://github.com/rancher/rancher/issues/46331) SQLite backed cache: investigate writes blocking reads
* [#46330](https://github.com/rancher/rancher/issues/46330) SQLite backed cache: support sorting and filtering on Steve synthetic fields
* [#46326](https://github.com/rancher/rancher/issues/46326) [v2.10] Add support for Docker 27.0.x and 27.1.x
* [#46268](https://github.com/rancher/rancher/issues/46268) [BUG] LDAP users cannot access project metrics and links of grafana, prometheus,etc are grayed out in project monitoring.
* [#46235](https://github.com/rancher/rancher/issues/46235) [BUG] Backing role in local cluster is not deleted upon deleting corresponding cluster roletemplate
* [#46222](https://github.com/rancher/rancher/issues/46222) Support `cgroup v2` for v2prov tests
* [#46202](https://github.com/rancher/rancher/issues/46202) k8s 1.31 support in APIServer
* [#46201](https://github.com/rancher/rancher/issues/46201) k8s 1.31 support for Webhook
* [#46199](https://github.com/rancher/rancher/issues/46199) Enable renovate's auto PR approval for rancher/lasso
* [#46197](https://github.com/rancher/rancher/issues/46197) [Feature] K8s 1.31 Support
* [#46166](https://github.com/rancher/rancher/issues/46166) [Design] Imperative Resource API
* [#46153](https://github.com/rancher/rancher/issues/46153) [v2.9] [RFE] Add CIS-1.9 (k8s v1.27-1.29) Scan capability 
* [#46128](https://github.com/rancher/rancher/issues/46128) [BUG] CLI: Azure Auth provider options are not correctly sorted, the options should be reverse order
* [#46098](https://github.com/rancher/rancher/issues/46098) Transition `rancher/system-agent` to `bci-micro`
* [#46002](https://github.com/rancher/rancher/issues/46002) [BUG] DynamicListener doesn't log panics from handlers
* [#45811](https://github.com/rancher/rancher/issues/45811) [BUG] cluster member roles need to be recreated after fleet workspace change for RKE1 clusters
* [#45771](https://github.com/rancher/rancher/issues/45771) [RFE] create catch-all de-dupe script
* [#45736](https://github.com/rancher/rancher/issues/45736) [RFE] Option to force password reset on first logon when setting up a rancher2_user
* [#45732](https://github.com/rancher/rancher/issues/45732) [RFE]  Capture LastUsed time for tokens
* [#45726](https://github.com/rancher/rancher/issues/45726) Evaluate replacing loglevel's Go binary by a shell script implementation
* [#45718](https://github.com/rancher/rancher/issues/45718) [RFE] Enhance the secret-synchronization controller from Rancher's management cluster -> downstream clusters 
* [#45624](https://github.com/rancher/rancher/issues/45624) [RFE] PrincipalID refactor
* [#45603](https://github.com/rancher/rancher/issues/45603) [BUG] rancher monitoring chart lacks Network Policy permission to collect metrics from GUI's ingress-nginx pods
* [#45591](https://github.com/rancher/rancher/issues/45591) [SURE-8656] [RFE] Support Creating a Cluster with a Service Account
* [#45509](https://github.com/rancher/rancher/issues/45509) [SURE-8169] [BUG] high memory usage for the aks.(*aksOperatorController).onClusterChange
* [#45496](https://github.com/rancher/rancher/issues/45496) [BUG] Keycloak admin user cannot see groups for cluster members
* [#45451](https://github.com/rancher/rancher/issues/45451) [BUG] Panic setting password to Azure AD (Entra ID) user
* [#45431](https://github.com/rancher/rancher/issues/45431) Remove webhook direct dependency on RKE
* [#45386](https://github.com/rancher/rancher/issues/45386) [BUG] `RESTART_STAMP` environment variable is not properly handled on Windows
* [#45385](https://github.com/rancher/rancher/issues/45385) [BUG] Windows system-agent-install script needlessly reinstalls RKE2
* [#45340](https://github.com/rancher/rancher/issues/45340) [BUG] Rancher CLI panics when we try to switch context without any selection 
* [#44944](https://github.com/rancher/rancher/issues/44944) [BUG] - RKE1 Azure node template has Ubuntu 18.04 as default image. Docker fails to install during cluster nodes provision
* [#44936](https://github.com/rancher/rancher/issues/44936) [BUG] Changing KDM URL doesn’t propagate to non-leader pods for `/v1-rke2-release/releases` endpoint
* [#44779](https://github.com/rancher/rancher/issues/44779) [RFE] Allow provisioning Vsphere RKE2 DS clusters with duplicate networks names [UI & Backend coordination]
* [#44698](https://github.com/rancher/rancher/issues/44698) [RFE] Add Unit Tests to the auth Package
* [#44441](https://github.com/rancher/rancher/issues/44441) [BUG] SAML provider search always returns users
* [#44352](https://github.com/rancher/rancher/issues/44352) Add managed annotation to Chart.yaml in rancher-webhook helm chart
* [#44347](https://github.com/rancher/rancher/issues/44347) [BUG] Stale secrets for impersonation user in downstream cluster
* [#43799](https://github.com/rancher/rancher/issues/43799) [BUG] Deleting namespaces from project as standard user doesn't remove the items from Rancher Dashboard
* [#42458](https://github.com/rancher/rancher/issues/42458) [BUG->RFE] Issues Encountered During Graceful Reboot of vSphere Windows Nodes
* [#42448](https://github.com/rancher/rancher/issues/42448) Deprecate rancher-k3s-upgrader
* [#42414](https://github.com/rancher/rancher/issues/42414) [BUG]Windows rke2 custom cluster - nodes stop displaying metrics in Monitoring after upgrading kubernetes version
* [#41988](https://github.com/rancher/rancher/issues/41988)  `kubectl auth can-i` fails when using user impersonation (`--as`) for ServiceAccounts
* [#41413](https://github.com/rancher/rancher/issues/41413) [BUG] Machine Configs orphaned on failed cluster create
* [#41143](https://github.com/rancher/rancher/issues/41143) [BUG] RKE2 Upgrade gets started when adding a new node to existing but already-upgraded cluster
* [#38494](https://github.com/rancher/rancher/issues/38494) [RFE] Implement SAML Single Logout 
* [#36539](https://github.com/rancher/rancher/issues/36539) Active Directory project and cluster members are not showing up when logged in as local rancher admin user
-----
