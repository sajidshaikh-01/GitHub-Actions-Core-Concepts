📘 Table of Contents

What is GitHub Actions

Core Components

Creating a Workflow

Understanding Actions

Checkout Action

Triggers (Events)

Jobs and Steps

Matrix Builds

Job Concurrency

Secrets and Variables

Access Workflow Context

Workflow Event Filters & Activity Types

Docker Example

Summary

💡 What is GitHub Actions

GitHub Actions is a CI/CD tool built into GitHub that helps you automate, build, test, and deploy code directly from your repositories.

✅ Automates your development workflows.
✅ Integrates easily with any environment (Docker, Kubernetes, AWS, etc.).
✅ You define automation using simple YAML files inside .github/workflows/.



⚙️ Core Components
Component	Description
Workflow	The automation pipeline defined in YAML (.github/workflows/*.yml).
Event	The trigger that starts a workflow (e.g., push, pull_request).
Job	A collection of steps that run together on a virtual machine.
Step	An individual task (run a command or use an action).
Action	A reusable component that performs a task (e.g., checkout code, setup Node).
Runner	The virtual machine that executes the jobs (Ubuntu, Windows, macOS).
🧩 Creating a Workflow

Create a file:
.github/workflows/first-workflow.yml

name: Hello World Workflow

on: [push]

jobs:
  hello-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print message
        run: echo "🎉 Hello from GitHub Actions!"




⚡ Understanding Actions

Actions are reusable scripts from the GitHub Marketplace or custom ones you write.
They are like prebuilt functions that you can plug into your pipeline.

Example: using an action to checkout your repo code.

📦 Checkout Action
- name: Checkout repository
  uses: actions/checkout@v4


✅ Pulls your repository code into the runner
✅ Needed before running build or test commands



🔔 Triggers (Events)

You can trigger workflows automatically or manually.

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:  # manual trigger



🧱 Jobs and Steps
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

🧮 Matrix Builds

Matrix allows you to run a job on multiple environments automatically.

strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node: [16, 18]

runs-on: ${{ matrix.os }}

steps:
  - name: Setup Node.js
    uses: actions/setup-node@v4
    with:
      node-version: ${{ matrix.node }}


✅ Runs same tests across multiple OS and Node versions.

🔁 Job Concurrency

Prevent multiple runs of the same job.

concurrency:
  group: deploy-production
  cancel-in-progress: true


✅ Ensures only one deployment runs at a time (useful in production).





🔒 Secrets and Variables

Store sensitive info (like passwords or tokens) securely in GitHub → Settings → Secrets and Variables → Actions.

Example use:

env:
  DOCKER_USER: ${{ secrets.DOCKER_USERNAME }}
  DOCKER_PASS: ${{ secrets.DOCKER_PASSWORD }}





🧠 Access Workflow Context

Access details about the current workflow, commit, or actor.

- name: Print context info
  run: |
    echo "Branch: ${{ github.ref }}"
    echo "Actor: ${{ github.actor }}"
    echo "Event: ${{ github.event_name }}"



🔍 Workflow Event Filters & Activity Types

Filters let you run workflows only for specific activities like PR opened or synchronized.

on:
  pull_request:
    branches: [main]
    types: [opened, reopened, synchronize]


✅ Helps avoid unnecessary runs when code isn’t changed.





🐳 Docker Example

A workflow that builds and pushes a Docker image to DockerHub.

name: Build and Push Docker Image

on:
  push:
    branches: [main]

jobs:
  docker:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            ${{ secrets.DOCKERHUB_USERNAME }}/myapp:${{ github.sha }}

🧾 Summary

✅ GitHub Actions is a powerful CI/CD automation tool
✅ YAML-based, event-driven workflows
✅ Integrates easily with Docker, Kubernetes, and cloud services
✅ Supports secrets, environment variables, concurrency, and matrix builds
✅ Perfect for building, testing, and deploying any modern application
