resource "google_compute_instance" "confidential_instance" {

  name             = "my-confidential-instance"
  zone             = "us-central1-a"
  machine_type     = "n2d-highmem-4"
  boot_disk {
    initialize_params {
      image = "centos-stream-9-v20250123"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }

    
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "saiteja@saitejaameda.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [attached_disk]
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      
    
  }

}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 11
  zone = "us-central1-a"
  type = "pd-ssd"
  
}

resource "google_compute_attached_disk" "attached-disk1" {
  disk     = "google_compute_disk.disk-1.id"
  instance = "google_compute_instance.confidential_instance.id"
  zone     = "us-central1-a"
}





