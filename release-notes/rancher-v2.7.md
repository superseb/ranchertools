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
