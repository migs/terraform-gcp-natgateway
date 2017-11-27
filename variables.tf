variable "project" { }
variable "region" { }
variable "nat-gateway-image" { default = "debian-cloud/debian-8" }
variable "nat-gateway-machine_type" { default = "f1-micro" }
variable "prefix" { default = "default" }
variable "squid_enabled" { default = false }
variable "squid_config" { default = "" }
variable "network" { default  = "default" }
variable "subnetwork" { default  = "default" }
variable "tags" { default = ["nat","internal"] }
variable "ha" { default = false }
variable "priority" { default = "800" }
variable "route-tag" { default = "no-ip" }
variable "region_params" {
  type = "map"
  default {
    europe-west1 {
      zone1 = "europe-west1-b"
      zone2 = "europe-west1-c"
      zone3 = "europe-west1-d"
    }
    europe-west2 {
      zone1 = "europe-west2-a"
      zone2 = "europe-west2-b"
      zone3 = "europe-west2-c"
    }
  }
}
