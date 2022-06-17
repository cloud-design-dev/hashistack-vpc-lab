output "vpc_id" {
  value = jsondecode(data.local_file.environment_info.content)["vpc_id"]
}
