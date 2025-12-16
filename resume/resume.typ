#import "@preview/basic-resume:0.2.4": *

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
My bread and butter, and the thing that makes the biggest impact of value for the company is designing a release process that works for everyone in the company, 
and I do mean everyone. A good release process can make or break a company's costs in head count, technical debt and business and developer satisfaction. I also
am a big fan of keeping things simply to allow for maximum flexibility, I'm very tool agnostic and have a good track record of becoming an expert in anything that makes sense
for the company to succeed.

== Work Experience

#work(
  title: "DevOps Production Engineer",
  location: "California (remote)",
  company: "Axonius",
  dates: dates-helper(start-date: "May 2025")
)
- Migrated our TeamCity CI/CD off a legacy AWS to a new one.
- Redesigned our Federal CI/CD process 
- *Technologies*: TeamCity, AWX, Ansible, Linux, Python, Bash, IAM, Terraform, FedRamp

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
  dates: dates-helper(start-date: "Mar 2020", end-date: "Jun 2022"),
)
- Lead the architecture review meeting for cross-team collaboration and new initiatives.
- Managed the architecture team's technical work to meet and exceed deadlines and requirements.
- Designed our implementation for Kubernetes (EKS).
- Worked alongside Data & AI team to design and introduce our own AI product (pre-GPT).
- *Technologies*: Kubernetes, Ansible, Jenkins, Linux, Python

#work(
  title: "DevOps Engineer",
  location: "San Francisco, CA (remote)",
  company: "Oportun",
  dates: dates-helper(start-date: "Sep 2018", end-date: "Mar 2020"),
)
- Migrated applications from on-prem to AWS, improving existing automation 
- Created disaster recovery environment with failover playbook.
- Migrated key environments within our AWS account to reduce costs by 20%.

#work(
  title: "Jr DevOps Engineer",
  location: "San Francisco, CA (remote)",
  company: "Oportun",
  dates: dates-helper(start-date: "Jun 2017", end-date: "Oct 2018"),
)
- Worked with development team to introduce new applications, meet security and scalability requirements.
- Coordinated production deployments and releases between product and engineering teams.
- Improved our Ansible and Jenkins managed development environment, consisting of 400+ EC2 instances, reduced AWS costs by 15% with architectural changes.
- Triage production issues and debugging full application stack issues.

== Projects
#project(
  dates: "Present",
  name: "tetrigo",
  role: "Owner",
  url: "tetrigo.net",
)
- Developed an online game based on the classic genre of game Puzzle League, written in TypeScript and React with Golang for the backend.
- Hosted with Cloudflare pages and GCP Cloud Run.
