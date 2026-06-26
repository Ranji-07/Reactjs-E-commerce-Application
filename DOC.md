# 🚀 ReactJS E-Commerce Application - End-to-End DevOps CI/CD Project

## 📌 Project Overview

This project demonstrates a complete end-to-end DevOps workflow by containerizing and deploying a ReactJS E-Commerce application using modern DevOps tools and AWS Cloud.

The project includes Docker containerization, Docker Compose orchestration, Git & GitHub branching strategy, Docker Hub image management, Jenkins CI/CD pipeline, AWS EC2 deployment, and application monitoring using Uptime Kuma.

---

## 🏗️ Project Architecture

```text
Developer
      │
      ▼
 GitHub Repository
(dev / master branches)
      │
      ▼
 Jenkins Pipeline
      │
      ├──────────────┐
      │              │
      ▼              ▼
Docker Hub DEV   Docker Hub PROD
(Public)         (Private)
      │              │
      └──────┬───────┘
             ▼
        AWS EC2 Instance
             │
             ▼
 ReactJS Application (Port 80)
             │
             ▼
      Uptime Kuma Monitoring
```

---

## ⚙️ Technologies Used

* ReactJS
* Docker
* Docker Compose
* Bash Scripting
* Git & GitHub
* Docker Hub
* Jenkins
* AWS EC2 (Ubuntu)
* Nginx
* Uptime Kuma

---

## 📂 Project Features

* Dockerized ReactJS application
* Multi-container deployment using Docker Compose
* Bash automation scripts for build and deployment
* Git branching strategy (dev & master)
* Docker Hub integration
* Jenkins CI/CD pipeline
* Automated image deployment
* AWS EC2 hosting
* Application served on Port 80
* Health monitoring with Uptime Kuma

---

## 📁 Project Structure

```
Reactjs-E-commerce-Application/
│
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── nginx.conf
├── build.sh
├── deploy.sh
├── .gitignore
├── .dockerignore
├── screenshots/
└── README.md
```

---

## 🔄 CI/CD Workflow

### Development Workflow

1. Developer pushes code to the **dev** branch.
2. Jenkins automatically builds the Docker image.
3. Docker image is pushed to the **Docker Hub DEV** repository.

### Production Workflow

1. Code is merged into the **master** branch.
2. Jenkins builds a production image.
3. Docker image is pushed to the **Docker Hub PROD** repository.
4. The production image is deployed to the AWS EC2 instance.

---

## ☁️ AWS Deployment

* Ubuntu EC2 Instance
* Docker Engine
* Nginx Container
* Application running on Port 80
* Security Group configured for HTTP & SSH

---

## 📊 Monitoring

Application health monitoring is implemented using **Uptime Kuma**.

Features:

* HTTP health checks
* Real-time uptime monitoring
* Dashboard view
* Notification support (Email / Telegram)

---

## 📸 Project Screenshots

### Jenkins

* Login Page
* Pipeline Configuration
* Successful Build

### AWS

* EC2 Dashboard
* Security Group

### Docker Hub

* DEV Repository
* PROD Repository

### Deployment

* Running Application

### Monitoring

* Uptime Kuma Dashboard

---

## 🔗 GitHub Repository

Replace with your repository URL.

---

## 🌐 Live Application

Replace with your EC2 Public IP.

---

## 👨‍💻 Author

**Ranjith**

DevOps Engineer | Cloud Enthusiast | AWS | Docker | Jenkins | CI/CD
