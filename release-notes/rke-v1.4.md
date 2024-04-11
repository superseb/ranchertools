| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.4.17](rke-v1.4.md#release-v1417) | Apr 10 2024 | 04/10/24 | 2024-04-10 |
| [v1.4.16](rke-v1.4.md#release-v1416) | Mar 07 2024 | 03/07/24 | 2024-03-07 |
| [v1.4.15](rke-v1.4.md#release-v1415) | Feb 27 2024 | 02/27/24 | 2024-02-27 |
| [v1.4.14](rke-v1.4.md#release-v1414) | Feb 13 2024 | 02/13/24 | 2024-02-13 |
| [v1.4.13](rke-v1.4.md#release-v1413) | Jan 22 2024 | 01/22/24 | 2024-01-22 |
| [v1.4.12](rke-v1.4.md#release-v1412) | Dec 19 2023 | 12/19/23 | 2023-12-19 |
| [v1.4.11](rke-v1.4.md#release-v1411) | Nov 15 2023 | 11/15/23 | 2023-11-15 |
| [v1.4.10](rke-v1.4.md#release-v1410) | Sep 19 2023 | 09/19/23 | 2023-09-19 |
| [v1.4.9](rke-v1.4.md#release-v149) | Sep 11 2023 | 09/11/23 | 2023-09-11 |
| [v1.4.8](rke-v1.4.md#release-v148) | Aug 03 2023 | 08/03/23 | 2023-08-03 |
| [v1.4.7](rke-v1.4.md#release-v147) | Jul 06 2023 | 07/06/23 | 2023-07-06 |
| [v1.4.6](rke-v1.4.md#release-v146) | Jun 23 2023 | 06/23/23 | 2023-06-23 |
| [v1.4.5](rke-v1.4.md#release-v145) | Apr 26 2023 | 04/26/23 | 2023-04-26 |
| [v1.4.4](rke-v1.4.md#release-v144) | Apr 07 2023 | 04/07/23 | 2023-04-07 |
| [v1.4.3](rke-v1.4.md#release-v143) | Mar 07 2023 | 03/07/23 | 2023-03-07 |
| [v1.4.2](rke-v1.4.md#release-v142) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v1.4.1](rke-v1.4.md#release-v141) | Nov 28 2022 | 11/28/22 | 2022-11-28 |
| [v1.4.0](rke-v1.4.md#release-v140) | Nov 11 2022 | 11/11/22 | 2022-11-11 |



Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed

| Kubernetes version |
| ----- |
| `v1.23.16-rancher2-3` |
| `v1.24.17-rancher1-1` |
| `v1.25.16-rancher2-3` |
| `v1.26.15-rancher1-1` |
| `v1.27.12-rancher1-1` (default) |
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
* Add ACI CNI 6033, 6041 variables https://github.com/rancher/rke/pull/3516

| Kubernetes version|
| ---- |
| `v1.27.11-rancher1-1` (default)|
 |`v1.26.14-rancher1-1`|
|`v1.25.16-rancher2-3`|
 |`v1.24.17-rancher1-1`|
 |`v1.23.16-rancher2-3`|

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.15...v1.4.16
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
* K8s 1.27 support https://github.com/rancher/rke/pull/3482
* External AWS cloud provider support https://github.com/rancher/rke/pull/3482
* Added Weave deprecation warning https://github.com/rancher/rke/pull/3482
* Changed etcd restoreImage to rke-tools for etcd >=3.5.7 https://github.com/rancher/rke/pull/3486

# RKE Kubernetes versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.27.10-rancher1-1` (default) |
| `v1.26.13-rancher1-1` |
| `v1.25.16-rancher2-2` |
| `v1.24.17-rancher1-1` |
| `v1.23.16-rancher2-3` |





| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.14...v1.4.15
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running. 

## What's Changed
* Introduced `v1.26.13-rancher1-1` 
* Fixed an issue for etcd v3.5.9 where etcd snapshot-restore fails due to missing /bin/sh in etcd container image [#3485](https://github.com/rancher/rke/issues/3485)
* Updated containerd to v1.6.27 and runc to v1.1.12 https://github.com/rancher/rke/pull/3494 

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.13-rancher1-1` (Default) |
| `v1.25.16-rancher2-2`  |
| `v1.24.17-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.13...v1.4.14
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running. 

## What's Changed
* [release/v1.4] Move to BCI by @superseb in https://github.com/rancher/rke/pull/3174
* Revert "Move to BCI" by @manuelbuil in https://github.com/rancher/rke/pull/3473
* Added ACI-CNI 6.0.3.2 variables  by @akhilesh-oc in https://github.com/rancher/rke/pull/3466
* [v1.4] update kdm branch by @kinarashah in https://github.com/rancher/rke/pull/3478

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.11-rancher2-2` (Default) |
| `v1.25.16-rancher2-2`  |
| `v1.24.17-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.12...v1.4.13
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements
- Introduced `v1.26.11-rancher2-1` and `v1.25.16-rancher2-1`
- Introduced calico and canal `v3.26.3` and nginx ingress `v1.9.4` for `v1.26.11-rancher2-1` and `v1.25.16-rancher2-1`

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.11-rancher2-1` (Default) |
| `v1.25.16-rancher2-1`  |
| `v1.24.17-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.12...v1.4.11
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.26.9-rancher1-1`, `v1.25.14-rancher1-1`

## Bug Fixes

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.9-rancher1-1` (Default) |
| `v1.25.14-rancher1-1`  |
| `v1.24.17-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.10...v1.4.11
-----
# Release v1.4.10

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

+ Adds support for Docker `v24.0.x`
* Add sandbox image to images to pre-pull by @jakefhyde in https://github.com/rancher/rke/pull/3211
* Set the default PodSecurityConfiguration value only if the cluster's k8s version is at least 1.23 by @jiaqiluo in https://github.com/rancher/rke/pull/3291
* Bump google.golang.org/grpc from 1.48.0 to 1.53.0 by @dependabot in https://github.com/rancher/rke/pull/3281
* update README and add troubleshooting doc links by @superseb in https://github.com/rancher/rke/pull/3310
* Replace deprecated io/ioutil by @manuelbuil in https://github.com/rancher/rke/pull/3329
* [release/v1.4] Security bumps by @macedogm in https://github.com/rancher/rke/pull/3308
* switch to release-v2.7 for RKE v1.4.10 release by @HarrisonWAffel in https://github.com/rancher/rke/pull/3380


## Bug Fixes 
* Use correct container name in log by @superseb in https://github.com/rancher/rke/pull/3323

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.8-rancher1-1` (Default) |
| `v1.25.13-rancher1-1`  |
| `v1.24.17-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.9...v1.4.10
-----
# Release v1.4.9

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.24.17-rancher1-1`, `v1.25.13-rancher1-1`, `v1.26.8-rancher1-1`
- Added ACI-CNI 6.0.3.1 variables 

## Bug Fixes 

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.8-rancher1-1` (Default) |
| `v1.25.13-rancher1-1`  |
| `v1.24.17-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.26.8-rancher1-1, v1.25.13-rancher1-1 and v1.24.17-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.26.8-rancher1
- rancher/hyperkube:v1.25.13-rancher1
- rancher/hyperkube:v1.24.17-rancher1

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.8...v1.4.9
-----
# Release v1.4.8

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.24.16-rancher1-1`, `v1.25.12-rancher1-1`, `v1.26.7-rancher1-1`

## Bug Fixes 
- Fixed an issue around PodSecurityConfiguration which prevented v1.22 clusters to upgrade https://github.com/rancher/rke/pull/3306

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.7-rancher1-1` (Default) |
| `v1.25.12-rancher1-1`  |
| `v1.24.16-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.26.7-rancher1-1, v1.25.12-rancher1-1 and v1.24.16-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.26.7-rancher1
- rancher/hyperkube:v1.25.12-rancher1
- rancher/hyperkube:v1.24.16-rancher1

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.7...v1.4.8
-----
# Release v1.4.7

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.24.15-rancher1-1`, `v1.25.11-rancher1-1`, `v1.26.6-rancher1-1`

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.6-rancher1-1` (Default) |
| `v1.25.11-rancher1-1`  |
| `v1.24.15-rancher1-1`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.26.6-rancher1-1, v1.25.11-rancher1-1 and v1.24.15-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.26.6-rancher1
- rancher/hyperkube:v1.25.11-rancher1
- rancher/hyperkube:v1.24.15-rancher1

## What's Changed
* [release/v1.4] Vendor June patches KDM data  by @doflamingo721 in https://github.com/rancher/rke/pull/3269
* [release/v1.4] Vendor June patches KDM data by @doflamingo721 in https://github.com/rancher/rke/pull/3276
* [release/v1.4] update README with latest by @github-actions in https://github.com/rancher/rke/pull/3279
* [release/v1.4] go generate by @github-actions in https://github.com/rancher/rke/pull/3282
* [release/v1.4] go generate by @github-actions in https://github.com/rancher/rke/pull/3283
* KDM Out Of Band Update For June 2023 - Rancher v2.7 by @HarrisonWAffel in https://github.com/rancher/rke/pull/3286


**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.6...v1.4.7
-----
# Release v1.4.6

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.26.4-rancher2-1`, `v1.25.9-rancher2-2`, `v1.24.13-rancher2-2`, and `v1.23.16-rancher2-3`

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.26.4-rancher2-1` (Default) |
| `v1.25.9-rancher2-2`  |
| `v1.24.13-rancher2-2`  |
| `v1.23.16-rancher2-3`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.26.4-rancher2-1, v1.25.9-rancher2-2 and v1.24.13-rancher2-2

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.26.4-rancher2
- rancher/hyperkube:v1.25.9-rancher2
- rancher/hyperkube:v1.24.13-rancher2

## What's Changed
* [release/v1.4] update README with latest by @github-actions in https://github.com/rancher/rke/pull/3216
* [release/v1.4] Vendor docker 23.0 support data from KDM. by @doflamingo721 in https://github.com/rancher/rke/pull/3229
* [v1.4] Update KDM for k8s v1.26 by @vardhaman22 in https://github.com/rancher/rke/pull/3237
* [release/v1.4] go generate by @github-actions in https://github.com/rancher/rke/pull/3240
* [v1.4] update kdm for default v1.26 by @kinarashah in https://github.com/rancher/rke/pull/3241
* [v1.4] Sync aci cni changes from v1.4.5 to v1.4 by @kinarashah in https://github.com/rancher/rke/pull/3257
* Bump github.com/docker/docker from 20.10.14+incompatible to 20.10.24+incompatible by @dependabot in https://github.com/rancher/rke/pull/3212
* [release/v1.4] go generate by @github-actions in https://github.com/rancher/rke/pull/3251
* Bump github.com/docker/distribution from 2.8.1+incompatible to 2.8.2+incompatible by @dependabot in https://github.com/rancher/rke/pull/3244
* Added ACI-CNI 5.2.7.1 variables by @LavanyaVaddavalli in https://github.com/rancher/rke/pull/3258
* [release/v1.4] go generate by @github-actions in https://github.com/rancher/rke/pull/3262
* ~set the default PodSecurityConfiguration value only if the cluster's k8s version is at least 1.23 by @jiaqiluo in https://github.com/rancher/rke/pull/3261~ was reverted by  https://github.com/rancher/rke/pull/3265 
* [v1.4] Updates for v1.4.6  by @kinarashah in https://github.com/rancher/rke/pull/3265

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.5...v1.4.6
-----
# Release v1.4.5

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.25.9-rancher2-1`, `v1.24.13-rancher2-1` and `v1.23.16-rancher2-2`
- ACI-CNI version bumped from `5.2.3.5` to `5.2.3.6`  

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.25.9-rancher2-1` (Default) |
| `v1.24.13-rancher2-1`  |
| `v1.23.16-rancher2-2`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.25.9-rancher2-1 and v1.24.13-rancher2-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.25.9-rancher2
- rancher/hyperkube:v1.24.13-rancher2 
-----
# Release v1.4.4

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.25.6-rancher4-1`. 

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.25.6-rancher4-1` (Default) |
| `v1.24.10-rancher4-1`  |
| `v1.23.16-rancher2-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.25.6-rancher4-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.25.6-rancher4 
-----
# Release v1.4.3

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.10-rancher4-1` and `v1.23.16-rancher2-1`. 

## Major Bug Fixes 
- Fixed high cpu usage issue for v1.24 clusters [#38816](https://github.com/rancher/rancher/issues/38816) 
- Fixed issues around `hostname-override` for AWS cloud provider: 
   1. Added `hostname-override` back to RKE. RKE will continue finding the node by matching `hostname_override` to `kubernetes.io/hostname` label on the node. Fixes `node not found` regression. 
   
   2. RKE will now set the `hostname-override` for `kube-proxy` to the instance metadata hostname only if `useInstanceMetadataHostname` is true. If `useInstanceMetadataHostname` is false, RKE will use `hostname-override` set by users. 
   
   Refer to [RKE PR](https://github.com/rancher/rke/pull/3140) for more details and https://github.com/rancher/rancher/issues/37634#issuecomment-1404341406 for testing usecases. 

- Fixed upgrade issue from clusters having v1beta1 calico custom resource definitions with latest kubernetes versions. [#40280](https://github.com/rancher/rancher/issues/40280)

- Removed flannel cpu/memory limits with latest kubernetes versions [#40178](https://github.com/rancher/rancher/issues/40178) 
      
## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.10-rancher4-1` (Default) |
| `v1.23.16-rancher2-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.10-rancher4-1 and v1.23.16-rancher2-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.10-rancher4 
- rancher/hyperkube:v1.23.16-rancher2
-----
# Release v1.4.2

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.9-rancher1-1` and `v1.23.15-rancher1-1`. 
- Introduced calico and canal v3.22.5 for `v1.24.9-rancher1-1` and `v1.23.15-rancher1-1`. 

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.9-rancher1-1` (Default) |
| `v1.23.15-rancher1-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.9-rancher1-1 and v1.23.15-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.9-rancher1 
- rancher/hyperkube:v1.23.15-rancher1

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.1...v1.4.2
-----
# Release v1.4.1

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.8-rancher1-1` and `v1.23.14-rancher1-1`. 

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.8-rancher1-1` (Default) |
| `v1.23.14-rancher1-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.6-rancher1-1 and v1.23.12-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.8-rancher1 
- rancher/hyperkube:v1.23.14-rancher1

## New Contributors
* @masap made their first contribution in https://github.com/rancher/rke/pull/3043

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.0...v1.4.1
-----
# Release v1.4.0

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.24.6-rancher1-1` and `v1.23.12-rancher1-1`.  

## Known Major Issues

- Ephemeral `/var/lib/dockershim` and `/var/lib/cri-dockerd` directories for kubelet container could cause kubelet/dockershim to send empty portMappings after upgrade. The workaround is to bind mount these directories by specifying `extra_binds` for kubelet service. See [#2993](https://github.com/rancher/rke/issues/2993). 
- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.24.6-rancher1-1` (Default) |
| `v1.23.12-rancher1-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

### New Images in v1.24.6-rancher1-1 and v1.23.12-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.24.6-rancher1 
- rancher/hyperkube:v1.23.12-rancher1
-----
