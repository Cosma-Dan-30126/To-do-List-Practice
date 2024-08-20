# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Define variables for project ID, region, and Docker image
variable "project_id" {
  description = "The ID of the project in which to create resources."
  type        = string
  default     = "vuecloud-431908" 
}

variable "region" {
  description = "The region in which to create resources."
  type        = string
  default     = "europe-west2-b"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "my-k8s-cluster"
}

variable "node_count" {
  description = "The number of nodes in the cluster."
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "The machine type to use for the cluster nodes."
  type        = string
  default     = "e2-medium"
}

variable "docker_image_name" {
  description = "The name of the Docker image."
  type        = string
  default     = "vueapp"
}

variable "docker_image_tag" {
  description = "The tag for the Docker image."
  type        = string
  default     = "latest"
}

variable "gcr_repository" {
  description = "The Google Container Registry repository."
  type        = string
  default     = "gcr.io"
}

# Create a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # Specify the initial node count and machine type
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 30
    preemptible  = true  # Set preemptible nodes if desired
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}

# Build and push Docker image
resource "null_resource" "docker_build" {
  provisioner "local-exec" {
    command = <<EOT
      docker build -t ${var.gcr_repository}/${var.project_id}/${var.docker_image_name}:${var.docker_image_tag} .
      docker push ${var.gcr_repository}/${var.project_id}/${var.docker_image_name}:${var.docker_image_tag}
    EOT
  }
}

# Deploy to Kubernetes
resource "kubernetes_deployment" "vueapp" {
  metadata {
    name = "vueapp"
    labels = {
      app = "vueapp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "vueapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "vueapp"
        }
      }

      spec {
        container {
          name  = "vueapp"
          image = "${var.gcr_repository}/${var.project_id}/${var.docker_image_name}:${var.docker_image_tag}"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vueapp" {
  metadata {
    name = "vueapp"
  }

  spec {
    selector = {
      app = "vueapp"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 8080
    }
  }
}

# Output the cluster name and endpoint
output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = google_container_cluster.primary.name
}

output "kubernetes_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = google_container_cluster.primary.endpoint
}
