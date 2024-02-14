| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.5.5](rke-v1.5.md#release-v155) | Feb 13 2024 | 02/13/24 | 2024-02-13 |
| [v1.5.3](rke-v1.5.md#release-v153) | Jan 22 2024 | 01/22/24 | 2024-01-22 |
| [v1.5.2](rke-v1.5.md#release-v152) | Jan 17 2024 | 01/17/24 | 2024-01-17 |
| [v1.5.1](rke-v1.5.md#release-v151) | Dec 19 2023 | 12/19/23 | 2023-12-19 |
| [v1.5.0](rke-v1.5.md#release-v150) | Dec 01 2023 | 12/01/23 | 2023-12-01 |



Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

Note: There is no official release for v1.5.4, the next release version available after v1.5.3 is v1.5.5.  

## What's Changed
* Introduced `v1.27.10-rancher1-1` and `v1.26.13-rancher1-1` 
* Updated containerd to v1.6.27 and runc to v1.1.12 https://github.com/rancher/rke/pull/3495

## Kubernetes Versions 

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.27.10-rancher1-1` (Default) |
| `v1.26.13-rancher1-1`  |
| `v1.25.16-rancher2-2`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.5.3...v1.5.5
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
* Add architecture.md by @manuelbuil in https://github.com/rancher/rke/pull/3453
* Clean/speed up Drone by @superseb in https://github.com/rancher/rke/pull/3417
* [release/v1.5] Simplify update README workflow by @superseb in https://github.com/rancher/rke/pull/3436
* [v1.5] Added ACI-CNI 6.0.3.2 variables by @akhilesh-oc in https://github.com/rancher/rke/pull/3475
* [v1.5] update kdm branch to release-v2.8 by @kinarashah in https://github.com/rancher/rke/pull/3479

| Kubernetes version    |
| --------------------- |
| `v1.27.8-rancher2-2` (Default) |
| `v1.26.11-rancher2-2`  |
| `v1.25.16-rancher2-2`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.5.2...v1.5.3
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.27.8-rancher2-1`, `v1.26.11-rancher2-1` and `v1.25.16-rancher2-1`
- Introduced calico and canal `v3.26.3` and nginx ingress `v1.9.4` for `v1.27.8-rancher2-1`, `v1.26.11-rancher2-1` and `v1.25.16-rancher2-1`

## Bug Fixes

- Added ACI 6.0.3.1 variables

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.27.8-rancher2-1` (Default) |
| `v1.26.11-rancher2-1`  |
| `v1.25.16-rancher2-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.5.2...v1.5.1
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements

- Introduced `v1.27.8-rancher2-1`, `v1.26.11-rancher2-1` and `v1.25.16-rancher2-1`
- Introduced calico and canal `v3.26.3` and nginx ingress `v1.9.4` for `v1.27.8-rancher2-1`, `v1.26.11-rancher2-1` and `v1.25.16-rancher2-1`

## Bug Fixes

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.27.8-rancher2-1` (Default) |
| `v1.26.11-rancher2-1`  |
| `v1.25.16-rancher2-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

**Full Changelog**: https://github.com/rancher/rke/compare/v1.5.1...v1.5.0
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## Enhancements
* Added support for `v1.27.6-rancher1-1`. 
* Introduced support for `external-aws`. 
  - In Kubernetes 1.27 and later, you must use an out-of-tree AWS cloud provider. See [documentation on how to set up external-aws](https://rke.docs.rancher.com/config-options/cloud-providers/aws#using-the-out-of-tree-aws-cloud-provider-for-rke).
  - All existing clusters must migrate prior to upgrading to v1.27 in order to stay functional. See [documentation on how to migrate to external-aws](https://rke.docs.rancher.com/config-options/cloud-providers/aws#migrating-to-the-out-of-tree-aws-cloud-provider-for-rke) on Kubernetes 1.26 and earlier. 
  - Note that there is a known issue with `external-aws` where RKE fails to find the node if both `hostname-override` and `internal-address` are empty. For more information, see https://github.com/rancher/rke/issues/3445 

## Other changes 
* [release/v1.5] Add env var to enable dual-stack in cri-dockerd by @superseb in https://github.com/rancher/rke/pull/3370
* [release/v1.5] Security bumps by @macedogm in https://github.com/rancher/rke/pull/3339
* Add warning log about weave deprecation by @manuelbuil in https://github.com/rancher/rke/pull/3337
* Fix "unknown revision v0.0.0" error caused by the k8s.io/kubernetes module by @jiaqiluo in https://github.com/rancher/rke/pull/3387
* changed etcd restore image to rke-tools for etcd >=3.5.7 by @vardhaman22 in https://github.com/rancher/rke/pull/3390

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.27.6-rancher1-1` (Default) | 
| `v1.26.9-rancher1-1`  |
| `v1.25.14-rancher1-1`  |

| Experimental Kubernetes version |
| --------------------- |
| N/A | 

## New Contributors
* @pjbgf made their first contribution in https://github.com/rancher/rke/pull/3410

**Full Changelog**: https://github.com/rancher/rke/compare/v1.4.11...v1.5.0
-----
