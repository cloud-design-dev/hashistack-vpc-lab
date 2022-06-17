variable "vpc_id" {
    default = jsondecode(data.local_file.environment_info.content)["vpc_id"]
}
#   vpc_id            = 
#   resource_group_id = jsondecode(data.local_file.environment_info.content)["resource_group"]
#   name              = jsondecode(data.local_file.environment_info.content)["name"]
#   ssh_key_id      = jsondecode(data.local_file.environment_info.content)["ssh_key_id"]
#   subnet_id         = jsondecode(data.local_file.environment_info.content)["subnet_id"]

