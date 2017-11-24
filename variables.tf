variable "project" { }
variable "region" { }
variable "image" { default = "debian-cloud/debian-8" }
variable "machine_type" { default = "f1-micro" }
variable "prefix" { default = "default" }
variable "squid_enabled" { default = false }
variable "squid_config" { default = "" }
variable "network" { default  = "default" }
variable "subnetwork" { default  = "default" }
variable "tags" { default = ["nat","internal"] }
variable "ha" { default = false }
variable "region_params" {
  type = "map"
  default = {
    europe-west1.zone1  = "europe-west1-b"
    europe-west1.zone2  = "europe-west1-c"
    europe-west1.zone3  = "europe-west1-d"
    europe-west2.zone1  = "europe-west2-a"
    europe-west2.zone2  = "europe-west2-b"
    europe-west2.zone3  = "europe-west2-c"
  }
}
variable "priority" { default = "800" }
variable "route-tag" { default = "no-ip" }
