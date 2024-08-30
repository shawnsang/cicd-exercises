


# Docker Image Vulnerability Scanning

In today’s fast-paced software development world, Docker has become a key tool for creating and deploying applications efficiently. 


Install Trivy
Lesson Progress
100% Complete

Let’s see how to install Trivy on Ubuntu , follow the below steps to install Trivy.

For other platform, please visit the official installation page.
## MAC

Mac users use the following command.
```
brew install aquasecurity/trivy/trivy
```

## Ubuntu

Execute the following commands to install Trivy on Ubuntu.
```
sudo apt-get install wget apt-transport-https gnupg lsb-release

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt update -y

sudo apt install trivy
```

## RHEL/CentOS

For RHEL Users.
```
$ sudo vim /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/$releasever/$basearch/
gpgcheck=0
enabled=1

$ sudo yum -y update

$ sudo yum -y install trivy
```
## Verify Trivy Installation

To verify the installation and understand all the available option, run the following trivy help command.
```
trivy -h
```
You should get an output a shown below.
```
trivy -h
Scanner for vulnerabilities in container images, file systems, and Git repositories, as well as for configuration issues and hard-coded secrets

Usage:
  trivy [global flags] command [flags] target
  trivy [command]

Examples:
  # Scan a container image
  $ trivy image python:3.4-alpine

  # Scan a container image from a tar archive
  $ trivy image --input ruby-3.1.tar

  # Scan local filesystem
  $ trivy fs .

  # Run in server mode
  $ trivy server

Scanning Commands
  aws         [EXPERIMENTAL] Scan AWS account
  config      Scan config files for misconfigurations
  filesystem  Scan local filesystem
  image       Scan a container image
  kubernetes  [EXPERIMENTAL] Scan kubernetes cluster
  repository  Scan a remote repository
  rootfs      Scan rootfs
  sbom        Scan SBOM for vulnerabilities
  vm          [EXPERIMENTAL] Scan a virtual machine image

Management Commands
  module      Manage modules
  plugin      Manage plugins

Utility Commands
  completion  Generate the autocompletion script for the specified shell
  convert     Convert Trivy JSON report into a different format
  help        Help about any command
  server      Server mode
  version     Print the version

Flags:
      --cache-dir string          cache directory (default "/Users/bibinwilson/Library/Caches/trivy")
  -c, --config string             config path (default "trivy.yaml")
  -d, --debug                     debug mode
  -f, --format string             version format (json)
      --generate-default-config   write the default config to trivy-default.yaml
  -h, --help                      help for trivy
      --insecure                  allow insecure server connections
  -q, --quiet                     suppress progress bar and log output
      --timeout duration          timeout (default 5m0s)
  -v, --version                   show version

Use "trivy [command] --help" for more information about a command.

```


## Scan Docker Images

Scanning Docker Images using Trivy is very easy. You just need to run the following trivy command with the image name you want to scan.
```
trivy image <image-name>
```

For example, I have a image named techiescamp/pet-clinic-app in my workstation. It is a docker image with java spring boot application.

I can scan the image using the following command. Trivy scans for both vulnerabilities in the image as as the java jar that is part of the image. The results of the scan will be displayed in a human-readable format.
```
trivy image techiescamp/pet-clinic-app:1.0.0
```

## Scan for severity

Trivy can scan for vulnerabilities of a specific severity. To do this, use the --severity <severity> flag to specify the vulnerability severity that you need to scan.
```
trivy image --severity CRITICAL techiescamp/pet-clinic-app:1.0.0
```

## Output as JSON

Trivy can also give output in JSON format. To do this, use the --format json flag, it will display the scanned results in JSON format.
```
trivy image --format json techiescamp/pet-clinic-app:1.0.0
```

## Ignore fixed vulnerabilities

There are vulnerabilities that cannot be fixed even if the packages are updated (unpatched/unfixed). Trivy can scan images ignoring those vulnerabilities. To do this, use the --ignore-unfixed flag.
```
trivy image --ignore-unfixed java:0.1
```

## Scan Docker tar Images

There are situations you might have the Docker images in tar format. In this case, you can use trivy to scan the image in tar format.

For example,
```
trivy image --input petclinic-app.tar
```