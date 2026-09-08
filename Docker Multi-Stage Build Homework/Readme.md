# Task 1 & 2: Running the Multi-Stage Dockerfile & Documnentation

## Application Output
Command:
```powershell
curl.exe http://localhost:8080
```

Output:
```text
Hello World from Docker Multi-Stage Build!
```

## Running Container
Command:
```powershell
docker ps --filter "name=multistage-node-container"
```

Output:
```text
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                         NAMES
fe36c005534e   node-multistage-app   "docker-entrypoint.s…"   6 minutes ago   Up 6 minutes   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp   multistage-node-container
```

Sreenshot:
![multi stage](<screenshots/multi-stage.png>)

# Task 3: Docker Application Deployment

### 1. Node.js
Output:
![node.js](<screenshots/nodejs.png>)

### 2. Python
Output:
![Python](<screenshots/python.png>)

### 3. Java
Output:
![java](<screenshots/java.png>)

## docker ps
Command:
```powershell
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

Output:
```text
NAMES                       IMAGE                 STATUS          PORTS
multistage-node-container   node-multistage-app   Up 23 minutes   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp
nginx-container             my-nginx-app          Up 40 minutes   0.0.0.0:8082->80/tcp, [::]:8082->80/tcp
react-container             my-react-app          Up 43 minutes   0.0.0.0:3001->80/tcp, [::]:3001->80/tcp
apache-container            my-apache-app         Up 50 minutes   0.0.0.0:8081->80/tcp, [::]:8081->80/tcp
python-container            my-python-app         Up 54 minutes   0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp
node-container              my-nodejs-app         Up 59 minutes   0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp
quirky_noyce                ubuntu                Up 3 days       
```

Screenshot:
![docker ps](<screenshots/docker-ps.png>)