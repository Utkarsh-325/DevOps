# Kubernetes Fundamentals

**Utkarsh Raj 24BCS10318**

## Task 1: Minikube and CLI installation verification

Verify that Minikube and the Kubernetes CLI (`kubectl`) are successfully installed on the local system.

**Commands**
```bash
minikube version
kubectl version --client
```

**Output**
```text
minikube version: v1.39.0
commit: 7a9f6a841470a207de8cf4bafcccee0969d8ba10

Client Version: v1.37.0
Kustomize Version: v5.8.1
```

**Screenshot:**

![k8s-verify](<screenshots/k8s-version.png>)

## Task 2: Starting the Minikube Kubernetes Cluster

Initialize the local single-node Kubernetes cluster using the containerized runtime environment.

**Commands**
```bash
minikube start --driver=docker
```

**Output**
```text
😄  minikube v1.39.0 on Ubuntu 26.04 (kvm/amd64)
✨  Using the docker driver based on user configuration
📌  Using Docker driver with root privileges
❗  For an improved experience it's recommended to use Docker Engine instead of Docker Desktop.
Docker Engine installation instructions: https://docs.docker.com/engine/install/#server
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🚜  Pulling base image v0.0.51 ...
💾  Downloading Kubernetes v1.37.0 preload ...
    > gcr.io/k8s-minikube/kicbase:  507.58 MiB / 507.61 MiB  99.99% 11.38 MiB p
    > preloaded-images-k8s-v18-v1...:  347.58 MiB / 347.58 MiB  100.00% 6.68 Mi
🔥  Creating docker container (CPUs=2, Memory=3072MB) ...
📦  Preparing Kubernetes v1.37.0 on containerd 2.3.4 ...
🔗  Configuring CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

**Screenshot:**

![mini start](<screenshots/mini-start.png>)

## Task 3: Verifying Cluster Status & Node Health

Inspect the status of the local cluster control plane, kubelet, API server, and verify the node is in Ready state.

**Commands**
```bash
minikube status
kubectl get nodes
```

**Output**
```text
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   81s   v1.37.0
```

**Screenshot:**

![k8s-out](<screenshots/k8s-status.png>)

## Task 4: Stopping the Minikube Cluster

Gracefully power down the Minikube cluster VM/container to release system resources.

**Command:**
```bash
minikube stop
```

**Output:**
```text
✋  Stopping node "minikube"  ...
🛑  Powering off "minikube" via SSH ...
🛑  1 node stopped.
```

**Screenshot:**

![mini stop](<screenshots/k8s-stop.png>)
