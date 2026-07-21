# React E-Commerce Application - DevOps & AWS Practice Project

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![React](https://img.shields.io/badge/React-61DAFB?style=for-the-badge&logo=react&logoColor=black)](https://react.dev/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![DevOps](https://img.shields.io/badge/DevOps-Practice-blueviolet?style=for-the-badge)](https://github.com/Ranji-07/Reactjs-E-commerce-Application)

> 🎓 **Comprehensive DevOps & AWS Practice Project** - Learn and implement real-world DevOps practices including Docker, Jenkins CI/CD, AWS deployment, and cloud infrastructure automation.

## 🎯 Project Overview

This is a **hands-on practice project** designed to master DevOps and AWS technologies. It implements:

- 🐳 **Docker containerization** with multi-stage builds
- 📦 **Docker Hub registry** with dev/prod separation
- 🔄 **Jenkins CI/CD pipeline** with GitHub integration
- ☁️ **AWS deployment** on EC2 instances
- 🛡️ **Security groups** and network configuration
- 📊 **Application monitoring** and health checks
- 🔐 **Version control** best practices

## 📚 Learning Objectives

This project helps you practice:

### Container & Registry
- ✅ Docker image creation and optimization
- ✅ Docker Compose for local development
- ✅ Docker Hub repository management
- ✅ Public vs Private repository setup
- ✅ Image versioning and tagging strategies

### CI/CD & Automation
- ✅ Jenkins installation and configuration
- ✅ GitHub webhook integration
- ✅ Automated build triggers
- ✅ Multi-branch pipeline strategies
- ✅ Build automation scripts (Bash)

### AWS Deployment
- ✅ EC2 instance launch and configuration
- ✅ Security Group setup and management
- ✅ Security best practices (IP whitelisting)
- ✅ Application deployment on AWS
- ✅ Infrastructure monitoring

### Monitoring & Health Checks
- ✅ Application health monitoring
- ✅ Log aggregation and analysis
- ✅ Alert configuration
- ✅ Notification systems
- ✅ Downtime detection

## 🛠️ Tech Stack

| Component | Technology | Purpose |
|-----------|-----------|----------|
| **Frontend** | React 18+ | Application UI |
| **Backend** | Node.js, Express | REST APIs |
| **Containerization** | Docker | Application packaging |
| **Registry** | Docker Hub | Image storage |
| **CI/CD** | Jenkins | Automation pipeline |
| **Version Control** | GitHub | Code repository |
| **Deployment** | AWS EC2 | Application hosting |
| **Monitoring** | Open-source tools | Health tracking |

## 🏗️ Project Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Repository                         │
│              (dev branch & master branch)                    │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼ (Webhook Trigger)
        ┌────────────────────────────┐
        │   Jenkins CI/CD Pipeline   │
        │  ┌──────────────────────┐  │
        │  │  Source: GitHub      │  │
        │  │  Build: CodeBuild    │  │
        │  │  Deploy: AWS EC2     │  │
        │  └──────────────────────┘  │
        └───────────┬────────────────┘
                    │
         ┌──────────┴──────────┐
         │                     │
         ▼ (dev branch)        ▼ (master branch)
    ┌─────────────┐      ┌──────────────┐
    │ Docker Hub  │      │  Docker Hub  │
    │  (dev repo) │      │ (prod repo)  │
    │  PUBLIC     │      │  PRIVATE     │
    └─────────────┘      └──────────────┘
         │                     │
         └──────────┬──────────┘
                    │
                    ▼
        ┌────────────────────────────┐
        │   AWS EC2 Instance         │
        │   (t2.micro)               │
        │  ┌──────────────────────┐  │
        │  │ Security Group       │  │
        │  │ - App access: Any    │  │
        │  │ - SSH: Your IP only  │  │
        │  └──────────────────────┘  │
        └───────────┬────────────────┘
                    │
                    ▼
        ┌────────────────────────────┐
        │   Monitoring System        │
        │  - Health Checks           │
        │  - Logs & Alerts           │
        │  - Notifications           │
        └────────────────────────────┘
```

## 📋 Implementation Checklist

### Docker Implementation ✅
- [x] **Dockerfile** - Multi-stage build
  ```dockerfile
  # Build stage
  FROM node:18-alpine AS builder
  WORKDIR /app
  COPY package*.json ./
  RUN npm ci
  COPY . .
  RUN npm run build
  
  # Runtime stage
  FROM node:18-alpine
  WORKDIR /app
  COPY --from=builder /app/node_modules ./
  COPY --from=builder /app/dist ./dist
  EXPOSE 3000
  CMD ["node", "dist/server.js"]
  ```
- [x] **docker-compose.yml** - Multi-service setup
  ```yaml
  version: '3.8'
  services:
    app:
      build: .
      ports:
        - "3000:3000"
      environment:
        - NODE_ENV=development
      depends_on:
        - db
    db:
      image: postgres:15
      environment:
        - POSTGRES_PASSWORD=password
  ```
- [x] **.gitignore & .dockerignore** - Clean repository

### Bash Scripting ✅
- [x] **build.sh** - Docker image building
  ```bash
  #!/bin/bash
  REGISTRY="your-dockerhub-username"
  IMAGE_NAME="react-ecommerce"
  
  docker build -t $REGISTRY/$IMAGE_NAME:latest .
  echo "Image built: $REGISTRY/$IMAGE_NAME:latest"
  ```
- [x] **deploy.sh** - Application deployment
  ```bash
  #!/bin/bash
  IMAGE="react-ecommerce:latest"
  CONTAINER_NAME="react-app"
  
  docker stop $CONTAINER_NAME || true
  docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE
  echo "Application deployed"
  ```

### Version Control ✅
- [x] **GitHub repository** with dev & master branches
- [x] **.gitignore** - Exclude unnecessary files
- [x] **CLI git workflow**
  ```bash
  git checkout dev
  git add .
  git commit -m "feat: your feature"
  git push origin dev
  ```

### Docker Hub Setup ✅
- [x] **dev repository** - PUBLIC
  - Automatic builds from dev branch
  - Development images
  - Auto-pushed on every dev commit
- [x] **prod repository** - PRIVATE
  - Production images only
  - Pushed on master branch merges
  - Access-controlled

### Jenkins CI/CD Pipeline ✅
- [x] **Jenkins Installation**
  ```bash
  # Ubuntu/Debian
  java -version
  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install jenkins
  ```
- [x] **GitHub Integration**
  - Webhook configuration: `http://jenkins-server:8080/github-webhook/`
  - SSH key setup for repository access
  - Branch-specific triggers
- [x] **Build Pipeline Stages**
  ```groovy
  pipeline {
    agent any
    triggers {
      githubPush()
    }
    stages {
      stage('Checkout') {
        steps {
          git branch: '${GIT_BRANCH}', url: 'https://github.com/Ranji-07/Reactjs-E-commerce-Application.git'
        }
      }
      stage('Build') {
        steps {
          sh './scripts/build.sh'
        }
      }
      stage('Push to Docker Hub') {
        steps {
          sh './scripts/push.sh'
        }
      }
      stage('Deploy') {
        steps {
          sh './scripts/deploy.sh'
        }
      }
    }
  }
  ```
- [x] **Multi-branch Triggers**
  - **dev branch** → Build & Push to dev repo
  - **master branch** → Build & Push to prod repo

### AWS EC2 Deployment ✅
- [x] **EC2 Instance Launch**
  ```bash
  # Instance type: t2.micro
  # OS: Ubuntu 20.04 LTS
  # Storage: 30GB
  ```
- [x] **Security Group Configuration**
  ```
  Inbound Rules:
  ├─ HTTP (80): 0.0.0.0/0 (Anyone)
  ├─ HTTPS (443): 0.0.0.0/0 (Anyone)
  ├─ Custom TCP (3000): 0.0.0.0/0 (App Access)
  └─ SSH (22): YOUR_IP_ADDRESS/32 (SSH Only from Your IP)
  
  Outbound Rules:
  └─ All traffic allowed
  ```
- [x] **Server Setup**
  ```bash
  # SSH into instance
  ssh -i key.pem ubuntu@instance-ip
  
  # Install Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  
  # Add user to docker group
  sudo usermod -aG docker $USER
  
  # Deploy application
  docker pull your-docker-username/react-ecommerce:latest
  docker run -d -p 3000:3000 your-docker-username/react-ecommerce:latest
  ```

### Monitoring & Health Checks ✅
- [x] **Open-source Monitoring Tools**
  - Prometheus for metrics collection
  - Grafana for visualization
  - AlertManager for notifications
  - Node Exporter for system metrics
- [x] **Health Check Endpoint**
  ```javascript
  app.get('/health', (req, res) => {
    res.status(200).json({ status: 'UP', timestamp: new Date() });
  });
  ```
- [x] **Monitoring Configuration**
  ```yaml
  # Prometheus scrape config
  scrape_configs:
    - job_name: 'react-app'
      static_configs:
        - targets: ['localhost:9090']
  ```
- [x] **Alert Rules**
  - Application down detection
  - High CPU/Memory usage
  - Disk space warnings
  - Custom metrics alerts
- [x] **Notification Channels**
  - Email alerts
  - Slack integration
  - PagerDuty (optional)
  - Custom webhooks

## 📂 Repository Structure

```
Reactjs-E-commerce-Application/
├── src/                           # Source code
├── public/                         # Static files
├── backend/                        # Backend API
├── Dockerfile                      # Container config
├── docker-compose.yml              # Multi-service setup
├── .gitignore                      # Git ignore rules
├── .dockerignore                   # Docker ignore rules
├── scripts/
│   ├── build.sh                   # Docker build script
│   ├── deploy.sh                  # Deployment script
│   ├── push.sh                    # Push to Docker Hub
│   └── monitor.sh                 # Monitoring setup
├── .github/
│   └── workflows/                 # GitHub Actions (optional)
├── jenkins/
│   ├── Jenkinsfile                # Pipeline definition
│   └── buildspec.yml              # Build specifications
├── monitoring/
│   ├── prometheus.yml             # Prometheus config
│   ├── grafana-dashboard.json     # Grafana dashboard
│   └── alertmanager.yml           # Alert rules
├── docs/
│   ├── DEVOPS_SETUP.md            # DevOps setup guide
│   ├── JENKINS_CONFIG.md          # Jenkins configuration
│   ├── AWS_DEPLOYMENT.md          # AWS deployment guide
│   └── MONITORING.md              # Monitoring setup
└── README.md
```

## 🚀 Quick Start

### Local Development with Docker

```bash
# Clone repository
git clone https://github.com/Ranji-07/Reactjs-E-commerce-Application.git
cd Reactjs-E-commerce-Application

# Build and run with Docker Compose
docker-compose up -d

# Application available at: http://localhost:3000

# View logs
docker-compose logs -f app
```

### Manual Docker Build & Deploy

```bash
# Build image
./scripts/build.sh

# Push to Docker Hub
./scripts/push.sh

# Deploy to server
./scripts/deploy.sh
```

## 📚 Documentation

| Guide | Purpose |
|-------|----------|
| [DEVOPS_SETUP.md](./docs/DEVOPS_SETUP.md) | Docker & containerization setup |
| [JENKINS_CONFIG.md](./docs/JENKINS_CONFIG.md) | Jenkins CI/CD configuration |
| [AWS_DEPLOYMENT.md](./docs/AWS_DEPLOYMENT.md) | AWS EC2 deployment guide |
| [MONITORING.md](./docs/MONITORING.md) | Monitoring & alerting setup |

## 🎓 Learning Resources

### Docker
- [Docker Official Documentation](https://docs.docker.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Multi-stage Builds](https://docs.docker.com/build/building/multi-stage/)

### Jenkins
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Jenkins Pipeline Guide](https://www.jenkins.io/doc/book/pipeline/)
- [GitHub Integration](https://plugins.jenkins.io/github/)

### AWS
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Security Groups Guide](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [AWS Best Practices](https://aws.amazon.com/architecture/best-practices/)

### Monitoring
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Getting Started](https://grafana.com/docs/grafana/latest/)
- [AlertManager Configuration](https://prometheus.io/docs/alerting/latest/configuration/)

## 💡 Key Learnings

### DevOps Practices
- ✅ Infrastructure as Code principles
- ✅ Containerization best practices
- ✅ CI/CD pipeline automation
- ✅ Blue-green deployment strategies
- ✅ Infrastructure monitoring

### AWS Services
- ✅ EC2 instance management
- ✅ Security group configuration
- ✅ IAM roles and policies
- ✅ CloudWatch monitoring
- ✅ Cost optimization

### Security
- ✅ Network segmentation
- ✅ IP whitelisting
- ✅ Secret management
- ✅ Container security
- ✅ Compliance best practices

## 🤝 Contributing

This is a practice project. Feel free to:
- Fork and experiment
- Add new features
- Improve automation
- Share learnings

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## 📞 Support

- 📧 **Email**: [your-email@example.com](mailto:your-email@example.com)
- 🐛 **Issues**: [GitHub Issues](https://github.com/Ranji-07/Reactjs-E-commerce-Application/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Ranji-07/Reactjs-E-commerce-Application/discussions)

## 📜 License

MIT License - see [LICENSE](./LICENSE) file for details.

---

<div align="center">

**🎓 This is a DevOps & AWS Practice Project**

*Learn by doing real-world DevOps practices*

[Back to top](#react-e-commerce-application---devops--aws-practice-project)

*Built with ❤️ by [Ranji-07](https://github.com/Ranji-07)*

</div>
