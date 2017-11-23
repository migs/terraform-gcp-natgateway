variable "project" { }
variable "region" { }
variable "image" { default = "debian-cloud/debian-8" }
variable "machine_type" { default = "f1-micro" }
variable "prefix" { default = "" }
variable "squid_enabled" { default = false }
variable "squid_config" { default = "" }
variable "network" { default  = "default" }
variable "subnetwork" { default  = "default" }
variable "tags" { default = "nat" }
variable "ha" { default = false }
variable "region_params" {
  type = "map"
  default = {
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
variable "zone1" { default = "${lookup(var.region_params["${var.region}"],zone1)}"}
variable "zone2" { default = "${lookup(var.region_params["${var.region}"],zone2)}"}
variable "zone3" { default = "${lookup(var.region_params["${var.region}"],zone3)}"}
variable "priority" { default = "800" }
