provider "google" {
  version = "3.90.0"

  project = "solution-kit-11"
  region = "europe-west3"
}

resource "google_service_account" "oncovision-artifact-id" {
    account_id = "oncovision-artifact-id" 
    display_name = "oncovision-artifact-id" 
}
    
resource "google_service_account" "semicolon-bigquery" {
    account_id = "semicolon-bigquery" 
    display_name = "semicolon-bigquery" 
}

resource "google_container_cluster" "oncovision" {
    name = "oncovision"
    location = "europe-west3-c"
       cluster_ipv4_cidr           = "10.61.0.0/17"  
        datapath_provider           = "ADVANCED_DATAPATH"  
        default_max_pods_per_node   = 110 
        enable_intranode_visibility = true  
        enable_shielded_nodes       = true
        # endpoint                    = "34.159.49.126"  
        # id                          = "projects/solution-kit-11/locations/europe-west3/clusters/oncovision" 
        # instance_group_urls         = []  
        # label_fingerprint           = "a9dc16a7"
        logging_service             = "logging.googleapis.com/kubernetes"  
        # master_version              = "1.24.9-gke.2000"  
        monitoring_service          = "monitoring.googleapis.com/kubernetes"
        network                     = "projects/solution-kit-11/global/networks/default"
        networking_mode             = "VPC_NATIVE"  
        node_locations              = ["europe-west3-a", "europe-west3-b", "europe-west3-c",]  
        node_version                = "1.24.9-gke.2000" 
        project                     = "solution-kit-11"
        # self_link                   = "https://container.googleapis.com/v1beta1/projects/solution-kit-11/locations/europe-west3/clusters/oncovision"  
        # services_ipv4_cidr          = "10.61.128.0/22"  
        subnetwork                  = "projects/solution-kit-11/regions/europe-west3/subnetworks/default" 
        # (3 unchanged attributes hidden)

        addons_config {

            horizontal_pod_autoscaling {
                disabled = false  
            }

            http_load_balancing {
                disabled = false  
            }

            network_policy_config {
                disabled = true  
            }
        }

        cluster_autoscaling {
            enabled = true  

            auto_provisioning_defaults {
                oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only",
                "https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring",
                "https://www.googleapis.com/auth/service.management.readonly",
                "https://www.googleapis.com/auth/servicecontrol",
                "https://www.googleapis.com/auth/trace.append",]  
                service_account = "default"  
            }

            resource_limits {
                maximum       = 1000000000  
                minimum       = 0  
                resource_type = "cpu"  
            }
        }

        database_encryption {
            state    = "DECRYPTED"  
        }

        default_snat_status {
            disabled = false  
        }

        # ip_allocation_policy { 
        #     cluster_secondary_range_name  = "gke-oncovision-pods-32836611"  
        #     services_ipv4_cidr_block      = "10.61.128.0/22"  
        #     services_secondary_range_name = "gke-oncovision-services-32836611"  
        # }

        logging_config {
            enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS", ]  
        }


        monitoring_config {
            enable_components = ["SYSTEM_COMPONENTS",]  
        }

        network_policy {
            enabled  = false  
            provider = "PROVIDER_UNSPECIFIED"  
        }

        node_config {
            disk_size_gb      = 100  
            disk_type         = "pd-standard"  
            guest_accelerator = []  
            image_type        = "COS_CONTAINERD"  
            labels            = {}  
            local_ssd_count   = 0  
            machine_type      = "e2-medium"  
            metadata          = {"disable-legacy-endpoints" = "true"  }
            oauth_scopes      = [
              "https://www.googleapis.com/auth/devstorage.read_only",
              "https://www.googleapis.com/auth/logging.write",
              "https://www.googleapis.com/auth/monitoring",
              "https://www.googleapis.com/auth/service.management.readonly",
              "https://www.googleapis.com/auth/servicecontrol",
              "https://www.googleapis.com/auth/trace.append",
            ]  
            preemptible       = false  
            service_account   = "default"  
            tags              = []  
            taint             = []  

            shielded_instance_config {
                enable_integrity_monitoring = true  
                enable_secure_boot          = true  
            }

            workload_metadata_config {
                mode          = "GKE_METADATA"  
                node_metadata = "GKE_METADATA_SERVER"  
            }
        }

        node_pool {
            initial_node_count  = 1  
            # instance_group_urls = []  
            max_pods_per_node   = 32  
            name                = "default-pool"  
            node_count          = 0  
            node_locations      = ["europe-west3-a","europe-west3-b",]  
            version             = "1.24.9-gke.2000"  

            autoscaling {
                max_node_count = 1000  
                min_node_count = 0  
            }

            management {
                auto_repair  = true  
                auto_upgrade = true  
            }

            node_config {
                disk_size_gb      = 100  
                disk_type         = "pd-standard"  
                guest_accelerator = []  
                image_type        = "COS_CONTAINERD"  
                labels            = {}  
                local_ssd_count   = 0  
                machine_type      = "e2-medium"  
                metadata          = {
                    "disable-legacy-endpoints" = "true"
                } 
                oauth_scopes      = ["https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/trace.append",
                ]  
                preemptible       = false  
                service_account   = "default"  
                tags              = []  
                taint             = []  

                shielded_instance_config {
                    enable_integrity_monitoring = true  
                    enable_secure_boot          = true  
                }

                workload_metadata_config {
                    mode          = "GKE_METADATA"  
                    node_metadata = "GKE_METADATA_SERVER"  
                }
            }

            upgrade_settings {
                max_surge       = 1  
                max_unavailable = 0  
            }
        }
      


        release_channel {
            channel = "REGULAR"  
        }


        workload_identity_config {
            identity_namespace = "solution-kit-11.svc.id.goog" 
        }
}
