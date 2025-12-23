# Deployment of Flask and Express Applications on a Single AWS EC2 Instance

This document describes the complete deployment process and CI/CD pipeline setup for running **Flask (Python)** and **Express (Node.js)** applications on the **same AWS EC2 instance** using **Docker** and **Jenkins**.

---

## Architecture Overview

* **AWS EC2**: Single Linux instance (Ubuntu)
* **Docker**: Containerization of Flask and Express apps
* **Docker Compose**: Orchestration of multiple containers
* **Jenkins**: CI/CD automation
* **GitHub**: Source code repository
* **Nginx (optional)**: Reverse proxy (recommended for production)

```
GitHub → Jenkins → Docker Build → Docker Compose → EC2
```

---

## Prerequisites

### AWS EC2

* Ubuntu 20.04 / 22.04
* Open inbound ports:

  * `22` (SSH)
  * `8080` (Jenkins)
  * `80` (Nginx)

### Software Installed on EC2

```bash
sudo apt update
sudo apt install -y docker.io docker-compose git
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
```

### Jenkins Installation

```bash
sudo apt install -y openjdk-17-jdk
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins
sudo systemctl start jenkins
```

Access Jenkins at:

```
http://<EC2_PUBLIC_IP>:8080
```

---

## Project Structure

```
project-root/
├── flask-app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── express-app/
│   ├── index.js
│   ├── package.json
│   └── Dockerfile
├── docker-compose.yml
└── Jenkinsfile
```

---

## Docker Setup

### Flask Dockerfile

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "app.py"]
```

### Express Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
```

---

## Docker Compose Configuration

```yaml
version: '3.8'
services:
  flask:
    build: ./flask-app
    container_name: flask_app
    ports:
      - "8000:8000"

  express:
    build: ./express-app
    container_name: express_app
    ports:
      - "3000:3000"
```

---

## Jenkins CI/CD Pipeline

### Jenkinsfile

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/<your-username>/<repo>.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker-compose build'
            }
        }

        stage('Deploy Containers') {
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
```

---

## Jenkins Configuration Steps

1. Create a **New Pipeline Job**
2. Select **Pipeline from SCM**
3. Choose **Git**
4. Provide repository URL
5. Set script path to `Jenkinsfile`
6. Save and Build

---

## Deployment Flow

1. Developer pushes code to GitHub
2. Jenkins pipeline triggers automatically
3. Jenkins pulls latest code
4. Docker images are built
5. Existing containers are stopped
6. New containers are started
7. Flask and Express apps are live

---

## Accessing Applications

* Flask API:

```
http://3.108.8.162/backend/api
```

* Express API:

```
http://3.108.8.162/frontend
```


## Best Practices

* Use environment variables for secrets
* Add `.dockerignore` files
* Enable Jenkins webhook triggers
* Use Nginx + HTTPS (Certbot)
* Add health checks to containers

---

## Troubleshooting

* **Permission denied (Docker)**:

```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

* **Port already in use**:

```bash
docker ps
docker stop <container>
```

---

## Summary

This setup enables a clean and scalable CI/CD workflow to deploy **Flask and Express applications on the same EC2 instance** using **Docker and Jenkins**, ensuring reproducibility, automation, and easy maintenance.


