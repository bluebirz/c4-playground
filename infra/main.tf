terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
provider "google" {
  project = var.project_id
}


resource "google_artifact_registry_repository" "repo" {
  provider      = google
  location      = var.location
  repository_id = "structurizr-repo"
  description   = "Structurizr repo"
  format        = "DOCKER"
}

output "repo_id" {
  value = google_artifact_registry_repository.repo.id
}



