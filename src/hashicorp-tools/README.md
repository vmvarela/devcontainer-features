
# Hashicorp Tools (hashicorp-tools)

Installs Hashicorp Products

## Example Usage

```json
"features": {
    "ghcr.io/vmvarela/devcontainer-features/hashicorp-tools:0": {
        "terraform": "1.9.5",
        "vault": "1.17.5"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| vault | Vault version | string | - |
| terraform | Terraform version | string | - |
| consul | Consul version | string | - |
| vagrant | Vagrant version | string | - |
| nomad | Nomad version | string | - |
| packer | Packer version | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/vmvarela/devcontainer-features/blob/main/src/hashicorp-tools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
