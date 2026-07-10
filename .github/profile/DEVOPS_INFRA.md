# ☁️ DevOps & Infrastructure Knowledge Base

## Table of Contents
1. [Infrastructure Architecture](#infrastructure-architecture)
2. [CI/CD Pipelines](#cicd-pipelines)
3. [Containerization](#containerization)
4. [Kubernetes](#kubernetes)
5. [Monitoring & Logging](#monitoring--logging)
6. [Cloud Platforms](#cloud-platforms)
7. [Security](#security)

---

## Infrastructure Architecture

### Design Principles
- **High Availability**: Redundancy across multiple zones
- **Scalability**: Horizontal and vertical scaling
- **Fault Tolerance**: Graceful degradation
- **Performance**: Optimized resource utilization
- **Cost Efficiency**: Automated scaling and resource optimization

### Reference Architecture

```
┌─────────────────────────────────────────────────┐
│              CDN / Load Balancer                │
└────────────────────┬────────────────────────────┘
                     │
      ┌──────────────┼──────────────┐
      │              │              │
   ┌──▼───┐      ┌──▼───┐      ┌──▼───┐
   │ App 1 │      │ App 2 │      │ App 3 │  (Kubernetes Cluster)
   └──┬───┘      └──┬───┘      └──┬───┘
      │              │              │
   ┌──▼──────────────▼──────────────▼──┐
   │    Database Cluster (RDS/GCP)    │
   └──────────────┬─────────────────────┘
                  │
   ┌──────────────┼────────────────┐
   │              │                │
┌──▼──┐      ┌──▼──┐          ┌──▼──┐
│Cache │      │Queue │         │Storage│
│(Redis)      │(RabbitMQ)      │(S3)  │
└──────┘      └──────┘         └──────┘
```

### Load Balancing
- Round-robin distribution
- Sticky sessions for stateful apps
- Health checks and auto-recovery
- Rate limiting and DDoS protection

### Auto-Scaling
- Metrics-based scaling (CPU, Memory, Custom)
- Scheduled scaling for predictable loads
- Cost optimization through right-sizing
- Integration with monitoring systems

---

## CI/CD Pipelines

### GitHub Actions Workflows

#### Build Pipeline
```yaml
name: Build & Test
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run lint
      - run: npm run test
      - run: npm run build
```

#### Deploy Pipeline
```yaml
name: Deploy to Production
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build Docker image
        run: docker build -t myapp:${{ github.sha }} .
      - name: Push to registry
        run: docker push myapp:${{ github.sha }}
      - name: Deploy to K8s
        run: |
          kubectl set image deployment/myapp \
            app=myapp:${{ github.sha }}
```

### Pipeline Stages
1. **Trigger**: Push, PR, Schedule, Manual
2. **Build**: Compile, package, artifact creation
3. **Test**: Unit, integration, E2E tests
4. **Quality**: SonarQube, code coverage analysis
5. **Security**: SAST, DAST, dependency scanning
6. **Stage Deploy**: Deploy to staging environment
7. **Smoke Tests**: Basic functionality verification
8. **Production Deploy**: Blue-green or canary deployment
9. **Post-Deploy**: Monitoring, logging verification

---

## Containerization

### Docker Best Practices

#### Multi-stage Builds
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
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

#### Optimization Techniques
- Minimal base images (alpine, distroless)
- Layer caching optimization
- Small final image sizes
- Security scanning (Trivy, Snyk)
- Non-root user execution

### Container Registry
- Docker Hub for public images
- AWS ECR for private repositories
- Image versioning strategy
- Lifecycle policies for old images
- Access control and permissions

---

## Kubernetes

### Core Concepts

#### Deployments
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: app
        image: myapp:latest
        ports:
        - containerPort: 3000
        resources:
          requests:
            memory: "256Mi"
            cpu: "100m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 10
          periodSeconds: 10
```

#### Services & Ingress
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  type: ClusterIP
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 3000
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

### Advanced Topics
- **StatefulSets**: For databases and stateful applications
- **DaemonSets**: For monitoring and logging agents
- **ConfigMaps & Secrets**: Configuration management
- **Helm Charts**: Package management
- **Service Mesh**: Istio, Linkerd for advanced networking
- **Network Policies**: Traffic control
- **Resource Quotas**: Namespace resource limits

---

## Monitoring & Logging

### Prometheus Stack

#### Prometheus Configuration
```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'kubernetes-nodes'
    kubernetes_sd_configs:
      - role: node
    scheme: https
    tls_config:
      ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

#### Grafana Dashboards
- System metrics (CPU, Memory, Disk)
- Application performance (Latency, Throughput, Errors)
- Business metrics (Revenue, Users, Conversions)
- Infrastructure health (Node status, Pod status)

### ELK Stack (Elasticsearch, Logstash, Kibana)

#### Logstash Pipeline
```ruby
input {
  beats {
    port => 5044
  }
}

filter {
  grok {
    match => { "message" => "%{COMBINEDAPACHELOG}" }
  }
  date {
    match => [ "timestamp", "dd/MMM/yyyy:HH:mm:ss Z" ]
  }
}

output {
  elasticsearch {
    hosts => ["elasticsearch:9200"]
    index => "logs-%{+YYYY.MM.dd}"
  }
}
```

### Alerting
- Alert rules based on metrics
- Multi-channel notifications (Slack, PagerDuty, Email)
- Escalation policies
- On-call scheduling

---

## Cloud Platforms

### AWS
- **Compute**: EC2, Lambda, ECS, EKS
- **Storage**: S3, EBS, EFS, Glacier
- **Database**: RDS, DynamoDB, ElastiCache
- **Networking**: VPC, CloudFront, Route 53
- **Security**: IAM, KMS, Secrets Manager

### Google Cloud Platform
- **Compute**: GCE, Cloud Run, GKE
- **Storage**: Cloud Storage, Persistent Disks
- **Database**: Cloud SQL, Firestore, BigQuery
- **Networking**: Cloud Load Balancing, Cloud CDN

### Microsoft Azure
- **Compute**: VMs, App Service, AKS
- **Storage**: Blob Storage, Managed Disks
- **Database**: Azure SQL, Cosmos DB
- **Networking**: Virtual Network, Application Gateway

---

## Security

### Infrastructure Security
- Network segmentation with VPCs/Security Groups
- WAF (Web Application Firewall)
- DDoS protection
- Certificate management (SSL/TLS)
- Encryption at rest and in transit

### Identity & Access Management
- IAM policies and roles
- RBAC (Role-Based Access Control)
- MFA enforcement
- Service accounts and API keys
- Audit logging

### Secrets Management
- HashiCorp Vault
- AWS Secrets Manager
- Kubernetes Secrets
- Encrypted secret files in version control

### Compliance
- GDPR, CCPA compliance
- SOC 2 Type II
- PCI DSS for payment systems
- HIPAA for healthcare
- Regular security audits

---

## 📚 Resources & References

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Prometheus Monitoring](https://prometheus.io/docs/)
- [Terraform Registry](https://registry.terraform.io/)
