**Utkarsh Raj 24BCS10318**

# Task 1: Docker Container Networking

## Architecture
* **`front-back`**: Bridge network connecting `frontend` and `backend`.
* **`back-data`**: Bridge network connecting `backend` and `database`.
* **`isolated-net`**: Standalone bridge network.
---

### Creating Networks
We create 3 networks that are mentioned in the architecture above and then verify that they exist.

Commands:

```powershell
# Creating the 3 netowrks
docker network create front-back
docker network create back-data
docker network create isolated-net

# Verifying all three exist
docker network ls
```

Output:

![creation](<screenshots/creation.png>)

### Deploying Containers

- We deploy frontend (using Nginx), which is connected to the network front-back.
- We then deploy backend (using Alpine with a persistent process), which is also connected to the network front-back.
- We connect backend to the second network back-data.

Commands:

```powershell
# Deploy Frontend (using Nginx)
docker run -d --name frontend --network front-back nginx:alpine

# Deploy Backend (using Alpine with a persistent process)
docker run -d --name backend --network front-back alpine sleep 3600

# Connect Backend to the second network
docker network connect back-data backend
```

Output:

![frontend backend](<screenshots/deploy-f-b.png>)

- We deploy the database (using MySQL), which is connected to the network back-data.

Commands:

```powershell
# Deploy Database (using MySQL)
docker run -d --name database --network back-data -e MYSQL_ROOT_PASSWORD=secret mysql:8.0
```

Output:

![database](<screenshots/database.png>)

### Verifying Multi-Network Configuration on backend
We inspect the backend container to verify it is assigned IP addresses on both front-back and back-data.

Commmand:

```powershell
docker inspect backend --format '{{json .NetworkSettings.Networks}}'
```

Output:

![verify](<screenshots/verify.png>)

### Testing Connectivity Between Containers

1. **Frontend -> Backend:**
   * Command: `docker exec frontend ping -c 2 backend`
   * Output: ![front-back](<screenshots/front-back.png>)

2. **Backend -> Database:**
   * Command: `docker exec backend ping -c 2 database`
   * Output: ![back-data](<screenshots/back-data.png>)

3. **Frontend -> Database (Isolation Verification):**
   * Command: `docker exec frontend ping -c 2 database`
   * Output: ![isolation](<screenshots/isolation.png>)

# Task 2: Host Network

1. Pull the Apache 2 image from Docker hub.
   - Command: `sudo docker pull httpd:2.4-alpine`
   - Output: ![apache pull](<screenshots/apache-pull.png>)

2. Creating an Apache 2 container using host network
   - Command: `sudo docker run -d --name apache-host --network host httpd:2.4-alpine`
   - Output: ![apache create](<screenshots/apache-create.png>)

3. Verifying the container status and port bindings
   - Command: `sudo docker ps --filter "name=apache-host"`
   - Output: ![verify](<screenshots/apache-verify.png>)

4. Access the Apache web server on port 80
   - Command: `sudo docker exec apache-host wget -qO- http://localhost:80`
   - Output: ![access](<screenshots/apache-access.png>)

# Task 3: Bind Mount

### Create the Local directory & `index.html` file

- Commands:
```bash
# 1. Create an index.html file
echo "<h1>Hello students</h1>" > index.html

# 2. Verify the file contents
cat index.html
```

- Output:
```html
<h1>Hello students</h1>
```

### Run the Nginx Container with the Bind Mount

- Commands:
```bash
# Run Nginx with local folder mounted to the container web root
sudo docker run -d -p 8085:80 --name nginx-bind-demo -v "$(pwd):/usr/share/nginx/html" nginx:alpine

# Verify the container is running
sudo docker ps --filter "name=nginx-bind-demo"
```

- Output:
```text
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                     NAMES
9f218e6d79bb   nginx:alpine   "/docker-entrypoint.…"   15 seconds ago   Up 14 seconds   0.0.0.0:8085->80/tcp, [::]:8085->80/tcp   nginx-bind-demo
```

### Access and Verify Initial Content

- Command:
```bash
curl http://localhost:8085
```

- Output:
```html
<h1>Hello students</h1>
```

### Modify the File on the Host (Without Container Restart)

- Commands:
```bash
echo "<h1>Hello students - Live Update Verified!</h1>" > index.html
```

### Verify the Live Changes Immediately

- Commands:
```
curl http://localhost:8085
```

- Output:
```html
<h1>Hello students - Live Update Verified!</h1>
```


## Screenshot
![task 3](<screenshots/t3.png>)

# Task 4: Docker Overlay Network Research

## 1. Overview and Core Concept
A Docker **Overlay Network** is a distributed software-defined network (SDN) driver that creates an abstract Layer 2/Layer 3 network across multiple physical or virtual Docker daemon hosts. 

While a standard `bridge` network is strictly isolated to a single host machine, an overlay network enables containers running on **Node A** to communicate directly and seamlessly with containers on **Node B** across an underlying physical network without requiring OS-level host routing, port forwarding, or manual NAT configurations.

---

## 2. Architectural Mechanics

### A. VXLAN Encapsulation
* Overlay networking is implemented using standard **VXLAN (Virtual Extensible LAN)** technology.
* Containers communicate via standard Ethernet frames. The Docker engine encapsulates these Layer 2 frames inside Layer 4 **UDP packets** (using standard destination port `4789`).
* The packets traverse the physical host-to-host network infrastructure and are transparently decapsulated by the destination node's Docker daemon before reaching the target container.

### B. Control Plane and Service Discovery
* **Gossip Protocol / Distributed State:** In Docker Swarm clusters, manager nodes synchronize network state, IP allocations, and endpoint locations using a decentralized gossip protocol.
* **Embedded Multi-Host DNS:** Containers across different physical nodes can discover and resolve each other by container name or Swarm service name (e.g., `api-service` resolves to the target container's overlay IP).
* **Control Plane Security:** Swarm management traffic runs over mutual TLS (mTLS) on TCP port `2377`, while node state and gossip communication use port `7946` (TCP/UDP).

### C. Data Plane Encryption
* Docker overlay networks provide native cryptographic security via IPsec tunneling.
* By passing the `--opt encrypted` flag during creation (`docker network create -d overlay --opt encrypted my-net`), all inter-host packet payloads are automatically encrypted at the kernel level using AES-GCM algorithms with zero modifications to application code.

---

## 3. Comparison: Bridge vs. Host vs. Overlay Networks

| Feature / Dimension | Bridge Network (`bridge`) | Host Network (`host`) | Overlay Network (`overlay`) |
| :--- | :--- | :--- | :--- |
| **Scope** | Single Docker Host | Single Docker Host | Multi-Host Cluster |
| **Network Isolation** | High (Internal subnet with NAT) | None (Shares host stack) | High (Virtual subnet over VXLAN) |
| **Cross-Host Routing** | Requires port mapping (`-p`) | Requires port mapping / manual proxy | Native flat routing across nodes |
| **Orchestration Requirement** | Standalone Docker Engine | Standalone Docker Engine | Docker Swarm or external KV store |
| **Encryption Support** | No native encryption | No (Host interface dependent) | Native Layer 3 IPsec encapsulation |

---

## 4. Primary Industry Use Cases

### 1. Microservices Across Multi-Node Clusters
In enterprise deployments, applications are decomposed into decoupled services (e.g., frontend, auth, backend, worker queue). When scaling these services across multiple virtual machines or cloud instances, overlay networks provide a single, unified private network where services can communicate directly via DNS regardless of which physical server hosts each instance.

### 2. High Availability (HA) and Workload Migration
When deploying services with redundant replicas in Docker Swarm:
* If Node A crashes, the cluster orchestrator automatically spins up replacement containers on Node B or Node C.
* Because the replacement containers attach to the identical overlay network, dependent microservices continue to route traffic to the service name without configuration changes or service interruption.

### 3. Secure Multi-Cloud and Hybrid-Cloud Transit
Organizations running workloads spanning private on-premise data centers and public cloud providers (such as AWS, Azure, or GCP) can run overlay networks with IPsec encryption enabled (`--opt encrypted`). This guarantees that sensitive container-to-container payloads traversing the public internet remain encrypted in transit without configuring external VPN gateways.

### 4. Multi-Tenant Network Isolation
In multi-tenant staging or production platforms, multiple distinct overlay networks can run on top of the same underlying server infrastructure. A database attached exclusively to `prod-db-overlay` is cryptographically and topologically inaccessible to application containers attached to `qa-overlay`, eliminating lateral attack surfaces between environments.

---

## 5. Essential Demonstration Commands

```bash
# 1. Initialize Docker Swarm (Prerequisite for native overlay networking)
docker swarm init

# 2. Create a standard multi-host overlay network
docker network create -d overlay multi-host-net

# 3. Create an end-to-end encrypted overlay network
docker network create -d overlay --opt encrypted secure-internal-net

# 4. Deploy a multi-replica service attached to the overlay network
docker service create --name backend-api --network multi-host-net --replicas 3 my-app:latest

# 5. Inspect the distributed network topology and attached endpoints
docker network inspect multi-host-net
```

## Screenshots
![output-1](<screenshots/t4-1.png>)
![output-2](<screenshots/t4-2.png>)