# Deploying Helm Charts

This repository contains a Helm chart that is automatically pushed to **GitHub Container Registry (GHCR)** using **GitHub Actions**. The chart can be installed directly from GHCR using `helm pull` and `helm install` commands.

### **1️⃣ Prerequisites**
Ensure you have the following installed:
- [Helm](https://helm.sh/docs/intro/install/) (v3.8+ required for OCI support)
- [GitHub CLI](https://cli.github.com/)
- Access to the repository with appropriate permissions

### **2️⃣ GitHub Actions Workflow (Auto Deployment)**
This repo is configured with a **GitHub Actions workflow** that automatically pushes Helm charts to GHCR.

#### **Manually Triggering the Workflow**
To deploy a new version, you can manually trigger the workflow:

- Navigate to the repository on GitHub.
- Go to **"Actions"** → **Select the workflow**.
- Click **"Run Workflow"** and enter:
   - `chart_name`: The name of the Helm chart.
   - `chart_version`: The version of the Helm chart.
- Click **"Run workflow"**.

Once the workflow completes, the Helm chart will be available at:
```
oci://ghcr.io/<your-github-username>/helm/<chart_name>:<chart_version>
```

---

## 📥 How to Install the Helm Chart

Once the Helm chart is published to GHCR, it can be installed using the following steps:

### **1️⃣ Authenticate to GHCR**
```sh
echo "<YOUR_GITHUB_TOKEN>" | helm registry login ghcr.io --username <your-github-username> --password-stdin
```
Alternatively, if using GitHub Actions `GITHUB_TOKEN`, you can use:
```sh
echo "${{ secrets.GITHUB_TOKEN }}" | helm registry login ghcr.io --username ${{ github.actor }} --password-stdin
```

### **2️⃣ Pull the Helm Chart**
```sh
helm pull oci://ghcr.io/<your-github-username>/helm/<chart_name> --version <chart_version>
```

### **3️⃣ Install the Chart**
```sh
helm install <release-name> oci://ghcr.io/<your-github-username>/helm/<chart_name> --version <chart_version>
```

---

## 🛠 Managing Chart Versions
To list all available versions of your Helm chart in GHCR, use:
```sh
helm search repo ghcr.io/<your-github-username>/helm/<chart_name>
```

To upgrade an existing installation:
```sh
helm upgrade <release-name> oci://ghcr.io/<your-github-username>/helm/<chart_name> --version <new-version>
```

---

## 🔄 Uninstalling the Chart
To remove the Helm release:
```sh
helm uninstall <release-name>
```