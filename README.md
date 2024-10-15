# devcontainer-features

Repository with features to use in devcontainers:
- [hashicorp-tools](./src/hashicorp-tools/README.md): Installs Hashicorp utilities (Terraform, Vault, Consul...)
- [terraform-docs](./src/terraform-docs/README.md): Instala terraform-docs
- [tflint](./src/tflint/README.md): Instala TFLint

## Usage

To use the features from this repository, add the desired features to `devcontainer.json`. To use the features from this repository, add the ones you need to `devcontainer.json`.

This sample installs Terraform and Vault into a devcontainer using [hashicorp-tools](./src/hashicorp-tools/README.md) feature.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/vmvarela/devcontainer-features/hashicorp-tools:0": {
            "terraform": "1.9.5",
            "vault": "1.17.5"
        }
    }
}
```

## Repository and Features Structure

Based on the repository `devcontainers/features`, this repository has a `src` folder. Each feature has its own subfolder, with at least a `devcontainer-feature.json` and an installation script `install.sh`.

```
├── src
│   ├── hello
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
│   ├── color
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
|   ├── ...
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
...
```
