output "cluster_endpoint" {
  description = "Cluster Endpoint"
  value       = google_container_cluster.gke.endpoint
}