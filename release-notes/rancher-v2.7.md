| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v2.7.2](rancher-v2.7.md#release-v272) | Apr 12 2023 | 04/12/23 | 2023-04-12 |
| [v2.7.1](rancher-v2.7.md#release-v271) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v2.7.0](rancher-v2.7.md#release-v270) | Nov 16 2022 | 11/16/22 | 2022-11-16 |



# Release v2.7.2

> It is important to review the Install/Upgrade Notes below before upgrading to any Rancher version.

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

-----
