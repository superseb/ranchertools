| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| [v1.6.3](rke-v1.6.md#release-v163) | Oct 21 2024 | 10/21/24 | 2024-10-21 |
| [v1.6.2](rke-v1.6.md#release-v162) | Sep 17 2024 | 09/17/24 | 2024-09-17 |
| [v1.6.1](rke-v1.6.md#release-v161) | Aug 05 2024 | 08/05/24 | 2024-08-05 |
| [v1.6.0](rke-v1.6.md#release-v160) | Jul 22 2024 | 07/22/24 | 2024-07-22 |



Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
* Bump github.com/opencontainers/runc from 1.1.12 to 1.1.14  
* Add ACI-CNI 6.1.1.1 variable  


# RKE Kubernetes versions
- `v1.27.16-rancher1-1`
- `v1.28.14-rancher1-1`
- `v1.29.9-rancher1-1`
- `v1.30.5-rancher1-1` (default)
-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
- Introduced `v1.30.4`, `v1.29.8` and `v1.28.13`
- Introduced calico and canal `v3.28.1` for `v1.30.4`
- Introduced calico and canal  `v3.27.4` for `v1.29.8` and `v1.28.13`
- Introduced nginx `v1.11.2` for `v1.30.4`, `v1.29.8` and `v1.28.13` 
- Introdced ACI `v6.0.4.3` for `v1.30.4`, `v1.29.8` and `v1.28.13`  

# RKE Kubernetes versions
- `v1.27.16-rancher1-1`
- `v1.28.13-rancher1-1`
- `v1.29.8-rancher1-1`
- `v1.30.4-rancher1-1` (default)

-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
- Introduced `v1.30.3`, `v1.29.7`, `v1.28.12` and `v1.27.16`

# RKE Kubernetes versions
- `v1.27.16-rancher1-1`
- `v1.28.12-rancher1-1`
- `v1.29.7-rancher1-1`
- `v1.30.3-rancher1-1` (default) 

-----
Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you're running.

## What's Changed
- Introduced `v1.30.2`, `v1.29.6`, `v1.28.11` and `v1.27.15`

>  In Kubernetes 1.30 and later, you must use an out-of-tree Azure cloud provider. The Azure cloud provider has been [removed completely](https://github.com/kubernetes/kubernetes/pull/122857), and won't work after an upgrade to Kubernetes 1.30 
> Weave CNI has been removed starting with Kubernetes 1.30 (https://github.com/rancher/rke/pull/3623)

> In Kubernetes 1.29, in-tree cloud providers have been disabled for **all cloud providers**. You must disable the `DisableCloudProviders` and `DisableKubeletCloudCredentialProvider` to use the in-tree cloud provider. See [upstream changes](https://github.com/kubernetes/kubernetes/pull/117503) for more details 

- Introduced support for Docker v26.0.x (https://github.com/rancher/rke/pull/3565) 
- Introduced ACI CNI v6.0.4.2 (https://github.com/rancher/rke/pull/3626)
- Fixed an issue with cluster provisioning and reconciling when using `extra_env` for `kube-api` (https://github.com/rancher/rke/pull/3597) 
- Fixed an issue with etcd node removal where RKE would would try to remove the member indefinitely (https://github.com/rancher/rke/pull/3573) 
- Fixed an issue with k8s >= 1.22 clusters where clusters would sporadically fail to scale etcd nodes (https://github.com/rancher/rke/pull/3622) 

# RKE Kubernetes versions
- `v1.27.15-rancher1-1`
- `v1.28.11-rancher1-1`
- `v1.29.6-rancher1-1`
- `v1.30.2-rancher1-1` (default) 

-----
