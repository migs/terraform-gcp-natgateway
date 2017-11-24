# Google Cloud Platform NAT Gateway Terraform Module

A Terraform Module for creating either 1 or 3 NAT Gateways in a given Google Project. Inspired by a simalar ['google module'](https://github.com/GoogleCloudPlatform/terraform-google-nat-gateway) but more opinionated, and does not use Managed Instance Groups as the goal for this module is for Terraform to completely own the instances, not to have an external entity creating/destroying them.

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

By passing the `ha` variable as `true`, 3 NAT gateways will be created instead of 1

## Variables

See `variables.tf` for a complete list of variables that can be overridden as required.
