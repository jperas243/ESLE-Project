# Terraform google cloud multi tier Kubernetes deployment
# AGISIT Lab Cloud-Native Application in a Kubernetes Cluster

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

provider "google" {
 credentials = file("${var.credentials}")
 project     = var.project
 region      = var.region
}

variable "region" {
    type = string
}

variable "project" {
    type = string
}

variable "workers_count" {
    type = number
}

variable "credentials" {
    type = string
}

variable "cluster_name" {
    type = string
}
# Configure Kubernetes provider with OAuth2 access token
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {
  depends_on = [module.gcp_gke]
}


#####################################################################
# Modules for Provisioning and Deployment
#####################################################################

# The module in folder 'gcp_gke' defines the Kubernetes Cluster
module "gcp_gke" {
  source   = "./gcp_gke"
  cluster_name = var.cluster_name
  project = var.project
  region = var.region
  workers_count = var.workers_count
}

