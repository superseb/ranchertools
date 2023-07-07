| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.3.22](rke-v1.3.md#release-v1322) | Jul 07 2023 | 07/07/23 | 2023-07-07 |
| [v1.3.21](rke-v1.3.md#release-v1321) | Jun 23 2023 | 06/23/23 | 2023-06-23 |
| [v1.3.20](rke-v1.3.md#release-v1320) | Apr 26 2023 | 04/26/23 | 2023-04-26 |
| [v1.3.19](rke-v1.3.md#release-v1319) | Mar 07 2023 | 03/07/23 | 2023-03-07 |
| [v1.3.18](rke-v1.3.md#release-v1318) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v1.3.17](rke-v1.3.md#release-v1317) | Nov 28 2022 | 11/28/22 | 2022-11-28 |
| [v1.3.16](rke-v1.3.md#release-v1316) | Nov 11 2022 | 11/11/22 | 2022-11-11 |
| [v1.3.15](rke-v1.3.md#release-v1315) | Sep 21 2022 | 09/21/22 | 2022-09-21 |
| [v1.3.14](rke-v1.3.md#release-v1314) | Aug 30 2022 | 08/30/22 | 2022-08-30 |
| [v1.3.13](rke-v1.3.md#release-v1313) | Aug 17 2022 | 08/17/22 | 2022-08-17 |
| [v1.3.12](rke-v1.3.md#release-v1312) | Jun 15 2022 | 06/15/22 | 2022-06-15 |
| [v1.3.11](rke-v1.3.md#release-v1311) | May 11 2022 | 05/11/22 | 2022-05-11 |
| [v1.3.10](rke-v1.3.md#release-v1310) | Apr 29 2022 | 04/29/22 | 2022-04-29 |
| [v1.3.9](rke-v1.3.md#release-v139) | Apr 04 2022 | 04/04/22 | 2022-04-04 |
| [v1.3.8](rke-v1.3.md#release-v138) | Mar 25 2022 | 03/25/22 | 2022-03-25 |
| [v1.3.7](rke-v1.3.md#release-v137) | Feb 08 2022 | 02/08/22 | 2022-02-08 |
| [v1.3.6](rke-v1.3.md#release-v136) | Jan 26 2022 | 01/26/22 | 2022-01-26 |
| [v1.3.5](rke-v1.3.md#release-v135) | Jan 24 2022 | 01/24/22 | 2022-01-24 |
| [v1.3.4](rke-v1.3.md#release-v134) | Jan 05 2022 | 01/05/22 | 2022-01-05 |
| [v1.3.3](rke-v1.3.md#release-v133) | Dec 17 2021 | 12/17/21 | 2021-12-17 |
| [v1.3.2](rke-v1.3.md#release-v132) | Nov 03 2021 | 11/03/21 | 2021-11-03 |
| [v1.3.1](rke-v1.3.md#release-v131) | Sep 17 2021 | 09/17/21 | 2021-09-17 |
| [v1.3.0](rke-v1.3.md#release-v130) | Aug 30 2021 | 08/30/21 | 2021-08-30 |



# Release v1.3.22

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.24.15-rancher1-1 (default)`

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.15-rancher1-1` (Default) |
| `v1.23.16-rancher2-3`  |
| `v1.22.17-rancher1-2`  |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.15-rancher1-1

**Updated Hyperkube Image based on k8s versions**

rancher/hyperkube:v1.24.15-rancher1

## What's Changed
* [release/v1.3] Vendor June patches KDM data. by @doflamingo721 in https://github.com/rancher/rke/pull/3270
* [release/v1.3] Vendor June patches KDM data by @doflamingo721 in https://github.com/rancher/rke/pull/3278
* KDM Out Of Band Update For June 2023 - Rancher v2.6 by @HarrisonWAffel in https://github.com/rancher/rke/pull/3285


**Full Changelog**: https://github.com/rancher/rke/compare/v1.3.21...v1.3.22
-----
# Release v1.3.21

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.24.13-rancher2-2 (default)`, `v1.23.16-rancher2-3`

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.13-rancher2-2 (default)` (Default) |
| `v1.23.16-rancher2-3`  |
| `v1.22.17-rancher1-2`  |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.13-rancher2-2

**Updated Hyperkube Image based on k8s versions**

rancher/hyperkube:v1.24.13-rancher2

## What's Changed
* [v2.6] Added ACI 5.2.7.1 variables by @LavanyaVaddavalli in https://github.com/rancher/rke/pull/3254
* [v1.3] update kdm by @kinarashah in https://github.com/rancher/rke/pull/3263
* [v1.3] update kdm data by @kinarashah in https://github.com/rancher/rke/pull/3266

**Full Changelog**: https://github.com/rancher/rke/compare/v1.3.20...v1.3.21
-----
# Release v1.3.20

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.13-rancher2-1`, `v1.23.16-rancher2-2`

- ACI-CNI version bumped from `5.2.3.5` to `5.2.3.6`

## Known Major Issues
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.13-rancher2-1` (Default) |
| `v1.23.16-rancher2-2`  |
| `v1.22.17-rancher1-2` |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.13-rancher2-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.13-rancher2
-----
# Release v1.3.19

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.10-rancher4-1`, `v1.23.16-rancher2-1` and `v1.22.17-rancher1-2`. 

## Major Bug Fixes 
- Fixed high cpu usage issue for v1.24 clusters [#38816](https://github.com/rancher/rancher/issues/38816) 
- Fixed issues around `hostname-override` for AWS cloud provider: 
   1. Added `hostname-override` back to RKE. RKE will continue finding the node by matching `hostname_override` to `kubernetes.io/hostname` label on the node. Fixes `node not found` regression. 
   
   2. RKE will now set the `hostname-override` for `kube-proxy` to the instance metadata hostname only if `useInstanceMetadataHostname` is true. If `useInstanceMetadataHostname` is false, RKE will use `hostname-override` set by users. 
   
   Refer to [RKE PR](https://github.com/rancher/rke/pull/3136) for more details and https://github.com/rancher/rancher/issues/37634#issuecomment-1404341406 for testing usecases. 

- Fixed upgrade issue from clusters having v1beta1 calico custom resource definitions with latest kubernetes versions. [#40280](https://github.com/rancher/rancher/issues/40280)

- Removed flannel cpu/memory limits with latest kubernetes versions [#40178](https://github.com/rancher/rancher/issues/40178) 
      
## Known Major Issues
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.10-rancher4-1` (Default) |
| `v1.23.16-rancher2-1`  |
| `v1.22.17-rancher1-2` |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.10-rancher4-1 and v1.23.16-rancher2-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.10-rancher4 
- rancher/hyperkube:v1.23.16-rancher2
-----
# Release v1.3.18

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.9-rancher1-1` ,`v1.23.15-rancher1-1` and `v1.22.17-rancher1-1`. 
- Introduced canal and calico v3.22.5 for `v1.24.9-rancher1-1` ,`v1.23.15-rancher1-1` and `v1.22.17-rancher1-1`

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`. 

| Kubernetes version    |
| --------------------- |
| `v1.24.9-rancher1-1` (Default) |
| `v1.23.15-rancher1-1`  |
| `v1.22.17-rancher1-1` |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.8-rancher1-1, v1.23.14-rancher1-1 and v1.22.16-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.9-rancher1 
- rancher/hyperkube:v1.23.15-rancher1
- rancher/hyperkube:v1.22.17-rancher1
-----
# Release v1.3.17

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.8-rancher1-1` ,`v1.23.14-rancher1-1` and `v1.22.16-rancher1-1`. 

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`. 

| Kubernetes version    |
| --------------------- |
| `v1.24.8-rancher1-1` (Default) |
| `v1.23.14-rancher1-1`  |
| `v1.22.16-rancher1-1` |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.8-rancher1-1, v1.23.14-rancher1-1 and v1.22.16-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.8-rancher1 
- rancher/hyperkube:v1.23.14-rancher1
- rancher/hyperkube:v1.22.16-rancher1
-----
# Release v1.3.16

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.6-rancher1-1` and `v1.23.12-rancher1-1`.  
- Updated `v1.22.15` to use new metrics-server v0.5.2. 

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`. 

| Kubernetes version    |
| --------------------- |
| `v1.24.6-rancher1-1` (Default) |
| `v1.23.12-rancher1-1`  |
| `v1.22.15-rancher1-1` |
| `v1.21.14-rancher1-1`  |
| `v1.20.15-rancher2-2`  |
| `v1.19.16-rancher2-1`  |
| `v1.18.20-rancher1-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.6-rancher1-1 and v1.23.12-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.6-rancher1 
- rancher/hyperkube:v1.23.12-rancher1
-----
# Release v1.3.15

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.19.16-rancher2-1` with updated hyperkube image `v1.19.16-rancher2`. See [rancher/38906](https://github.com/rancher/rancher/issues/38906)

## Bug Fixes 
- Fixed an issue where `rke up` deletes user addons before redeploying them. See [#3042](https://github.com/rancher/rke/issues/3042)
- Fixed an issue where rke dies with SIGSEGV on creating an etcd snapshot. See [#3028](https://github.com/rancher/rke/issues/3028)

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.4-rancher1-1` (Default) |
| `v1.23.10-rancher1-1`  |
| `v1.22.13-rancher1-1` |
| `v1.21.14-rancher1-1` |
| `v1.20.15-rancher2-2` |
| `v1.19.16-rancher2-1` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.19.16-rancher2-1 

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.19.16-rancher2
-----
# Release v1.3.14

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.4-rancher1-1`,`v1.23.10-rancher1-1`, `v1.22.13-rancher1-1`


## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.4-rancher1-1` (Default) |
| `v1.23.10-rancher1-1`  |
| `v1.22.13-rancher1-1` |
| `v1.21.14-rancher1-1` |
| `v1.20.15-rancher2-2` |
| `v1.19.16-rancher1-6` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.4-rancher1, v1.23.10-rancher1, v1.22.13-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.4-rancher1
- rancher/hyperkube:v1.23.10-rancher1
- rancher/hyperkube:v1.22.13-rancher1
-----
# Release v1.3.13

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.2-rancher1-1`,`v1.23.8-rancher1-1`, `v1.22.11-rancher1-1`, `v1.21.14-rancher1-1` and `v1.20.15-rancher2-2`
- `cri-dockerd` is now enabled by default for `v1.24.2-rancher1-1`. 
- Added retries for etcd snapshot and other improvements; for more details, see [#2952](https://github.com/rancher/rke/pull/2952).

## Bug Fixes

- Fixed an issue where Docker image pull fails from private registry if cri-dockerd is enabled. See [#3002](https://github.com/rancher/rke/pull/3002).


## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.2-rancher1-1` (Default) |
| `v1.23.8-rancher1-1`  |
| `v1.22.11-rancher1-1` |
| `v1.21.14-rancher1-1` |
| `v1.20.15-rancher2-2` |
| `v1.19.16-rancher1-6` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.2-rancher1, v1.23.8-rancher1, v1.22.11-rancher1, v1.21.14-rancher1, v1.20.15-rancher2-2

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.2-rancher1
- rancher/hyperkube:v1.23.8-rancher1
- rancher/hyperkube:v1.22.11-rancher1
- rancher/hyperkube:v1.21.14-rancher1
- rancher/hyperkube:v1.20.15-rancher2
-----
# Release v1.3.12

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.23.7-rancher1-1`, `v1.22.10-rancher1-1` and `v1.21.13-rancher1-1`
- Introduced new versions `v1.19.16-rancher1-6`, `v1.20.15-rancher1-4`, `v1.21.13-rancher1-1`, `v1.22.10-rancher1-1` and `v1.23.7-rancher1-1`  to use `nginx-1.2.1-rancher1` based off of upstream [nginx ingress v1.2.1](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.1). 

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.23.7-rancher1-1` (Default) |
| `v1.22.10-rancher1-1`  |
| `v1.21.13-rancher1-1` |
| `v1.20.15-rancher1-4` |
| `v1.19.16-rancher1-6` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version    |
| --------------------- |
| N/A | 

### New Images in v1.23.7-rancher1, v1.22.10-rancher1, v1.21.13-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.23.6-rancher1
- rancher/hyperkube:v1.22.10-rancher1
- rancher/hyperkube:v1.21.13-rancher1
-----
# Release v1.3.11

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Kubernetes v1.23 is no longer experimental; it is now supported and the default version.

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.23.6-rancher1-1` (Default) |
| `v1.22.9-rancher1-1`  |
| `v1.21.12-rancher1-1` |
| `v1.20.15-rancher1-3` |
| `v1.19.16-rancher1-5` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version    |
| --------------------- |
| N/A | 

### New Images in v1.23.6-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.23.6-rancher1
-----
# Release v1.3.10

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced new Kubernetes versions `v1.21.12-rancher1-1`, `v1.22.9-rancher1-1` and `v1.23.6-rancher1-1` which use etcd `v3.5.3`. [Etcd v3.5.3](https://github.com/etcd-io/etcd/blob/main/CHANGELOG/CHANGELOG-3.5.md#v353-2022-04-13) fixes [inconsistent revisions and data occurs](https://github.com/etcd-io/etcd/pull/13908) in v3.5.0-v3.5.2. 
- Introduced new versions `v1.19.16-rancher1-5`, `v1.20.15-rancher1-3`, `v1.21.12-rancher1-1`, `v1.22.9-rancher1-1` and `v1.23.6-rancher1-1` to use `nginx-1.2.0-rancher1` based off of upstream [nginx ingress v1.2.0](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.0) for [CVE-2021-25745](https://github.com/kubernetes/ingress-nginx/issues/8502). 

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.22.9-rancher1-1`  |
| `v1.21.12-rancher1-1` |
| `v1.20.15-rancher1-3` |
| `v1.19.16-rancher1-5` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version    |
| --------------------- |
| `v1.23.6-rancher1-1` | 

### New Images in v1.23.6-rancher1, v1.22.9-rancher1, and v1.21.12-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.23.6-rancher1
- rancher/hyperkube:v1.22.9-rancher1
- rancher/hyperkube:v1.21.12-rancher1
-----
# Release v1.3.9

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Announcement 
**A data-corruption issue is reported in etcd 3.5.0, 3.5.1 and 3.5.2 per [upstream etcd advisory](https://groups.google.com/a/kubernetes.io/g/dev/c/B7gJs88XtQc/m/rSgNOzV2BwAJ). [The upstream issue](https://github.com/etcd-io/etcd/issues/13766) has not yet been resolved and no fix is available.**
**All 1.22 and 1.23 releases of RKE embed etcd v3.5.x. For this reason, we recommend that users avoid deploying new production Kubernetes clusters using these releases until the issue is fixed upstream and we publish a release that includes that fix.** 

**Please note that RKE v1.3.8+ creates clusters with v1.22.x by default so we recommend setting `kubernetes_version:` in cluster.yml to other available Kubernetes versions.**

**For existing clusters created with these versions, upstream recommends:** 

> Enable data corruption check with `--experimental-initial-corrupt-check` flag. The flag is the only reliable automated way of detecting an inconsistency. This mode has seen significant usage in production and is going to be promoted as default in etcd v3.6. 

Per upstream recommendation as mentioned above, please update your existing clusters to the following new versions introduced with RKE v1.3.9: `v1.22.7-rancher1-2` and `v1.23.4-rancher1-2`. They have the etcd arg `experimental-initial-corrupt-check` set to `true`.  

**Note this may not always work https://github.com/etcd-io/etcd/issues/13766#issuecomment-1083033017 and we suggest not deploying new clusters on production with these versions.** 

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.22.7-rancher1-2`  |
| `v1.21.10-rancher1-1` |
| `v1.20.15-rancher1-2` |
| `v1.19.16-rancher1-4` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version    |
| --------------------- |
| `v1.23.4-rancher1-2` | 

### New Images in v1.23.4-rancher1-2, v1.22.7-rancher1-2, and v1.21.10-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.23.4-rancher1
- rancher/hyperkube:v1.22.7-rancher1
- rancher/hyperkube:v1.21.10-rancher1
-----
# Release v1.3.8

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Kubernetes v1.22 is no longer experimental and is now supported. Kubernetes v1.23 is experimental.

## Major Bug Fixes

- CoreDNS Autoscaler now has a readiness and liveness check. See [#24939](https://github.com/rancher/rancher/issues/24939).
- Fixed a regression such that options passed in cluster configuration for nginx configuration don't get passed to the new nginx ingress controller configmap. This is fixed with Kubernetes versions `1.19.16-rancher1-4`, `1.20.15-rancher1-2`, `1.21.9-rancher1-2`. See [#36851](https://github.com/rancher/rancher/issues/36851#issuecomment-1076611079) for more information.
- Fixed an issue where rotateEncryptionKey resulted into a panic when creating cluster. See [#36333](https://github.com/rancher/rancher/issues/36333).

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.22.7-rancher1-1`  |
| `v1.21.10-rancher1-1` |
| `v1.20.15-rancher1-2` |
| `v1.19.16-rancher1-4` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version    |
| --------------------- |
| `v1.23.4-rancher1-1` | 

### New Images in v1.23.4-rancher1, v1.22.7-rancher1, and v1.21.10-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.23.4-rancher1
- rancher/hyperkube:v1.22.7-rancher1
- rancher/hyperkube:v1.21.10-rancher1
-----
# Release v1.3.7

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Security Enhancements

- Updated NGINX Ingress Controller image to v1.1.0 to address critical CVEs. See [#36136](https://github.com/rancher/rancher/issues/36136).

## Major Bug Fixes

- Fixed a regression in nginx ingress template where `tcp-services-configmap` and `udp-services-configmap` weren't applied on upgrade from `nginx-ingress-v0.30.0` to `>=controller-v0.31.0`. See [#35943](https://github.com/rancher/rancher/issues/35943).

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.21.9-rancher1-1` |
| `v1.20.15-rancher1-1`  |
| `v1.19.16-rancher1-3` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version    |
| --------------------- |
| `v1.22.6-rancher1-1` | 

### New Images in v1.22.6-rancher1, v1.21.9-rancher1, and v1.20.15-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.22.6-rancher1
- rancher/hyperkube:v1.21.9-rancher1
- rancher/hyperkube:v1.20.15-rancher1
-----
# Release v1.3.6

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.22.5-rancher2`, and `v1.21.8-rancher2` to use new hyperkube base with updated iptables > 1.8.5 https://github.com/rancher/rancher/issues/35709 

## Fixes 

* Added logic to delete hostname-override in kubelet for aws cloud provider https://github.com/rancher/rke/pull/2803

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.21.8-rancher2-1` | 
| `v1.20.14-rancher2-1`  |
| `v1.19.16-rancher1-3` |
| `v1.18.20-rancher1-3` |

| Experimental Kubernetes version |
| --------------------- |
| `v1.22.5-rancher2-1` | 

### New Images in v1.22.5-rancher1 and v1.21.8-rancher1 

**Updated Hyperkube Image based on k8s versions**
- rancher/hyperkube:v1.22.5-rancher2
- rancher/hyperkube:v1.21.8-rancher2
-----

-----
# Release v1.3.4

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.22.5-rancher1`, `v1.21.8-rancher1` and `v1.20.14-rancher1`. 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.22.5-rancher1-1` | 
| `v1.21.8-rancher1-1` | 
| `v1.20.14-rancher1-1`  |
| `v1.19.16-rancher1-2` |
| `v1.18.20-rancher1-3` |

### New Images in v1.22.5-rancher1, v1.21.8-rancher1 and v1.20.14-rancher1

**Updated Hyperkube Image based on k8s versions**
- rancher/hyperkube:v1.22.5-rancher1
- rancher/hyperkube:v1.21.8-rancher1
- rancher/hyperkube:v1.20.14-rancher1
-----
# Release v1.3.3

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.22.4-rancher1`, `v1.21.7-rancher1` and `v1.20.13-rancher1`. 

## Fixes 

* Fixed an issue where custom encryption config didn't work in cluster.yml. [[#2701](https://github.com/rancher/rke/pull/2701)]

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.22.4-rancher1-1` | 
| `v1.21.7-rancher1-1` | 
| `v1.20.13-rancher1-1`  |
| `v1.19.16-rancher1-2` |
| `v1.18.20-rancher1-3` |

### New Images in v1.22.4-rancher1, v1.21.7-rancher1 and v1.20.13-rancher1

**Updated Hyperkube Image based on k8s versions**
- rancher/hyperkube:v1.22.4-rancher1
- rancher/hyperkube:v1.21.7-rancher1
- rancher/hyperkube:v1.20.13-rancher1
-----
# Release v1.3.2

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.21.6-rancher1`, `v1.20.12-rancher1` and `v1.19.16-rancher1`.
* Introduced new nginx-ingress image `nginx-0.49.3-rancher1` to address [CVE-2021-25742](https://github.com/kubernetes/ingress-nginx/issues/7837) for `v1.21.6-rancher1`, `v1.20.12-rancher1` and `v1.19.16-rancher1`. 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.21.6-rancher1-1` | 
| `v1.20.12-rancher1-1`  |
| `v1.19.16-rancher1-1` |
| `v1.18.20-rancher1-2` |

### New Images in v1.21.6-rancher1, v1.20.12-rancher1, v1.19.16-rancher1

**Updated Hyperkube Image based on k8s versions**
- rancher/hyperkube:v1.21.6-rancher1
- rancher/hyperkube:v1.20.12-rancher1
- rancher/hyperkube:v1.19.16-rancher1
-----
# Release v1.3.1

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.21.5-rancher1`, `v1.20.11-rancher1`, and `v1.19.15-rancher1`.

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.21.5-rancher1-1` | 
| `v1.20.11-rancher1-2`  |
| `v1.19.15-rancher1-2` |
| `v1.18.20-rancher1-2` |

### New Images in v1.20.9-rancher1, v1.19.13-rancher1

**Updated Hyperkube Image based on k8s versions**
- rancher/hyperkube:v1.21.5-rancher1
- rancher/hyperkube:v1.20.11-rancher1
- rancher/hyperkube:v1.19.15-rancher1
-----
# Release v1.3.0

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements
- Introduced support for Kubernetes v1.21.
- Introduced option to enable cri-dockerd for Kubernetes v1.21. 
- Introduced support to enable IPv6DualStack for Kubernetes v1.21. [#1902](https://github.com/rancher/rke/issues/1902)
- Introduced support for ECR plugin [#28693](https://github.com/rancher/rancher/issues/28693) 

## Major Bug Fixes since v1.2.11
- Fixed an issue where etcd snapshot-restore fails with encryption and custom certs [#2559](https://github.com/rancher/rke/issues/2559)
- Fixed an issue for v1.21 clusters where Flannel pods do not come active on SELinux enabled nodes [#2620](https://github.com/rancher/rke/issues/2620)
- Fixed an issue where `etcd-snapshot save` without local state file waits for state file to get copied [#2492](https://github.com/rancher/rke/issues/2492) 
- Fixed an issue where proxy env vars weren't unset correctly for bastion host [#2525](https://github.com/rancher/rke/issues/2525)
- Fixed an issue for vsphere clusters where addon jobs don't complete before timeout [#2535](https://github.com/rancher/rke/issues/2535)
- Fixed an issue where etcd fails to find hostname certs with uppercase cert names. [#2485](https://github.com/rancher/rke/issues/2485)
- Fixed an issue where cert generate-csr does not reflect changes to nodes [#2571](https://github.com/rancher/rke/issues/2571) 


## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images) option in your `cluster.yml`.

 Kubernetes version|
 -----------------|
 `v1.21.4-rancher1-1`|  (default)
 `v1.20.10-rancher1-2`
 `v1.19.14-rancher1-2`|  
 `v1.18.20-rancher1-2`|


-----
