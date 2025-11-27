# Introduction

GitHub Actions optimize code-delivery time, from idea to deployment, on a community-powered platform.

Suppose you manage a team that's developing a web site that will improve your customers' experience when they contact product support. This project is important to upper management. They want a high-quality site, and they want to publish it soon. You need to make sure your team is producing code that tests, builds, and deploys quickly once a feature is implemented. On top of that, your IT department wants to automate creating and tearing down the project's infrastructure. You decide to use continuous integration (CI) and continuous delivery (CD) to automate all the build, test, and deployment tasks. You're also going to adopt infrastructure as code (IaC) to automate the IT tasks.

There are several tools available to help you achieve these goals. However, because you're already using GitHub for your code repository, you decide to investigate GitHub Actions to see if it provides the automation you need.

In this module, you'll be introduced to GitHub Actions and workflows. In subsequent modules, you'll use what you learn here to implement continuous integration, continuous delivery, and infrastructure as code.

## Learning objectives

In this module, you'll:

* Learn what GitHub Actions are, the types of actions, and where to find them.
* Identify the required components within a GitHub Actions workflow file.
* Plan the automation of your software-development lifecycle with GitHub Actions workflows.
* Create a container action and have it run in a workflow that's triggered by a push event to your GitHub repository.

## Prerequisites

* A GitHub account

# How does GitHub Actions automate development tasks?

Here, we introduce GitHub Actions and workflows. You learn the types of actions you can use and where to find them. You also look at examples of these types of actions and how they fit in a workflow.

## GitHub decreases time from idea to deployment

GitHub is designed to help teams of developers and DevOps engineers build and deploy applications quickly. There are many features in GitHub that enable these efficiencies, but they generally fall into one of two categories:

* ***Communication***: Consider all of the ways that GitHub makes it easy for a team of developers to communicate about the software development project: code reviews in pull requests, GitHub issues, project boards, wikis, notifications, and so on.
* ***Automation***: GitHub Actions lets your team automate workflows at every step in the software-development process, from integration to delivery to deployment. It even lets you automate adding labels to pull requests and checking for stale issues and pull requests.

When combined, these features have allowed thousands of development teams to effectively decrease the amount of time it takes from their initial idea to deployment.

## Use workflow automation to decrease development time

In this module, we focus on automation. Let's take a moment to understand how teams can use automation to reduce the amount of time it takes to complete a typical development and deployment workflow.

Consider all of the tasks that must happen after the code is written, but before you can reliably use the code for its intended purpose. Depending on your organization's goals, you likely need to perform one or more of the following tasks:

* Ensure the code passes all unit tests.
* Perform code quality and compliance checks to make sure the source code meets the organization's standards.
* Check the code and its dependencies for known security issues.
* Build the code by integrating new source code from (potentially) multiple contributors.
* Ensure the software passes integration tests.
* Specify the version of the new build.
* Deliver the new binaries to the appropriate filesystem location.
* Deploy the new binaries to one or more servers.
* Determine if any of these tasks don't pass, and report the issue to the proper individual or team for resolution.

The challenge is to do these tasks reliably, consistently, and in a sustainable manner. This process is an ideal job for workflow automation. If you're already relying on GitHub, you likely want to set up your workflow automation using GitHub Actions.

## What is GitHub Actions?

GitHub Actions are packaged scripts to automate tasks in a software-development workflow in GitHub. You can configure GitHub Actions to trigger complex workflows that meet your organization's needs. The trigger can happen each time developers check new source code into a specific branch, at timed intervals, or manually. The result is a reliable and sustainable automated workflow, which leads to a significant decrease in development time.

## Where can you find GitHub Actions?

GitHub Actions are scripts that adhere to a yml data format. Each repository has an Actions tab that provides a quick and easy way to get started with setting up your first script. If you see a workflow that you think might be a great starting point, just select the Configure button to add the script and begin editing the source yml.

![image](github-actions-automate-development-tasks-01.png)

However, beyond those GitHub Actions featured on the Actions tab, you can:

* Search for GitHub Actions in the GitHub Marketplace. The GitHub Marketplace allows you to discover and purchase tools that extend your workflow.
* Search for open-source projects. For example, the GitHub Actions organization features many popular open-source repos containing GitHub Actions you can use.
* Write your own GitHub Actions from scratch. You can make them open source, or even publish them to the GitHub Marketplace.

## Using open-source GitHub Actions

Many GitHub Actions are open source and available for anyone who wants to use them. However, just like with any open-source software, you need to carefully check them before using them in your project. Similar to recommended community standards with open-source software such as including a README, code of conduct, contributing file, and issue templates, you can follow these recommendations when using GitHub Actions:

* Review the action's action.yml file for inputs, outputs, and to make sure the code does what it says it does.
* Check if the action is in the GitHub Marketplace. This check is worthwhile, even if an action doesn't have to be on the GitHub Marketplace to be valid.
* Check if the action is verified in the GitHub Marketplace. Verification means that GitHub approved the use of this action. However, you should still review it before using it.
* Include the version of the action you're using by specifying a Git ref, SHA, or tag.

## Types of GitHub actions

There are three types of GitHub actions: container actions, JavaScript actions, and composite actions.

With container actions, the environment is part of the action's code. These actions can only be run in a Linux environment that GitHub hosts. Container actions support many different languages.

JavaScript actions don't include the environment in the code. You have to specify the environment to execute these actions. You can run these actions in a VM (virtual machine) in the cloud or on-premises. JavaScript actions support Linux, macOS, and Windows environments.

Composite actions allow you to combine multiple workflow steps within one action. For example, you can use this feature to bundle together multiple run commands into an action, and then have a workflow that executes the bundled commands as a single step using that action.

### The anatomy of a GitHub action

Here's an example of an action that performs a git checkout of a repository. This action, actions/checkout@v1, is part of a step in a workflow. This step also builds the Node.js code that was checked out. We'll talk about workflows, jobs, and steps in the next section.

```yml
steps:
  - uses: actions/checkout@v1
  - name: npm install and build webpack
    run: |
      npm install
      npm run build
```

Suppose you want to use a container action to run containerized code. Your action might look like this:

```yml
name: "Hello Actions"
description: "Greet someone"
author: "octocat@github.com"

inputs:
    MY_NAME:
      description: "Who to greet"
      required: true
      default: "World"

runs:
    uses: "docker"
    image: "Dockerfile"

branding:
    icon: "mic"
    color: "purple"
```

***Notice*** the inputs section. Here, you're getting the value of a variable called MY_NAME. This variable is set in the workflow that runs this action.

In the runs section, notice you specify docker in the uses attribute. When you set this value, you need to provide the path to the Docker image file. In this case, Dockerfile. We're not covering the specifics of Docker here, but if you'd like more information, check out the Introduction to Docker Containers module.

The last section, branding, personalizes your action in the GitHub Marketplace if you decide to publish it there.

You can find a complete list of action metadata at Metadata syntax for GitHub Actions.

## What is a GitHub Actions workflow?

A GitHub Actions workflow is a process that you set up in your repository to automate software-development lifecycle tasks, including GitHub Actions. With a workflow, you can build, test, package, release, and deploy any project on GitHub.

To create a workflow, you add actions to a .yml file in the `.github/workflows` directory in your GitHub repository.

In the exercise coming up, your workflow file main.yml looks like this example:

```yml
name: A workflow for my Hello World file
on: push
jobs:
  build:
    name: Hello world action
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: ./action-a
      with:
        MY_NAME: "Mona"
```

***Notice the on***: attribute, its value is a trigger to specify when this workflow runs. Here, it triggers a run when there's a push event to your repository. You can specify single events like on: push, an array of events like on: [push, pull_request], or an event-configuration map that schedules a workflow or restricts the execution of a workflow to specific files, tags, or branch changes. The map might look something like this:

```yml
on:
  # Trigger the workflow on push or pull request,
  # but only for the main branch
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  # Also trigger on page_build, as well as release created events
  page_build:
  release:
    types: # This configuration doesn't affect the page_build event above
      - created
```
An event triggers on all activity types for the event unless you specify the type or types. For a comprehensive list of events and their activity types, see: Events that trigger workflows in the GitHub documentation.

A workflow must have at least one job. A job is a section of the workflow associated with a runner. A runner can be GitHub-hosted or self-hosted, and the job can run on a machine or in a container. You specify the runner with the runs-on: attribute. Here, you're telling the workflow to run this job on ubuntu-latest.

Each job has steps to complete. In our example, the step uses the action actions/checkout@v1 to check out the repository. What's interesting is the uses: ./action-a value, which is the path to the container action that you build in an action.yml file.

The last part of this workflow file sets the MY_NAME variable value for this workflow. Recall the container action took an input called MY_NAME.

For more information on workflow syntax, see Workflow syntax for GitHub Actions

## Referencing actions in workflows

When creating workflows in GitHub Actions, you can reference actions from various sources. These actions can be used to automate tasks in your workflows. Below are the primary sources where workflows can reference actions:

1. A published Docker container image on Docker Hub

Workflows can reference actions that are published as Docker container images on Docker Hub. These actions are containerized and include all dependencies required to execute the action. To use such an action, you specify the Docker image in the uses attribute of your workflow step. For example:

```yml 
steps:
  - name: Run a Docker action
    uses: docker://<docker-image-name>:<tag>
```

2. Any public repository

Actions hosted in public repositories can be directly referenced in your workflows. These actions are accessible to anyone and can be used by specifying the repository name and version (Git ref, SHA, or tag) in the uses attribute. For example:

```yml
    steps:
      - name: Use a public action
        uses: actions/checkout@v3
``` 

[!IMPORTANT]

    For better security, use a full commit SHA when referencing actions—not just a tag like @v3.
    This makes sure your workflow always uses the exact same code, even if the action is updated or changed later.

Example: `uses: actions/checkout@c2c1744e079e0dd11c8e0af4a96064ca4f6a2e9e`

3. The same repository as your workflow file

You can reference actions stored in the same repository as your workflow file. This feature is useful for custom actions that are specific to your project. To reference such actions, use a relative path to the action's directory. For example:

```yml 
    steps:
      - name: Use a local action
        uses: ./path-to-action
```
For more details, see security hardening guidance for GitHub Actions.

4. An enterprise marketplace

If your organization uses GitHub Enterprise, you can reference actions from your enterprise's private marketplace. These actions are curated and managed by your organization, ensuring compliance with internal standards. For example:

```yml 
    steps:
      - name: Use an enterprise marketplace action
        uses: enterprise-org/action-name@v1
```

***Note***

* Actions in private repositories can also be referenced, but they require proper authentication and permissions.

* When referencing actions, always specify a version (Git ref, SHA, or tag) to ensure consistency and avoid unexpected changes.

For more information, see Referencing actions in workflows.

## GitHub-hosted versus self-hosted runners

We briefly mentioned runners as being associated with a job. A runner is simply a server that has the GitHub Actions runner application installed. In the previous workflow example, there was a runs-on: ubuntu-latest attribute within the jobs block, which told the workflow that the job is going to run using the GitHub-hosted runner that's running in the ubuntu-latest environment.

When it comes to runners, there are two options from which to choose: GitHub-hosted runners or self-hosted runners. If you use a GitHub-hosted runner, each job runs in a fresh instance of a virtual environment. The GitHub-hosted runner type you define, runs-on: {operating system-version} then specifies that environment. With self-hosted runners, you need to apply the self-hosted label, its operating system, and the system architecture. For example, a self-hosted runner with a Linux operating system and ARM32 architecture would look like the following specification: runs-on: [self-hosted, linux, ARM32].

Each type of runner has its benefits, but GitHub-hosted runners offer a quicker and simpler way to run your workflows, albeit with limited options. Self-hosted runners are a highly configurable way to run workflows in your own custom local environment. You can run self-hosted runners on-premises or in the cloud. You can also use self-hosted runners to create a custom hardware configuration with more processing power or memory. This type of configuration helps to run larger jobs, install software available on your local network, and choose an operating system not offered by GitHub-hosted runners.

### GitHub Actions can have usage limits

GitHub Actions does have some usage limits, depending on your GitHub plan and whether your runner is GitHub-hosted or self-hosted. For more information on usage limits, check out Usage limits, billing, and administration in the GitHub documentation.

## GitHub hosted larger runners

GitHub offers larger runners for workflows that require more resources. These runners are GitHub-hosted and provide increased CPU, memory, and disk space compared to standard runners. They're designed to handle resource-intensive workflows efficiently, ensuring optimal performance for demanding tasks.

### Runner sizes and labels

Larger runners are available in multiple configurations, providing enhanced vCPUs, RAM, and SSD storage to meet diverse workflow requirements. These configurations are ideal for scenarios such as:

* Compiling large codebases with extensive source files.
* Running comprehensive test suites, including integration and end-to-end tests.
* Processing large datasets for data analysis or machine learning tasks.
* Building applications with complex dependencies or large binary outputs.
* Performing high-performance simulations or computational modeling.
* Executing video encoding, rendering, or other multimedia processing workflows.

To use a larger runner, specify the desired runner label in the runs-on attribute of your workflow file. For example, to use a runner with 16 vCPUs and 64 GB of RAM, you would set runs-on: ubuntu-latest-16core.

```yml
jobs:
  build:
    runs-on: ubuntu-latest-16core
    steps:
      - uses: actions/checkout@v2
      - name: Build project
        run: make build
```

These larger runners maintain compatibility with existing workflows by including the same preinstalled tools as standard ubuntu-latest runners.

For more information about runner sizes for larger runners, see the GitHub documentation

### Managing larger runners

GitHub provides tools to manage larger runners effectively, ensuring optimal resource utilization and cost management. Here are some key aspects of managing larger runners:

#### Monitoring usage

You can monitor the usage of larger runners through the GitHub Actions usage page in your repository or organization settings. This page provides insights into the number of jobs run, the total runtime, and the associated costs.

#### Managing access

To control access to larger runners, you can configure repository or organization-level policies. This configuration ensures that only authorized workflows or teams can use these high-resource runners.

#### Cost management

Larger runners incur extra costs based on their usage. To manage costs, consider the following suggestions:

* Use larger runners only for workflows that require high resources.
* Reduce runtime by optimizing workflows.
* Monitor billing details regularly to track expenses.

#### Scaling workflows

If your workflows require frequent use of larger runners, consider scaling strategies such as:

* Using self-hosted runners for predictable workloads.
* Splitting workflows into smaller jobs to distribute the load across standard runners.


# Identify the components of GitHub Actions

Here, you'll learn about the basic components of a GitHub Actions workflow file.

## The components of GitHub Actions

![image](github-actions-workflow-components.png)

There are several components that work together to run tasks or jobs within a GitHub Actions workflow. In short, an event triggers the workflow, which contains a job. This job then uses steps to dictate which actions will run within the workflow. To better see how these components work together, let's take a quick look at each one.

### Workflows

A workflow is an automated process that you add to your repository. A workflow needs to have at least one job, and different events can trigger it. You can use it to build, test, package, release, or deploy your repository's project on GitHub.

### Jobs

The job is the first major component within the workflow. A job is a section of the workflow that will be associated with a runner. A runner can be GitHub-hosted or self-hosted, and the job can run on a machine or in a container. You'll specify the runner with the runs-on: attribute. Here, you're telling the workflow to run this job on ubuntu-latest. We'll talk more about runners in the next unit.

### Steps

A step is an individual task that can run commands in a job. In our preceding example, the step uses the action actions/checkout@v2 to check out the repository. What's interesting is the uses: ./action-a value. This is the path to the container action that you'll build in an action.yml file.

### Actions

The actions inside your workflow are the standalone commands that are executed. These standalone commands can reference GitHub actions such as using your own custom actions, or community actions like the one we use in the preceding example, actions/checkout@v2. You can also run commands such as run: npm install -g bats to execute a command on the runner.


# Configure a GitHub Actions workflow


Here, you learn some common configurations within a workflow file. You also explore the categories of event types, disabling and deleting workflows, and using specific versions of an action for security best practices.

## Configure workflows to run for scheduled events

As mentioned previously, you can configure your workflows to run when specific activity occurs on GitHub, when an event outside of GitHub happens, or at a scheduled time. The schedule event allows you to trigger a workflow to run at specific UTC times using POSIX cron syntax. This cron syntax has five * fields, and each field represents a unit of time.

![image](scheduled-events.png)

For example, if you wanted to run a workflow every 15 minutes, the schedule event would look like the following example:

```yml
on:
  schedule:
    - cron:  '*/15 * * * *'
```

And if you wanted to run a workflow every Sunday at 3:00am, the schedule event would look like this:

```yml
on:
  schedule:
    - cron:  '0 3 * * SUN'
```

You can also use operators to specify a range of values or to dial in your scheduled workflow. The shortest interval you can run scheduled workflows is once every five minutes, and they run on the latest commit on the default or base branch.

## Configure workflows to run for manual events

In addition to scheduled events, you can manually trigger a workflow by using the workflow_dispatch event. This event allows you to run the workflow by using the GitHub REST API or by selecting the Run workflow button in the Actions tab within your repository on GitHub. Using workflow_dispatch, you can choose on which branch you want the workflow to run, and set optional inputs that GitHub presents as form elements in the UI.

```yml
on:
  workflow_dispatch:
    inputs:
      logLevel:
        description: 'Log level'     
        required: true
        default: 'warning'
      tags:
        description: 'Test scenario tags'  
```

In addition to workflow_dispatch, you can use the GitHub API to trigger a webhook event called repository_dispatch. This event allows you to trigger a workflow for activity that occurs outside of GitHub. It essentially serves as an HTTP request to your repository asking GitHub to trigger a workflow off an action or webhook. Using this manual event requires you to do two things: send a POST request to the GitHub endpoint /repos/{owner}/{repo}/dispatches with the webhook event names in the request body, and configure your workflow to use the repository_dispatch event.

```Bash
curl \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/octocat/hello-world/dispatches \
  -d '{"event_type":"event_type"}'
```

```yml
on:
  repository_dispatch:
    types: [opened, deleted]
```

## Configure workflows to run for webhook events

Lastly, you can configure a workflow to run when specific webhook events occur on GitHub. You can trigger most webhook events from more than one activity for a webhook. If multiple activities exist for a webhook, you can specify an activity type to trigger the workflow. For example, you can run a workflow for the check_run event, but only for the rerequested or requested_action activity types.
```yml
on:
  check_run:
    types: [rerequested, requested_action]
```

## Repository_dispatch

repository_dispatch is a custom event in GitHub Actions that allows external systems (or even other GitHub workflows) to manually trigger workflows by sending a POST request to the GitHub API. It enables flexible automation and integration with outside tools, scripts, or systems that need to start workflows in your repo.

### Use cases

* Trigger workflows from external CI/CD tools.

* Coordinate multi-repo deployments (for example, Repo A finishes build → triggers Repo B).

* Start automation based on external events (webhooks, monitoring alerts, CRON jobs outside GitHub).

* Chain workflow executions between repositories or within monorepos.

### Example workflow that listens to repository_dispatch

```yml
name: Custom Dispatch Listener

on:
  repository_dispatch:
    types: [run-tests, deploy-to-prod]  # Optional filtering

jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - name: Echo the payload
        run: |
          echo "Event type: ${{ github.event.action }}"
          echo "Payload value: ${{ github.event.client_payload.env }}"
```

#### Key elements:

* types: Optional. Defines custom event types like run-tests, deploy-to-prod, etc.

* github.event.client_payload: Access to any other custom data passed in the dispatch event.

* github.event.action: Name of the event_type sent.

### Triggering the event via API

You must send a POST request to the GitHub REST API v3 endpoint:

```sh
POST https://api.github.com/repos/OWNER/REPO/dispatches
```

#### Authorization

* Requires a personal access token (PAT) with repo scope.
* For organizations, ensure proper access settings for your token.

#### Sample command structure

```sh
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  https://api.github.com/repos/OWNER/REPO/dispatches \
  -d '{"event_type":"run-tests","client_payload":{"env":"staging"}}'
```

#### Payload structure

```JSON
{
  "event_type": "run-tests",
  "client_payload": {
    "env": "staging"
  }
}
```

#### Parameters

Field 	Type 	Description 	Required
event_type 	string 	A custom name for the event. This name maps to the types value in your workflow trigger 	Yes
client_payload 	object 	Arbitrary JSON payload to send custom data to the workflow (github.event.client_payload) 	No

#### Repository_dispatch parameters breakdown

When making a POST request to the GitHub API endpoint, you must pass a JSON body with two main parameters:

* event_type
* client_payload

#### event_type

A required custom string that you define. GitHub treats this value as the "action" or "type" of the dispatch. It’s used to identify what triggered the workflow and filter workflows that are listening for specific types.

* Format:
    * Type: string
    * Example: "deploy", "run-tests", "sync-db", "build-docker"

* Use in Workflow: Used in listening for specific event types and accessing the value inside the workflow. This helps with the reuse of a single workflow for multiple purposes and makes automation more organized and event-driven.

* Example:

```JSON
- name: Print event type
  run: echo "Event type: ${{ github.event.action }}"
```

#### client_payload

A free-form JSON object that lets you send custom data along with the dispatch. You define the structure, and it's accessible inside the workflow.

* Format:
    * Type: object
    * Custom keys and values

* Use in Workflow: This object is used for multi-environment deployments, versioned releases, or passing context from another system or pipeline and enables parameterized workflows, similar to input arguments.

* Example:

```JSON
- name: Show payload values
  run: |
    echo "Environment: ${{ github.event.client_payload.env }}"
    echo "Version: ${{ github.event.client_payload.version }}"
```

#### Example payload breakdown

```JSON
{
  "event_type": "deploy-to-prod",
  "client_payload": {
    "env": "production",
    "build_id": "build-456",
    "initiator": "admin_user",
    "services": ["web", "api", "worker"]
  }
}
```

## Use conditional keywords

Within your workflow file, you can access context information and evaluate expressions. Although expressions are commonly used with the conditional if keyword in a workflow file to determine whether a step should run or not, you can use any supported context and expression to create a conditional. It's important to know that when using conditionals in your workflow, you need to use the specific syntax ${{ <expression> }}. This syntax tells GitHub to evaluate an expression rather than treat it as a string.

For example, a workflow that uses the if conditional to check if the github.ref (the branch or tag ref that triggered the workflow run) matches refs/heads/main. In order to proceed, the workflow would look something like this:

```yml
name: CI
on: push
jobs:
  prod-check:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      ...
```

Notice that in this example, the ${{ }} are missing from the syntax. With some expressions, like the if conditional, you can omit the expression syntax. GitHub automatically evaluates some of these common expressions, but you can always include them in case you forget which expressions GitHub automatically evaluates.

For more information about workflow syntax and expressions, check out Workflow syntax for GitHub Actions.

## Disable and delete workflows

After adding a workflow to your repository, you might find a situation where you want to temporarily disable the workflow. You can stop a workflow from being triggered without having to delete the file from the repo, either on GitHub or through the GitHub REST API. When you wish to enable the workflow again, you can easily do it using the same methods.

![image](disable-workflow.png)

Disabling a workflow can be useful in some of the following situations:

* An error on a workflow is producing too many or wrong requests impacting external services negatively.
* You want to temporarily pause a workflow that isn't critical and is consuming too many minutes on your account.
* You want to pause a workflow that's sending requests to a service that is down.
* You're working on a fork, and you don't need all the functionality of some workflows it includes (like scheduled workflows).

You can also cancel a workflow run that's in progress in the GitHub UI from the Actions tab or by using the GitHub API endpoint DELETE /repos/{owner}/{repo}/actions/runs/{run_id}. Keep in mind that when you cancel a workflow run, GitHub cancels all of its jobs and steps within that run.

## Use an organization's templated workflow

If you have a workflow that multiple teams use within an organization, you don't need to re-create the same workflow for each repository. Instead, you can promote consistency across your organization by using a workflow template defined in the organization's .github repository. Any member within the organization can use an organization template workflow, and any repository within that organization has access to those template workflows.

You can find these workflows by navigating to the Actions tab of a repository within the organization, selecting New workflow, and then finding the organization's workflow template section titled "Workflows created by organization name". For example, the organization called Mona has a template workflow as shown here.

![image](mona-workflow.png)

## Use specific versions of an action

When referencing actions in your workflow, we recommend that you refer to a specific version of that action rather than just the action itself. By referencing a specific version, you're placing a safeguard from unexpected changes pushed to the action that could potentially break your workflow. Here are several ways you can reference a specific version of an action:

```yml
steps:    
  # Reference a specific commit
  - uses: actions/setup-node@c46424eee26de4078d34105d3de3cc4992202b1e
  # Reference the major version of a release
  - uses: actions/setup-node@v1
  # Reference a minor version of a release
  - uses: actions/setup-node@v1.2
  # Reference a branch
  - uses: actions/setup-node@main
```

Some references are safer than others. For example, referencing a specific branch runs that action off of the latest changes from that branch, which you might or might not want. By referencing a specific version number or commit SHA hash, you're being more specific about the version of the action you're running. For more stability and security, we recommend that you use the commit SHA of a released action within your workflows.