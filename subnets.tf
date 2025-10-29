resource "google_compute_subnetwork" "public" {
  name                     = "public"
  private_ip_google_access = true
  ip_cidr_range            = var.ip_cidr_range_subnet_public
  stack_type               = "IPV4_ONLY"
  region                   = var.region
  network                  = google_compute_network.vpc.id

}

resource "google_compute_subnetwork" "private" {
  name                     = "private"
  private_ip_google_access = true
  ip_cidr_range            = var.ip_cidr_range_subnet_private
  stack_type               = "IPV4_ONLY"
  region                   = var.region
  network                  = google_compute_network.vpc.id

  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = var.ip_cidr_range_pods
  }

  secondary_ip_range {
    range_name    = "k8s-services"
    ip_cidr_range = var.ip_cidr_range_services
  }
}