# NovaBank – Architecture Summary

## Business Context
NovaBank is a digital bank currently operating a small customer-facing portal on on-premises infrastructure. The existing setup consists of a single virtual machine hosting a web API and a PostgreSQL database, with logs written only to local files and no clear separation between development and production environments.
As a regulated financial institution, NovaBank must meet strict requirements around availability, data protection, auditability, and operational resilience. At the same time, the current on-premises setup limits scalability, automation, and visibility, and introduces operational risk due to manual processes and single points of failure.
NovaBank’s leadership has decided to begin its transition to the public cloud to improve reliability, compliance readiness, and long-term agility, while keeping costs predictable and avoiding unnecessary complexity at this early stage.

## Objectives
-Improve reliability and resilience by meeting baseline targets of 99.9% availability, RPO ≤ 1 hour, and RTO ≤ 4 hours.
-Enable repeatable and automated deployments using Infrastructure as Code, eliminating manual “click-ops” and reducing operational risk.
-Centralize logging and monitoring to support incident investigation.
-Maintain architectural simplicity by selecting a minimal set of well-understood cloud services and deliberately avoiding complex platforms in the initial phase.
-Control and justify cloud costs by choosing cost-efficient service tiers, limiting over-provisioning. 


## Proposed Direction
- AWS public cloud
- EC2 for API
- Amazon RDS (PostgreSQL)
- CloudWatch for centralized logging
- Terraform for IaC

## Architecture Diagram
Check (NovaBank.drawio.png)

## Key Decisions & Trade-offs
1. Cloud Provider: AWS

Decision: Use AWS for the initial migration phase.
Rationale: Mature managed services (EC2, RDS, CloudWatch) enable availability, backups, and logging with minimal setup.
Trade-off: Azure offers similar capabilities; this choice does not create long-term vendor lock-in.

2. Compute Model: EC2 Virtual Machines

Decision: Deploy the NovaBank API on EC2 instances.
Rationale: Aligns with the existing on-prem VM architecture, reducing migration risk.
Trade-off: Requires OS management and offers less automated scaling than container or serverless options.

3. Database: Amazon RDS (PostgreSQL)
Decision: Use Amazon RDS with PostgreSQL.
Rationale: Provides automated backups, high availability, and private networking, supporting RPO/RTO targets.
Trade-off: Higher cost than self-managed databases but significantly lower operational risk.

4. Environment Separation: Dev and Prod

Decision: Separate Dev and Prod using the same Terraform code with environment variables.
Rationale: Ensures consistency while isolating changes and reducing deployment risk.
Trade-off: Slightly increased cost due to duplicated resources.

5. Infrastructure as Code: Terraform

Decision: Provision all infrastructure using Terraform.
Rationale: Enables repeatable, auditable, and automated deployments and supports CI/CD.
Trade-off: Initial learning curve offset by long-term reliability.

6. Logging & Auditability: AWS CloudWatch

Decision: Centralize logs in CloudWatch with ≥12 months retention.
Rationale: Supports auditing, troubleshooting, and operational visibility.
Trade-off: Adequate for MVP; may be extended with advanced observability tools later.

## Assumptions
See assumptions.md

## Cost Management Approach

This proof-of-concept is intentionally designed to keep cloud costs low while demonstrating a realistic and scalable architecture.

- Small AWS instance sizes are used to minimize baseline costs.
- Managed services (EC2, RDS, CloudWatch) are preferred to reduce operational overhead.
- No over-engineering (no multi-region, no complex autoscaling policies for the PoC).
- Resources are provisioned only for demonstration purposes.
- The architecture remains ready for future autoscaling and optimization if required.

This approach ensures cost efficiency while preserving a clear path to production readiness.

## Cloud Transformation Approach (CloudNation 6D Model)

This proof-of-concept is aligned with the CloudNation 6D Cloud Migration Model, which provides a structured yet flexible approach to cloud transformation.

### Discover  
The current on-premises setup is analyzed to understand existing workloads, constraints, and cloud readiness. This phase establishes a clear baseline and reduces migration risks by identifying assumptions early.

### Define  
Key requirements and objectives for the cloud migration are defined, including availability, logging, and data persistence needs. Gaps between the current state and the target cloud setup are identified.

### Design  
A target cloud architecture is designed using AWS managed services. This includes EC2 for compute, RDS for the database layer, and CloudWatch for centralized logging, balancing simplicity and scalability.

### Develop  
The designed architecture is implemented using Terraform as Infrastructure as Code. This ensures repeatable, auditable, and automated provisioning while allowing flexibility to adjust the design if new insights emerge.

### Deploy  
The infrastructure is deployed to AWS using Terraform CLI commands. This phase validates the design through actual provisioning and confirms that the environment behaves as expected.

### Deliver (Continuous)  
After deployment, the environment is ready for ongoing operation and improvement. Monitoring, logging, and cost visibility are in place, enabling future optimization, security hardening, and functional enhancements.

This PoC demonstrates the early stages of the CloudNation 6D model and serves as a foundation for further evolution toward a fully optimized cloud environment.

