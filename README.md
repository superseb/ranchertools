# Rancher tools

**Note: this is not official documentation, make sure you have a backup and test it before applying any of this**

Index of miscellaneous non official gists/tools for Rancher

## Gists

- [Retrieve kubeconfig for custom cluster from Rancher](https://gist.github.com/superseb/f6cd637a7ad556124132ca39961789a4)
- [Retrieve kubeconfig from RKE v0.1.x or Rancher v2.0.x/v2.1.x custom cluster controlplane node](https://gist.github.com/superseb/3d8de6092ebc4b1581185197583f472a)
- [Retrieve kubeconfig from RKE v0.2.x or Rancher v2.2.x custom cluster controlplane node](https://gist.github.com/superseb/b14ed3b5535f621ad3d2aa6a4cd6443b)
- [Recover cluster.rkestate using kubeconfig](https://gist.github.com/superseb/649a64bdbca51e0cba5341d94608ae48)
- [Recover cluster.rkestate file from controlplane node](https://gist.github.com/superseb/e9f2628d1033cb20e54f6ee268683a7a)
- [Rancher v2.1.8 single install embedded etcd maintenance](https://gist.github.com/superseb/48037c0323147e603bc0197bd5ecb9b5)
- [Rancher v2.2.0 single install embedded etcd maintenance](https://gist.github.com/superseb/f223b15949c031983da2cb850f56a897)
- [Rancher v2.2.0 single install embedded etcd query](https://gist.github.com/superseb/d27253befe5e180334162c18187212fb)
- [Check kubelet nodefs/imagefs](https://gist.github.com/superseb/a4fa9640d801c54452132db8af51f2e4)
- [Run WebSocket test for Rancher 2](https://gist.github.com/superseb/89972344508e99b9336ad7eff78cb928)
- [Roll nodes in a Rancher 2 custom cluster using DigitalOcean droplets](https://gist.github.com/superseb/922f3be6eacc89fcc31a45353dc5aaf5)
- [cluster.rkestate to kubeconfig](https://gist.github.com/superseb/acb944e39c0166ec33aa1c43b5c61f8c)
- [CNI interface per pod](https://gist.github.com/superseb/4e0577a93ced88fa6fe5c39d2d778060)
- [Delete evicted pods using kubectl](https://gist.github.com/superseb/0f654d4e8945195e08fd1a2a061e0762)
- [Run nodelocal DNS on Rancher 2 custom cluster (RKE)](https://gist.github.com/superseb/0500a758cdb8bbac5dc47ca570738a1d)
- [Run kube-dns preferably on controlplane nodes and else on etcd nodes on a Rancher 2 custom cluster](https://gist.github.com/superseb/893e1d5b1e4fd19160d9611dbe63d073)
- [Create local user and generate kubeconfig in Rancher 2 via API](https://gist.github.com/superseb/cad9b87c844f166b9c9bf97f5dea1609)
- [Extended Rancher 2 cleanup for custom cluster hosts](https://gist.github.com/superseb/06539c6dcd377e118d72bfefdd444f81)
- [curl a gist to generate self signed certificates](https://gist.github.com/superseb/b2c1d6c9baa32609a49ee117a27bc700)
```
curl https://gist.githubusercontent.com/superseb/b2c1d6c9baa32609a49ee117a27bc700/raw/7cb196e974e13b213ac6ec3105971dd5e21e4c66/selfsignedcert.sh | bash -s -- test.example.com
```
- [Generate CA, intermediate CA and server certificate with DNS alt names using Terraform in Docker and launch Rancher](https://gist.github.com/superseb/14ce3c94e0d6896bb43b19b70543be67)
- [Extract self signed CA certificate from Rancher](https://gist.github.com/superseb/2732303f0c85d6aca8fab617ea262ebb)
- [Debug EKS cluster created in Rancher](https://gist.github.com/superseb/c6e8581eef5d01518b17544c07ea4032)
- [PLEG tester](https://gist.github.com/superseb/af32314125aac8e0aa7546239db55f82)

## Tools

- [ranchercheck: Check certificate chain on your Rancher 2 install](https://github.com/superseb/ranchercheck)

## Repositories

- [tf-do-rancher2: Automated Rancher single install and custom cluster with nodes using API and shell scripts](https://github.com/superseb/tf-do-rancher2)
- [tf-do-rancher2-airgap: Terraform config to launch Rancher 2.0 in a simulated airgapped environment](https://github.com/superseb/tf-do-rancher2-airgap/)
- [tf-do-rancher16: Automated Rancher 1.6 single install and custom cluster with nodes using API and shell scripts](https://github.com/superseb/tf-do-rancher16)
- [tf-do-rancherd: Automated rancherd single install and custom cluster with nodes using API and shell scripts](https://github.com/superseb/tf-do-rancherd)
- [multipass-rke: RKE cluster on multipass instances](https://github.com/superseb/multipass-rke)
- [multipass-k3s: k3s cluster on multipass instances](https://github.com/superseb/multipass-k3s)

## Playgrounds

- [Katacoda: Explore RKE2](https://katacoda.com/superseb/scenarios/rke2)
- [Katacoda: Explore K3s](https://katacoda.com/superseb/scenarios/k3s)
- [Katacoda: Import K3s in Rancher 2](https://www.katacoda.com/superseb/scenarios/rancher2-k3s-import)
- [Katacoda: Import RKE2 in Rancher 2.5](https://katacoda.com/superseb/scenarios/rancher25-rke2-import)
- [Katacoda scenarios source](https://github.com/superseb/katacoda-scenarios)
