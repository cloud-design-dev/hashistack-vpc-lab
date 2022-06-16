data "local_file" "packer_manifest" {
  filename = "../shared-data/manifest.json"
}

data "local_file" "environment_info" {
  filename = "../shared-data/env_info.json"
}
