provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        provider_terraform_version: "{{ .provider_terraform.version }}"
        terraform_version: "{{ .terraform.version }}"
  textReplace:
    goss/goss.yaml:
      from: "Terraform v{{ .terraform.previousVersion }}"
      to: "Terraform v{{ .terraform.version }}"

dependencies:
  provider_terraform:
    releasesFrom:
      dockerImageTags:
        source: crossplane/provider-terraform-controller
    version: "> 0.0.1"
    validVersionPattern: "[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+"
  terraform:
    releasesFrom:
      githubReleases:
        source: hashicorp/terraform
    version: "> 1.0.0"
