# Google Cloud Platform NAT Gateway Terraform Module

A Terraform Module for creating NAT Gateways in a given Google Project. Inspired by a simalar ['google module'](https://github.com/GoogleCloudPlatform/terraform-google-nat-gateway) but more opinionated, and does not use Managed Instance Groups as the goal for this module is for Terraform to completely own the instances, not to have an external entity creating/destroying them.

## Usage

```
module "terraform-gcp-natgateway" {
  source = "github.com/migs/terraform-gcp-natgateway"
  project = "${var.project}"
  region = "${var.region}"
}
```

All VMs without public IP addresses should have the `no-ip` tag to enable routing traffic through the NAT Gateway(s). This can be overridden with the `route-tag` variable.

## High Availability

By passing the `zones` variable, you can control how many NAT gateways are created (one per zone in a given region).

## Variables

See `variables.tf` for a complete list of variables that can be overridden as required.
