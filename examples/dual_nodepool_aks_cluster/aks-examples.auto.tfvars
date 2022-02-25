## Cluster
cluster_name = "foocluster"

## System Node pool
sysnp_name            = "systemnodep"
sysnp_vm_size         = "Standard_DS2_v2"
sysnp_zones           = ["1", "2", "3"]
sysnp_is_auto_scaling = true
sysnp_max_count       = "3"
sysnp_min_count       = "1"

## User Node pool
enable_user_nodepool   = true
usernp_name            = "usernodep"
usernp_vm_size         = "Standard_DS2_v2"
usernp_is_auto_scaling = true
usernp_min_count       = 1
usernp_max_count       = 1
usernp_os_type         = "Linux"
usernp_zones           = ["1", "2", "3"]
usernp_disk_type       = "Managed"