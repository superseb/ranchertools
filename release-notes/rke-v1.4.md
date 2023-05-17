| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.4.5](rke-v1.4.md#release-v145) | Apr 26 2023 | 04/26/23 | 2023-04-26 |
| [v1.4.4](rke-v1.4.md#release-v144) | Apr 07 2023 | 04/07/23 | 2023-04-07 |
| [v1.4.3](rke-v1.4.md#release-v143) | Mar 07 2023 | 03/07/23 | 2023-03-07 |
| [v1.4.2](rke-v1.4.md#release-v142) | Jan 24 2023 | 01/24/23 | 2023-01-24 |
| [v1.4.1](rke-v1.4.md#release-v141) | Nov 28 2022 | 11/28/22 | 2022-11-28 |
| [v1.4.0](rke-v1.4.md#release-v140) | Nov 11 2022 | 11/11/22 | 2022-11-11 |



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
