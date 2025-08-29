resource "google_cloud_run_v2_service" "c4" {
  name                 = "structurizr-c4"
  location             = var.location
  deletion_protection  = false
  ingress              = "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true

  scaling {
    max_instance_count = 100
  }

  template {
    containers {
      image = "${var.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.name}/${var.image_name}"
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
  depends_on = [null_resource.push_image]
}

output "cloud_run_url" {
  value = google_cloud_run_v2_service.c4.uri
}

