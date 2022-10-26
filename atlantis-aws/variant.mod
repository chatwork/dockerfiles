provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        awscli_version: "{{ .awscli.version }}"
        atlantis_version: "{{ .atlantis.version }}"
        dump_init_version: "{{ .dump_init.version }}"
        gosu_version: "{{ .gosu.version }}"
        git_lfs_version: "{{ .git_lfs.version }}"
        terraform_version: "{{ .terraform.version }}"
        conftest_version: "{{ .conftest.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        awscli_version: "{{ .awscli.version }}"
        atlantis_version: "{{ .atlantis.version }}"
        dump_init_version: "{{ .dump_init.version }}"
        gosu_version: "{{ .gosu.version }}"
        git_lfs_version: "{{ .git_lfs.version }}"
        terraform_version: "{{ .terraform.version }}"
        conftest_version: "{{ .conftest.version }}"

dependencies:
  awscli:
    releasesFrom:
      dockerImageTags:
        source: chatwork/aws
    version: "> 2.0.0"
  atlantis:
    releasesFrom:
      githubReleases:
        source: runatlantis/atlantis
    version: "> 0.0.0"
  dumb_init:
    releasesFrom:
      githubReleases:
        source: Yelp/dumb-init
    version: "> 0.0.0"
  gosu:
    releasesFrom:
      githubReleases:
        source: tianon/gosu
    version: "> 0.0.0"
  git_lfs:
    releasesFrom:
      githubReleases:
        source: git-lfs/git-lfs
    version: "> 0.0.0"
  terraform:
    releasesFrom:
      githubReleases:
        source: hashicorp/terraform
    version: "> 0.0.0"
  conftest:
    releasesFrom:
      githubReleases:
        source: open-policy-agent/conftest
    version: "> 0.0.0"
