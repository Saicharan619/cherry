terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.0"
    }
  }
}

provider "google" {
  project     = "saitejaameda"
  region      = "us-central1"
  credentials = file("gcp.json")
}