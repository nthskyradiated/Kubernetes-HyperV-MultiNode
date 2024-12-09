# Provisioning Pod Network

Container Network Interface (CNI) is a standard interface for managing IP networks between containers across many nodes.

I use Project Calico - [Calico](https://www.tigera.io/project-calico/) as networking option.


### Deploy Calico

I was using Weave previously but decided to switch to Calico for my Kubernetes networking

Deploy Calico network. Run only once on the `controlplane01` node. You may see a warning, but this is OK.

[//]: # (host:controlplane01)

On `controlplane01`

Download the Calico custom resource definition:
```bash
curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/custom-resources.yaml -O
```
in the downloaded yaml, change the cidr to what we use: 10.244.0.0/16

install the operator:

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
```
apply the edited manifest (make sure you edited it!)
```bash
kubectl apply -f custom-resources.yaml
```


Wait for the Calico pods to be ready.

## Verification

[//]: # (command:kubectl rollout status daemonset calico-node -n calico-system --timeout=90s)

List the registered Kubernetes nodes from the controlplane node:

```bash
kubectl get pods -n calico-system
```

Output will be similar to

```
NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-58586df886-jhjlq   1/1     Running   0          27m
calico-node-2s6l5                          1/1     Running   0          27m
calico-node-vttfs                          1/1     Running   0          27m
calico-typha-5b64958849-fzk4n              1/1     Running   0          27m
csi-node-driver-228xs                      2/2     Running   0          27m
csi-node-driver-88wp9                      2/2     Running   0          27m
```

Once the Calico pods are fully running, the nodes should be ready.

```bash
kubectl get nodes
```

Output will be similar to

```
NAME       STATUS   ROLES    AGE     VERSION
node01     Ready    <none>   4m11s   v1.28.4
node02     Ready    <none>   2m49s   v1.28.4
```

Reference: https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/calico-network-policy/#install-the-Calico-net-addon

Next: [Kube API Server to Kubelet Connectivity](./14-kube-apiserver-to-kubelet.md)</br>
Prev: [Configuring Kubectl](./12-configuring-kubectl.md)
