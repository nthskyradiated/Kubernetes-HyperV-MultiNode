# K8s Multi-Node On-prem Deployment on Hyper-V with Vagrant

Updated: Nov 2024


Always run the `cert_verify.sh` script at the places it suggests, and always ensure you are on the correct node when you do stuff. If `cert_verify.sh` shows anything in red, then you have made an error in a previous step. For the controlplane node checks, run the check on `controlplane01` and on `controlplane02`

## Cluster Details

 Bootstrap a highly available Kubernetes cluster with end-to-end encryption between components and RBAC authentication.

* [Kubernetes](https://github.com/kubernetes/kubernetes) Latest version
* [Container Runtime](https://github.com/containerd/containerd) Latest version
* [Project Calico](https://www.tigera.io/project-calico/)
* [etcd](https://github.com/coreos/etcd) v3.5.9
* [CoreDNS](https://github.com/coredns/coredns) v1.9.4

### Node configuration

* Two control plane nodes (`controlplane01` and `controlplane02`) running the control plane components as operating system services. This is not a kubeadm cluster as you are used to if you have been doing the CKA course. The control planes are *not* themselves nodes, therefore will not show with `kubectl get nodes`.
* Two worker nodes (`node01` and `node02`)
* (optional) One loadbalancer VM running [HAProxy](https://www.haproxy.org/) to balance requests between the two API servers and provide the endpoint for your KUBECONFIG.
* In case you want to run a minimal setup, just reduce the number of vm's (sometimes I remove the load balancer and 2nd control plane from the vagrantfile). Just be mindful of the configuration steps and adjust accordingly.
