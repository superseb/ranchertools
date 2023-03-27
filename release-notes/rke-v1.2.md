| Version | Date | US date | EU date |
| ------- | ---- | ------- | ------- |
| v1.2.23 | Sep 21 2022 | 09/21/22 | 2022-09-21 |
| v1.2.22 | Aug 17 2022 | 08/17/22 | 2022-08-17 |
| v1.2.21 | Jun 15 2022 | 06/15/22 | 2022-06-15 |
| v1.2.20 | Apr 29 2022 | 04/29/22 | 2022-04-29 |
| v1.2.19 | Mar 30 2022 | 03/30/22 | 2022-03-30 |
| v1.2.18 | Feb 08 2022 | 02/08/22 | 2022-02-08 |
| v1.2.17 | Jan 24 2022 | 01/24/22 | 2022-01-24 |
| v1.2.16 | Jan 05 2022 | 01/05/22 | 2022-01-05 |
| v1.2.15 | Dec 17 2021 | 12/17/21 | 2021-12-17 |
| v1.2.14 | Nov 03 2021 | 11/03/21 | 2021-11-03 |
| v1.2.13 | Sep 17 2021 | 09/17/21 | 2021-09-17 |
| v1.2.12 | Sep 01 2021 | 09/01/21 | 2021-09-01 |
| v1.2.11 | Jul 28 2021 | 07/28/21 | 2021-07-28 |
| v1.2.10 | Jul 26 2021 | 07/26/21 | 2021-07-26 |
| v1.2.9 | Jun 22 2021 | 06/22/21 | 2021-06-22 |
| v1.2.8 | May 03 2021 | 05/03/21 | 2021-05-03 |
| v1.2.7 | Mar 30 2021 | 03/30/21 | 2021-03-30 |
| v1.2.6 | Mar 02 2021 | 03/02/21 | 2021-03-02 |
| v1.2.5 | Jan 25 2021 | 01/25/21 | 2021-01-25 |
| v1.2.4 | Jan 07 2021 | 01/07/21 | 2021-01-07 |
| v1.2.3 | Nov 13 2020 | 11/13/20 | 2020-11-13 |
| v1.2.2 | Nov 09 2020 | 11/09/20 | 2020-11-09 |
| v1.2.1 | Oct 16 2020 | 10/16/20 | 2020-10-16 |
| v1.2.0 | Oct 05 2020 | 10/05/20 | 2020-10-05 |



# Release v1.2.23

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Enhancements

- Introduced `v1.19.16-rancher2-1` with updated hyperkube. See [rancher/38907](https://github.com/rancher/rancher/issues/38907)

## Known Major Issues

- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.15-rancher2-1`  |
| `v1.19.16-rancher2-1` |
| `v1.18.20-rancher1-3` |
| `v1.17.17-rancher2-4` |
-----
# Release v1.2.22

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Major Bug Fixes

- Introduced new `v1.20.15-rancher2-1` with new hyperkube image `v1.20.15-rancher2`. See [#37655](https://github.com/rancher/rancher/issues/37655).

## Known Major Issues

- In clusters where `cloud_provider` is configured and either `address` or `internal_address` does not contain a valid IP address (e.g., hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.15-rancher2-1`  |
| `v1.19.16-rancher1-6` |
| `v1.18.20-rancher1-3` |
| `v1.17.17-rancher2-4` |
-----
# Release v1.2.21

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Major Bug Fixes

- Introduced new versions `v1.19.16-rancher1-6` and `v1.20.15-rancher1-4` to use `nginx-1.2.1-rancher1` based off of upstream [nginx ingress v1.2.1](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.1). 

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.15-rancher1-4`  |
| `v1.19.16-rancher1-6` |
| `v1.18.20-rancher1-3` |
| `v1.17.17-rancher2-4` |

-----
# Release v1.2.20

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Major Bug Fixes

- Introduced new versions `v1.19.16-rancher1-5` and `v1.20.15-rancher1-3` to use `nginx-1.2.0-rancher1` based off of upstream [nginx ingress v1.2.0](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.0) for https://github.com/kubernetes/ingress-nginx/issues/8502.

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.15-rancher1-3`  |
| `v1.19.16-rancher1-5` |
| `v1.18.20-rancher1-3` |
| `v1.17.17-rancher2-4` |

-----
# Release v1.2.19

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes are both simplified and easily automated, and they are entirely independent of the operating system and platform you’re running.

## Major Bug Fixes

- Fixed a regression such that options passed in cluster configuration for nginx configuration don't get passed to the new nginx ingress controller configmap. This is fixed with Kubernetes versions `1.19.16-rancher1-4` and `1.20.15-rancher1-2`. See [#36851](https://github.com/rancher/rancher/issues/36851#issuecomment-1076611079) for more information.
- CoreDNS Autoscaler now has a readiness and liveness check. See [#36362](https://github.com/rancher/rancher/issues/36362).
- Ingresses on Amazon EC2 node driver clusters in an HA Rancher cluster on v1.20 may now be created without error. See [#35754](https://github.com/rancher/rancher/issues/35754).

## Known Major Issues

- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. See [#1725](https://github.com/rancher/rke/issues/1725).

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.15-rancher1-2`  |
| `v1.19.16-rancher1-4` |
| `v1.18.20-rancher1-3` |
| `v1.17.17-rancher2-4` |

### New Images in v1.20.15-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.15-rancher1
-----
# Release v1.2.18

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
| `v1.20.15-rancher1-1`  |
| `v1.19.16-rancher1-3` |
| `v1.18.20-rancher1-3` |
| `v1.17.17-rancher2-4` |

### New Images in v1.20.15-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.15-rancher1
-----

-----
# Release v1.2.16

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.14-rancher1`. 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.14-rancher1-1`  |
| `v1.19.16-rancher1-1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.14-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.14-rancher1
-----
# Release v1.2.15

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.13-rancher1`. 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.13-rancher1-1`  |
| `v1.19.16-rancher1-1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.13-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.13-rancher1
-----
# Release v1.2.14

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.12-rancher1` and `v1.19.16-rancher1`.
* Introduced new nginx-ingress image `nginx-0.49.3-rancher1` to address [CVE-2021-25742](https://github.com/kubernetes/ingress-nginx/issues/7837) for `v1.20.12-rancher1` and `v1.19.16-rancher1`. 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.12-rancher1-1`  |
| `v1.19.16-rancher1-1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.12-rancher1, v1.19.16-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.12-rancher1
- rancher/hyperkube:v1.19.16-rancher1
-----
# Release v1.2.13

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.11-rancher1`, and `v1.19.15-rancher1`.

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.11-rancher1-1`  |
| `v1.19.15-rancher1-1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.9-rancher1, v1.19.13-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.11-rancher1
- rancher/hyperkube:v1.19.15-rancher1
-----

-----
# Release v1.2.11

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Bug Fixes
- changed the default kubernetes version to v1.20.9-rancher1-1, this was incorrectly set to an older version v1.20.8-rancher1-1

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.9-rancher1-1`  |
| `v1.19.13-rancher1-1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.9-rancher1
- rancher/hyperkube:v1.19.13-rancher1
- rancher/hyperkube:v1.18.20-rancher1
-----
# Release v1.2.10

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.9-rancher1`, and `v1.19.13-rancher1`.

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.9-rancher1`  |
| `v1.19.13-rancher1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.9-rancher1, v1.19.13-rancher1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.9-rancher1
- rancher/hyperkube:v1.19.13-rancher1
- rancher/hyperkube:v1.18.20-rancher1
-----
# Release v1.2.9

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.8-rancher1-1`, `v1.19.12-rancher1-1` and `v1.18.20-rancher1-2`. 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.8-rancher1-1`  |
| `v1.19.12-rancher1-1` |
| `v1.18.20-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.8-rancher1-1, v1.19.12-rancher1-1, v1.18.20-rancher1-2

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.8-rancher1
- rancher/hyperkube:v1.19.12-rancher1
- rancher/hyperkube:v1.18.20-rancher1
-----
# Release v1.2.8

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.6-rancher1-1`, `v1.19.10-rancher1-1`, `v1.18.18-rancher1-2` and `v1.17.17-rancher2-3`
* Kubeconfig and state files have file permissions set to 0600
* The S3 Access Key and Secret Key are passed as environment variables to the etcd-rolling-snapshots container

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.6-rancher1-1`  |
| `v1.19.10-rancher1-1` |
| `v1.18.18-rancher1-2` |
| `v1.17.17-rancher2-3` |

### New Images in v1.20.6-rancher1-1, v1.19.10-rancher1-1, v1.18.18-rancher1-2 and v1.17.17-rancher2-3

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.6-rancher1
- rancher/hyperkube:v1.19.10-rancher1
- rancher/hyperkube:v1.18.18-rancher1
- rancher/hyperkube:v1.17.17-rancher2
-----
# Release v1.2.7

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.5-rancher1-1`, `v1.19.9-rancher1-1` and`v1.18.17-rancher1-1`.

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.5-rancher1-1`  |
| `v1.19.9-rancher1-1`  |
| `v1.18.17-rancher1-1` |
| `v1.17.17-rancher2-1` |

### New Images in v1.20.5-rancher1-1, v1.19.9-rancher1-1 and v1.18.16-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.5-rancher1
- rancher/hyperkube:v1.19.9-rancher1
- rancher/hyperkube:v1.18.17-rancher1

-----
# Release v1.2.6

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running.

## Enhancements

* Introduced new Kubernetes images `v1.20.4-rancher1-1`, `v1.19.8-rancher1-1`, `v1.18.16-rancher1-1` and `1.17.17-rancher2-1`
* Made priority class name configurable [#30047](https://github.com/rancher/rancher/issues/30047)
* Added an auditlog configuration checksum to trigger kube-apiserver restart when auditlog configuration changes #2440
* Added a warning when a snapshot name has a zip extension #2435

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.20.4-rancher1-1`  |
| `v1.19.8-rancher1-1`  |
| `v1.18.16-rancher1-1` |
| `v1.17.17-rancher2-1` |

### New Images in v1.19.8-rancher1-1, v1.18.16-rancher1-1, and v1.17.17-rancher2-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.20.4-rancher1
- rancher/hyperkube:v1.19.8-rancher1
- rancher/hyperkube:v1.18.16-rancher1
- rancher/hyperkube:v1.17.17-rancher2

-----
# Release v1.2.5

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements

* Introduced new Kubernetes images `v1.19.7-rancher1-1`, `v1.18.15-rancher1-1` and `1.17.17-rancher1-1` 
* Make etcd snapshot job timeout customizable. [[#2418](https://github.com/rancher/rke/pull/2418)]
* Mark all default addons as critical. [[#2423](https://github.com/rancher/rke/pull/2423)]
* Exclude Cisco ACI image from mirror. [[#30840](https://github.com/rancher/rancher/issues/30840)]

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.19.7-rancher1-1`  |
| `v1.18.15-rancher1-1` |
| `v1.17.17-rancher1-1` |

### New Images in v1.19.7-rancher1-1, v1.18.15-rancher1-1, and v1.17.17-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.19.7-rancher1
- rancher/hyperkube:v1.18.15-rancher1
- rancher/hyperkube:v1.17.17-rancher1
-----
# Release v1.2.4

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements

* Introduced new Kubernetes images `v1.19.6-rancher1-1`, `v1.18.14-rancher1-1` and `1.17.16-rancher1-1` 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |
| --------------------- |
| `v1.19.6-rancher1-1`  |
| `v1.18.14-rancher1-1` |
| `v1.17.16-rancher1-1` |

### New Images in v1.19.6-rancher1-1, v1.18.14-rancher1-1,  1.17.16-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.19.6-rancher1
- rancher/hyperkube:v1.18.14-rancher1
- rancher/hyperkube:v1.17.16-rancher1
-----
# Release v1.2.3

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements

* Introduced new Kubernetes images `v1.19.4-rancher1-1`, `v1.18.12-rancher1-1` and `1.17.14-rancher1-2` 

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

| Kubernetes version    |      |
| --------------------- | ---- |
| `v1.19.4-rancher1-1`  |      |
| `v1.18.12-rancher1-1` |      |
| `v1.17.14-rancher1-1` |      |

### New Images in v1.19.4-rancher1-1, v1.18.12-rancher1-1,  1.17.14-rancher1-1

**Updated Hyperkube Image based on k8s versions**

- rancher/hyperkube:v1.19.4-rancher1
- rancher/hyperkube:v1.18.12-rancher1
- rancher/hyperkube:v1.17.14-rancher1
-----
# Release v1.2.2

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements

- Added options to configure different network modes for nginx ingress controller [#1876](https://github.com/rancher/rke/issues/1876)


## Major Bug Fixes since v1.2.0

- Fixed a bug where RKE Network Addon Job regularly timed out. [#2143](https://github.com/rancher/rke/issues/2143)
- Fixed a bug where deleting an etcd node would sometimes make the cluster unhealthy. [#24547](https://github.com/rancher/rancher/issues/24547)


## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [#1725](https://github.com/rancher/rke/issues/1725)


## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images) option in your `cluster.yml`.

 Kubernetes version|
 -----------------|
 `v1.19.3-rancher1-2`|  (default)
 `v1.18.10-rancher1-2`|
 `v1.17.13-rancher1-2`|  
 `v1.16.15-rancher1-3`|


-----
# Release v1.2.1

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements

* Introduced new Kubernetes versions `v1.19.3-rancher1-1`, `v1.18.10-rancher1-1`, and `v1.17.13-rancher1-1` to address following CVEs:
1. [CVE-2020-8563](https://github.com/kubernetes/kubernetes/issues/95621) - Secret leaks in kube-controller-manager when using vSphere provider
2. [CVE-2020-8564](https://github.com/kubernetes/kubernetes/issues/95622) - Docker config secrets leaked when file is malformed and log level >= 4
3. [CVE-2020-8566](https://github.com/kubernetes/kubernetes/issues/95624) - Mask Ceph RBD adminSecrets in logs when logLevel >= 4

[Security Announcement](https://groups.google.com/g/kubernetes-announce/c/ScdmyORnPDk)

## Known Major Issues
- In clusters where `cloud_provider` is configured, and either `address` or `internal_address` does not contain a valid IP address (e.g. hostname or FQDN), kube-proxy will fail to start. [[#1725](https://github.com/rancher/rke/issues/1725)]

## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images/) option in your `cluster.yml`.

 Kubernetes version|
 -----------------|
`v1.19.3-rancher1-1`|
`v1.18.10-rancher1-1`|
`v1.17.13-rancher1-1`|

### New Images in `v1.19.3-rancher1-1`, `v1.18.10-rancher1-1` and `v1.17.13-rancher1-1`:

**Updated Hyperkube Image based on k8s versions**
- rancher/hyperkube:v1.19.3-rancher1
- rancher/hyperkube:v1.18.10-rancher1
- rancher/hyperkube:v1.17.13-rancher1
-----
# Release v1.2.0

Rancher Kubernetes Engine (RKE) is a CNCF-certified Kubernetes distribution that runs entirely within Docker containers. It works on bare-metal and virtualized servers. With RKE, the installation and operation of Kubernetes is both simplified and easily automated, and it’s entirely independent of the operating system and platform you’re running. 

## Enhancements

- Rancher Logging now picks up errors involved during snapshot creation [#2111](https://github.com/rancher/rke/issues/2111)
- etcd's unused port 4001 has been removed [#2123](https://github.com/rancher/rke/issues/2123)
- Ingress Controller has been updated to v0.35.0 [#2207](https://github.com/rancher/rke/issues/2207)


## Major Bug Fixes since v1.1.7

- Node's are now removed correctly when cloud provider sets the node name [#2122](https://github.com/rancher/rke/issues/2122)
- Fixed provisioning issue with lib/modules on Fedora CoreOS [#2194](https://github.com/rancher/rke/issues/2194)


## Kubernetes Versions

Each version of RKE has a specific list of supported Kubernetes versions. If you want to use a different version than listed below, you will need to update Kubernetes using the [system images](https://rancher.com/docs/rke/latest/en/config-options/system-images) option in your `cluster.yml`.

 Kubernetes version|
 -----------------|
 `v1.19.2-rancher1-1`|  (default)
 `v1.18.9-rancher1-1`
 `v1.17.12-rancher1-1`|  
 `v1.16.15-rancher1-2`|


-----
