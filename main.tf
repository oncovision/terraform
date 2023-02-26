provider "google" {
  version = "3.90.0"

  project = "solution-kit-11"
  region  = "europe-west3"
}

terraform {
  backend "gcs" {
    bucket = "onco-tfstate"
  }
}


resource "google_service_account" "oncovision-artifact-id" {
  account_id   = "oncovision-artifact-id"
  display_name = "oncovision-artifact-id"
}

resource "google_service_account" "semicolon-bigquery" {
  account_id   = "semicolon-bigquery"
  display_name = "semicolon-bigquery"
}

resource "google_container_cluster" "oncovision" {
  enable_autopilot   = true
  enable_tpu         = false
  name               = "oncovision"
  location           = "europe-west3"
  cluster_ipv4_cidr  = "10.61.0.0/17"
  datapath_provider  = "ADVANCED_DATAPATH"
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  network            = "projects/solution-kit-11/global/networks/default"
  networking_mode    = "VPC_NATIVE"
  node_locations     = ["europe-west3-a", "europe-west3-b", "europe-west3-c", ]
  node_version       = "1.24.9-gke.2000"
  project            = "solution-kit-11"
  subnetwork         = "projects/solution-kit-11/regions/europe-west3/subnetworks/default"
  default_snat_status {
    disabled = false
  }
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS", ]
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", ]
  }
  release_channel {
    channel = "REGULAR"
  }
  vertical_pod_autoscaling {
    enabled = true
  }

}
