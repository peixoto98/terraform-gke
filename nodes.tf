resource "google_service_account" "gke" {
  account_id = "gke-sa"
}

resource "google_container_node_pool" "gke-node-pool" {
  name       = "gke-node-pool"
  location   = var.region
  cluster    = google_container_cluster.gke.id
  node_count = 1

  autoscaling {
    max_node_count = var.max_node_count
    min_node_count = var.min_node_count
  }

  management {
    auto_upgrade = true
    auto_repair = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    service_account = google_service_account.gke.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}