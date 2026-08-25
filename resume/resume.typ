#import "@preview/basic-resume:0.2.9": *

#let name = "Christopher Gikas"
#let location = "California, United States"
#let email = ""
#let personal-site = "gikas.io"
#let linkedin = "linkedin.com/in/cgik"
#let github = "github.com/cgik"

#show: resume.with(
  author: name,
  location: location,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)
== Summary
My bread and butter, and where I make the biggest impact for a company, is designing release processes that work for everyone in the company, and I do mean everyone. A good release process can make or break a company’s costs in headcount, technical debt, and both business and developer satisfaction.
I’m also a big fan of keeping things simple to allow for maximum flexibility. I’m very tool-agnostic and have a good track record of quickly becoming an expert in whatever makes the most sense for the problem at hand

== Work Experience

#work(
  title: "DevOps Production Engineer",
  location: "California (remote)",
  company: "Axonius",
  dates: dates-helper(start-date: "May 2025")
)
- Redesigned and stabilized the Federal release process, including installer workflows, golden/base-image creation with Packer, encrypted AMIs, LUKS/LVM configuration, and Rocky/RHEL deployment support.
- Migrated legacy CI/CD and installer workflows into the R&D TeamCity environment while resolving build, artifact, release-tagging, and deployment issues across multiple release pipelines.
- Built and improved release automation using TeamCity and GitHub Actions for Federal builds, artifact distribution, ECR workflows, S3 uploads, OVA/AMI releases, and documentation publishing.
- Reduced infrastructure costs by 10,000/month through snapshot/storage optimization, alongside additional infrastructure cost-reduction work.
- Documented release tooling and previously siloed operational knowledge to improve maintainability and knowledge transfer across teams.
- *Technologies*: TeamCity, AWX, Ansible, Linux, Python, Bash, IAM, Terraform, FedRAMP

#work(
  title: "Staff Platform Engineer",
  location: "San Francisco, CA (remote)",
  company: "Grubmarket",
  dates: dates-helper(start-date: "Jun 2022", end-date: "Nov 2024"),
)
- Introduced observability with DataDog, went from customers alerting us about something being wrong to proactively fixing things.
- Went from manual deployments and in-repository secrets to fully automated deployments and secrets management, also moved from nothing to Terraform for everything in our infrastructure.
- Implemented just-in-time and passwordless access to both our data and AWS environments.
- Migrated legacy infrastructure to modern AWS ECS architecture and Fargate, keeping things simple for a small team.
- Worked cross-internal company to meet security needs for SOC2 and streamline, securing our applications and IP.
- Migrated MySQL 5.7 to MySQL 8 zero downtime, no customer interruption.
- *Technologies*: ECS, Github Actions, Java, RDS, IAM, S3, DataDog, CloudFront, Terraform

#work(
  title: "Senior DevOps Engineer",
  location: "San Francisco, CA (remote)",
  company: "Oportun",
  dates: dates-helper(start-date: "Jun 2017", end-date: "Jun 2022"),
)
Promoted from Jr. DevOps Engineer to DevOps Engineer to Senior DevOps Engineer
- Led architecture reviews and cross-team technical initiatives, including managing the architecture team’s technical work.
- Designed the company’s Kubernetes implementation on AWS EKS and worked with the Data & AI team to design and introduce an internal AI product.
- Migrated applications from on-premises infrastructure to AWS and created a disaster recovery environment with a documented failover process.
- Improved AWS architecture and automation across environments, including a 20% cost reduction in key environments and a 15% reduction in a 400+ EC2 development environment.
- Coordinated production releases across product and engineering teams and debugged production issues across the full application stack.
- *Technologies*: Kubernetes, Ansible, Jenkins, Linux, Python

== Projects
#project(
  dates: "Present",
  name: "tetrigo",
  role: "Owner",
  url: "tetrigo.net",
)
- Designed, developed, and operate an original online puzzle game inspired by the Puzzle League genre, owning the product from game mechanics and architecture through deployment and production operations.
