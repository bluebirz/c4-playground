# https://medium.com/@jonay.sosag/automate-docker-builds-and-push-to-google-artifact-registry-with-terraform-including-args-e3f0872da2a2
resource "null_resource" "auth_docker" {
  provisioner "local-exec" {
    command = <<EOF
            gcloud auth configure-docker ${var.location}-docker.pkg.dev
        EOF
  }
}

resource "null_resource" "build_image" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOF
          cd ../structurizr
          docker-compose -f ./docker-compose-builder.yaml build ${var.build_name}
        EOF
  }
  depends_on = [null_resource.auth_docker]
}

resource "null_resource" "tag_image" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOF
          docker tag ${var.image_name} ${var.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.name}/${var.image_name}
        EOF
  }
  depends_on = [null_resource.build_image, google_artifact_registry_repository.repo]
}

resource "null_resource" "push_image" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOF
          docker push ${var.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.name}/${var.image_name}
        EOF
  }
  depends_on = [null_resource.tag_image]
}

