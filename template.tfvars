
###  ---  Default Template  ---  ###
kind_cluster_name        = "dev-cluster"
kind_cluster_config_path = "~/.kube/config"
k8s_version              = "v1.35.0"
additional_control_planes_count = 0
worker_count = 1

###---MinIO configuration
minio_root_user        = "root"
minio_root_password    = "q1w2e3r4100@"  # Replace with a secret ref or more secure value
minio_buckets          = "terraform,loki"
minio_persistence_size = "10Gi"
minio_service_type     = "ClusterIP"


