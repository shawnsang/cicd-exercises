

You can install Hadolint on Linux, Mac, and Windows systems.

https://github.com/hadolint/hadolint#configure


## Install in Linux

If you want to install Hadolint in your Linux system follow the below step.

**Step 1:** Download the latest Linux Hadolint package from Hadolint Github Release page.
```
wget -O hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
```

**Step 2:** Once you downloaded the application, move it to the /usr/local/bin directory.
```
sudo mv hadolint /usr/local/bin/hadolint
```

**Step 3:** Give execution permission to Hadolint using the command given below.
```
sudo chmod +x /usr/local/bin/hadolint
```

## Install in Mac

You can install Hadolint on your Mac system using the command given below.
```
brew install hadolint
```

To check if Hadolint is installed on your Linux or Mac system, run the command:
```
hadolint --version
```

## Install in Windows

Use scoop to install Hadolint on windows

```
scoop install hadolint
```

Once you have installed hadolint you will have hadolint CLI to run the lint test against the Dockerfiles.

To understand all the CLI options you can use the –help flag.

```
hadolint --help
```

## Use Hadolint
To use Hadolint, simply install it on your system and run the command with your Dockerfile. Hadolint will give a list of errors it finds in your Dockerfile as an output, along with a severity level and the cause of that problem.

To get a practical understanding, we will use a Dockerfile that is not optimized.

Save the following as a Dockerfile.
```
FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get update && apt-get install -y curl
RUN echo "hello world" | grep "world" | wc -l
CMD ["echo", "Hello, world!"]
```

Let’s run Hadolint against the above Dockerfile. Ensure you have the Dockerfile in the same Directory you are running the hadolint command.
```
hadolint Dockerfile
```

You will get the following output with a Warning and Info message with the rule numbers and remediation info as shown in the image below.

If you check warning number 7, Hadolint gives info on the shell script as well. Hadolint under the hood uses Shellcheck to lint shell scripts that are part of the RUN instruction.

Now, If you check the exit code, you will get a non-zero exit code
```
hadolint-examples git:(main) ✗ echo $?                      
1
➜  hadolint-examples git:(main) ✗
```

If you implement all the recommendations, you will get the following Dockerfile.
```
# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set the default shell with -o pipefail
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Run commands
RUN apt-get update && \
    apt-get install -y curl=8.4.0 --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "hello world" | grep -c "world"

# Default command to run
CMD ["echo", "Hello, world!"]
```

Now, if you run the Hadolint against the remediated and updated Dockerfile you will not get any warnings or info messages. If you check the exit code, you will get a 0 as shown in the image below.
Ignoring Rules

There are scenarios where you might not want to remediate all the recommendations. In such cases, you ignore specific rules using the --ignore flag.

For example, if I want to ignore DL3008 that recommends specifying versions of software packages, I can use the following command.

```
hadolint --ignore DL3008 Dockerfile
```

When working with CI/CD systems we need to standardize all the configuration and rules for lining. Here is where hadolint.yaml configuration files come in to picture.
